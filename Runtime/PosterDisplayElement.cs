#if UNITY_EDITOR
using UnityEngine;
using VRC.SDKBase;

namespace PosterDisplay
{
    [DisallowMultipleComponent]
    [RequireComponent(typeof(MeshRenderer))]
    [AddComponentMenu("Poster Display/Display Element")]
    public class PosterDisplayElement : MonoBehaviour, IEditorOnly
    {
    }
}
#endif
