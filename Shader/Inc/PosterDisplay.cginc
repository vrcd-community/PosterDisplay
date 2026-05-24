#include "EaseFunctions.cginc"
#include "EaseAnimations.cginc"
#include "EaseBlend.cginc"

#define glsl_mod(x,y) (((x)-(y)*floor((x)/(y))))

fixed4 GetPosterColor(
    float2 uv, 
    float timeOffset, 
    float durationStatic, 
    float durationEase, 
    int gridHorizontal, 
    int gridVertical, 
    int stride, 
    float cellMargin, 
    int easeFunction, 
    int easeAnimation, 
    sampler2D mainTex, 
    float4 mainTex_ST, 
    float4 mainTint, 
    sampler2D idleTex, 
    float4 idleTex_ST, 
    float4 idleTint, 
    float idling,
    int idleBlendMode,
    sampler2D idleBlendMaskTex,
    float4 idleBlendMaskTex_ST,
    float idleBlendMaskFeather) {

    if (idling == 1.0)
    {
        // if fully idling, skip animation and just show the idling texture
        float2 uvIdling = uv * idleTex_ST.xy + idleTex_ST.zw;
        uvIdling = saturate(uvIdling);
        fixed4 colIdling = tex2D(idleTex, uvIdling);
        colIdling *= idleTint;
        return colIdling;
    }

    // Resolve current/next frame indices from time.
    int frameOffset = timeOffset;
    float durationOffsetWithinFrame = timeOffset % 1.0; // fractional part of timeOffset for blending

    float durationPerFrame = durationStatic + durationEase;
    float time = _Time.y + durationOffsetWithinFrame * durationPerFrame;
    
    int numFrames = gridHorizontal * gridVertical;

    float durationCycle = durationPerFrame * numFrames;

    float timeInCycle = glsl_mod(time, durationCycle);

    uint fromFrame = (uint)(timeInCycle / durationPerFrame);
    uint toFrame = (fromFrame + 1) % numFrames;

    // Apply stride to frame indices
    fromFrame = (fromFrame * stride + frameOffset) % numFrames;
    toFrame = (toFrame * stride + frameOffset) % numFrames;

    float timeInFrame = glsl_mod(timeInCycle, durationPerFrame);

    // Ease factor goes 0..1 during the ease window, then stays at 1 during the static window.
    float easeRatio = (durationEase > 0.0001) ? saturate(timeInFrame / durationEase) : 1.0;
    float easeFactor = EaseFunction(easeRatio, easeFunction);

    int2 uvCurrentFrame = int2(fromFrame % gridHorizontal, fromFrame / gridHorizontal);
    int2 uvNextFrame = int2(toFrame % gridHorizontal, toFrame / gridHorizontal);
    float2 uvCellSize = float2(1.0 / gridHorizontal, 1.0 / gridVertical);

    float2 uvPrimary;
    float2 uvSecondary;
    float blend;
    float useBlend;
    EaseAnimation(uv, cellMargin, uvCurrentFrame, uvNextFrame, uvCellSize, easeFactor, easeAnimation, uvPrimary, uvSecondary, blend, useBlend);

    // apply texture scale and offset
    uvPrimary = uvPrimary * mainTex_ST.xy + mainTex_ST.zw;
    // clamp uv to [0,1]
    uvPrimary = saturate(uvPrimary);
    
    // sample the texture
    fixed4 col = tex2D(mainTex, uvPrimary);
    if (useBlend > 0.5)
    {
        // apply texture scale and offset for secondary
        uvSecondary = uvSecondary * mainTex_ST.xy + mainTex_ST.zw;
        // clamp uv to [0,1] for secondary
        uvSecondary = saturate(uvSecondary);
        // sample the secondary texture and blend
        fixed4 colNext = tex2D(mainTex, uvSecondary);
        col = lerp(col, colNext, blend);
    }

    // apply main tint
    col *= mainTint;

    idling = saturate(idling);
    if (idling > 0.0)
    {
        float2 uvIdling = uv * idleTex_ST.xy + idleTex_ST.zw;
        uvIdling = saturate(uvIdling);
        fixed4 colIdling = tex2D(idleTex, uvIdling);
        colIdling *= idleTint;

        col = EaseBlend(col, colIdling, idling, idleBlendMode, uv, idleBlendMaskTex, idleBlendMaskTex_ST, idleBlendMaskFeather);
    }

    return col;
}