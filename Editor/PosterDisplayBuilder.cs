using System;
using System.Linq;
using UdonSharpEditor;
using UnityEditor.Build;
using UnityEditor.Build.Reporting;
using UnityEngine;
using UnityEngine.SceneManagement;
using VRC.SDKBase;
using VRC.SDKBase.Editor.BuildPipeline;
using Object = UnityEngine.Object;

namespace PosterDisplay
{
    public class PosterDisplayBuilder : IProcessSceneWithReport, IVRCSDKBuildRequestedCallback
    {
        // Generate proxies before the SDK serializes Udon programs at order 0.
        public int callbackOrder => -1000;

        public bool OnBuildRequested(VRCSDKRequestedBuildType buildType) =>
            buildType != VRCSDKRequestedBuildType.Scene || CheckScene(SceneManager.GetActiveScene(), false);

        private static bool CheckScene(Scene scene, bool includeWarnings)
        {
            var issues = PosterDisplayLayout.Validate(scene);
            foreach (var issue in issues)
            {
                string message = $"{issue.manager.name} / 展示位 {issue.group + 1}：{issue.message}";
                if (issue.error) Debug.LogError(message, issue.manager);
                else if (includeWarnings) Debug.LogWarning(message, issue.manager);
            }
            return !issues.Any(issue => issue.error);
        }

        public void OnProcessScene(Scene scene, BuildReport report)
        {
            if (!CheckScene(scene, true))
                throw new BuildFailedException("请在展示位管理窗口修复配置错误后再 Build。");

            foreach (var controller in PosterDisplayLayout.Components<PosterDisplayController>(scene))
                controller.ClearMainTexture();

            foreach (var manager in PosterDisplayLayout.Components<PosterDisplayManager>(scene))
            {
                foreach (var group in manager.groups)
                {
                    if (group.elements.Count == 0) continue;
                    if (PosterDisplayLayout.TryLink(group.url, out var link, out _))
                        BuildGroup(manager, group, link);
                    else
                        foreach (var element in group.elements)
                            element.GetComponent<MeshRenderer>().enabled = false;
                }
                Object.DestroyImmediate(manager);
            }
            foreach (var element in PosterDisplayLayout.Components<PosterDisplayElement>(scene))
                Object.DestroyImmediate(element);
        }

        private static void BuildGroup(PosterDisplayManager manager, PosterDisplayGroup group, Uri link)
        {
            var root = new GameObject("Poster Display " + link.Segments.Last().TrimEnd('/'));
            SceneManager.MoveGameObjectToScene(root, manager.gameObject.scene);
            root.transform.SetParent(manager.transform, false);
            var controller = root.AddUdonSharpComponent<PosterDisplayController>();
            controller.endpoint = new VRCUrl(link.AbsoluteUri.TrimEnd('/'));
            controller.durationStatic = manager.duration;
            controller.durationEase = manager.transitionDuration;
            controller.posterTexPropName = PosterDisplayLayout.TextureProperty(manager.shading);
            controller.targetRenderers = new Renderer[group.elements.Count];
            controller.timeOffsets = new float[group.elements.Count];
            controller.animators = group.elements.Select(element => element.GetComponent<Animator>())
                .Where(animator => animator).ToArray();

            var material = PosterDisplayLayout.CreateMaterial(manager, null);
            for (int i = 0; i < group.elements.Count; i++)
            {
                var renderer = group.elements[i].GetComponent<MeshRenderer>();
                var materials = renderer.sharedMaterials;
                if (materials.Length == 0) materials = new Material[1];
                materials[0] = material;
                renderer.sharedMaterials = materials;
                controller.targetRenderers[i] = renderer;
                controller.timeOffsets[i] = PosterDisplayLayout.Offset(manager.stagger, i, group.elements.Count);
            }
            UdonSharpEditorUtility.CopyProxyToUdon(controller);
        }
    }
}
