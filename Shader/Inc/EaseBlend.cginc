// all the ease blend modes
// 0: blend mode: lerp
// 1: blend mode: mask (using a mask texture to control the blending, with feathering support)
fixed4 EaseBlend(
    fixed4 colorPrimary,
    fixed4 colorSecondary,
    float easeFactor,
    int blendMode,
    float2 uv,
    sampler2D blendMaskTex,
    float4 blendMaskTex_ST,
    float blendMaskFeather)
{
    if (blendMode == 0) // blend mode: lerp
    {
        return lerp(colorPrimary, colorSecondary, easeFactor);
    }
    if (blendMode == 1) // blend mode: mask
    {
        float2 uvMask = uv * blendMaskTex_ST.xy + blendMaskTex_ST.zw;
        uvMask = saturate(uvMask);
        fixed4 maskSample = tex2D(blendMaskTex, uvMask);
        float maskValue = (maskSample.r + maskSample.g + maskSample.b) / 3.0; // assuming mask is in RGB channels
        float blendFactor = 1.0 - smoothstep(easeFactor - blendMaskFeather, easeFactor + blendMaskFeather, maskValue);

        return lerp(colorPrimary, colorSecondary, blendFactor);
    }
    return colorPrimary; // default to primary color if blend mode is unrecognized
}