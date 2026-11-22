#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using UnityEngine;
using VRC.SDKBase;

namespace PosterDisplay
{
    [Serializable]
    public class PosterDisplayGroup
    {
        public string url = "";
        public List<GameObject> elements = new List<GameObject>();
    }

    public enum PosterTransition { None, SlideRight, SlideLeft, SlideDown, SlideUp, Fade, ZoomIn, ZoomOut }
    public enum PosterShading { Unlit, PBR }

    [DisallowMultipleComponent]
    [AddComponentMenu("Poster Display/Display Manager")]
    public class PosterDisplayManager : MonoBehaviour, IEditorOnly
    {
        [HideInInspector] public List<PosterDisplayGroup> groups = new List<PosterDisplayGroup>();
        [HideInInspector] public bool stagger = true;
        [HideInInspector] public float duration = 20f;
        [HideInInspector] public float transitionDuration = 0.5f;
        [HideInInspector] public PosterTransition transition = PosterTransition.ZoomOut;
        [HideInInspector] public PosterShading shading;
        [HideInInspector] public float roughness = 0.5f;
        [HideInInspector] public float emission = 1f;
    }
}
#endif
