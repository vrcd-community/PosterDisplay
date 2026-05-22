Shader "Xuan25/PosterDisplay/Unlit"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MainTint ("Tint", Color) = (1,1,1,1)
        _DurationStatic ("Static Duration", Float) = 20.0
        _DurationEase ("Ease Duration", Float) = 0.5
        _GridHorizontal ("Grid Horizontal", Int) = 4
        _GridVertical ("Grid Vertical", Int) = 2
        _CellMargin ("Cell Margin", Float) = 0.01
        // all the ease functions
        // 0: easeInSine
        // 1: easeOutSine
        // 2: easeInOutSine
        // 3: easeInQuad
        // 4: easeOutQuad
        // 5: easeInOutQuad
        // 6: easeInCubic
        // 7: easeOutCubic
        // 8: easeInOutCubic
        // 9: easeInQuart
        // 10: easeOutQuart
        // 11: easeInOutQuart
        // 12: easeInQuint
        // 13: easeOutQuint
        // 14: easeInOutQuint
        // 15: easeInExpo
        // 16: easeOutExpo
        // 17: easeInOutExpo
        // 18: easeInCirc
        // 19: easeOutCirc
        // 20: easeInOutCirc
        // 21: easeInBack
        // 22: easeOutBack
        // 23: easeInOutBack
        // 24: easeInElastic
        // 25: easeOutElastic
        // 26: easeInOutElastic
        // 27: easeInBounce
        // 28: easeOutBounce
        // 29: easeInOutBounce
        [KeywordEnum(easeInSine, easeOutSine, easeInOutSine, easeInQuad, easeOutQuad, easeInOutQuad, easeInCubic, easeOutCubic, easeInOutCubic, easeInQuart, easeOutQuart, easeInOutQuart, easeInQuint, easeOutQuint, easeInOutQuint, easeInExpo, easeOutExpo, easeInOutExpo, easeInCirc, easeOutCirc, easeInOutCirc, easeInBack, easeOutBack, easeInOutBack, easeInElastic, easeOutElastic, easeInOutElastic, easeInBounce, easeOutBounce, easeInOutBounce)]
        _EaseFunction ("Ease Function", Int) = 20
        
        _TimeOffset ("Time Offset", Float) = 0.0

        // all the ease animation modes
        // 0: none
        // 1: slide to right
        // 2: slide to left
        // 3: slide to bottom
        // 4: slide to top
        // 5: fade
        // 6: zoom in
        // 7: zoom out
        [KeywordEnum(None, SlideToRight, SlideToLeft, SlideToBottom, SlideToTop, Fade, ZoomIn, ZoomOut)]
        _EaseAnimation ("Ease Animation", Int) = 7
        
        _IdleTex ("Idle Texture", 2D) = "black" {}
        _IdleTint ("Idle Tint", Color) = (1,1,1,1)
        _Idling ("Idling", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"
            #include "Inc/PosterDisplay.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _MainTint;

            float _DurationStatic;
            float _DurationEase;

            float _TimeOffset;

            int _GridHorizontal;
            int _GridVertical;
            float _CellMargin;

            int _EaseFunction;
            int _EaseAnimation;

            sampler2D _IdleTex;
            float4 _IdleTex_ST;
            float4 _IdleTint;
            
            float _Idling;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = GetPosterColor(
                    i.uv,
                    _TimeOffset,
                    _DurationStatic,
                    _DurationEase,
                    _GridHorizontal,
                    _GridVertical,
                    _CellMargin,
                    _EaseFunction,
                    _EaseAnimation,
                    _MainTex, _MainTex_ST, _MainTint,
                    _IdleTex, _IdleTex_ST, _IdleTint,
                    _Idling
                );

                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
