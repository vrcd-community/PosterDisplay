// all the ease animation modes
// 0: none
// 1: slide to right
// 2: slide to left
// 3: slide to bottom
// 4: slide to top
// 5: fade
// 6: zoom in
// 7: zoom out

inline float2 EaseAnimationSlideToRight(float2 uvSurface, float2 margin, float2 uvCurrentFrame, float2 uvNextFrame, float2 uvCellSize, float easeFactor)
{
    float2 surfaceUVMargined = uvSurface * (1 - margin * 2) + margin; // apply cell margin to uv
    float2 uv;
    if (uvSurface.x < easeFactor)
    {
        // left part of the surface is from the next frame
        // sample next frame with uv shifted to the left by (1 - easeFactor) of the frame width
        uv.x = (surfaceUVMargined.x + uvNextFrame.x + (1 - easeFactor)) * uvCellSize.x;
        uv.y = (surfaceUVMargined.y + uvNextFrame.y) * uvCellSize.y;
    }
    else
    {
        // right part of the surface is from the current frame
        // sample current frame with uv shifted to the left by easeFactor of the frame width
        uv.x = (surfaceUVMargined.x + uvCurrentFrame.x - easeFactor) * uvCellSize.x;
        uv.y = (surfaceUVMargined.y + uvCurrentFrame.y) * uvCellSize.y;
    }
    return uv;
}

inline float2 EaseAnimationSlideToLeft(float2 uvSurface, float2 margin, float2 uvCurrentFrame, float2 uvNextFrame, float2 uvCellSize, float easeFactor)
{
    float2 surfaceUVMargined = uvSurface * (1 - margin * 2) + margin;
    float2 uv;
    if (uvSurface.x > 1.0 - easeFactor)
    {
        uv.x = (surfaceUVMargined.x + uvNextFrame.x - (1.0 - easeFactor)) * uvCellSize.x;
        uv.y = (surfaceUVMargined.y + uvNextFrame.y) * uvCellSize.y;
    }
    else
    {
        uv.x = (surfaceUVMargined.x + uvCurrentFrame.x + easeFactor) * uvCellSize.x;
        uv.y = (surfaceUVMargined.y + uvCurrentFrame.y) * uvCellSize.y;
    }
    return uv;
}

inline float2 EaseAnimationSlideToBottom(float2 uvSurface, float2 margin, float2 uvCurrentFrame, float2 uvNextFrame, float2 uvCellSize, float easeFactor)
{
    float2 surfaceUVMargined = uvSurface * (1 - margin * 2) + margin;
    float2 uv;
    if (uvSurface.y > 1.0 - easeFactor)
    {
        uv.x = (surfaceUVMargined.x + uvNextFrame.x) * uvCellSize.x;
        uv.y = (surfaceUVMargined.y + uvNextFrame.y - (1.0 - easeFactor)) * uvCellSize.y;
    }
    else
    {
        uv.x = (surfaceUVMargined.x + uvCurrentFrame.x) * uvCellSize.x;
        uv.y = (surfaceUVMargined.y + uvCurrentFrame.y + easeFactor) * uvCellSize.y;
    }
    return uv;
}

inline float2 EaseAnimationSlideToTop(float2 uvSurface, float2 margin, float2 uvCurrentFrame, float2 uvNextFrame, float2 uvCellSize, float easeFactor)
{
    float2 surfaceUVMargined = uvSurface * (1 - margin * 2) + margin;
    float2 uv;
    if (uvSurface.y < easeFactor)
    {
        uv.x = (surfaceUVMargined.x + uvNextFrame.x) * uvCellSize.x;
        uv.y = (surfaceUVMargined.y + uvNextFrame.y + (1.0 - easeFactor)) * uvCellSize.y;
    }
    else
    {
        uv.x = (surfaceUVMargined.x + uvCurrentFrame.x) * uvCellSize.x;
        uv.y = (surfaceUVMargined.y + uvCurrentFrame.y - easeFactor) * uvCellSize.y;
    }
    return uv;
}

inline float2 EaseAnimationFrameUV(float2 uvSurface, float2 margin, float2 uvFrame, float2 uvCellSize)
{
    // uvFrame is the cell index in the grid.
    float2 surfaceUVMargined = uvSurface * (1 - margin * 2) + margin;
    return (surfaceUVMargined + uvFrame) * uvCellSize;
}

inline float2 EaseAnimationZoomSurface(float2 uvSurface, float zoom)
{
    return (uvSurface - 0.5) / zoom + 0.5;
}

inline float EaseAnimationInsideCell(float2 uvAtlas, float2 uvFrame, float2 uvCellSize)
{
    float2 cellMin = uvFrame * uvCellSize;
    float2 cellMax = cellMin + uvCellSize;
    return step(cellMin.x, uvAtlas.x) * step(cellMin.y, uvAtlas.y) * step(uvAtlas.x, cellMax.x) * step(uvAtlas.y, cellMax.y);
}

inline void EaseAnimation(float2 uvSurface, float2 margin, float2 uvCurrentFrame, float2 uvNextFrame, float2 uvCellSize, float easeFactor, int animationType,
    out float2 uvPrimary, out float2 uvSecondary, out float blend, out float useBlend)
{
    easeFactor = saturate(easeFactor);
    // Default: show current frame only.
    uvPrimary = EaseAnimationFrameUV(uvSurface, margin, uvCurrentFrame, uvCellSize);
    uvSecondary = EaseAnimationFrameUV(uvSurface, margin, uvNextFrame, uvCellSize);
    blend = easeFactor;
    useBlend = 0.0;

    if (animationType == 1)
    {
        uvPrimary = EaseAnimationSlideToRight(uvSurface, margin, uvCurrentFrame, uvNextFrame, uvCellSize, easeFactor);
        return;
    }
    if (animationType == 2)
    {
        uvPrimary = EaseAnimationSlideToLeft(uvSurface, margin, uvCurrentFrame, uvNextFrame, uvCellSize, easeFactor);
        return;
    }
    if (animationType == 3)
    {
        uvPrimary = EaseAnimationSlideToBottom(uvSurface, margin, uvCurrentFrame, uvNextFrame, uvCellSize, easeFactor);
        return;
    }
    if (animationType == 4)
    {
        uvPrimary = EaseAnimationSlideToTop(uvSurface, margin, uvCurrentFrame, uvNextFrame, uvCellSize, easeFactor);
        return;
    }
    if (animationType == 5)
    {
        // Fade between current and next.
        useBlend = 1.0;
        return;
    }
    if (animationType == 6)
    {
        // Zoom-in next frame while blending in.
        float zoom = lerp(0.5, 1.0, easeFactor);
        float2 uvZoomNext = EaseAnimationZoomSurface(uvSurface, zoom);
        uvSecondary = EaseAnimationFrameUV(uvZoomNext, margin, uvNextFrame, uvCellSize);
        // Only blend where the zoomed atlas UV stays inside the next cell.
        useBlend = EaseAnimationInsideCell(uvSecondary, uvNextFrame, uvCellSize);
        blend = blend * useBlend;
        return;
    }
    if (animationType == 7)
    {
        // Zoom-out current frame while blending out.
        float zoom = lerp(1.0, 2.0, easeFactor);
        float2 uvZoomCurrent = EaseAnimationZoomSurface(uvSurface, zoom);
        uvPrimary = EaseAnimationFrameUV(uvZoomCurrent, margin, uvCurrentFrame, uvCellSize);
        useBlend = 1.0;
        return;
    }
}

inline float2 EaseAnimation(float2 uvSurface, float2 margin, float2 uvCurrentFrame, float2 uvNextFrame, float2 uvCellSize, float easeFactor, int animationType)
{
    float2 uvPrimary;
    float2 uvSecondary;
    float blend;
    float useBlend;
    EaseAnimation(uvSurface, margin, uvCurrentFrame, uvNextFrame, uvCellSize, easeFactor, animationType, uvPrimary, uvSecondary, blend, useBlend);
    return uvPrimary;
}