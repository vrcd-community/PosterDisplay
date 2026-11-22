using System;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace PosterDisplay
{
    [CustomEditor(typeof(PosterDisplayManager))]
    internal class PosterDisplayManagerInspector : Editor
    {
        private PosterDisplayManager manager => (PosterDisplayManager)target;
        private PosterDisplayPreview preview;
        private List<PosterDisplayLayout.Issue> issues;

        [MenuItem("Tools/VRCD/展示位管理")]
        private static void SelectManager()
        {
            var scene = SceneManager.GetActiveScene();
            var existing = Selection.activeGameObject?.GetComponentInParent<PosterDisplayManager>();
            if (!existing || existing.gameObject.scene != scene)
                existing = PosterDisplayLayout.Components<PosterDisplayManager>(scene).FirstOrDefault();
            if (!existing)
            {
                var go = new GameObject("Poster Display Manager");
                existing = go.AddComponent<PosterDisplayManager>();
                Undo.RegisterCreatedObjectUndo(go, "创建展示位管理对象");
            }
            Selection.activeGameObject = existing.gameObject;
            EditorGUIUtility.PingObject(existing.gameObject);
        }

        [MenuItem("Tools/VRCD/展示位管理", true)]
        private static bool CanSelectManager() => !EditorApplication.isPlayingOrWillChangePlaymode &&
            PrefabStageUtility.GetCurrentPrefabStage() == null && SceneManager.GetActiveScene().isLoaded;

        private void OnEnable()
        {
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

        public override void OnInspectorGUI()
        {
            var scene = manager.gameObject.scene;
            if (EditorApplication.isPlayingOrWillChangePlaymode || !scene.IsValid() || !scene.isLoaded ||
                PrefabStageUtility.GetPrefabStage(manager.gameObject) != null)
            {
                EditorGUILayout.HelpBox("请在 Scene 的 Edit Mode 中管理展示位。", MessageType.Info);
                return;
            }
            EditorGUILayout.LabelField("管理海报", EditorStyles.boldLabel);
            for (int g = 0; g < manager.groups.Count; g++) DrawGroup(g);
            if (GUILayout.Button("添加展示位")) Edit("添加展示位", () => manager.groups.Add(new PosterDisplayGroup()));
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("显示设置", EditorStyles.boldLabel);
            DrawDisplay();
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("着色设置", EditorStyles.boldLabel);
            DrawShading();
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
                if (GUILayout.Button("新建 Element")) CreateElement(group);
                var addition = (PosterDisplayElement)EditorGUILayout.ObjectField("加入已有 Element", null,
                    typeof(PosterDisplayElement), true);
                if (addition && addition.gameObject.scene == manager.gameObject.scene && !group.elements.Contains(addition.gameObject))
                    Edit("加入已有 Element", () => group.elements.Add(addition.gameObject));
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
                    DeleteElement(group, index);
                    GUIUtility.ExitGUI();
                }
            }
        }

        private void DeleteElement(PosterDisplayGroup group, int index)
        {
            var element = group.elements[index];
            var scene = manager.gameObject.scene;
            if (!element || element.scene != scene || !element.GetComponent<PosterDisplayElement>() ||
                manager.transform.IsChildOf(element.transform))
            {
                Edit("删除 Element", () => group.elements.RemoveAt(index));
                return;
            }

            // Removing a parent also destroys its children. Include their bindings in the same Undo.
            bool WillBeDestroyed(GameObject obj) => obj && obj.transform.IsChildOf(element.transform);
            Undo.IncrementCurrentGroup();
            int undo = Undo.GetCurrentGroup();
            Undo.SetCurrentGroupName("删除 Element");
            foreach (var owner in PosterDisplayLayout.Components<PosterDisplayManager>(scene))
            {
                if (!owner.groups.Any(slot => slot.elements.Exists(WillBeDestroyed))) continue;
                Undo.RegisterCompleteObjectUndo(owner, "删除 Element");
                foreach (var slot in owner.groups) slot.elements.RemoveAll(WillBeDestroyed);
                PrefabUtility.RecordPrefabInstancePropertyModifications(owner);
            }
            Undo.DestroyObjectImmediate(element);
            Undo.CollapseUndoOperations(undo);
            Changed();
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

}
