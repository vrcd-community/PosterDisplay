#if UNITY_EDITOR
using PosterDisplay;
using UnityEditor.Build;
using UnityEditor.Build.Reporting;
using UnityEngine;

namespace PosterDisplay
{

    public class PosterDisplayBuilder : IProcessSceneWithReport
    {
        public int callbackOrder => 0;

        public void OnProcessScene(UnityEngine.SceneManagement.Scene scene, BuildReport report)
        {
            Process();
        }

        private void Process()
        {
            ClearDebugTextures();
        }

        private void ClearDebugTextures()
        {
            PosterDisplayController[] targets = FindComponentGlobal<PosterDisplayController>();

            int count = 0;
            foreach (PosterDisplayController target in targets)
            {
                if (target == null) continue;

                target.ClearMainTexture();
                count++;
            }
            
            Debug.Log($"[{nameof(PosterDisplayBuilder)}] Cleared textures for {count} PosterDisplayController instances.");
        }

        public T[] FindComponentGlobal<T>() where T : Component
        {
            T[] components = Object.FindObjectsOfType<T>(true);
            if (components.Length == 0)
            {
                Debug.Log($"[{nameof(PosterDisplayBuilder)}] No {typeof(T).Name} found in scene.");
                return null;
            }

            Debug.Log($"[{nameof(PosterDisplayBuilder)}] Found {components.Length} {typeof(T).Name} in scene.");

            return components;
        }
    }

}
#endif