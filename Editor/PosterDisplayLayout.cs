using System;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace PosterDisplay
{
    internal static class PosterDisplayLayout
    {
        private const int Columns = 4;
        private const int Rows = 2;
        public static T[] Components<T>(Scene scene) where T : Component =>
            scene.GetRootGameObjects().SelectMany(root => root.GetComponentsInChildren<T>(true)).ToArray();

        public static bool TryLink(string input, out Uri uri, out Guid slot)
        {
            slot = Guid.Empty;
            if (!Uri.TryCreate(input?.Trim(), UriKind.Absolute, out uri) ||
                uri.Scheme != Uri.UriSchemeHttps || uri.UserInfo.Length != 0 ||
                uri.Query.Length != 0 || uri.Fragment.Length != 0)
                return false;

            string[] parts = uri.AbsolutePath.TrimEnd('/').Split('/');
            return parts.Length == 7 && parts[1] == "api" && parts[2] == "v1" &&
                   parts[3] == "vrchat" && parts[4] == "display" &&
                   Guid.TryParseExact(parts[5], "D", out _) && Guid.TryParseExact(parts[6], "D", out slot);
        }

        public static float Offset(bool stagger, int index, int count) =>
            stagger ? index % (Columns * Rows) + (float)index / count : 0f;

        public static string TextureProperty(PosterShading shading) =>
            shading == PosterShading.PBR ? "_PosterTex" : "_MainTex";

        public static T Asset<T>(string guid) where T : UnityEngine.Object =>
            AssetDatabase.LoadAssetAtPath<T>(AssetDatabase.GUIDToAssetPath(guid));

        public static Material Template(PosterShading shading) => Asset<Material>(shading == PosterShading.PBR
            ? "2985387d365891fdcbb327ac82bbfb04" : "a685a537ee29130fb8fee2efc74ed44b");

        public static Material CreateMaterial(PosterDisplayManager manager, Texture texture)
        {
            var material = new Material(Template(manager.shading));
            material.SetTexture(TextureProperty(manager.shading), texture);
            material.SetFloat("_Idling", 0);
            material.SetFloat("_DurationStatic", manager.duration);
            material.SetFloat("_DurationEase", manager.transitionDuration);
            material.SetInt("_EaseAnimation", (int)manager.transition);
            material.SetInt("_Stride", 1);
            material.SetInt("_GridHorizontal", Columns);
            material.SetInt("_GridVertical", Rows);
            if (manager.shading == PosterShading.PBR)
            {
                material.SetFloat("_Smoothness", 1 - manager.roughness);
                material.SetColor("_EmissionColor", Color.white * manager.emission);
            }
            return material;
        }

        internal sealed class Issue
        {
            public PosterDisplayManager manager;
            public int group;
            public bool error;
            public string message;
        }

        public static List<Issue> Validate(Scene scene)
        {
            var issues = new List<Issue>();
            var slots = new Dictionary<Guid, (PosterDisplayManager, int)>();
            var elements = new Dictionary<GameObject, (PosterDisplayManager, int)>();
            var manualTargets = new HashSet<Renderer>(Components<PosterDisplayController>(scene)
                .Where(controller => controller.targetRenderers != null)
                .SelectMany(controller => controller.targetRenderers));
            foreach (var manager in Components<PosterDisplayManager>(scene))
            {
                for (int g = 0; g < manager.groups.Count; g++)
                {
                    var group = manager.groups[g];
                    void Report(string message, bool error = true) =>
                        issues.Add(new Issue { manager = manager, group = g, message = message, error = error });

                    if (!TryLink(group.url, out _, out var slot))
                        Report(string.IsNullOrWhiteSpace(group.url) ? "展示链接为空，Build 时将跳过这组。" :
                            "请输入网站复制的完整展示链接，Build 时将跳过这组。", false);
                    else if (slots.TryGetValue(slot, out var first))
                    {
                        Report($"展示位 ID 与 {first.Item1.name} 的第 {first.Item2 + 1} 组重复。");
                        issues.Add(new Issue { manager = first.Item1, group = first.Item2, error = true,
                            message = $"展示位 ID 与 {manager.name} 的第 {g + 1} 组重复。" });
                    }
                    else slots.Add(slot, (manager, g));

                    for (int i = 0; i < group.elements.Count; i++)
                    {
                        var element = group.elements[i];
                        string label = $"Element {i + 1}";
                        if (!element) Report($"{label} 引用为空。");
                        else if (element.scene != scene || !element.GetComponent<PosterDisplayElement>() ||
                                 !element.GetComponent<MeshRenderer>())
                            Report($"{label} 需要引用当前 Scene 中带 Display Element 和 MeshRenderer 的对象。");
                        else if (elements.TryGetValue(element, out var owner))
                            Report($"{label} 已分配给 {owner.Item1.name} 的第 {owner.Item2 + 1} 组。");
                        else if (manualTargets.Contains(element.GetComponent<MeshRenderer>()))
                            Report($"{label} 已由场景中的手动 Controller 管理，请先解除该引用。");
                        else elements.Add(element, (manager, g));
                    }
                }
            }
            return issues;
        }
    }
}
