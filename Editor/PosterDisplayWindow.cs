using System;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace PosterDisplay
{
    public class PosterDisplayWindow : EditorWindow
    {
        [SerializeField] private PosterDisplayManager manager;
        private PosterDisplayPreview preview;
        private Vector2 scroll;
        private List<PosterDisplayLayout.Issue> issues;
        private bool showGroups = true, showDisplay = true, showShading = true;

        [MenuItem("Tools/VRCD/展示位管理")]
        public static void Open() => GetWindow<PosterDisplayWindow>("展示位管理").Show();

        internal static void Open(PosterDisplayManager target)
        {
            var window = GetWindow<PosterDisplayWindow>("展示位管理");
            window.Bind(target);
            window.Show();
        }

        private void OnEnable()
        {
            minSize = new Vector2(370, 320);
            preview = new PosterDisplayPreview(Repaint);
            Undo.undoRedoPerformed += Changed;
            EditorApplication.hierarchyChanged += Changed;
            EditorApplication.playModeStateChanged += PlayModeChanged;
        }

        private void OnDisable()
        {
            Undo.undoRedoPerformed -= Changed;
            EditorApplication.hierarchyChanged -= Changed;
            EditorApplication.playModeStateChanged -= PlayModeChanged;
            preview?.Dispose();
        }

        private void PlayModeChanged(PlayModeStateChange state)
        {
            if (state == PlayModeStateChange.ExitingEditMode) preview.Stop();
            Changed();
        }

        private void Bind(PosterDisplayManager target)
        {
            preview?.Stop();
            manager = target;
            Changed();
        }

        private void Changed()
        {
            issues = null;
            preview?.Refresh();
            Repaint();
        }

        private void Edit(string label, Action action)
        {
            Undo.RecordObject(manager, label);
            action();
            PrefabUtility.RecordPrefabInstancePropertyModifications(manager);
            EditorSceneManager.MarkSceneDirty(manager.gameObject.scene);
            Changed();
        }

        private void OnGUI()
        {
            if (EditorApplication.isPlayingOrWillChangePlaymode || PrefabStageUtility.GetCurrentPrefabStage() != null)
            {
                EditorGUILayout.HelpBox("请在 Scene 的 Edit Mode 中管理展示位。", MessageType.Info);
                return;
            }
            var scene = SceneManager.GetActiveScene();
            if (!scene.IsValid() || !scene.isLoaded) return;
            if (!manager || manager.gameObject.scene != scene)
            {
                var first = PosterDisplayLayout.Components<PosterDisplayManager>(scene).FirstOrDefault();
                if (manager != first) Bind(first);
            }
            if (!manager)
            {
                if (GUILayout.Button("在当前 Scene 创建展示位管理对象"))
                {
                    var go = new GameObject("Poster Display Manager");
                    var target = go.AddComponent<PosterDisplayManager>();
                    Undo.RegisterCreatedObjectUndo(go, "创建展示位管理对象");
                    Selection.activeGameObject = go;
                    Bind(target);
                }
                return;
            }

            var selected = (PosterDisplayManager)EditorGUILayout.ObjectField("管理对象", manager, typeof(PosterDisplayManager), true);
            if (selected && selected != manager && selected.gameObject.scene == scene) Bind(selected);
            issues = issues ?? PosterDisplayLayout.Validate(scene);
            using (var view = new EditorGUILayout.ScrollViewScope(scroll))
            {
                scroll = view.scrollPosition;
                showGroups = EditorGUILayout.Foldout(showGroups, "管理海报", true);
                if (showGroups)
                {
                    for (int g = 0; g < manager.groups.Count; g++) DrawGroup(g);
                    if (GUILayout.Button("添加展示位")) Edit("添加展示位", () => manager.groups.Add(new PosterDisplayGroup()));
                }
                EditorGUILayout.Space();
                showDisplay = EditorGUILayout.Foldout(showDisplay, "显示设置", true);
                if (showDisplay) DrawDisplay();
                EditorGUILayout.Space();
                showShading = EditorGUILayout.Foldout(showShading, "着色设置", true);
                if (showShading) DrawShading();
            }
            if (GUILayout.Button(preview.Active ? "停止预览" : "在 Scene View 预览"))
            {
                if (preview.Active) preview.Stop();
                else preview.Show(manager);
            }
        }

        private void DrawGroup(int index)
        {
            var group = manager.groups[index];
            using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
            {
                using (new EditorGUILayout.HorizontalScope())
                {
                    EditorGUILayout.LabelField($"展示位 {index + 1}", EditorStyles.boldLabel);
                    if (GUILayout.Button("移除组", GUILayout.Width(58)) &&
                        (group.elements.Count == 0 || EditorUtility.DisplayDialog("移除展示位",
                            "移除整组引用，场景中的海报对象会保留。", "移除组", "取消")))
                    {
                        Edit("移除展示位", () => manager.groups.RemoveAt(index));
                        GUIUtility.ExitGUI();
                    }
                }
                string url = EditorGUILayout.TextField("完整展示链接", group.url);
                if (url != group.url) Edit("修改展示链接", () => group.url = url.Trim());
                if (PosterDisplayLayout.TryLink(group.url, out var uri, out var slot))
                {
                    EditorGUILayout.LabelField("World ID", uri.Segments[5].TrimEnd('/'));
                    EditorGUILayout.LabelField("Slot ID", slot.ToString());
                    string address = uri.AbsoluteUri.TrimEnd('/');
                    if (GUILayout.Button("检查链接并加载当前投放"))
                    {
                        preview.Show(manager);
                        preview.Load(address);
                    }
                    preview.DrawStatus(address);
                }
                foreach (var issue in (issues ?? (issues = PosterDisplayLayout.Validate(manager.gameObject.scene)))
                    .Where(item => item.manager == manager && item.group == index))
                    EditorGUILayout.HelpBox(issue.message, issue.error ? MessageType.Error : MessageType.Warning);

                for (int i = 0; i < group.elements.Count; i++) DrawElement(group, i);
                using (new EditorGUILayout.HorizontalScope())
                {
                    if (GUILayout.Button("新建 Element")) CreateElement(group);
                    var selected = Selection.activeGameObject;
                    using (new EditorGUI.DisabledScope(!selected || selected.scene != manager.gameObject.scene ||
                        !selected.GetComponent<PosterDisplayElement>() || group.elements.Contains(selected)))
                        if (GUILayout.Button("加入所选 Element"))
                            Edit("加入所选 Element", () => group.elements.Add(selected));
                }
            }
        }

        private void DrawElement(PosterDisplayGroup group, int index)
        {
            using (new EditorGUILayout.HorizontalScope())
            {
                GUILayout.Label($"Element {index + 1}", GUILayout.Width(70));
                var element = group.elements[index];
                var target = (GameObject)EditorGUILayout.ObjectField(element, typeof(GameObject), true);
                if (target != element) Edit("分配 Element", () => group.elements[index] = target);
                using (new EditorGUI.DisabledScope(!element))
                {
                    if (GUILayout.Button("定位", GUILayout.Width(40)))
                    {
                        Selection.activeGameObject = element;
                        SceneView.lastActiveSceneView?.FrameSelected();
                    }
                }
                using (new EditorGUI.DisabledScope(index == 0))
                    if (GUILayout.Button("↑", GUILayout.Width(24))) MoveElement(group, index, index - 1);
                using (new EditorGUI.DisabledScope(index + 1 == group.elements.Count))
                    if (GUILayout.Button("↓", GUILayout.Width(24))) MoveElement(group, index, index + 1);
                if (GUILayout.Button("−", GUILayout.Width(24)))
                {
                    int choice = element ? EditorUtility.DisplayDialogComplex("移除 Element",
                        "可以同时删除场景对象，或仅移除该展示位中的引用。", "仅移除引用", "取消", "删除对象") : 0;
                    if (choice == 1) return;
                    Edit("移除 Element", () => group.elements.RemoveAt(index));
                    if (choice == 2) Undo.DestroyObjectImmediate(element);
                    GUIUtility.ExitGUI();
                }
            }
        }

        private void MoveElement(PosterDisplayGroup group, int from, int to)
        {
            Edit("调整 Element 顺序", () =>
            {
                var element = group.elements[from];
                group.elements.RemoveAt(from);
                group.elements.Insert(to, element);
            });
            GUIUtility.ExitGUI();
        }

        private void CreateElement(PosterDisplayGroup group)
        {
            var element = GameObject.CreatePrimitive(PrimitiveType.Quad);
            element.name = GameObjectUtility.GetUniqueNameForSibling(manager.transform, "Poster Element");
            element.transform.SetParent(manager.transform, false);
            element.transform.localScale = new Vector3(0.9f, 1.6f, 1f);
            DestroyImmediate(element.GetComponent<Collider>());
            element.AddComponent<PosterDisplayElement>();
            Undo.RegisterCreatedObjectUndo(element, "创建海报 Element");
            Edit("创建海报 Element", () => group.elements.Add(element));
            Selection.activeGameObject = element;
            EditorGUIUtility.PingObject(element);
        }

        private void DrawDisplay()
        {
            EditorGUI.BeginChangeCheck();
            bool stagger = EditorGUILayout.Toggle("错开展示海报", manager.stagger);
            float duration = Mathf.Max(8, EditorGUILayout.FloatField("展示时间（秒）", manager.duration));
            var animation = (PosterTransition)EditorGUILayout.EnumPopup("翻页类型", manager.transition);
            float ease = EditorGUILayout.Slider("翻页时间（秒）", manager.transitionDuration, 0, 2);
            if (EditorGUI.EndChangeCheck()) Edit("修改显示设置", () =>
            {
                manager.stagger = stagger;
                manager.duration = duration;
                manager.transition = animation;
                manager.transitionDuration = ease;
            });
        }

        private void DrawShading()
        {
            EditorGUI.BeginChangeCheck();
            var shading = (PosterShading)EditorGUILayout.EnumPopup("着色类型", manager.shading);
            float roughness = manager.roughness;
            float emission = manager.emission;
            if (shading == PosterShading.PBR)
            {
                roughness = EditorGUILayout.Slider("粗糙度", roughness, 0, 1);
                emission = Mathf.Max(0, EditorGUILayout.FloatField("自发光强度", emission));
            }
            if (EditorGUI.EndChangeCheck()) Edit("修改着色设置", () =>
            {
                manager.shading = shading;
                manager.roughness = roughness;
                manager.emission = emission;
            });
        }
    }

    [CustomEditor(typeof(PosterDisplayManager))]
    internal class PosterDisplayManagerInspector : Editor
    {
        public override void OnInspectorGUI()
        {
            if (GUILayout.Button("打开展示位管理")) PosterDisplayWindow.Open((PosterDisplayManager)target);
        }
    }
}
