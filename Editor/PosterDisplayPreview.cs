using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.Networking;
using Object = UnityEngine.Object;

namespace PosterDisplay
{
    internal sealed class PosterDisplayPreview : IDisposable
    {
        private sealed class OnlineImage
        {
            public UnityWebRequest request;
            public Texture2D texture;
            public string status;
        }

        private readonly Dictionary<string, OnlineImage> images = new Dictionary<string, OnlineImage>();
        private readonly Dictionary<MeshRenderer, Material> materials = new Dictionary<MeshRenderer, Material>();
        private readonly Dictionary<MeshRenderer, Material[]> originals = new Dictionary<MeshRenderer, Material[]>();
        private readonly Action repaint;
        private PosterDisplayManager manager;
        private Camera drawing;
        public bool Active { get; private set; }

        public PosterDisplayPreview(Action repaint)
        {
            this.repaint = repaint;
            Camera.onPreCull += BeforeCamera;
            Camera.onPostRender += AfterCamera;
            EditorApplication.update += Update;
        }

        public void DrawStatus(string url)
        {
            if (images.TryGetValue(url, out var image))
                EditorGUILayout.HelpBox(image.status, image.request != null || image.texture
                    ? MessageType.Info : MessageType.Warning);
        }

        public void Load(string url)
        {
            if (images.TryGetValue(url, out var old) && old.request != null) return;
            var image = old ?? new OnlineImage();
            image.request = UnityWebRequest.Get(url);
            image.request.timeout = 15;
            image.request.SendWebRequest();
            image.status = "正在检查展示链接…";
            images[url] = image;
        }

        public void Show(PosterDisplayManager value)
        {
            Active = true;
            manager = value;
            Refresh();
        }

        public void Refresh()
        {
            Restore();
            foreach (var material in materials.Values) Object.DestroyImmediate(material);
            materials.Clear();
            if (!Active || !manager) return;
            var fallback = PosterDisplayLayout.Asset<Texture2D>("58a9727bb51b8c122ab7d0ba6c5d6c19");
            foreach (var group in manager.groups)
            {
                var texture = fallback;
                if (PosterDisplayLayout.TryLink(group.url, out var link, out _) &&
                    images.TryGetValue(link.AbsoluteUri.TrimEnd('/'), out var image) && image.texture)
                    texture = image.texture;
                for (int i = 0; i < group.elements.Count; i++)
                {
                    var element = group.elements[i];
                    if (!element || element.scene != manager.gameObject.scene ||
                        !element.GetComponent<PosterDisplayElement>()) continue;
                    var renderer = element.GetComponent<MeshRenderer>();
                    if (!renderer || materials.ContainsKey(renderer)) continue;
                    var material = PosterDisplayLayout.CreateMaterial(manager, texture);
                    material.hideFlags = HideFlags.HideAndDontSave;
                    material.SetFloat("_TimeOffset", PosterDisplayLayout.Offset(manager.stagger, i, group.elements.Count));
                    materials.Add(renderer, material);
                }
            }
            SceneView.RepaintAll();
        }

        public void Stop()
        {
            Active = false;
            Refresh();
            SceneView.RepaintAll();
        }

        [Serializable]
        private class ApiError { public string message = ""; }

        private static string ReadError(UnityWebRequest request)
        {
            if (request.responseCode == 404)
            {
                string message = JsonUtility.FromJson<ApiError>(request.downloadHandler.text)?.message;
                switch (message)
                {
                    case "World not found": return "找不到此世界。";
                    case "No display slots found for this world":
                    case "Display slot not found": return "此世界中找不到该展示位。";
                    case "No active posting plan for this world":
                    case "No posting plan for this display slot": return "展示位有效，当前暂无投放。";
                }
            }
            return "未能取得图片：" + request.error;
        }

        private void Update()
        {
            foreach (var image in images.Values)
            {
                var request = image.request;
                if (request == null || !request.isDone) continue;
                try
                {
                    if (image.texture) Object.DestroyImmediate(image.texture);
                    image.texture = null;
                    if (request.result == UnityWebRequest.Result.Success)
                    {
                        var texture = new Texture2D(2, 2);
                        if (texture.LoadImage(request.downloadHandler.data, true))
                        {
                            texture.hideFlags = HideFlags.HideAndDontSave;
                            image.texture = texture;
                            image.status = "已加载当前投放。";
                        }
                        else
                        {
                            Object.DestroyImmediate(texture);
                            image.status = "链接返回的内容无法解码为图片。";
                        }
                    }
                    else image.status = ReadError(request);
                }
                catch (Exception ex) { image.status = "无法读取展示链接的响应：" + ex.Message; }
                finally { request.Dispose(); image.request = null; }
                Refresh();
                repaint();
            }
            if (Active && manager)
            {
                EditorApplication.QueuePlayerLoopUpdate();
                SceneView.RepaintAll();
            }
        }

        // Swap materials only while a Scene View camera renders. Scene saves, game cameras
        // and the build pipeline continue to see the authored materials.
        private void BeforeCamera(Camera camera)
        {
            if (!Active || camera.cameraType != CameraType.SceneView || drawing) return;
            drawing = camera;
            foreach (var pair in materials)
            {
                if (!pair.Key) continue;
                var slots = pair.Key.sharedMaterials;
                originals.Add(pair.Key, slots);
                var preview = (Material[])slots.Clone();
                if (preview.Length == 0) preview = new Material[1];
                preview[0] = pair.Value;
                pair.Key.sharedMaterials = preview;
            }
        }

        private void AfterCamera(Camera camera)
        {
            if (camera == drawing) Restore();
        }

        private void Restore()
        {
            foreach (var pair in originals)
                if (pair.Key) pair.Key.sharedMaterials = pair.Value;
            originals.Clear();
            drawing = null;
        }

        public void Dispose()
        {
            Camera.onPreCull -= BeforeCamera;
            Camera.onPostRender -= AfterCamera;
            EditorApplication.update -= Update;
            Stop();
            foreach (var image in images.Values)
            {
                image.request?.Abort();
                image.request?.Dispose();
                if (image.texture) Object.DestroyImmediate(image.texture);
            }
            images.Clear();
        }
    }
}
