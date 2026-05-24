
using System.Xml.Serialization;
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

namespace PosterDisplay
{
    public enum PosterDisplayState
    {
        Off,
        Initializing,
        Ready,
        Loading,
        Displaying,
        Halting,
        Error
    }

    [UdonBehaviourSyncMode(BehaviourSyncMode.NoVariableSync)]
    public class PosterDisplayController : UdonSharpBehaviour
    {
        [Header("Basic Settings")]
        [Space(10)]

        [Tooltip("Endpoint URL for the poster image.")]
        [SerializeField] public VRCUrl endpoint;

        [Tooltip("Duration for which each poster frame is displayed without transition, in seconds.")]
        [SerializeField] public float durationStatic = 20.0f;

        [Tooltip("Duration for the ease transition, in seconds.")]
        [SerializeField] public float durationEase = 0.5f;

        [Tooltip("Stride for the poster to show in the grid. A stride of 1 means every poster will be shown in order, a stride of 2 means every other poster will be shown, etc.")]
        [SerializeField] public int stride = 1;

        [Tooltip("Number of columns in the poster grid.")]
        [SerializeField] public int gridHorizontal = 4;

        [Tooltip("Number of rows in the poster grid.")]
        [SerializeField] public int gridVertical = 2;

        [Tooltip("Whether to start downloading the poster image automatically when enabled.")]
        [SerializeField] public bool startDownloadOnEnable = true;

        [Tooltip("Delay before starting the download, in seconds.")]
        [SerializeField] public float downloadDelayOnEnable = 0.5f;

        [Tooltip("Renderer component to apply the poster texture to.")]
        [SerializeField] public Renderer[] targetRenderers;

        [Tooltip("Time offsets for each poster image. If multiple offsets are provided, they will be applied in a round-robin fashion to the target materials. If left empty, no time offset will be applied.")]
        [SerializeField] public float[] timeOffsets;

        [Header("Material Settings")]
        [Space(10)]

        [Tooltip("Material slot index for the poster texture.")]
        [SerializeField] public int materialSlotIndex = 0;

        [Tooltip("Material property name for the poster texture.")]
        [SerializeField] public string posterTexPropName = "_MainTex";

        [Tooltip("Material property name for the time offset.")]
        [SerializeField] public string timeOffsetPropName = "_TimeOffset";

        [Tooltip("Material property name for the static duration.")]
        [SerializeField] public string durationStaticPropName = "_DurationStatic";

        [Tooltip("Material property name for the ease duration.")]
        [SerializeField] public string durationEasePropName = "_DurationEase";

        [Tooltip("Material property name for the stride.")]
        [SerializeField] public string stridePropName = "_Stride";

        [Tooltip("Material property name for the grid horizontal count.")]
        [SerializeField] public string gridHorizontalPropName = "_GridHorizontal";

        [Tooltip("Material property name for the grid vertical count.")]
        [SerializeField] public string gridVerticalPropName = "_GridVertical";

        [Header("Animation Settings")]
        [Space(10)]

        [Tooltip("Animators to control for state changes. The specified animator parameters will be set on all of these animators when the state changes.")]
        [SerializeField] public Animator[] animators;

        [Tooltip("Animator parameter name for the Initializing state. This should be a boolean parameter that is true when the state is Initializing and false otherwise.")]
        [SerializeField] public string animatorInitializingKey = "Initializing";

        [Tooltip("Animator parameter name for the Ready state. This should be a boolean parameter that is true when the state is Ready and false otherwise.")]
        [SerializeField] public string animatorReadyKey = "Ready";

        [Tooltip("Animator parameter name for the Loading state. This should be a boolean parameter that is true when the state is Loading and false otherwise.")]
        [SerializeField] public string animatorLoadingKey = "Loading";
        
        [Tooltip("Animator parameter name for the Displaying state. This should be a boolean parameter that is true when the state is Displaying and false otherwise.")]
        [SerializeField] public string animatorDisplayingKey = "Displaying";

        [Tooltip("Animator parameter name for the Halting state. This should be a boolean parameter that is true when the state is Halting and false otherwise.")]
        [SerializeField] public string animatorHaltingKey = "Halting";

        [Tooltip("Animator parameter name for the Error state. This should be a boolean parameter that is true when the state is Error and false otherwise.")]
        [SerializeField] public string animatorErrorKey = "Error";

        private VRC.SDK3.Image.VRCImageDownloader downloader;
        private VRC.SDK3.Image.IVRCImageDownload downloadHandle;

        private Material[] targetMaterials;
        private int posterTexPropID;
        private PosterDisplayState currentState = PosterDisplayState.Off;

        public void OnEnable()
        {
            Initialize();
        }

        public void OnDisable()
        {
            Halt();
        }

        /// <summary>
        /// Halts the controller by setting the state to Halting and scheduling a reset after a short delay. <br/>
        /// This is auto called when the controller is disabled. <br/>
        /// 
        /// </summary>
        /// 
        /// <remarks> 
        /// This stop the controller gracefully with stopping visual (if any) <br/>
        /// You may want to call <c>Reset</c> instead for an immediate stop without any stopping visual<br/>
        /// 
        /// </remarks> 
        public void Halt()
        {
            SetState(PosterDisplayState.Halting);

            // Delay the reset to ensure any state animations can complete before we dispose of the downloader and download handle.
            SendCustomEventDelayedSeconds(nameof(HaltIfPending), 1.0f);
        }

        /// <summary>
        /// Resets the controller by disposing of the current download handle and image downloader, <br/>
        /// and clearing the poster texture from the target materials. <br/>
        /// 
        /// </summary>
        /// 
        /// <remarks> 
        /// This stop the controller immediately and clean up resources. <br/>
        /// You may want to call <c>Halt</c> instead for a graceful stopping visual<br/>
        /// 
        /// </remarks> 
        public void Reset()
        {
            if (downloadHandle != null)
            {
                Debug.Log($"[{nameof(PosterDisplay)}] Disposing download handle. GameObject: {gameObject.name}");
                downloadHandle.Dispose();
                downloadHandle = null;
            }

            if (downloader != null)
            {
                Debug.Log($"[{nameof(PosterDisplay)}] Disposing image downloader. GameObject: {gameObject.name}");
                downloader.Dispose();
                downloader = null;
            }
        }

        /// <summary>
        /// Initializes the controller by setting up the image downloader, resolving target materials, and applying initial renderer settings. <br/>
        /// If configured to start download on enable, it will also trigger the download process after an optional delay. <br/>
        /// This is auto called when the controller is enabled. <br/>
        /// You can also call this manually to re-initialize the controller if needed. <br/>
        /// 
        /// </summary>
        public void Initialize()
        {
            SetState(PosterDisplayState.Initializing);

            Reset();

            Debug.Log($"[{nameof(PosterDisplay)}] Initializing PosterDisplay. GameObject: {gameObject.name}");

            downloader = new VRC.SDK3.Image.VRCImageDownloader();

            targetMaterials = ResolveTargetMaterials();
            posterTexPropID = VRCShader.PropertyToID(posterTexPropName);

            UpdateRendererSettings();

            if (startDownloadOnEnable)
            {
                if (downloadDelayOnEnable > 0)
                {
                    SendCustomEventDelayedSeconds(nameof(StartDownload), downloadDelayOnEnable);
                }
                else
                {
                    StartDownload();
                }
            }
            else
            {
                SetState(PosterDisplayState.Ready);
            }
        }

        /// <summary>
        /// Updates the renderer settings on the target materials based on the current configuration. <br/>
        /// This includes setting the duration, grid, and time offset properties on the materials. <br/>
        /// <br/>
        /// This is called during initialization to apply the initial settings. <br/>
        /// You can also call this manually if you change any of the related settings at runtime. <br/>
        /// 
        /// </summary>
        public void UpdateRendererSettings()
        {
            if (targetMaterials == null)
                return;

            int durationStaticPropID = VRCShader.PropertyToID(durationStaticPropName);
            int durationEasePropID = VRCShader.PropertyToID(durationEasePropName);
            int stridePropID = VRCShader.PropertyToID(stridePropName);
            int gridHorizontalPropID = VRCShader.PropertyToID(gridHorizontalPropName);
            int gridVerticalPropID = VRCShader.PropertyToID(gridVerticalPropName);
            int timeOffsetPropID = VRCShader.PropertyToID(timeOffsetPropName);

            bool setTimeOffset = timeOffsets != null && timeOffsets.Length > 0;

            for (int i = 0; i < targetMaterials.Length; i++)
            {
                if (targetMaterials[i] == null)
                    continue;

                targetMaterials[i].SetFloat(durationStaticPropID, durationStatic);
                targetMaterials[i].SetFloat(durationEasePropID, durationEase);
                targetMaterials[i].SetInt(stridePropID, stride);
                targetMaterials[i].SetInt(gridHorizontalPropID, gridHorizontal);
                targetMaterials[i].SetInt(gridVerticalPropID, gridVertical);

                if (setTimeOffset)
                {
                    float timeOffset = timeOffsets[i % timeOffsets.Length];
                    targetMaterials[i].SetFloat(timeOffsetPropID, timeOffset);
                }
            }
        }

        private Material ResolveTargetMaterial(Renderer targetRenderer)
        {
            if (targetRenderer == null)
            {
                Debug.LogError($"[{nameof(PosterDisplay)}] Target renderer is null. GameObject: {gameObject.name}");
                return null;
            }

            Material[] materials = targetRenderer.materials;

            if (materialSlotIndex < 0 || materialSlotIndex >= materials.Length)
            {
                Debug.LogError($"[{nameof(PosterDisplay)}] Invalid material slot index: {materialSlotIndex}. GameObject: {gameObject.name}");
                return null;
            }

            return materials[materialSlotIndex];
        }

        private Material[] ResolveTargetMaterials()
        {
            Material[] results = new Material[targetRenderers.Length];

            for (int i = 0; i < targetRenderers.Length; i++)
            {
                Material material = ResolveTargetMaterial(targetRenderers[i]);
                if (material == null)
                {
                    Debug.LogError($"[{nameof(PosterDisplay)}] Failed to resolve material for renderer at index {i}. GameObject: {gameObject.name}");
                    continue;
                }

                results[i] = material;
            }

            return results;
        }


        // This method has to be public to be called by SendCustomEventDelayedSeconds, but it should not be called directly by users.
        public void HaltIfPending()
        {
            if (currentState == PosterDisplayState.Halting)
            {
                SetState(PosterDisplayState.Off);
                Reset();
            }
        }

        // This method has to be public to be called by SendCustomEventDelayedSeconds, but it should not be called directly by users.
        public void StartDownload()
        {
            if (currentState != PosterDisplayState.Initializing && currentState != PosterDisplayState.Ready)
            {
                Debug.LogWarning($"[{nameof(PosterDisplay)}] StartDownload called but current state is expired: {currentState}. Ignoring. GameObject: {gameObject.name}");
                return;
            }

            if (endpoint == null)
                return;

            SetState(PosterDisplayState.Loading);

            Debug.Log($"[{nameof(PosterDisplay)}] Starting download of poster image from URL: {endpoint}. GameObject: {gameObject.name}");

            if (downloadHandle != null)
            {
                Debug.Log($"[{nameof(PosterDisplay)}] Disposing previous download handle. GameObject: {gameObject.name}");
                downloadHandle.Dispose();
                downloadHandle = null;
            }

            if (downloader == null)
            {
                Debug.LogError($"[{nameof(PosterDisplay)}] Image downloader is not initialized. Cannot start download. GameObject: {gameObject.name}");
                SetState(PosterDisplayState.Error);
                return;
            }

            VRC.SDK3.Image.TextureInfo textureInfo = new VRC.SDK3.Image.TextureInfo();
            textureInfo.GenerateMipMaps = true;

            downloadHandle = downloader.DownloadImage(
                endpoint,
                null,
                (VRC.Udon.Common.Interfaces.IUdonEventReceiver)this,
                textureInfo
            );
        }

        public override void OnImageLoadSuccess(VRC.SDK3.Image.IVRCImageDownload result)
        {
            if (result != downloadHandle)
            {
                Debug.LogWarning($"[{nameof(PosterDisplay)}] Received download success for an unknown download. Ignoring. GameObject: {gameObject.name}");
                result.Dispose();
                return;
            }

            if (currentState != PosterDisplayState.Loading)
            {
                Debug.LogWarning($"[{nameof(PosterDisplay)}] Received download success for a download that is expired or already handled. Ignoring. GameObject: {gameObject.name}");
                result.Dispose();
                return;
            }

            Debug.Log($"[{nameof(PosterDisplay)}] Successfully downloaded poster image from URL: {endpoint}. GameObject: {gameObject.name}");

            if (targetMaterials == null)
            {
                Debug.LogError($"[{nameof(PosterDisplay)}] Target materials not set. Cannot apply downloaded texture. GameObject: {gameObject.name}");
                result.Dispose();
                SetState(PosterDisplayState.Error);
                return;
            }

            foreach (Material targetMaterial in targetMaterials)
            {
                if (targetMaterial == null)
                    continue;

                targetMaterial.SetTexture(posterTexPropID, result.Result);
            }

            SetState(PosterDisplayState.Displaying);
        }

        public override void OnImageLoadError(VRC.SDK3.Image.IVRCImageDownload result)
        {
            result.Dispose();

            if (currentState != PosterDisplayState.Loading)
            {
                Debug.LogWarning($"[{nameof(PosterDisplay)}] Received download error for a download that is expired or already handled. Ignoring. GameObject: {gameObject.name}");
                return;
            }

            Debug.LogError($"[{nameof(PosterDisplay)}] Failed to download image from URL: {endpoint}. Reason: {result.ErrorMessage}. GameObject: {gameObject.name}");
            SetState(PosterDisplayState.Error);
        }


        private void SetState(PosterDisplayState state)
        {
            currentState = state;

            if (animators == null)
                return;

            foreach (Animator animator in animators)
            {
                if (animator == null)
                    continue;

                animator.SetBool(animatorInitializingKey, state == PosterDisplayState.Initializing);
                animator.SetBool(animatorReadyKey, state == PosterDisplayState.Ready);
                animator.SetBool(animatorLoadingKey, state == PosterDisplayState.Loading);
                animator.SetBool(animatorDisplayingKey, state == PosterDisplayState.Displaying);
                animator.SetBool(animatorHaltingKey, state == PosterDisplayState.Halting);
                animator.SetBool(animatorErrorKey, state == PosterDisplayState.Error);
            }
        }

#if UNITY_EDITOR

        public void ClearMainTexture()
        {
            Material[] targetMaterials = ResolveTargetMaterials();
            int materialPropertyID = VRCShader.PropertyToID(posterTexPropName);

            foreach (Material targetMaterial in targetMaterials)
            {
                if (targetMaterial == null)
                    continue;

                targetMaterial.SetTexture(materialPropertyID, null);
            }
        }

#endif

    }

}
