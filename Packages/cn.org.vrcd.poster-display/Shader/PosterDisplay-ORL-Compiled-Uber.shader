Shader "Xuan25/PosterDisplay/ORL-Compiled/Uber"
{
    Properties {
        UI_MainHeader("# Main Settings", Int) = 1
        _Color("Main Color", Color) = (1, 1, 1, 1)
        _MainTex("Albedo", 2D) = "white" { }
        [Enum(RGB, 0, R, 1, G, 2, B, 3)][_MainTex]_AlbedoChannel("Albedo Channel %ShowIf(_MainTex)", Int) = 0
        [Enum(UV, 0, Local Space, 1, World Space, 2, Triplanar, 3)]_MappingSpace("Mapping Space", Int) = 0
        [Enum(X, 0, Y, 1, Z, 2)]_PlanarAxisX("X Axis %ShowIf(_MappingSpace > 0 && _MappingSpace < 3) %CombineWith(_PlanarAxisY)", Int) = 0
        [HideInInspector][Enum(X, 0, Y, 1, Z, 2)]_PlanarAxisY("Y Axis %ShowIf(_MappingSpace > 0 && _MappingSpace < 3)", Int) = 2
        [NoScaleOffset]_MaskMap("Masks >", 2D) = "white" { }
        [Enum(R, 0, G, 1, B, 2, A, 3)]_MetalChannel("Metal %ShowIf(_MaskMap) %CombineWith(_AOChannel, _DetailMaskChannel, _SmoothChannel)", Int) = 0
        [HideInInspector][Enum(R, 0, G, 1, B, 2, A, 3)]_AOChannel("AO", Int) = 1
        [HideInInspector][Enum(R, 0, G, 1, B, 2, A, 3)]_DetailMaskChannel("Detail", Int) = 2
        [HideInInspector][Enum(R, 0, G, 1, B, 2, A, 3)]_SmoothChannel("Smooth", Int) = 3
        _Smoothness("Smoothness %ShowIf(!_MaskMap)", Range(0, 1)) = 0.5
        [ToggleUI][_MaskMap]_RoughnessMode("Roughness Mode %ShowIf(_MaskMap)", Int) = 0
        _Metallic("Metallic %ShowIf(!_MaskMap)", Range(0, 1)) = 0
        _MetallicRemap("Metallic Remap %ShowIf(_MaskMap) %RemapSlider(0,1)", Vector) = (0, 1, 0, 1)
        _SmoothnessRemap("Smoothness Remap %ShowIf(_MaskMap) %RemapSlider(0,1)", Vector) = (0, 1, 0, 1)
        _OcclusionStrength("AO Strength %ShowIf(_MaskMap)", Range(0, 1)) = 1
        [ToggleUI]_DetailAsTintMask("Detail as Tint Mask %ShowIf(_MaskMap)", Int) =  0
        [NoScaleOffset]_BumpMap("Normal Map >", 2D) = "bump" { }
        _BumpScale("Normal Map Scale %ShowIf(_BumpMap)", Range(-1, 1)) = 1
        [ToggleUI]_FlipBumpY("Flip Y (UE Mode) %ShowIf(_BumpMap)", Int) = 0
        [Toggle(_EMISSION)]_EmissionEnabled("Emission", Int) = 0
        _EmissionMap("Emission Map > %ShowIf(_EMISSION)", 2D) = "white" { }
        [HDR]_EmissionColor("Emission Color %ShowIf(_EMISSION)", Color) = (0, 0, 0, 1)
        [Enum(RGB, 0, R, 1, G, 2, B, 3)][_EmissionMap]_EmissionChannel("Emission Channel %ShowIf(_EmissionMap)", Int) = 0
        UI_ParallaxHeader("# Parallax", Int) = 0
        UI_ParallaxDocs("[This module has documentation](https://shaders.orels.sh/docs/orl-standard/base-shader#parallax)", Int) = 0
        [Toggle(PARALLAX)]_EnableParallax("Enable Parallax", Int) = 0
        [NoScaleOffset]_Height("Height > %ShowIf(PARALLAX)", 2D) = "black" {}
        _HeightScale("Height Scale %ShowIf(PARALLAX)", Range(0, 0.1)) = 0.006
        _HeightRefPlane("Height Ref Plane %ShowIf(PARALLAX)", Range(-1, 1)) = 0.5
        [KeywordEnum(Eight, Sixteen,ThirtyTwo, SixtyFour)]_ParallaxSteps("Steps %ShowIf(PARALLAX)", Int) = 0
        [ToggleUI]_ParallaxScaleBasedOnAngle("Scaled Based On Angle %ShowIf(PARALLAX)", Int) = 0
        UI_ParallaxScaleBasedOnAngleNote("> This will scale the parallax effect based on the angle between the camera forward ray and the surface normal %ShowIf(PARALLAX)", Int) = 0
        UI_DetailsHeader("# Details", Int) = 0
        UI_DetailsDocs("[This module has documentation](https://shaders.orels.sh/docs/orl-standard/base-shader#details)", Int) = 0
        [Toggle(DETAILS_OVERLAY)]_DetailsOverlay("Enable Details", Int) = 0
        [ToggleUI]_DIgnoreMask("Ignore Mask %ShowIf(DETAILS_OVERLAY)", Int) = 0
        UI_IgnoreMaskNote("> Force-draws the detail effects %ShowIf(DETAILS_OVERLAY)", Int) = 0
        [KeywordEnum(Packed, Separated)]DETAILS_MODE("Detail Map Mode %ShowIf(DETAILS_OVERLAY)", Int) = 1
        _DDetailsMap("Details Map %ShowIf(DETAILS_OVERLAY)", 2D) = "gray" { }
        UI_DetailsMapNote("> R: Albedo, G: Normal G, B: Smooth, A: Normal R. Uncheck sRGB! %ShowIf(DETAILS_OVERLAY && DETAILS_MODE_PACKED)", Int) = 0
        UI_DetailsMapNoteSeparate("> RGB: Albedo, A: Smooth %ShowIf(DETAILS_OVERLAY && DETAILS_MODE_SEPARATED)", Int) = 0
        [NoScaleOffset]_DDetailsNormal("Details Normal Map > %ShowIf(DETAILS_OVERLAY && DETAILS_MODE_SEPARATED)", 2D) = "bump" { }
        [Enum(UV, 0, Local Space, 1, World Space, 2)]_DMappingSpace("Mapping Space %ShowIf(DETAILS_OVERLAY)", Int) = 0
        [Enum(UV1, 0, UV2, 1, UV3, 2, UV4, 3)]_DUVChannel("UV Set %ShowIf(_DMappingSpace == 0 && DETAILS_OVERLAY)", Int) = 0
        [Enum(X, 0, Y, 1, Z, 2)]_DPlanarAxisX("X Axis %ShowIf(_DMappingSpace > 0 && DETAILS_OVERLAY) %CombineWith(_DPlanarAxisY)", Int) = 0
        [HideInInspector][Enum(X, 0, Y, 1, Z, 2)]_DPlanarAxisY("Y Axis", Int) = 2
        _DAlbedoScale("Albedo Scale %ShowIf(DETAILS_OVERLAY)", Range(0.0, 2.0)) = 1
        UI_DetailAlbedoNote("> Values < 0.5 - darken, > 0.5 - lighten %ShowIf(DETAILS_OVERLAY && !_DAlbedoMixingLegacy)", Int) = 0
        UI_DAlbedoMixingLegacyNote("> Multiplies albedo by 2x the detail Albedo. Same as BIRP Standard Shader %ShowIf(DETAILS_OVERLAY && _DAlbedoMixingLegacy && DETAILS_MODE_SEPARATED)", Int) = 0
        [ToggleUI]_DAlbedoMixingLegacy("Legacy Albedo Mixing %ShowIf(DETAILS_OVERLAY && DETAILS_MODE_SEPARATED)", Int) = 0
        _DNormalScale("Normal Scale %ShowIf(DETAILS_OVERLAY)", Range(0.0, 2.0)) = 1
        [ToggleUI]_DNormalFlipY("Flip Y (UE Mode) %ShowIf(DETAILS_OVERLAY)", Int) = 0
        _DSmoothScale("Smooth Scale %ShowIf(DETAILS_OVERLAY)", Range(0.0, 2.0)) = 1
        UI_DetailSmoothNote("> Values < 0.5 - roughen, > 0.5 - smoothen %ShowIf(DETAILS_OVERLAY)", Int) = 0
        UI_VRCFeaturesHeader("# VRChat Features", Int) = 0
        UI_VRCDocs("[This module has documentation](https://shaders.orels.sh/docs/orl-standard/base-shader#vr-chat-features)", Int) = 0
        [Enum(Standard, 0, Toon, 1, Hidden, 2, Transparent, 3, Cutout, 4, ToonCutout, 5)]_VRCFallbackTag("VRC Fallback %OverrideTag(VRCFallback)", Int) = 0
        [Toggle(VRC_FEATURES)]_VRCFeaturesEnabled("VRChat Features Enabled", Int) = 0
        UI_VRCHideMainViewHeader("## Hide from Main View %ShowIf(VRC_FEATURES)", Int) = 0
        [ToggleUI]_VRCHideInVR("In VR %ShowIf(VRC_FEATURES)", Int) = 0
        [ToggleUI]_VRCHideInDesktop("On Desktop %ShowIf(VRC_FEATURES)p", Int) = 0
        UI_VRCHideCameraHeader("## Hide from Handheld Camera %ShowIf(VRC_FEATURES)", Int) = 0
        [ToggleUI]_VRCHideInVRCamera("In VR %ShowIf(VRC_FEATURES)", Int) = 0
        [ToggleUI]_VRCHideInDesktopCamera("On Desktop %ShowIf(VRC_FEATURES)", Int) = 0
        UI_VRCHideInMirrorHeader("## Hide from Mirror %ShowIf(VRC_FEATURES)", Int) = 0
        [ToggleUI]_VRCHideInVRMirror("In VR %ShowIf(VRC_FEATURES)", Int) = 0
        [ToggleUI]_VRCHideInDesktopMirror("On Desktop %ShowIf(VRC_FEATURES)", Int) = 0
        UI_VRCLightVolumesHeader("# VRC Light Volumes", Int) = 0
        [Toggle(VRCLIGHTVOLUMES)]_VRCLightVolumesEnabled("Enable VRC Light Volumes", Int) = 0
        _VRCLightVolumesSurfacePushoff("Surface Pushoff", Range(0, 1)) = 0.08
        UI_VRCLightVolumesSurfacePushoffNote("> Pushes the volume sampling point away from the surface along the normal vector. This is useful for avoiding leaking and other artifacts on thin surfaces\nValues in 0.05-0.15 range are recommended", Int) = 0
        [ToggleUI]UI_PosterDisplayHeader ("# Poster Display", Int) = 1
        _PosterTex ("Poster Texture", 2D) = "white" {}
        _PosterTint ("Poster Tint", Color) = (1,1,1,1)
        _DurationStatic ("Static Duration", Float) = 20.0
        _DurationEase ("Ease Duration", Float) = 0.5
        _GridHorizontal ("Grid Horizontal", Int) = 4
        _GridVertical ("Grid Vertical", Int) = 2
        _CellMargin ("Cell Margin", Float) = 0.01
        [KeywordEnum(easeInSine, easeOutSine, easeInOutSine, easeInQuad, easeOutQuad, easeInOutQuad, easeInCubic, easeOutCubic, easeInOutCubic, easeInQuart, easeOutQuart, easeInOutQuart, easeInQuint, easeOutQuint, easeInOutQuint, easeInExpo, easeOutExpo, easeInOutExpo, easeInCirc, easeOutCirc, easeInOutCirc, easeInBack, easeOutBack, easeInOutBack, easeInElastic, easeOutElastic, easeInOutElastic, easeInBounce, easeOutBounce, easeInOutBounce)]
_EaseFunction ("Ease Function", Int) = 20
        _TimeOffset ("Time Offset", Float) = 0.0
        [KeywordEnum(None, SlideToRight, SlideToLeft, SlideToBottom, SlideToTop, Fade, ZoomIn, ZoomOut)]
_EaseAnimation ("Ease Animation", Int) = 7
        _IdleTex ("Idle Texture", 2D) = "black" {}
        _IdleTint ("Idle Tint", Color) = (1,1,1,1)
        _Idling ("Idling", Range(0,1)) = 0.0
        UI_AudioLinkHeader("# Audio Link", Int) = 1
        UI_AudioLinkDocs("[This module has documentation](https://shaders.orels.sh/docs/orl-standard/audio-link)", Int) = 0
        UI_GlobalSettingsHeader("## Global Settings", Int) = 0
        [NoScaleOffset]_ALMask("Mask >", 2D) = "white" { }
        [Enum(UV1, 0, UV2, 1, UV3, 2, UV4, 3)]_ALUVChannel("UV Channel", Int) = 0
        [HDR]_ALTint("Tint", Color) = (1, 1, 1, 1)
        [ToggleUI]_KillEffects("Kill Effects", Int) = 0
        [KeywordEnum(Band Selection, UV Based, Waveform, Pulse, Bar)]AL_EFFECT("Effect Type", Int) = 0
        UI_SelectedEffect("## Effect Settings", Int) = 0
        [IntRange]_BandFrequency("Frequency Band %ShowIf(AL_EFFECT_BAND_SELECTION)", Range(1, 4)) = 1
        UI_BandNote("> 1: Bass, 2: Low Mids, 3: High Mids, 4: Highs %ShowIf(AL_EFFECT_BAND_SELECTION)", Int) = 0
        _BandHistoryRange("History Range %ShowIf(AL_EFFECT_BAND_SELECTION)", Float) = 128
        [Enum(X, 0, Y, 1, Negative X, 2, Negative Y, 3)]_BandScrollAxis("Scroll Axis %ShowIf(AL_EFFECT_BAND_SELECTION)", Int) = 1
        _UVHistoryRange("History Range %ShowIf(AL_EFFECT_UV_BASED)", Float) = 128
        [ToggleUI]_UVFlipXY("Flip UV X and Y %ShowIf(AL_EFFECT_UV_BASED)", Int) = 0
        [ToggleUI]_UVUseThemeColors("Use Theme Colors %ShowIf(AL_EFFECT_UV_BASED)", Int) = 0
        [ToggleUI]UI_UVColorsNote("> Check AudioLink object for colors, still applies global tint! %ShowIf(AL_EFFECT_UV_BASED)", Int) = 0
        _WVFRMBottomColor("Waveform Bottom Color %ShowIf(AL_EFFECT_WAVEFORM) %Gradient()", 2D) = "white" { }
        _WVFRMTopColor("Waveform Top Color %ShowIf(AL_EFFECT_WAVEFORM) %Gradient()", 2D) = "black" { }
        [ToggleUI]_WVFRMMiddleLine("Add Middle Line %ShowIf(AL_EFFECT_WAVEFORM)", Int) = 0
        _WVFRMMiddleColor("Waveform Middle Color %ShowIf(_WVFRMMiddleLine && AL_EFFECT_WAVEFORM) %Gradient()", 2D) = "gray" { }
        [ToggleUI]_WVFRMFlipUVDirection("Flip UV Direction %ShowIf(AL_EFFECT_WAVEFORM)", Int) = 0
        _WVFRMMiddleLineWidth("Line Width %ShowIf(_WVFRMMiddleLine && AL_EFFECT_WAVEFORM)", Range(0, 1)) = 0.05
        [ToggleUI]_WVFRMFlip("Flip Waveform %ShowIf(AL_EFFECT_WAVEFORM)", Int) = 0
        _WVFRMOffset("Waveform Offset %ShowIf(AL_EFFECT_WAVEFORM)", Range(0, 1)) = 0.5
        _WVFRMScale("Waveform Scale %ShowIf(AL_EFFECT_WAVEFORM)", Range(0, 1)) = 0.05
        [IntRange]_PulseBand("Frequency Band %ShowIf(AL_EFFECT_PULSE)", Range(1, 4)) = 1
        [IntRange]_PulseSmoothing("Smoothing %ShowIf(AL_EFFECT_PULSE && _PulseMode == 0)", Range(0, 16)) = 5
        [Enum(Emission, 0, Texture, 1)]_PulseMode("Pulse Mode %ShowIf(AL_EFFECT_PULSE)", Int) = 0
        _PulseStrength("Pulse Strength %ShowIf(AL_EFFECT_PULSE)", Float) = 1
        [Enum(Additive, 0, Multiply, 1)]_PulseEmissionMode("Emission Mode %ShowIf(AL_EFFECT_PULSE && _PulseMode == 0)", Int) = 0
        [Enum(Bump, 0, Continuous, 1)]_PulseTextureAdjustment("Texture Pulse Mode %ShowIf(AL_EFFECT_PULSE && _PulseMode == 1)", Int) = 1
        [ToggleUI]UI_PulseTextureNote("> Bump: Bumps the texture in a direction with the beat %ShowIf(AL_EFFECT_PULSE && _PulseMode == 1 && _PulseTextureAdjustment == 0)", Int) = 0
        [ToggleUI]UI_PulseTextureNote2("> Continuous: Pushes the texture continuously with the beat %ShowIf(AL_EFFECT_PULSE && _PulseMode == 1 && _PulseTextureAdjustment == 1)", Int) = 0
        [NoScaleOffset]_PulseTexture("Pulse Texture > %ShowIf(AL_EFFECT_PULSE && _PulseMode == 1)", 2D) = "white" { }
        _PulseTextureDirection("Pulse Direction %ShowIf(AL_EFFECT_PULSE && _PulseMode == 1)", Vector) = (0, 1, 0, 0)
        [IntRange]_BarBand("Frequency Band %ShowIf(AL_EFFECT_BAR)", Range(1, 4)) = 1
        [IntRange]_BarSmoothing("Smoothing %ShowIf(AL_EFFECT_BAR)", Range(0, 16)) = 7
        [Enum(X, 0, Y, 1, Negative X, 2, Negative Y, 3)]_BarAxis("Bar UV Axis %ShowIf(AL_EFFECT_BAR)", Int) = 1
        _BarColor("Bar Gradient %ShowIf(AL_EFFECT_BAR) %Gradient()", 2D) = "white" { }
        _BarScale("Bar Scale %ShowIf(AL_EFFECT_BAR)", Float) = 1
        [ToggleUI]UI_Spacer(">  ", Int) = 0
        [ToggleUI]UI_AudioLinkThanksNote("[Thanks to the amazing AudioLink project <3](https://github.com/llealloo/vrc-udon-audio-link)", Int) = 0
        [ToggleUI]UI_LTCGIHeader ("# LTCGI", Int) = 1
        UI_LTCGIDocs("[This module has documentation](https://shaders.orels.sh/docs/orl-standard/ltcgi)", Int) = 0
        [Toggle(INTEGRATE_LTCGI)]_IntegrateLTCGI("Integrate LTCGI", Int) = 0
        UI_LTCGIDownload("[Make sure to download LTCGI before enabling this option](https://github.com/PiMaker/ltcgi/releases)", Int) = 0
        [ToggleUI]_LTCGIEnableOnMobile("Enable on Mobile", Int) = 0
        UI_LTCGIEnableOnMobileNote("?> LTCGI is pretty heavy for mobile devices, please test your content when enabling this option", Int) = 0
        [ToggleUI]_LTCGIClampBrightness("Clamp Brightness", Int) = 0
        _LTCGIMaxBrightness("Max Brightness %ShowIf(_LTCGIClampBrightness)", Range(0,1)) = 1
        _LTCGIDiffuseIntensity("Diffuse Intensity", Float) = 1
        _LTCGISpecularIntensity("Specular Intensity", Float) = 1
        _LTCGIRoughnessModifier("Roughness Modifier", Range(-1,1)) = 0
        [ToggleUI]_LTCGIAlphaPremultiply("Alpha Premultiply %ShowIf(INTEGRATE_AREALIT)", Float) = 0
        UI_ShadingModeHeader("# Shading Mode", Int) = 0
        [KeywordEnum(Default, Cloth)]SHADING_MODE("Shading Mode", Int) = 0
        [Toggle(CLEARCOAT)]_ClearCoat("Add Clear Coat %ShowIf(SHADING_MODE_DEFAULT)", Int) = 0
        _ClearCoatStrength("Clear Coat Strength %ShowIf(SHADING_MODE_DEFAULT && CLEARCOAT)", Range(0,1)) = 1
        [ToggleUI]_HasClearCoatMask("Use Clear Coat Mask %ShowIf(SHADING_MODE_DEFAULT && CLEARCOAT)", Int) = 0
        _ClearCoatMask("Clear Coat Mask %ShowIf(SHADING_MODE_DEFAULT && CLEARCOAT && _HasClearCoatMask)", 2D) = "white" {}
        [Enum(R, 0, G, 1, B, 2, A, 3)][_ClearCoatMask]_ClearCoatMaskChannel("Clear Coat Mask Channel %ShowIf(SHADING_MODE_DEFAULT && CLEARCOAT && _HasClearCoatMask)", Int) = 3
        _ClearCoatSmoothness("Clear Coat Smoothness %ShowIf(SHADING_MODE_DEFAULT && CLEARCOAT)", Range(0, 1)) = 0.999
        [ToggleUI]_ClothHasCustomSheen("Custom Sheen Color %ShowIf(SHADING_MODE_CLOTH)", Int) = 0
        _ClothSheenColor("Sheen Color %ShowIf(SHADING_MODE_CLOTH && _ClothHasCustomSheen)", Color) = (0.04,0.04,0.04,1)
        [ToggleUI]_ClothHasSubsurface("Add Subsurface Color %ShowIf(SHADING_MODE_CLOTH)", Int) = 0
        _ClothSubsurfaceColor("Subsurface Color %ShowIf(SHADING_MODE_CLOTH && _ClothHasSubsurface)", Color) = (1,1,1,1)
        UI_AdvancedSettingsHeader("# Advanced Settings", Int) = 1
        [Enum(UnityEngine.Rendering.CullMode)]_CullMode("Culling Mode", Int) = 2
        _RenderType("Render Type %RenderType(_BlendOp, _SrcBlend, _DstBlend, _BlendOpAlpha, _SrcBlendAlpha, _DstBlendAlpha, _ZWrite)", Float) = -1
        [Enum(UnityEngine.Rendering.BlendOp)]_BlendOp("Blend Operation %ShowIf(_RenderType == 4)", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]_SrcBlend("Source Blend %ShowIf(_RenderType == 4)", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]_DstBlend("Destination Blend %ShowIf(_RenderType == 4)", Int) = 0
        [Enum(UnityEngine.Rendering.BlendOp)]_BlendOpAlpha("Blend Operation Alpha %ShowIf(_RenderType == 4)", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]_SrcBlendAlpha("Source Blend Alpha %ShowIf(_RenderType == 4)", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]_DstBlendAlpha("Destination Blend Alpha %ShowIf(_RenderType == 4)", Int) = 0
        _Cutoff("Cutoff %ShowIf(_RenderType == 1)", Range(0, 1)) = 0.5
        [Toggle(SHADE_VERTEXLIGHTS)]_ShadeVertexLights("Enable Vertex Lights", Int) = 0
        UI_ShadeVertexLightsNote("?> This will enable vertex-light compatible shader variants. If you're not planning to use vertex (non-important) lights - you can keep this off to make the final shader smaller", Int) = 0
        UI_AdvancedSettingsDepthHeader("## Depth", Int) = 1
        [Enum(Off, 0, On, 1)]_ZWrite("Depth Write", Int) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)]_ZTest("Depth Test", Int) = 4
        UI_GSAAHeader("## GSAA", Float) = 0
        [Toggle(GSAA)]_EnableGSAA("GSAA Enabled", Int) = 1
        UI_GSAANote("> GSAA dramatically reduces specular aliasing", Int) = 0
        _GSAAVariance("GSAA Variance %ShowIf(GSAA)", Range(0, 1)) = 0.05
        _GSAAThreshold("GSAA Threshold %ShowIf(GSAA)", Range(0, 1)) = 0.1
        [ToggleUI]_GSAAIncludeNormalMaps("Include Normal Maps %ShowIf(GSAA)", Int) = 0
        UI_GSAAIncludeNormalMapsNote("?> GSAA calculation can include per-pixel normal maps. This can sometimes lead to a 'pixelated' look when used with sharp angle or heavily tiled normal maps. You can disable this option to only use mesh normals.", Int) = 0
        UI_MobileTweaks("## Mobile Tweaks", Int) = 1
        [Toggle(FORCE_BOX_PROJECTION)]_ForceBoxProjection("Force Box Projection", Int) = 0
        [Toggle(APPLY_COLOR_CORRECTION)]_ApplyColorCorrection("Apply Mobile Color Correction", Int) = 0
        UI_ApplyColorCorrectionNote("?> Enables in-shader color correction, useful for Mobile platforms where PostProcessing is not available", Int) = 0
        [KeywordEnum(ACES, Unreal, Uncharted)]MOBILE_TONEMAP("Mobile Tonemap Mode %ShowIf(_ApplyColorCorrection)", Int) = 0
        _ColorCorrLift("Lift %ShowIf(_ApplyColorCorrection)", Range(0, 2)) = 1
        _ColorCorrGamma("Gamma %ShowIf(_ApplyColorCorrection)", Range(0,2)) = 1.1
        _ColorCorrGain("Gain %ShowIf(_ApplyColorCorrection)", Range(0, 2)) = 1.4
        UI_LightmappingHeader("# Lightmapping", Int) = 1
        UI_LightmappingDocs("[This module has documentation](https://shaders.orels.sh/docs/orl-standard/base-shader#lightmapping)", Int) = 0
        [Toggle(NONLINEAR_SH)]_NonlinearSH("Non-Linear Lightprobe SH", Int) = 0
        _SpecOcclusion("Reflection Probe Occlusion", Range(0, 1)) = 0.25
        UI_SpecOcclusionNote("?> a.k.a. Specular Occlusion. Controls how much the reflection probe specular will be occluded by the lightmap / lightprobe diffuse", Int) = 0
        _RealtimeShadowSpecOcclusion("Realtime Shadow Specular Occlusion", Range(0, 1)) = 0
        UI_RealtimeShadowSpecularOcclusionNote("> This effect is not physically correct, it can be useful to tone down strong reflection probes in shadowed areas %ShowIf(_RealtimeShadowSpecOcclusion > 0)", Int) = 0
        [Toggle(BICUBIC_LIGHTMAP)]_Bicubic("Bicubic Sampling", Int) = 0
        [Toggle(BAKED_SPECULAR)]_BakedSpecular("Baked Specular", Int) = 0
        _SpecularRoughnessMod("Specular Roughness Mod %ShowIf(BAKED_SPECULAR)", Range(0, 1)) = 1
        _BakedSpecularOcclusion("Baked Specular Occlusion %ShowIf(BAKED_SPECULAR)", Range(0, 1)) = 0.75
        UI_BakedSpecularOcclusionNote("?> If the object is lightmapped: this will adjust the intensity of the lightmap specular derived from the Directional lightmap.\nIf the object is not lightmapped: this will adjust the intensity of the specular derived from lightprobes %ShowIf(BAKED_SPECULAR)", Int) = 0
        UI_GITweaksHeader("## Global Illumination Tweaks", Int) = 0
        [ToggleUI]_BoxProjectionContactHardening("Box Projection Contact Hardening", Int) = 0
        _BoxProjectionContactHardeningStrength("Hardening Strength %ShowIf(_BoxProjectionContactHardening)", Range(0, 1)) = 1
        UI_BoxProjectionContactHardeningNote("?> This will make the box projected reflections more visible closer to the surface. This creates more accurate looking reflections, especially on rougher materials", Int) = 0
        _GIEmissiveBoost("GI Emissive Boost", Float) = 1
        [ToggleUI]_IgnoreRealtimeGI("Ignore Relatime GI", Int) = 0
        UI_IgnoreRealtimeGINote("?> This will make the material ignore Unity Realtime GI system. It does not affect custom RTGI systems like LTCGI", Int) = 0
        [ToggleUI]_RealtimeGIDisableBicubic("Disable Bicubic for RTGI %ShowIf(BICUBIC_LIGHTMAP)", Int) = 0
        UI_BakeryHeader("## Bakery Features", Int) = 0
        [Toggle(BAKERY_ENABLED)]_BakeryEnabled("Enable Bakery Features", Int) = 0
        [KeywordEnum(None, MONOSH, SH, RNM)]BAKERY("Bakery Mode %ShowIf(BAKERY_ENABLED)", Int) = 0
        [Toggle(BAKERY_SHNONLINEAR)]_BakerySHNonLinear("Bakery Non-Linear SH %ShowIf(BAKERY_ENABLED)", Int) = 1
        [Toggle(BAKERY_VOLUME)]_BakeryVolume("Support Volumes %ShowIf(BAKERY_ENABLED)", Int) = 0
        UI_BakeryVolumeAssigner("Volume Assigner %ShowIf(BAKERY_ENABLED && BAKERY_VOLUME) %BakeryVolumeAssigner()", Int) = 0
        [Toggle(BAKERY_COMPRESSED_VOLUME)]_BakeryCompressedVolume("Support Compressed Volumes %ShowIf(BAKERY_ENABLED && BAKERY_VOLUME)", Int) = 0
        [Toggle(BAKERY_VOLROTATIONY)]_BakeryVolumeRotationY("Support Baked Volume Rotation %ShowIf(BAKERY_ENABLED && BAKERY_VOLUME)", Int) = 0
        [Toggle(BAKERY_VOLROTATION)]_BakeryVolumeRotation("Support Runtime Volume Rotation %ShowIf(BAKERY_ENABLED && BAKERY_VOLUME)", Int) = 0
        UI_BakeryVolumeRotationNote("> Volume rotation support requires extra scripting in VRChat %ShowIf(BAKERY_ENABLED && BAKERY_VOLUME && (BAKERY_VOLROTATION || BAKERY_VOLROTATIONY))", Int) = 0
        UI_AdvancedSettingsStancilHeader("# Stencils", Int) = 0
        [IntRange]_StencilRef("Reference", Range(0, 255)) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("Comparison", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilPassOp("Pass Operation", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilFailOp("Fail Operation", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilZFailOp("ZFail Operation", Float) = 0
        UI_InternalHeader("# Internal", Int) = 0
        [HideInInspector]INTERNAL_ShaderVersion("Shader Version", Int) = 700
        [HideInInspector]INTERNAL_MaterialShaderVersion("Material Shader Version", Int) = 0
        [NonModifiableTextureData]_DFG("DFG > %RequiredTexture(@/dfg-multiscatter.exr)", 2D) = "white" {}
        UI_BakerySHHeader("## Bakery SH", Int) = 0
        _RNM0("RNM0 >", 2D) = "white" {}
        _RNM1("RNM1 >", 2D) = "white" {}
        _RNM2("RNM2 >", 2D) = "white" {}
        UI_BakeryVolumesHeader("## Bakery Volumes", Int) = 0
        _Volume0("Volume 0 >", 3D) = "white" {}
        _Volume1("Volume 1 >", 3D) = "white" {}
        _Volume2("Volume 2 >", 3D) = "white" {}
        _Volume3("Volume 3 >", 3D) = "white" {}
        _VolumeMask("Volume Mask >", 3D) = "white" {}
        _VolumeMin("Volume min", Vector) = (0,0,0)
        _VolumeInvSize("Volume Inv Size", Vector) = (1000001, 1000001, 1000001)
    }

    SubShader
    {
        Tags { "VRCFallback"="Standard" "RenderType" = "Opaque" "Queue" = "Geometry" "LTCGI" = "_IntegrateLTCGI"  }

        Stencil
{
    Ref [_StencilRef]
    Comp [_StencilComp]
    Pass [_StencilPassOp]
    Fail [_StencilFailOp]
    ZFail [_StencilZFailOp]
}
        ZTest[_ZTest]
        ZWrite[_ZWrite]
        Cull[_CullMode]
        BlendOp [_BlendOp], [_BlendOpAlpha]
        Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]

        // Global Include Start
        CGINCLUDE
        #include "UnityStandardUtils.cginc"
        #include "Lighting.cginc"
        #include "AutoLight.cginc"

        // Sampling Library
        // Sampling Library Module Start
        // com.unity.render-pipelines.core copyright © 2020 Unity Technologies ApS
        //
        // Licensed under the Unity Companion License for Unity-dependent projects--see [Unity Companion License](http://www.unity3d.com/legal/licenses/Unity_Companion_License).
        //
        // Unless expressly provided otherwise, the Software under this license is made available strictly on an “AS IS” BASIS WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED. Please review the license for details on these and other terms and conditions.
        
        // Credit to Jason Booth for digging this all up
        
        // If your looking in here and thinking WTF, yeah, I know. These are taken from the SRPs, to allow us to use the same
        // texturing library they use. However, since they are not included in the standard pipeline by default, there is no
        // way to include them in and they have to be inlined, since someone could copy this shader onto another machine without
        // Better Shaders installed. Unfortunate, but I'd rather do this and have a nice library for texture sampling instead
        // of the patchy one Unity provides being inlined/emulated in HDRP/URP. Strangely, PSSL and XBoxOne libraries are not
        // included in the standard SRP code, but they are in tons of Unity own projects on the web, so I grabbed them from there.
        
        
        #if defined(SHADER_API_XBOXONE)
        
        // Initialize arbitrary structure with zero values.
        // Do not exist on some platform, in this case we need to have a standard name that call a function that will initialize all parameters to 0
        #define ZERO_INITIALIZE(type, name) name = (type)0;
        #define ZERO_INITIALIZE_ARRAY(type, name, arraySize) { for (int arrayIndex = 0; arrayIndex < arraySize; arrayIndex++) { name[arrayIndex] = (type)0; } }
        
        // Texture util abstraction
        
        #define CALCULATE_TEXTURE2D_LOD(textureName, samplerName, coord2) textureName.CalculateLevelOfDetail(samplerName, coord2)
        
        // Texture abstraction
        
        #define TEXTURE2D(textureName)                Texture2D textureName
        #define TEXTURE2D_ARRAY(textureName)          Texture2DArray textureName
        #define TEXTURECUBE(textureName)              TextureCube textureName
        #define TEXTURECUBE_ARRAY(textureName)        TextureCubeArray textureName
        #define TEXTURE3D(textureName)                Texture3D textureName
        
        #define TEXTURE2D_FLOAT(textureName)          TEXTURE2D(textureName)
        #define TEXTURE2D_ARRAY_FLOAT(textureName)    TEXTURE2D_ARRAY(textureName)
        #define TEXTURECUBE_FLOAT(textureName)        TEXTURECUBE(textureName)
        #define TEXTURECUBE_ARRAY_FLOAT(textureName)  TEXTURECUBE_ARRAY(textureName)
        #define TEXTURE3D_FLOAT(textureName)          TEXTURE3D(textureName)
        
        #define TEXTURE2D_HALF(textureName)           TEXTURE2D(textureName)
        #define TEXTURE2D_ARRAY_HALF(textureName)     TEXTURE2D_ARRAY(textureName)
        #define TEXTURECUBE_HALF(textureName)         TEXTURECUBE(textureName)
        #define TEXTURECUBE_ARRAY_HALF(textureName)   TEXTURECUBE_ARRAY(textureName)
        #define TEXTURE3D_HALF(textureName)           TEXTURE3D(textureName)
        
        #define TEXTURE2D_SHADOW(textureName)         TEXTURE2D(textureName)
        #define TEXTURE2D_ARRAY_SHADOW(textureName)   TEXTURE2D_ARRAY(textureName)
        #define TEXTURECUBE_SHADOW(textureName)       TEXTURECUBE(textureName)
        #define TEXTURECUBE_ARRAY_SHADOW(textureName) TEXTURECUBE_ARRAY(textureName)
        
        #define RW_TEXTURE2D(type, textureName)       RWTexture2D<type> textureName
        #define RW_TEXTURE2D_ARRAY(type, textureName) RWTexture2DArray<type> textureName
        #define RW_TEXTURE3D(type, textureName)       RWTexture3D<type> textureName
        
        #define SAMPLER(samplerName)                  SamplerState samplerName
        #define SAMPLER_CMP(samplerName)              SamplerComparisonState samplerName
        
        #define TEXTURE2D_PARAM(textureName, samplerName)                 TEXTURE2D(textureName), SAMPLER(samplerName)
        #define TEXTURE2D_ARRAY_PARAM(textureName, samplerName)           TEXTURE2D_ARRAY(textureName), SAMPLER(samplerName)
        #define TEXTURECUBE_PARAM(textureName, samplerName)               TEXTURECUBE(textureName), SAMPLER(samplerName)
        #define TEXTURECUBE_ARRAY_PARAM(textureName, samplerName)         TEXTURECUBE_ARRAY(textureName), SAMPLER(samplerName)
        #define TEXTURE3D_PARAM(textureName, samplerName)                 TEXTURE3D(textureName), SAMPLER(samplerName)
        
        #define TEXTURE2D_SHADOW_PARAM(textureName, samplerName)          TEXTURE2D(textureName), SAMPLER_CMP(samplerName)
        #define TEXTURE2D_ARRAY_SHADOW_PARAM(textureName, samplerName)    TEXTURE2D_ARRAY(textureName), SAMPLER_CMP(samplerName)
        #define TEXTURECUBE_SHADOW_PARAM(textureName, samplerName)        TEXTURECUBE(textureName), SAMPLER_CMP(samplerName)
        #define TEXTURECUBE_ARRAY_SHADOW_PARAM(textureName, samplerName)  TEXTURECUBE_ARRAY(textureName), SAMPLER_CMP(samplerName)
        
        #define TEXTURE2D_ARGS(textureName, samplerName)                textureName, samplerName
        #define TEXTURE2D_ARRAY_ARGS(textureName, samplerName)          textureName, samplerName
        #define TEXTURECUBE_ARGS(textureName, samplerName)              textureName, samplerName
        #define TEXTURECUBE_ARRAY_ARGS(textureName, samplerName)        textureName, samplerName
        #define TEXTURE3D_ARGS(textureName, samplerName)                textureName, samplerName
        
        #define TEXTURE2D_SHADOW_ARGS(textureName, samplerName)         textureName, samplerName
        #define TEXTURE2D_ARRAY_SHADOW_ARGS(textureName, samplerName)   textureName, samplerName
        #define TEXTURECUBE_SHADOW_ARGS(textureName, samplerName)       textureName, samplerName
        #define TEXTURECUBE_ARRAY_SHADOW_ARGS(textureName, samplerName) textureName, samplerName
        
        #define SAMPLE_TEXTURE2D(textureName, samplerName, coord2)                               textureName.Sample(samplerName, coord2)
        #define SAMPLE_TEXTURE2D_LOD(textureName, samplerName, coord2, lod)                      textureName.SampleLevel(samplerName, coord2, lod)
        #define SAMPLE_TEXTURE2D_BIAS(textureName, samplerName, coord2, bias)                    textureName.SampleBias(samplerName, coord2, bias)
        #define SAMPLE_TEXTURE2D_GRAD(textureName, samplerName, coord2, dpdx, dpdy)              textureName.SampleGrad(samplerName, coord2, dpdx, dpdy)
        #define SAMPLE_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)                  textureName.Sample(samplerName, float3(coord2, index))
        #define SAMPLE_TEXTURE2D_ARRAY_LOD(textureName, samplerName, coord2, index, lod)         textureName.SampleLevel(samplerName, float3(coord2, index), lod)
        #define SAMPLE_TEXTURE2D_ARRAY_BIAS(textureName, samplerName, coord2, index, bias)       textureName.SampleBias(samplerName, float3(coord2, index), bias)
        #define SAMPLE_TEXTURE2D_ARRAY_GRAD(textureName, samplerName, coord2, index, dpdx, dpdy) textureName.SampleGrad(samplerName, float3(coord2, index), dpdx, dpdy)
        #define SAMPLE_TEXTURECUBE(textureName, samplerName, coord3)                             textureName.Sample(samplerName, coord3)
        #define SAMPLE_TEXTURECUBE_LOD(textureName, samplerName, coord3, lod)                    textureName.SampleLevel(samplerName, coord3, lod)
        #define SAMPLE_TEXTURECUBE_BIAS(textureName, samplerName, coord3, bias)                  textureName.SampleBias(samplerName, coord3, bias)
        #define SAMPLE_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)                textureName.Sample(samplerName, float4(coord3, index))
        #define SAMPLE_TEXTURECUBE_ARRAY_LOD(textureName, samplerName, coord3, index, lod)       textureName.SampleLevel(samplerName, float4(coord3, index), lod)
        #define SAMPLE_TEXTURECUBE_ARRAY_BIAS(textureName, samplerName, coord3, index, bias)     textureName.SampleBias(samplerName, float4(coord3, index), bias)
        #define SAMPLE_TEXTURE3D(textureName, samplerName, coord3)                               textureName.Sample(samplerName, coord3)
        #define SAMPLE_TEXTURE3D_LOD(textureName, samplerName, coord3, lod)                      textureName.SampleLevel(samplerName, coord3, lod)
        
        #define SAMPLE_TEXTURE2D_SHADOW(textureName, samplerName, coord3)                    textureName.SampleCmpLevelZero(samplerName, (coord3).xy, (coord3).z)
        #define SAMPLE_TEXTURE2D_ARRAY_SHADOW(textureName, samplerName, coord3, index)       textureName.SampleCmpLevelZero(samplerName, float3((coord3).xy, index), (coord3).z)
        #define SAMPLE_TEXTURECUBE_SHADOW(textureName, samplerName, coord4)                  textureName.SampleCmpLevelZero(samplerName, (coord4).xyz, (coord4).w)
        #define SAMPLE_TEXTURECUBE_ARRAY_SHADOW(textureName, samplerName, coord4, index)     textureName.SampleCmpLevelZero(samplerName, float4((coord4).xyz, index), (coord4).w)
        
        #define LOAD_TEXTURE2D(textureName, unCoord2)                                   textureName.Load(int3(unCoord2, 0))
        #define LOAD_TEXTURE2D_LOD(textureName, unCoord2, lod)                          textureName.Load(int3(unCoord2, lod))
        #define LOAD_TEXTURE2D_MSAA(textureName, unCoord2, sampleIndex)                 textureName.Load(unCoord2, sampleIndex)
        #define LOAD_TEXTURE2D_ARRAY(textureName, unCoord2, index)                      textureName.Load(int4(unCoord2, index, 0))
        #define LOAD_TEXTURE2D_ARRAY_MSAA(textureName, unCoord2, index, sampleIndex)    textureName.Load(int3(unCoord2, index), sampleIndex)
        #define LOAD_TEXTURE2D_ARRAY_LOD(textureName, unCoord2, index, lod)             textureName.Load(int4(unCoord2, index, lod))
        #define LOAD_TEXTURE3D(textureName, unCoord3)                                   textureName.Load(int4(unCoord3, 0))
        #define LOAD_TEXTURE3D_LOD(textureName, unCoord3, lod)                          textureName.Load(int4(unCoord3, lod))
        
        #define PLATFORM_SUPPORT_GATHER
        #define GATHER_TEXTURE2D(textureName, samplerName, coord2)                textureName.Gather(samplerName, coord2)
        #define GATHER_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)   textureName.Gather(samplerName, float3(coord2, index))
        #define GATHER_TEXTURECUBE(textureName, samplerName, coord3)              textureName.Gather(samplerName, coord3)
        #define GATHER_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index) textureName.Gather(samplerName, float4(coord3, index))
        #define GATHER_RED_TEXTURE2D(textureName, samplerName, coord2)            textureName.GatherRed(samplerName, coord2)
        #define GATHER_GREEN_TEXTURE2D(textureName, samplerName, coord2)          textureName.GatherGreen(samplerName, coord2)
        #define GATHER_BLUE_TEXTURE2D(textureName, samplerName, coord2)           textureName.GatherBlue(samplerName, coord2)
        #define GATHER_ALPHA_TEXTURE2D(textureName, samplerName, coord2)          textureName.GatherAlpha(samplerName, coord2)
        
        
        #elif defined(SHADER_API_PSSL)
        
          // Initialize arbitrary structure with zero values.
          // Do not exist on some platform, in this case we need to have a standard name that call a function that will initialize all parameters to 0
          #define ZERO_INITIALIZE(type, name) name = (type)0;
          #define ZERO_INITIALIZE_ARRAY(type, name, arraySize) { for (int arrayIndex = 0; arrayIndex < arraySize; arrayIndex++) { name[arrayIndex] = (type)0; } }
        
          // Texture util abstraction
        
          #define CALCULATE_TEXTURE2D_LOD(textureName, samplerName, coord2) textureName.GetLOD(samplerName, coord2)
        
          // Texture abstraction
        
          #define TEXTURE2D(textureName)                Texture2D textureName
          #define TEXTURE2D_ARRAY(textureName)          Texture2DArray textureName
          #define TEXTURECUBE(textureName)              TextureCube textureName
          #define TEXTURECUBE_ARRAY(textureName)        TextureCubeArray textureName
          #define TEXTURE3D(textureName)                Texture3D textureName
        
          #define TEXTURE2D_FLOAT(textureName)          TEXTURE2D(textureName)
          #define TEXTURE2D_ARRAY_FLOAT(textureName)    TEXTURE2D_ARRAY(textureName)
          #define TEXTURECUBE_FLOAT(textureName)        TEXTURECUBE(textureName)
          #define TEXTURECUBE_ARRAY_FLOAT(textureName)  TEXTURECUBE_ARRAY(textureName)
          #define TEXTURE3D_FLOAT(textureName)          TEXTURE3D(textureName)
        
          #define TEXTURE2D_HALF(textureName)           TEXTURE2D(textureName)
          #define TEXTURE2D_ARRAY_HALF(textureName)     TEXTURE2D_ARRAY(textureName)
          #define TEXTURECUBE_HALF(textureName)         TEXTURECUBE(textureName)
          #define TEXTURECUBE_ARRAY_HALF(textureName)   TEXTURECUBE_ARRAY(textureName)
          #define TEXTURE3D_HALF(textureName)           TEXTURE3D(textureName)
        
          #define TEXTURE2D_SHADOW(textureName)         TEXTURE2D(textureName)
          #define TEXTURE2D_ARRAY_SHADOW(textureName)   TEXTURE2D_ARRAY(textureName)
          #define TEXTURECUBE_SHADOW(textureName)       TEXTURECUBE(textureName)
          #define TEXTURECUBE_ARRAY_SHADOW(textureName) TEXTURECUBE_ARRAY(textureName)
        
          #define RW_TEXTURE2D(type, textureName)       RW_Texture2D<type> textureName
          #define RW_TEXTURE2D_ARRAY(type, textureName) RW_Texture2D_Array<type> textureName
          #define RW_TEXTURE3D(type, textureName)       RW_Texture3D<type> textureName
        
          #define SAMPLER(samplerName)                  SamplerState samplerName
          #define SAMPLER_CMP(samplerName)              SamplerComparisonState samplerName
        
          #define TEXTURE2D_PARAM(textureName, samplerName)                 TEXTURE2D(textureName), SAMPLER(samplerName)
          #define TEXTURE2D_ARRAY_PARAM(textureName, samplerName)           TEXTURE2D_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_PARAM(textureName, samplerName)               TEXTURECUBE(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_ARRAY_PARAM(textureName, samplerName)         TEXTURECUBE_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURE3D_PARAM(textureName, samplerName)                 TEXTURE3D(textureName), SAMPLER(samplerName)
        
          #define TEXTURE2D_SHADOW_PARAM(textureName, samplerName)          TEXTURE2D(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURE2D_ARRAY_SHADOW_PARAM(textureName, samplerName)    TEXTURE2D_ARRAY(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_SHADOW_PARAM(textureName, samplerName)        TEXTURECUBE(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_ARRAY_SHADOW_PARAM(textureName, samplerName)  TEXTURECUBE_ARRAY(textureName), SAMPLER_CMP(samplerName)
        
          #define TEXTURE2D_ARGS(textureName, samplerName)                textureName, samplerName
          #define TEXTURE2D_ARRAY_ARGS(textureName, samplerName)          textureName, samplerName
          #define TEXTURECUBE_ARGS(textureName, samplerName)              textureName, samplerName
          #define TEXTURECUBE_ARRAY_ARGS(textureName, samplerName)        textureName, samplerName
          #define TEXTURE3D_ARGS(textureName, samplerName)                textureName, samplerName
        
          #define TEXTURE2D_SHADOW_ARGS(textureName, samplerName)         textureName, samplerName
          #define TEXTURE2D_ARRAY_SHADOW_ARGS(textureName, samplerName)   textureName, samplerName
          #define TEXTURECUBE_SHADOW_ARGS(textureName, samplerName)       textureName, samplerName
          #define TEXTURECUBE_ARRAY_SHADOW_ARGS(textureName, samplerName) textureName, samplerName
        
          #define SAMPLE_TEXTURE2D(textureName, samplerName, coord2)                               textureName.Sample(samplerName, coord2)
          #define SAMPLE_TEXTURE2D_LOD(textureName, samplerName, coord2, lod)                      textureName.SampleLevel(samplerName, coord2, lod)
          #define SAMPLE_TEXTURE2D_BIAS(textureName, samplerName, coord2, bias)                    textureName.SampleBias(samplerName, coord2, bias)
          #define SAMPLE_TEXTURE2D_GRAD(textureName, samplerName, coord2, dpdx, dpdy)              textureName.SampleGrad(samplerName, coord2, dpdx, dpdy)
          #define SAMPLE_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)                  textureName.Sample(samplerName, float3(coord2, index))
          #define SAMPLE_TEXTURE2D_ARRAY_LOD(textureName, samplerName, coord2, index, lod)         textureName.SampleLevel(samplerName, float3(coord2, index), lod)
          #define SAMPLE_TEXTURE2D_ARRAY_BIAS(textureName, samplerName, coord2, index, bias)       textureName.SampleBias(samplerName, float3(coord2, index), bias)
          #define SAMPLE_TEXTURE2D_ARRAY_GRAD(textureName, samplerName, coord2, index, dpdx, dpdy) textureName.SampleGrad(samplerName, float3(coord2, index), dpdx, dpdy)
          #define SAMPLE_TEXTURECUBE(textureName, samplerName, coord3)                             textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURECUBE_LOD(textureName, samplerName, coord3, lod)                    textureName.SampleLevel(samplerName, coord3, lod)
          #define SAMPLE_TEXTURECUBE_BIAS(textureName, samplerName, coord3, bias)                  textureName.SampleBias(samplerName, coord3, bias)
          #define SAMPLE_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)                textureName.Sample(samplerName, float4(coord3, index))
          #define SAMPLE_TEXTURECUBE_ARRAY_LOD(textureName, samplerName, coord3, index, lod)       textureName.SampleLevel(samplerName, float4(coord3, index), lod)
          #define SAMPLE_TEXTURECUBE_ARRAY_BIAS(textureName, samplerName, coord3, index, bias)     textureName.SampleBias(samplerName, float4(coord3, index), bias)
          #define SAMPLE_TEXTURE3D(textureName, samplerName, coord3)                               textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURE3D_LOD(textureName, samplerName, coord3, lod)                      textureName.SampleLevel(samplerName, coord3, lod)
        
          #define SAMPLE_TEXTURE2D_SHADOW(textureName, samplerName, coord3)                    textureName.SampleCmpLevelZero(samplerName, (coord3).xy, (coord3).z)
          #define SAMPLE_TEXTURE2D_ARRAY_SHADOW(textureName, samplerName, coord3, index)       textureName.SampleCmpLevelZero(samplerName, float3((coord3).xy, index), (coord3).z)
          #define SAMPLE_TEXTURECUBE_SHADOW(textureName, samplerName, coord4)                  textureName.SampleCmpLevelZero(samplerName, (coord4).xyz, (coord4).w)
          #define SAMPLE_TEXTURECUBE_ARRAY_SHADOW(textureName, samplerName, coord4, index)     textureName.SampleCmpLevelZero(samplerName, float4((coord4).xyz, index), (coord4).w)
        
          #define LOAD_TEXTURE2D(textureName, unCoord2)                                   textureName.Load(int3(unCoord2, 0))
          #define LOAD_TEXTURE2D_LOD(textureName, unCoord2, lod)                          textureName.Load(int3(unCoord2, lod))
          #define LOAD_TEXTURE2D_MSAA(textureName, unCoord2, sampleIndex)                 textureName.Load(unCoord2, sampleIndex)
          #define LOAD_TEXTURE2D_ARRAY(textureName, unCoord2, index)                      textureName.Load(int4(unCoord2, index, 0))
          #define LOAD_TEXTURE2D_ARRAY_MSAA(textureName, unCoord2, index, sampleIndex)    textureName.Load(int3(unCoord2, index), sampleIndex)
          #define LOAD_TEXTURE2D_ARRAY_LOD(textureName, unCoord2, index, lod)             textureName.Load(int4(unCoord2, index, lod))
          #define LOAD_TEXTURE3D(textureName, unCoord3)                                   textureName.Load(int4(unCoord3, 0))
          #define LOAD_TEXTURE3D_LOD(textureName, unCoord3, lod)                          textureName.Load(int4(unCoord3, lod))
        
          #define PLATFORM_SUPPORT_GATHER
          #define GATHER_TEXTURE2D(textureName, samplerName, coord2)                textureName.Gather(samplerName, coord2)
          #define GATHER_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)   textureName.Gather(samplerName, float3(coord2, index))
          #define GATHER_TEXTURECUBE(textureName, samplerName, coord3)              textureName.Gather(samplerName, coord3)
          #define GATHER_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index) textureName.Gather(samplerName, float4(coord3, index))
          #define GATHER_RED_TEXTURE2D(textureName, samplerName, coord2)            textureName.GatherRed(samplerName, coord2)
          #define GATHER_GREEN_TEXTURE2D(textureName, samplerName, coord2)          textureName.GatherGreen(samplerName, coord2)
          #define GATHER_BLUE_TEXTURE2D(textureName, samplerName, coord2)           textureName.GatherBlue(samplerName, coord2)
          #define GATHER_ALPHA_TEXTURE2D(textureName, samplerName, coord2)          textureName.GatherAlpha(samplerName, coord2)
        
        
        
        #elif defined(SHADER_API_D3D11)
        
          // Initialize arbitrary structure with zero values.
          // Do not exist on some platform, in this case we need to have a standard name that call a function that will initialize all parameters to 0
          #define ZERO_INITIALIZE(type, name) name = (type)0;
          #define ZERO_INITIALIZE_ARRAY(type, name, arraySize) { for (int arrayIndex = 0; arrayIndex < arraySize; arrayIndex++) { name[arrayIndex] = (type)0; } }
        
          // Texture util abstraction
        
          #define CALCULATE_TEXTURE2D_LOD(textureName, samplerName, coord2) textureName.CalculateLevelOfDetail(samplerName, coord2)
        
          // Texture abstraction
        
          #define TEXTURE2D(textureName)                Texture2D textureName
          #define TEXTURE2D_ARRAY(textureName)          Texture2DArray textureName
          #define TEXTURECUBE(textureName)              TextureCube textureName
          #define TEXTURECUBE_ARRAY(textureName)        TextureCubeArray textureName
          #define TEXTURE3D(textureName)                Texture3D textureName
        
          #define TEXTURE2D_FLOAT(textureName)          TEXTURE2D(textureName)
          #define TEXTURE2D_ARRAY_FLOAT(textureName)    TEXTURE2D_ARRAY(textureName)
          #define TEXTURECUBE_FLOAT(textureName)        TEXTURECUBE(textureName)
          #define TEXTURECUBE_ARRAY_FLOAT(textureName)  TEXTURECUBE_ARRAY(textureName)
          #define TEXTURE3D_FLOAT(textureName)          TEXTURE3D(textureName)
        
          #define TEXTURE2D_HALF(textureName)           TEXTURE2D(textureName)
          #define TEXTURE2D_ARRAY_HALF(textureName)     TEXTURE2D_ARRAY(textureName)
          #define TEXTURECUBE_HALF(textureName)         TEXTURECUBE(textureName)
          #define TEXTURECUBE_ARRAY_HALF(textureName)   TEXTURECUBE_ARRAY(textureName)
          #define TEXTURE3D_HALF(textureName)           TEXTURE3D(textureName)
        
          #define TEXTURE2D_SHADOW(textureName)         TEXTURE2D(textureName)
          #define TEXTURE2D_ARRAY_SHADOW(textureName)   TEXTURE2D_ARRAY(textureName)
          #define TEXTURECUBE_SHADOW(textureName)       TEXTURECUBE(textureName)
          #define TEXTURECUBE_ARRAY_SHADOW(textureName) TEXTURECUBE_ARRAY(textureName)
        
          #define RW_TEXTURE2D(type, textureName)       RWTexture2D<type> textureName
          #define RW_TEXTURE2D_ARRAY(type, textureName) RWTexture2DArray<type> textureName
          #define RW_TEXTURE3D(type, textureName)       RWTexture3D<type> textureName
        
          #define SAMPLER(samplerName)                  SamplerState samplerName
          #define SAMPLER_CMP(samplerName)              SamplerComparisonState samplerName
        
          #define TEXTURE2D_PARAM(textureName, samplerName)                 TEXTURE2D(textureName), SAMPLER(samplerName)
          #define TEXTURE2D_ARRAY_PARAM(textureName, samplerName)           TEXTURE2D_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_PARAM(textureName, samplerName)               TEXTURECUBE(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_ARRAY_PARAM(textureName, samplerName)         TEXTURECUBE_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURE3D_PARAM(textureName, samplerName)                 TEXTURE3D(textureName), SAMPLER(samplerName)
        
          #define TEXTURE2D_SHADOW_PARAM(textureName, samplerName)          TEXTURE2D(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURE2D_ARRAY_SHADOW_PARAM(textureName, samplerName)    TEXTURE2D_ARRAY(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_SHADOW_PARAM(textureName, samplerName)        TEXTURECUBE(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_ARRAY_SHADOW_PARAM(textureName, samplerName)  TEXTURECUBE_ARRAY(textureName), SAMPLER_CMP(samplerName)
        
          #define TEXTURE2D_ARGS(textureName, samplerName)                textureName, samplerName
          #define TEXTURE2D_ARRAY_ARGS(textureName, samplerName)          textureName, samplerName
          #define TEXTURECUBE_ARGS(textureName, samplerName)              textureName, samplerName
          #define TEXTURECUBE_ARRAY_ARGS(textureName, samplerName)        textureName, samplerName
          #define TEXTURE3D_ARGS(textureName, samplerName)                textureName, samplerName
        
          #define TEXTURE2D_SHADOW_ARGS(textureName, samplerName)         textureName, samplerName
          #define TEXTURE2D_ARRAY_SHADOW_ARGS(textureName, samplerName)   textureName, samplerName
          #define TEXTURECUBE_SHADOW_ARGS(textureName, samplerName)       textureName, samplerName
          #define TEXTURECUBE_ARRAY_SHADOW_ARGS(textureName, samplerName) textureName, samplerName
        
          #define SAMPLE_TEXTURE2D(textureName, samplerName, coord2)                               textureName.Sample(samplerName, coord2)
          #define SAMPLE_TEXTURE2D_LOD(textureName, samplerName, coord2, lod)                      textureName.SampleLevel(samplerName, coord2, lod)
          #define SAMPLE_TEXTURE2D_BIAS(textureName, samplerName, coord2, bias)                    textureName.SampleBias(samplerName, coord2, bias)
          #define SAMPLE_TEXTURE2D_GRAD(textureName, samplerName, coord2, dpdx, dpdy)              textureName.SampleGrad(samplerName, coord2, dpdx, dpdy)
          #define SAMPLE_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)                  textureName.Sample(samplerName, float3(coord2, index))
          #define SAMPLE_TEXTURE2D_ARRAY_LOD(textureName, samplerName, coord2, index, lod)         textureName.SampleLevel(samplerName, float3(coord2, index), lod)
          #define SAMPLE_TEXTURE2D_ARRAY_BIAS(textureName, samplerName, coord2, index, bias)       textureName.SampleBias(samplerName, float3(coord2, index), bias)
          #define SAMPLE_TEXTURE2D_ARRAY_GRAD(textureName, samplerName, coord2, index, dpdx, dpdy) textureName.SampleGrad(samplerName, float3(coord2, index), dpdx, dpdy)
          #define SAMPLE_TEXTURECUBE(textureName, samplerName, coord3)                             textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURECUBE_LOD(textureName, samplerName, coord3, lod)                    textureName.SampleLevel(samplerName, coord3, lod)
          #define SAMPLE_TEXTURECUBE_BIAS(textureName, samplerName, coord3, bias)                  textureName.SampleBias(samplerName, coord3, bias)
          #define SAMPLE_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)                textureName.Sample(samplerName, float4(coord3, index))
          #define SAMPLE_TEXTURECUBE_ARRAY_LOD(textureName, samplerName, coord3, index, lod)       textureName.SampleLevel(samplerName, float4(coord3, index), lod)
          #define SAMPLE_TEXTURECUBE_ARRAY_BIAS(textureName, samplerName, coord3, index, bias)     textureName.SampleBias(samplerName, float4(coord3, index), bias)
          #define SAMPLE_TEXTURE3D(textureName, samplerName, coord3)                               textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURE3D_LOD(textureName, samplerName, coord3, lod)                      textureName.SampleLevel(samplerName, coord3, lod)
        
          #define SAMPLE_TEXTURE2D_SHADOW(textureName, samplerName, coord3)                    textureName.SampleCmpLevelZero(samplerName, (coord3).xy, (coord3).z)
          #define SAMPLE_TEXTURE2D_ARRAY_SHADOW(textureName, samplerName, coord3, index)       textureName.SampleCmpLevelZero(samplerName, float3((coord3).xy, index), (coord3).z)
          #define SAMPLE_TEXTURECUBE_SHADOW(textureName, samplerName, coord4)                  textureName.SampleCmpLevelZero(samplerName, (coord4).xyz, (coord4).w)
          #define SAMPLE_TEXTURECUBE_ARRAY_SHADOW(textureName, samplerName, coord4, index)     textureName.SampleCmpLevelZero(samplerName, float4((coord4).xyz, index), (coord4).w)
        
          #define LOAD_TEXTURE2D(textureName, unCoord2)                                   textureName.Load(int3(unCoord2, 0))
          #define LOAD_TEXTURE2D_LOD(textureName, unCoord2, lod)                          textureName.Load(int3(unCoord2, lod))
          #define LOAD_TEXTURE2D_MSAA(textureName, unCoord2, sampleIndex)                 textureName.Load(unCoord2, sampleIndex)
          #define LOAD_TEXTURE2D_ARRAY(textureName, unCoord2, index)                      textureName.Load(int4(unCoord2, index, 0))
          #define LOAD_TEXTURE2D_ARRAY_MSAA(textureName, unCoord2, index, sampleIndex)    textureName.Load(int3(unCoord2, index), sampleIndex)
          #define LOAD_TEXTURE2D_ARRAY_LOD(textureName, unCoord2, index, lod)             textureName.Load(int4(unCoord2, index, lod))
          #define LOAD_TEXTURE3D(textureName, unCoord3)                                   textureName.Load(int4(unCoord3, 0))
          #define LOAD_TEXTURE3D_LOD(textureName, unCoord3, lod)                          textureName.Load(int4(unCoord3, lod))
        
          #define PLATFORM_SUPPORT_GATHER
          #define GATHER_TEXTURE2D(textureName, samplerName, coord2)                textureName.Gather(samplerName, coord2)
          #define GATHER_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)   textureName.Gather(samplerName, float3(coord2, index))
          #define GATHER_TEXTURECUBE(textureName, samplerName, coord3)              textureName.Gather(samplerName, coord3)
          #define GATHER_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index) textureName.Gather(samplerName, float4(coord3, index))
          #define GATHER_RED_TEXTURE2D(textureName, samplerName, coord2)            textureName.GatherRed(samplerName, coord2)
          #define GATHER_GREEN_TEXTURE2D(textureName, samplerName, coord2)          textureName.GatherGreen(samplerName, coord2)
          #define GATHER_BLUE_TEXTURE2D(textureName, samplerName, coord2)           textureName.GatherBlue(samplerName, coord2)
          #define GATHER_ALPHA_TEXTURE2D(textureName, samplerName, coord2)          textureName.GatherAlpha(samplerName, coord2)
        
        #elif defined(SHADER_API_METAL)
        
          // Initialize arbitrary structure with zero values.
          // Do not exist on some platform, in this case we need to have a standard name that call a function that will initialize all parameters to 0
          #define ZERO_INITIALIZE(type, name) name = (type)0;
          #define ZERO_INITIALIZE_ARRAY(type, name, arraySize) { for (int arrayIndex = 0; arrayIndex < arraySize; arrayIndex++) { name[arrayIndex] = (type)0; } }
        
          // Texture util abstraction
        
          #define CALCULATE_TEXTURE2D_LOD(textureName, samplerName, coord2) textureName.CalculateLevelOfDetail(samplerName, coord2)
        
          // Texture abstraction
        
          #define TEXTURE2D(textureName)                Texture2D textureName
          #define TEXTURE2D_ARRAY(textureName)          Texture2DArray textureName
          #define TEXTURECUBE(textureName)              TextureCube textureName
          #define TEXTURECUBE_ARRAY(textureName)        TextureCubeArray textureName
          #define TEXTURE3D(textureName)                Texture3D textureName
        
          #define TEXTURE2D_FLOAT(textureName)          Texture2D_float textureName
          #define TEXTURE2D_ARRAY_FLOAT(textureName)    Texture2DArray textureName    // no support to _float on Array, it's being added
          #define TEXTURECUBE_FLOAT(textureName)        TextureCube_float textureName
          #define TEXTURECUBE_ARRAY_FLOAT(textureName)  TextureCubeArray textureName  // no support to _float on Array, it's being added
          #define TEXTURE3D_FLOAT(textureName)          Texture3D_float textureName
        
          #define TEXTURE2D_HALF(textureName)           Texture2D_half textureName
          #define TEXTURE2D_ARRAY_HALF(textureName)     Texture2DArray textureName    // no support to _float on Array, it's being added
          #define TEXTURECUBE_HALF(textureName)         TextureCube_half textureName
          #define TEXTURECUBE_ARRAY_HALF(textureName)   TextureCubeArray textureName  // no support to _float on Array, it's being added
          #define TEXTURE3D_HALF(textureName)           Texture3D_half textureName
        
          #define TEXTURE2D_SHADOW(textureName)         TEXTURE2D(textureName)
          #define TEXTURE2D_ARRAY_SHADOW(textureName)   TEXTURE2D_ARRAY(textureName)
          #define TEXTURECUBE_SHADOW(textureName)       TEXTURECUBE(textureName)
          #define TEXTURECUBE_ARRAY_SHADOW(textureName) TEXTURECUBE_ARRAY(textureName)
        
          #define RW_TEXTURE2D(type, textureName)       RWTexture2D<type> textureName
          #define RW_TEXTURE2D_ARRAY(type, textureName) RWTexture2DArray<type> textureName
          #define RW_TEXTURE3D(type, textureName)       RWTexture3D<type> textureName
        
          #define SAMPLER(samplerName)                  SamplerState samplerName
          #define SAMPLER_CMP(samplerName)              SamplerComparisonState samplerName
        
          #define TEXTURE2D_PARAM(textureName, samplerName)                 TEXTURE2D(textureName), SAMPLER(samplerName)
          #define TEXTURE2D_ARRAY_PARAM(textureName, samplerName)           TEXTURE2D_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_PARAM(textureName, samplerName)               TEXTURECUBE(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_ARRAY_PARAM(textureName, samplerName)         TEXTURECUBE_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURE3D_PARAM(textureName, samplerName)                 TEXTURE3D(textureName), SAMPLER(samplerName)
        
          #define TEXTURE2D_SHADOW_PARAM(textureName, samplerName)          TEXTURE2D(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURE2D_ARRAY_SHADOW_PARAM(textureName, samplerName)    TEXTURE2D_ARRAY(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_SHADOW_PARAM(textureName, samplerName)        TEXTURECUBE(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_ARRAY_SHADOW_PARAM(textureName, samplerName)  TEXTURECUBE_ARRAY(textureName), SAMPLER_CMP(samplerName)
        
          #define TEXTURE2D_ARGS(textureName, samplerName)                textureName, samplerName
          #define TEXTURE2D_ARRAY_ARGS(textureName, samplerName)          textureName, samplerName
          #define TEXTURECUBE_ARGS(textureName, samplerName)              textureName, samplerName
          #define TEXTURECUBE_ARRAY_ARGS(textureName, samplerName)        textureName, samplerName
          #define TEXTURE3D_ARGS(textureName, samplerName)                textureName, samplerName
        
          #define TEXTURE2D_SHADOW_ARGS(textureName, samplerName)         textureName, samplerName
          #define TEXTURE2D_ARRAY_SHADOW_ARGS(textureName, samplerName)   textureName, samplerName
          #define TEXTURECUBE_SHADOW_ARGS(textureName, samplerName)       textureName, samplerName
          #define TEXTURECUBE_ARRAY_SHADOW_ARGS(textureName, samplerName) textureName, samplerName
        
          #define SAMPLE_TEXTURE2D(textureName, samplerName, coord2)                               textureName.Sample(samplerName, coord2)
          #define SAMPLE_TEXTURE2D_LOD(textureName, samplerName, coord2, lod)                      textureName.SampleLevel(samplerName, coord2, lod)
          #define SAMPLE_TEXTURE2D_BIAS(textureName, samplerName, coord2, bias)                    textureName.SampleBias(samplerName, coord2, bias)
          #define SAMPLE_TEXTURE2D_GRAD(textureName, samplerName, coord2, dpdx, dpdy)              textureName.SampleGrad(samplerName, coord2, dpdx, dpdy)
          #define SAMPLE_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)                  textureName.Sample(samplerName, float3(coord2, index))
          #define SAMPLE_TEXTURE2D_ARRAY_LOD(textureName, samplerName, coord2, index, lod)         textureName.SampleLevel(samplerName, float3(coord2, index), lod)
          #define SAMPLE_TEXTURE2D_ARRAY_BIAS(textureName, samplerName, coord2, index, bias)       textureName.SampleBias(samplerName, float3(coord2, index), bias)
          #define SAMPLE_TEXTURE2D_ARRAY_GRAD(textureName, samplerName, coord2, index, dpdx, dpdy) textureName.SampleGrad(samplerName, float3(coord2, index), dpdx, dpdy)
          #define SAMPLE_TEXTURECUBE(textureName, samplerName, coord3)                             textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURECUBE_LOD(textureName, samplerName, coord3, lod)                    textureName.SampleLevel(samplerName, coord3, lod)
          #define SAMPLE_TEXTURECUBE_BIAS(textureName, samplerName, coord3, bias)                  textureName.SampleBias(samplerName, coord3, bias)
          #define SAMPLE_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)                textureName.Sample(samplerName, float4(coord3, index))
          #define SAMPLE_TEXTURECUBE_ARRAY_LOD(textureName, samplerName, coord3, index, lod)       textureName.SampleLevel(samplerName, float4(coord3, index), lod)
          #define SAMPLE_TEXTURECUBE_ARRAY_BIAS(textureName, samplerName, coord3, index, bias)     textureName.SampleBias(samplerName, float4(coord3, index), bias)
          #define SAMPLE_TEXTURE3D(textureName, samplerName, coord3)                               textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURE3D_LOD(textureName, samplerName, coord3, lod)                      textureName.SampleLevel(samplerName, coord3, lod)
        
          #define SAMPLE_TEXTURE2D_SHADOW(textureName, samplerName, coord3)                    textureName.SampleCmpLevelZero(samplerName, (coord3).xy, (coord3).z)
          #define SAMPLE_TEXTURE2D_ARRAY_SHADOW(textureName, samplerName, coord3, index)       textureName.SampleCmpLevelZero(samplerName, float3((coord3).xy, index), (coord3).z)
          #define SAMPLE_TEXTURECUBE_SHADOW(textureName, samplerName, coord4)                  textureName.SampleCmpLevelZero(samplerName, (coord4).xyz, (coord4).w)
          #define SAMPLE_TEXTURECUBE_ARRAY_SHADOW(textureName, samplerName, coord4, index)     textureName.SampleCmpLevelZero(samplerName, float4((coord4).xyz, index), (coord4).w)
        
          #define LOAD_TEXTURE2D(textureName, unCoord2)                                   textureName.Load(int3(unCoord2, 0))
          #define LOAD_TEXTURE2D_LOD(textureName, unCoord2, lod)                          textureName.Load(int3(unCoord2, lod))
          #define LOAD_TEXTURE2D_MSAA(textureName, unCoord2, sampleIndex)                 textureName.Load(unCoord2, sampleIndex)
          #define LOAD_TEXTURE2D_ARRAY(textureName, unCoord2, index)                      textureName.Load(int4(unCoord2, index, 0))
          #define LOAD_TEXTURE2D_ARRAY_MSAA(textureName, unCoord2, index, sampleIndex)    textureName.Load(int3(unCoord2, index), sampleIndex)
          #define LOAD_TEXTURE2D_ARRAY_LOD(textureName, unCoord2, index, lod)             textureName.Load(int4(unCoord2, index, lod))
          #define LOAD_TEXTURE3D(textureName, unCoord3)                                   textureName.Load(int4(unCoord3, 0))
          #define LOAD_TEXTURE3D_LOD(textureName, unCoord3, lod)                          textureName.Load(int4(unCoord3, lod))
        
          #define PLATFORM_SUPPORT_GATHER
          #define GATHER_TEXTURE2D(textureName, samplerName, coord2)                textureName.Gather(samplerName, coord2)
          #define GATHER_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)   textureName.Gather(samplerName, float3(coord2, index))
          #define GATHER_TEXTURECUBE(textureName, samplerName, coord3)              textureName.Gather(samplerName, coord3)
          #define GATHER_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index) textureName.Gather(samplerName, float4(coord3, index))
          #define GATHER_RED_TEXTURE2D(textureName, samplerName, coord2)            textureName.GatherRed(samplerName, coord2)
          #define GATHER_GREEN_TEXTURE2D(textureName, samplerName, coord2)          textureName.GatherGreen(samplerName, coord2)
          #define GATHER_BLUE_TEXTURE2D(textureName, samplerName, coord2)           textureName.GatherBlue(samplerName, coord2)
          #define GATHER_ALPHA_TEXTURE2D(textureName, samplerName, coord2)          textureName.GatherAlpha(samplerName, coord2)
        
        #elif defined(SHADER_API_VULKAN)
          // This file assume SHADER_API_VULKAN is defined
          // TODO: This is a straight copy from D3D11.hlsl. Go through all this stuff and adjust where needed.
        
        
          // Initialize arbitrary structure with zero values.
          // Do not exist on some platform, in this case we need to have a standard name that call a function that will initialize all parameters to 0
          #define ZERO_INITIALIZE(type, name) name = (type)0;
          #define ZERO_INITIALIZE_ARRAY(type, name, arraySize) { for (int arrayIndex = 0; arrayIndex < arraySize; arrayIndex++) { name[arrayIndex] = (type)0; } }
        
          // Texture util abstraction
        
          #define CALCULATE_TEXTURE2D_LOD(textureName, samplerName, coord2) textureName.CalculateLevelOfDetail(samplerName, coord2)
        
          // Texture abstraction
        
          #define TEXTURE2D(textureName)                Texture2D textureName
          #define TEXTURE2D_ARRAY(textureName)          Texture2DArray textureName
          #define TEXTURECUBE(textureName)              TextureCube textureName
          #define TEXTURECUBE_ARRAY(textureName)        TextureCubeArray textureName
          #define TEXTURE3D(textureName)                Texture3D textureName
        
          #define TEXTURE2D_FLOAT(textureName)          Texture2D_float textureName
          #define TEXTURE2D_ARRAY_FLOAT(textureName)    Texture2DArray textureName    // no support to _float on Array, it's being added
          #define TEXTURECUBE_FLOAT(textureName)        TextureCube_float textureName
          #define TEXTURECUBE_ARRAY_FLOAT(textureName)  TextureCubeArray textureName  // no support to _float on Array, it's being added
          #define TEXTURE3D_FLOAT(textureName)          Texture3D_float textureName
        
          #define TEXTURE2D_HALF(textureName)           Texture2D_half textureName
          #define TEXTURE2D_ARRAY_HALF(textureName)     Texture2DArray textureName    // no support to _float on Array, it's being added
          #define TEXTURECUBE_HALF(textureName)         TextureCube_half textureName
          #define TEXTURECUBE_ARRAY_HALF(textureName)   TextureCubeArray textureName  // no support to _float on Array, it's being added
          #define TEXTURE3D_HALF(textureName)           Texture3D_half textureName
        
          #define TEXTURE2D_SHADOW(textureName)         TEXTURE2D(textureName)
          #define TEXTURE2D_ARRAY_SHADOW(textureName)   TEXTURE2D_ARRAY(textureName)
          #define TEXTURECUBE_SHADOW(textureName)       TEXTURECUBE(textureName)
          #define TEXTURECUBE_ARRAY_SHADOW(textureName) TEXTURECUBE_ARRAY(textureName)
        
          #define RW_TEXTURE2D(type, textureName)       RWTexture2D<type> textureName
          #define RW_TEXTURE2D_ARRAY(type, textureName) RWTexture2DArray<type> textureName
          #define RW_TEXTURE3D(type, textureName)       RWTexture3D<type> textureName
        
          #define SAMPLER(samplerName)                  SamplerState samplerName
          #define SAMPLER_CMP(samplerName)              SamplerComparisonState samplerName
        
          #define TEXTURE2D_PARAM(textureName, samplerName)                 TEXTURE2D(textureName), SAMPLER(samplerName)
          #define TEXTURE2D_ARRAY_PARAM(textureName, samplerName)           TEXTURE2D_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_PARAM(textureName, samplerName)               TEXTURECUBE(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_ARRAY_PARAM(textureName, samplerName)         TEXTURECUBE_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURE3D_PARAM(textureName, samplerName)                 TEXTURE3D(textureName), SAMPLER(samplerName)
        
          #define TEXTURE2D_SHADOW_PARAM(textureName, samplerName)          TEXTURE2D(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURE2D_ARRAY_SHADOW_PARAM(textureName, samplerName)    TEXTURE2D_ARRAY(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_SHADOW_PARAM(textureName, samplerName)        TEXTURECUBE(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_ARRAY_SHADOW_PARAM(textureName, samplerName)  TEXTURECUBE_ARRAY(textureName), SAMPLER_CMP(samplerName)
        
          #define TEXTURE2D_ARGS(textureName, samplerName)                textureName, samplerName
          #define TEXTURE2D_ARRAY_ARGS(textureName, samplerName)          textureName, samplerName
          #define TEXTURECUBE_ARGS(textureName, samplerName)              textureName, samplerName
          #define TEXTURECUBE_ARRAY_ARGS(textureName, samplerName)        textureName, samplerName
          #define TEXTURE3D_ARGS(textureName, samplerName)                textureName, samplerName
        
          #define TEXTURE2D_SHADOW_ARGS(textureName, samplerName)         textureName, samplerName
          #define TEXTURE2D_ARRAY_SHADOW_ARGS(textureName, samplerName)   textureName, samplerName
          #define TEXTURECUBE_SHADOW_ARGS(textureName, samplerName)       textureName, samplerName
          #define TEXTURECUBE_ARRAY_SHADOW_ARGS(textureName, samplerName) textureName, samplerName
        
          #define SAMPLE_TEXTURE2D(textureName, samplerName, coord2)                               textureName.Sample(samplerName, coord2)
          #define SAMPLE_TEXTURE2D_LOD(textureName, samplerName, coord2, lod)                      textureName.SampleLevel(samplerName, coord2, lod)
          #define SAMPLE_TEXTURE2D_BIAS(textureName, samplerName, coord2, bias)                    textureName.SampleBias(samplerName, coord2, bias)
          #define SAMPLE_TEXTURE2D_GRAD(textureName, samplerName, coord2, dpdx, dpdy)              textureName.SampleGrad(samplerName, coord2, dpdx, dpdy)
          #define SAMPLE_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)                  textureName.Sample(samplerName, float3(coord2, index))
          #define SAMPLE_TEXTURE2D_ARRAY_LOD(textureName, samplerName, coord2, index, lod)         textureName.SampleLevel(samplerName, float3(coord2, index), lod)
          #define SAMPLE_TEXTURE2D_ARRAY_BIAS(textureName, samplerName, coord2, index, bias)       textureName.SampleBias(samplerName, float3(coord2, index), bias)
          #define SAMPLE_TEXTURE2D_ARRAY_GRAD(textureName, samplerName, coord2, index, dpdx, dpdy) textureName.SampleGrad(samplerName, float3(coord2, index), dpdx, dpdy)
          #define SAMPLE_TEXTURECUBE(textureName, samplerName, coord3)                             textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURECUBE_LOD(textureName, samplerName, coord3, lod)                    textureName.SampleLevel(samplerName, coord3, lod)
          #define SAMPLE_TEXTURECUBE_BIAS(textureName, samplerName, coord3, bias)                  textureName.SampleBias(samplerName, coord3, bias)
          #define SAMPLE_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)                textureName.Sample(samplerName, float4(coord3, index))
          #define SAMPLE_TEXTURECUBE_ARRAY_LOD(textureName, samplerName, coord3, index, lod)       textureName.SampleLevel(samplerName, float4(coord3, index), lod)
          #define SAMPLE_TEXTURECUBE_ARRAY_BIAS(textureName, samplerName, coord3, index, bias)     textureName.SampleBias(samplerName, float4(coord3, index), bias)
          #define SAMPLE_TEXTURE3D(textureName, samplerName, coord3)                               textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURE3D_LOD(textureName, samplerName, coord3, lod)                      textureName.SampleLevel(samplerName, coord3, lod)
        
          #define SAMPLE_TEXTURE2D_SHADOW(textureName, samplerName, coord3)                    textureName.SampleCmpLevelZero(samplerName, (coord3).xy, (coord3).z)
          #define SAMPLE_TEXTURE2D_ARRAY_SHADOW(textureName, samplerName, coord3, index)       textureName.SampleCmpLevelZero(samplerName, float3((coord3).xy, index), (coord3).z)
          #define SAMPLE_TEXTURECUBE_SHADOW(textureName, samplerName, coord4)                  textureName.SampleCmpLevelZero(samplerName, (coord4).xyz, (coord4).w)
          #define SAMPLE_TEXTURECUBE_ARRAY_SHADOW(textureName, samplerName, coord4, index)     textureName.SampleCmpLevelZero(samplerName, float4((coord4).xyz, index), (coord4).w)
        
          #define LOAD_TEXTURE2D(textureName, unCoord2)                                   textureName.Load(int3(unCoord2, 0))
          #define LOAD_TEXTURE2D_LOD(textureName, unCoord2, lod)                          textureName.Load(int3(unCoord2, lod))
          #define LOAD_TEXTURE2D_MSAA(textureName, unCoord2, sampleIndex)                 textureName.Load(unCoord2, sampleIndex)
          #define LOAD_TEXTURE2D_ARRAY(textureName, unCoord2, index)                      textureName.Load(int4(unCoord2, index, 0))
          #define LOAD_TEXTURE2D_ARRAY_MSAA(textureName, unCoord2, index, sampleIndex)    textureName.Load(int3(unCoord2, index), sampleIndex)
          #define LOAD_TEXTURE2D_ARRAY_LOD(textureName, unCoord2, index, lod)             textureName.Load(int4(unCoord2, index, lod))
          #define LOAD_TEXTURE3D(textureName, unCoord3)                                   textureName.Load(int4(unCoord3, 0))
          #define LOAD_TEXTURE3D_LOD(textureName, unCoord3, lod)                          textureName.Load(int4(unCoord3, lod))
        
          #define PLATFORM_SUPPORT_GATHER
          #define GATHER_TEXTURE2D(textureName, samplerName, coord2)                textureName.Gather(samplerName, coord2)
          #define GATHER_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)   textureName.Gather(samplerName, float3(coord2, index))
          #define GATHER_TEXTURECUBE(textureName, samplerName, coord3)              textureName.Gather(samplerName, coord3)
          #define GATHER_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index) textureName.Gather(samplerName, float4(coord3, index))
          #define GATHER_RED_TEXTURE2D(textureName, samplerName, coord2)            textureName.GatherRed(samplerName, coord2)
          #define GATHER_GREEN_TEXTURE2D(textureName, samplerName, coord2)          textureName.GatherGreen(samplerName, coord2)
          #define GATHER_BLUE_TEXTURE2D(textureName, samplerName, coord2)           textureName.GatherBlue(samplerName, coord2)
          #define GATHER_ALPHA_TEXTURE2D(textureName, samplerName, coord2)          textureName.GatherAlpha(samplerName, coord2)
        
        #elif defined(SHADER_API_SWITCH)
          // This file assume SHADER_API_SWITCH is defined
        
          // Initialize arbitrary structure with zero values.
          // Do not exist on some platform, in this case we need to have a standard name that call a function that will initialize all parameters to 0
          #define ZERO_INITIALIZE(type, name) name = (type)0;
          #define ZERO_INITIALIZE_ARRAY(type, name, arraySize) { for (int arrayIndex = 0; arrayIndex < arraySize; arrayIndex++) { name[arrayIndex] = (type)0; } }
        
          // Texture util abstraction
        
          #define CALCULATE_TEXTURE2D_LOD(textureName, samplerName, coord2) textureName.CalculateLevelOfDetail(samplerName, coord2)
        
          // Texture abstraction
        
          #define TEXTURE2D(textureName)                Texture2D textureName
          #define TEXTURE2D_ARRAY(textureName)          Texture2DArray textureName
          #define TEXTURECUBE(textureName)              TextureCube textureName
          #define TEXTURECUBE_ARRAY(textureName)        TextureCubeArray textureName
          #define TEXTURE3D(textureName)                Texture3D textureName
        
          #define TEXTURE2D_FLOAT(textureName)          Texture2D_float textureName
          #define TEXTURE2D_ARRAY_FLOAT(textureName)    Texture2DArray textureName    // no support to _float on Array, it's being added
          #define TEXTURECUBE_FLOAT(textureName)        TextureCube_float textureName
          #define TEXTURECUBE_ARRAY_FLOAT(textureName)  TextureCubeArray textureName  // no support to _float on Array, it's being added
          #define TEXTURE3D_FLOAT(textureName)          Texture3D_float textureName
        
          #define TEXTURE2D_HALF(textureName)           Texture2D_half textureName
          #define TEXTURE2D_ARRAY_HALF(textureName)     Texture2DArray textureName    // no support to _float on Array, it's being added
          #define TEXTURECUBE_HALF(textureName)         TextureCube_half textureName
          #define TEXTURECUBE_ARRAY_HALF(textureName)   TextureCubeArray textureName  // no support to _float on Array, it's being added
          #define TEXTURE3D_HALF(textureName)           Texture3D_half textureName
        
          #define TEXTURE2D_SHADOW(textureName)         TEXTURE2D(textureName)
          #define TEXTURE2D_ARRAY_SHADOW(textureName)   TEXTURE2D_ARRAY(textureName)
          #define TEXTURECUBE_SHADOW(textureName)       TEXTURECUBE(textureName)
          #define TEXTURECUBE_ARRAY_SHADOW(textureName) TEXTURECUBE_ARRAY(textureName)
        
          #define RW_TEXTURE2D(type, textureName)       RWTexture2D<type> textureName
          #define RW_TEXTURE2D_ARRAY(type, textureName) RWTexture2DArray<type> textureName
          #define RW_TEXTURE3D(type, textureName)       RWTexture3D<type> textureName
        
          #define SAMPLER(samplerName)                  SamplerState samplerName
          #define SAMPLER_CMP(samplerName)              SamplerComparisonState samplerName
        
          #define TEXTURE2D_PARAM(textureName, samplerName)                 TEXTURE2D(textureName), SAMPLER(samplerName)
          #define TEXTURE2D_ARRAY_PARAM(textureName, samplerName)           TEXTURE2D_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_PARAM(textureName, samplerName)               TEXTURECUBE(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_ARRAY_PARAM(textureName, samplerName)         TEXTURECUBE_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURE3D_PARAM(textureName, samplerName)                 TEXTURE3D(textureName), SAMPLER(samplerName)
        
          #define TEXTURE2D_SHADOW_PARAM(textureName, samplerName)          TEXTURE2D(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURE2D_ARRAY_SHADOW_PARAM(textureName, samplerName)    TEXTURE2D_ARRAY(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_SHADOW_PARAM(textureName, samplerName)        TEXTURECUBE(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_ARRAY_SHADOW_PARAM(textureName, samplerName)  TEXTURECUBE_ARRAY(textureName), SAMPLER_CMP(samplerName)
        
          #define TEXTURE2D_ARGS(textureName, samplerName)                textureName, samplerName
          #define TEXTURE2D_ARRAY_ARGS(textureName, samplerName)          textureName, samplerName
          #define TEXTURECUBE_ARGS(textureName, samplerName)              textureName, samplerName
          #define TEXTURECUBE_ARRAY_ARGS(textureName, samplerName)        textureName, samplerName
          #define TEXTURE3D_ARGS(textureName, samplerName)                textureName, samplerName
        
          #define TEXTURE2D_SHADOW_ARGS(textureName, samplerName)         textureName, samplerName
          #define TEXTURE2D_ARRAY_SHADOW_ARGS(textureName, samplerName)   textureName, samplerName
          #define TEXTURECUBE_SHADOW_ARGS(textureName, samplerName)       textureName, samplerName
          #define TEXTURECUBE_ARRAY_SHADOW_ARGS(textureName, samplerName) textureName, samplerName
        
          #define SAMPLE_TEXTURE2D(textureName, samplerName, coord2)                               textureName.Sample(samplerName, coord2)
          #define SAMPLE_TEXTURE2D_LOD(textureName, samplerName, coord2, lod)                      textureName.SampleLevel(samplerName, coord2, lod)
          #define SAMPLE_TEXTURE2D_BIAS(textureName, samplerName, coord2, bias)                    textureName.SampleBias(samplerName, coord2, bias)
          #define SAMPLE_TEXTURE2D_GRAD(textureName, samplerName, coord2, dpdx, dpdy)              textureName.SampleGrad(samplerName, coord2, dpdx, dpdy)
          #define SAMPLE_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)                  textureName.Sample(samplerName, float3(coord2, index))
          #define SAMPLE_TEXTURE2D_ARRAY_LOD(textureName, samplerName, coord2, index, lod)         textureName.SampleLevel(samplerName, float3(coord2, index), lod)
          #define SAMPLE_TEXTURE2D_ARRAY_BIAS(textureName, samplerName, coord2, index, bias)       textureName.SampleBias(samplerName, float3(coord2, index), bias)
          #define SAMPLE_TEXTURE2D_ARRAY_GRAD(textureName, samplerName, coord2, index, dpdx, dpdy) textureName.SampleGrad(samplerName, float3(coord2, index), dpdx, dpdy)
          #define SAMPLE_TEXTURECUBE(textureName, samplerName, coord3)                             textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURECUBE_LOD(textureName, samplerName, coord3, lod)                    textureName.SampleLevel(samplerName, coord3, lod)
          #define SAMPLE_TEXTURECUBE_BIAS(textureName, samplerName, coord3, bias)                  textureName.SampleBias(samplerName, coord3, bias)
          #define SAMPLE_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)                textureName.Sample(samplerName, float4(coord3, index))
          #define SAMPLE_TEXTURECUBE_ARRAY_LOD(textureName, samplerName, coord3, index, lod)       textureName.SampleLevel(samplerName, float4(coord3, index), lod)
          #define SAMPLE_TEXTURECUBE_ARRAY_BIAS(textureName, samplerName, coord3, index, bias)     textureName.SampleBias(samplerName, float4(coord3, index), bias)
          #define SAMPLE_TEXTURE3D(textureName, samplerName, coord3)                               textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURE3D_LOD(textureName, samplerName, coord3, lod)                      textureName.SampleLevel(samplerName, coord3, lod)
        
          #define SAMPLE_TEXTURE2D_SHADOW(textureName, samplerName, coord3)                    textureName.SampleCmpLevelZero(samplerName, (coord3).xy, (coord3).z)
          #define SAMPLE_TEXTURE2D_ARRAY_SHADOW(textureName, samplerName, coord3, index)       textureName.SampleCmpLevelZero(samplerName, float3((coord3).xy, index), (coord3).z)
          #define SAMPLE_TEXTURECUBE_SHADOW(textureName, samplerName, coord4)                  textureName.SampleCmpLevelZero(samplerName, (coord4).xyz, (coord4).w)
          #define SAMPLE_TEXTURECUBE_ARRAY_SHADOW(textureName, samplerName, coord4, index)     textureName.SampleCmpLevelZero(samplerName, float4((coord4).xyz, index), (coord4).w)
        
        
          #define LOAD_TEXTURE2D(textureName, unCoord2)                       textureName.Load(int3(unCoord2, 0))
          #define LOAD_TEXTURE2D_LOD(textureName, unCoord2, lod)              textureName.Load(int3(unCoord2, lod))
          #define LOAD_TEXTURE2D_MSAA(textureName, unCoord2, sampleIndex)     textureName.Load(unCoord2, sampleIndex)
          #define LOAD_TEXTURE2D_ARRAY(textureName, unCoord2, index)          textureName.Load(int4(unCoord2, index, 0))
          #define LOAD_TEXTURE2D_ARRAY_LOD(textureName, unCoord2, index, lod) textureName.Load(int4(unCoord2, index, lod))
          #define LOAD_TEXTURE3D(textureName, unCoord3)                       textureName.Load(int4(unCoord3, 0))
          #define LOAD_TEXTURE3D_LOD(textureName, unCoord3, lod)              textureName.Load(int4(unCoord3, lod))
        
          #define PLATFORM_SUPPORT_GATHER
          #define GATHER_TEXTURE2D(textureName, samplerName, coord2)                textureName.Gather(samplerName, coord2)
          #define GATHER_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)   textureName.Gather(samplerName, float3(coord2, index))
          #define GATHER_TEXTURECUBE(textureName, samplerName, coord3)              textureName.Gather(samplerName, coord3)
          #define GATHER_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index) textureName.Gather(samplerName, float4(coord3, index))
          #define GATHER_RED_TEXTURE2D(textureName, samplerName, coord2)            textureName.GatherRed(samplerName, coord2)
          #define GATHER_GREEN_TEXTURE2D(textureName, samplerName, coord2)          textureName.GatherGreen(samplerName, coord2)
          #define GATHER_BLUE_TEXTURE2D(textureName, samplerName, coord2)           textureName.GatherBlue(samplerName, coord2)
          #define GATHER_ALPHA_TEXTURE2D(textureName, samplerName, coord2)          textureName.GatherAlpha(samplerName, coord2)
        
        #elif defined(SHADER_API_GLCORE)
        
          // OpenGL 4.1 SM 5.0 https://docs.unity3d.com/Manual/SL-ShaderCompileTargets.html
          #if (SHADER_TARGET >= 46)
            #define OPENGL4_1_SM5 1
          #else
            #define OPENGL4_1_SM5 0
          #endif
        
          // Initialize arbitrary structure with zero values.
          // Do not exist on some platform, in this case we need to have a standard name that call a function that will initialize all parameters to 0
          #define ZERO_INITIALIZE(type, name) name = (type)0;
          #define ZERO_INITIALIZE_ARRAY(type, name, arraySize) { for (int arrayIndex = 0; arrayIndex < arraySize; arrayIndex++) { name[arrayIndex] = (type)0; } }
        
          // Texture util abstraction
        
          #define CALCULATE_TEXTURE2D_LOD(textureName, samplerName, coord2) textureName.CalculateLevelOfDetail(samplerName, coord2)
        
          // Texture abstraction
        
          #define TEXTURE2D(textureName)                  Texture2D textureName
          #define TEXTURE2D_ARRAY(textureName)            Texture2DArray textureName
          #define TEXTURECUBE(textureName)                TextureCube textureName
          #define TEXTURECUBE_ARRAY(textureName)          TextureCubeArray textureName
          #define TEXTURE3D(textureName)                  Texture3D textureName
        
          #define TEXTURE2D_FLOAT(textureName)            TEXTURE2D(textureName)
          #define TEXTURE2D_ARRAY_FLOAT(textureName)      TEXTURE2D_ARRAY(textureName)
          #define TEXTURECUBE_FLOAT(textureName)          TEXTURECUBE(textureName)
          #define TEXTURECUBE_ARRAY_FLOAT(textureName)    TEXTURECUBE_ARRAY(textureName)
          #define TEXTURE3D_FLOAT(textureName)            TEXTURE3D(textureName)
        
          #define TEXTURE2D_HALF(textureName)             TEXTURE2D(textureName)
          #define TEXTURE2D_ARRAY_HALF(textureName)       TEXTURE2D_ARRAY(textureName)
          #define TEXTURECUBE_HALF(textureName)           TEXTURECUBE(textureName)
          #define TEXTURECUBE_ARRAY_HALF(textureName)     TEXTURECUBE_ARRAY(textureName)
          #define TEXTURE3D_HALF(textureName)             TEXTURE3D(textureName)
        
          #define TEXTURE2D_SHADOW(textureName)           TEXTURE2D(textureName)
          #define TEXTURE2D_ARRAY_SHADOW(textureName)     TEXTURE2D_ARRAY(textureName)
          #define TEXTURECUBE_SHADOW(textureName)         TEXTURECUBE(textureName)
          #define TEXTURECUBE_ARRAY_SHADOW(textureName)   TEXTURECUBE_ARRAY(textureName)
        
          #define RW_TEXTURE2D(type, textureName)         RWTexture2D<type> textureName
          #define RW_TEXTURE2D_ARRAY(type, textureName)   RWTexture2DArray<type> textureName
          #define RW_TEXTURE3D(type, textureName)         RWTexture3D<type> textureName
        
          #define SAMPLER(samplerName)                    SamplerState samplerName
          #define SAMPLER_CMP(samplerName)                SamplerComparisonState samplerName
        
          #define TEXTURE2D_PARAM(textureName, samplerName)                 TEXTURE2D(textureName), SAMPLER(samplerName)
          #define TEXTURE2D_ARRAY_PARAM(textureName, samplerName)           TEXTURE2D_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_PARAM(textureName, samplerName)               TEXTURECUBE(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_ARRAY_PARAM(textureName, samplerName)         TEXTURECUBE_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURE3D_PARAM(textureName, samplerName)                 TEXTURE3D(textureName), SAMPLER(samplerName)
        
          #define TEXTURE2D_SHADOW_PARAM(textureName, samplerName)          TEXTURE2D(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURE2D_ARRAY_SHADOW_PARAM(textureName, samplerName)    TEXTURE2D_ARRAY(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_SHADOW_PARAM(textureName, samplerName)        TEXTURECUBE(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_ARRAY_SHADOW_PARAM(textureName, samplerName)  TEXTURECUBE_ARRAY(textureName), SAMPLER_CMP(samplerName)
        
          #define TEXTURE2D_ARGS(textureName, samplerName)                textureName, samplerName
          #define TEXTURE2D_ARRAY_ARGS(textureName, samplerName)          textureName, samplerName
          #define TEXTURECUBE_ARGS(textureName, samplerName)              textureName, samplerName
          #define TEXTURECUBE_ARRAY_ARGS(textureName, samplerName)        textureName, samplerName
          #define TEXTURE3D_ARGS(textureName, samplerName)                textureName, samplerName
        
          #define TEXTURE2D_SHADOW_ARGS(textureName, samplerName)         textureName, samplerName
          #define TEXTURE2D_ARRAY_SHADOW_ARGS(textureName, samplerName)   textureName, samplerName
          #define TEXTURECUBE_SHADOW_ARGS(textureName, samplerName)       textureName, samplerName
          #define TEXTURECUBE_ARRAY_SHADOW_ARGS(textureName, samplerName) textureName, samplerName
        
          #define SAMPLE_TEXTURE2D(textureName, samplerName, coord2)                               textureName.Sample(samplerName, coord2)
          #define SAMPLE_TEXTURE2D_LOD(textureName, samplerName, coord2, lod)                      textureName.SampleLevel(samplerName, coord2, lod)
          #define SAMPLE_TEXTURE2D_BIAS(textureName, samplerName, coord2, bias)                    textureName.SampleBias(samplerName, coord2, bias)
          #define SAMPLE_TEXTURE2D_GRAD(textureName, samplerName, coord2, ddx, ddy)                textureName.SampleGrad(samplerName, coord2, ddx, ddy)
          #define SAMPLE_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)                  textureName.Sample(samplerName, float3(coord2, index))
          #define SAMPLE_TEXTURE2D_ARRAY_LOD(textureName, samplerName, coord2, index, lod)         textureName.SampleLevel(samplerName, float3(coord2, index), lod)
          #define SAMPLE_TEXTURE2D_ARRAY_BIAS(textureName, samplerName, coord2, index, bias)       textureName.SampleBias(samplerName, float3(coord2, index), bias)
          #define SAMPLE_TEXTURE2D_ARRAY_GRAD(textureName, samplerName, coord2, index, dpdx, dpdy) textureName.SampleGrad(samplerName, float3(coord2, index), dpdx, dpdy)
          #define SAMPLE_TEXTURECUBE(textureName, samplerName, coord3)                             textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURECUBE_LOD(textureName, samplerName, coord3, lod)                    textureName.SampleLevel(samplerName, coord3, lod)
          #define SAMPLE_TEXTURECUBE_BIAS(textureName, samplerName, coord3, bias)                  textureName.SampleBias(samplerName, coord3, bias)
          #ifdef UNITY_NO_CUBEMAP_ARRAY
            #define SAMPLE_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)           ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURECUBE_ARRAY)
            #define SAMPLE_TEXTURECUBE_ARRAY_LOD(textureName, samplerName, coord3, index, lod)  ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURECUBE_ARRAY_LOD)
            #define SAMPLE_TEXTURECUBE_ARRAY_LOD(textureName, samplerName, coord3, index, bias) ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURECUBE_ARRAY_LOD)
          #else
            #define SAMPLE_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)           textureName.Sample(samplerName, float4(coord3, index))
            #define SAMPLE_TEXTURECUBE_ARRAY_LOD(textureName, samplerName, coord3, index, lod)  textureName.SampleLevel(samplerName, float4(coord3, index), lod)
            #define SAMPLE_TEXTURECUBE_ARRAY_BIAS(textureName, samplerName, coord3, index, bias)textureName.SampleBias(samplerName, float4(coord3, index), bias)
          #endif
          #define SAMPLE_TEXTURE3D(textureName, samplerName, coord3)                          textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURE3D_LOD(textureName, samplerName, coord3, lod)                 textureName.SampleLevel(samplerName, coord3, lod)
        
          #define SAMPLE_TEXTURE2D_SHADOW(textureName, samplerName, coord3)                   textureName.SampleCmpLevelZero(samplerName, (coord3).xy, (coord3).z)
          #define SAMPLE_TEXTURE2D_ARRAY_SHADOW(textureName, samplerName, coord3, index)      textureName.SampleCmpLevelZero(samplerName, float3((coord3).xy, index), (coord3).z)
          #define SAMPLE_TEXTURECUBE_SHADOW(textureName, samplerName, coord4)                 textureName.SampleCmpLevelZero(samplerName, (coord4).xyz, (coord4).w)
          #define SAMPLE_TEXTURECUBE_ARRAY_SHADOW(textureName, samplerName, coord4, index)    textureName.SampleCmpLevelZero(samplerName, float4((coord4).xyz, index), (coord4).w)
        
          #define LOAD_TEXTURE2D(textureName, unCoord2)                                   textureName.Load(int3(unCoord2, 0))
          #define LOAD_TEXTURE2D_LOD(textureName, unCoord2, lod)                          textureName.Load(int3(unCoord2, lod))
          #define LOAD_TEXTURE2D_MSAA(textureName, unCoord2, sampleIndex)                 textureName.Load(unCoord2, sampleIndex)
          #define LOAD_TEXTURE2D_ARRAY(textureName, unCoord2, index)                      textureName.Load(int4(unCoord2, index, 0))
          #define LOAD_TEXTURE2D_ARRAY_MSAA(textureName, unCoord2, index, sampleIndex)    textureName.Load(int3(unCoord2, index), sampleIndex)
          #define LOAD_TEXTURE2D_ARRAY_LOD(textureName, unCoord2, index, lod)             textureName.Load(int4(unCoord2, index, lod))
        
          #if OPENGL4_1_SM5
            #define PLATFORM_SUPPORT_GATHER
            #define GATHER_TEXTURE2D(textureName, samplerName, coord2)                  textureName.Gather(samplerName, coord2)
            #define GATHER_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)     textureName.Gather(samplerName, float3(coord2, index))
            #define GATHER_TEXTURECUBE(textureName, samplerName, coord3)                textureName.Gather(samplerName, coord3)
            #define GATHER_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)   textureName.Gather(samplerName, float4(coord3, index))
          #else
            #define GATHER_TEXTURE2D(textureName, samplerName, coord2)                  ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_TEXTURE2D)
            #define GATHER_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)     ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_TEXTURE2D_ARRAY)
            #define GATHER_TEXTURECUBE(textureName, samplerName, coord3)                ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_TEXTURECUBE)
            #define GATHER_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)   ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_TEXTURECUBE_ARRAY)
          #endif
        
        
        #elif defined(SHADER_API_GLES3)
        
          // GLES 3.1 + AEP shader feature https://docs.unity3d.com/Manual/SL-ShaderCompileTargets.html
          #if (SHADER_TARGET >= 40)
            #define GLES3_1_AEP 1
          #else
            #define GLES3_1_AEP 0
          #endif
        
          // Initialize arbitrary structure with zero values.
          // Do not exist on some platform, in this case we need to have a standard name that call a function that will initialize all parameters to 0
          #define ZERO_INITIALIZE(type, name) name = (type)0;
          #define ZERO_INITIALIZE_ARRAY(type, name, arraySize) { for (int arrayIndex = 0; arrayIndex < arraySize; arrayIndex++) { name[arrayIndex] = (type)0; } }
        
          // Texture util abstraction
        
          #define CALCULATE_TEXTURE2D_LOD(textureName, samplerName, coord2) textureName.CalculateLevelOfDetail(samplerName, coord2)
        
          // Texture abstraction
        
          #define TEXTURE2D(textureName)                  Texture2D textureName
          #define TEXTURE2D_ARRAY(textureName)            Texture2DArray textureName
          #define TEXTURECUBE(textureName)                TextureCube textureName
          #define TEXTURECUBE_ARRAY(textureName)          TextureCubeArray textureName
          #define TEXTURE3D(textureName)                  Texture3D textureName
        
          #define TEXTURE2D_FLOAT(textureName)            Texture2D_float textureName
          #define TEXTURE2D_ARRAY_FLOAT(textureName)      Texture2DArray textureName    // no support to _float on Array, it's being added
          #define TEXTURECUBE_FLOAT(textureName)          TextureCube_float textureName
          #define TEXTURECUBE_ARRAY_FLOAT(textureName)    TextureCubeArray textureName  // no support to _float on Array, it's being added
          #define TEXTURE3D_FLOAT(textureName)            Texture3D_float textureName
        
          #define TEXTURE2D_HALF(textureName)             Texture2D_half textureName
          #define TEXTURE2D_ARRAY_HALF(textureName)       Texture2DArray textureName    // no support to _float on Array, it's being added
          #define TEXTURECUBE_HALF(textureName)           TextureCube_half textureName
          #define TEXTURECUBE_ARRAY_HALF(textureName)     TextureCubeArray textureName  // no support to _float on Array, it's being added
          #define TEXTURE3D_HALF(textureName)             Texture3D_half textureName
        
          #define TEXTURE2D_SHADOW(textureName)           TEXTURE2D(textureName)
          #define TEXTURE2D_ARRAY_SHADOW(textureName)     TEXTURE2D_ARRAY(textureName)
          #define TEXTURECUBE_SHADOW(textureName)         TEXTURECUBE(textureName)
          #define TEXTURECUBE_ARRAY_SHADOW(textureName)   TEXTURECUBE_ARRAY(textureName)
        
          #if GLES3_1_AEP
            #define RW_TEXTURE2D(type, textureName)         RWTexture2D<type> textureName
            #define RW_TEXTURE2D_ARRAY(type, textureName)   RWTexture2DArray<type> textureName
            #define RW_TEXTURE3D(type, textureName)         RWTexture3D<type> textureName
          #else
            #define RW_TEXTURE2D(type, textureName)         ERROR_ON_UNSUPPORTED_FUNCTION(RWTexture2D)
            #define RW_TEXTURE2D_ARRAY(type, textureName)   ERROR_ON_UNSUPPORTED_FUNCTION(RWTexture2DArray)
            #define RW_TEXTURE3D(type, textureName)         ERROR_ON_UNSUPPORTED_FUNCTION(RWTexture3D)
          #endif
        
          #define SAMPLER(samplerName)                    SamplerState samplerName
          #define SAMPLER_CMP(samplerName)                SamplerComparisonState samplerName
        
          #define TEXTURE2D_PARAM(textureName, samplerName)                 TEXTURE2D(textureName), SAMPLER(samplerName)
          #define TEXTURE2D_ARRAY_PARAM(textureName, samplerName)           TEXTURE2D_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_PARAM(textureName, samplerName)               TEXTURECUBE(textureName), SAMPLER(samplerName)
          #define TEXTURECUBE_ARRAY_PARAM(textureName, samplerName)         TEXTURECUBE_ARRAY(textureName), SAMPLER(samplerName)
          #define TEXTURE3D_PARAM(textureName, samplerName)                 TEXTURE3D(textureName), SAMPLER(samplerName)
        
          #define TEXTURE2D_SHADOW_PARAM(textureName, samplerName)          TEXTURE2D(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURE2D_ARRAY_SHADOW_PARAM(textureName, samplerName)    TEXTURE2D_ARRAY(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_SHADOW_PARAM(textureName, samplerName)        TEXTURECUBE(textureName), SAMPLER_CMP(samplerName)
          #define TEXTURECUBE_ARRAY_SHADOW_PARAM(textureName, samplerName)  TEXTURECUBE_ARRAY(textureName), SAMPLER_CMP(samplerName)
        
          #define TEXTURE2D_ARGS(textureName, samplerName)                textureName, samplerName
          #define TEXTURE2D_ARRAY_ARGS(textureName, samplerName)          textureName, samplerName
          #define TEXTURECUBE_ARGS(textureName, samplerName)              textureName, samplerName
          #define TEXTURECUBE_ARRAY_ARGS(textureName, samplerName)        textureName, samplerName
          #define TEXTURE3D_ARGS(textureName, samplerName)                textureName, samplerName
        
          #define TEXTURE2D_SHADOW_ARGS(textureName, samplerName)         textureName, samplerName
          #define TEXTURE2D_ARRAY_SHADOW_ARGS(textureName, samplerName)   textureName, samplerName
          #define TEXTURECUBE_SHADOW_ARGS(textureName, samplerName)       textureName, samplerName
          #define TEXTURECUBE_ARRAY_SHADOW_ARGS(textureName, samplerName) textureName, samplerName
        
          #define SAMPLE_TEXTURE2D(textureName, samplerName, coord2)                               textureName.Sample(samplerName, coord2)
          #define SAMPLE_TEXTURE2D_LOD(textureName, samplerName, coord2, lod)                      textureName.SampleLevel(samplerName, coord2, lod)
          #define SAMPLE_TEXTURE2D_BIAS(textureName, samplerName, coord2, bias)                    textureName.SampleBias(samplerName, coord2, bias)
          #define SAMPLE_TEXTURE2D_GRAD(textureName, samplerName, coord2, ddx, ddy)                textureName.SampleGrad(samplerName, coord2, ddx, ddy)
          #define SAMPLE_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)                  textureName.Sample(samplerName, float3(coord2, index))
          #define SAMPLE_TEXTURE2D_ARRAY_LOD(textureName, samplerName, coord2, index, lod)         textureName.SampleLevel(samplerName, float3(coord2, index), lod)
          #define SAMPLE_TEXTURE2D_ARRAY_BIAS(textureName, samplerName, coord2, index, bias)       textureName.SampleBias(samplerName, float3(coord2, index), bias)
          #define SAMPLE_TEXTURE2D_ARRAY_GRAD(textureName, samplerName, coord2, index, dpdx, dpdy) textureName.SampleGrad(samplerName, float3(coord2, index), dpdx, dpdy)
          #define SAMPLE_TEXTURECUBE(textureName, samplerName, coord3)                             textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURECUBE_LOD(textureName, samplerName, coord3, lod)                    textureName.SampleLevel(samplerName, coord3, lod)
          #define SAMPLE_TEXTURECUBE_BIAS(textureName, samplerName, coord3, bias)                  textureName.SampleBias(samplerName, coord3, bias)
        
          #ifdef UNITY_NO_CUBEMAP_ARRAY
            #define SAMPLE_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)           ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURECUBE_ARRAY)
            #define SAMPLE_TEXTURECUBE_ARRAY_LOD(textureName, samplerName, coord3, index, lod)  ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURECUBE_ARRAY_LOD)
            #define SAMPLE_TEXTURECUBE_ARRAY_BIAS(textureName, samplerName, coord3, index, bias)ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURECUBE_ARRAY_BIAS)
          #else
            #define SAMPLE_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)           textureName.Sample(samplerName, float4(coord3, index))
            #define SAMPLE_TEXTURECUBE_ARRAY_LOD(textureName, samplerName, coord3, index, lod)  textureName.SampleLevel(samplerName, float4(coord3, index), lod)
            #define SAMPLE_TEXTURECUBE_ARRAY_BIAS(textureName, samplerName, coord3, index, bias)textureName.SampleBias(samplerName, float4(coord3, index), bias)
          #endif
        
          #define SAMPLE_TEXTURE3D(textureName, samplerName, coord3)                          textureName.Sample(samplerName, coord3)
          #define SAMPLE_TEXTURE3D_LOD(textureName, samplerName, coord3, lod)                 textureName.SampleLevel(samplerName, coord3, lod)
        
          #define SAMPLE_TEXTURE2D_SHADOW(textureName, samplerName, coord3)                   textureName.SampleCmpLevelZero(samplerName, (coord3).xy, (coord3).z)
          #define SAMPLE_TEXTURE2D_ARRAY_SHADOW(textureName, samplerName, coord3, index)      textureName.SampleCmpLevelZero(samplerName, float3((coord3).xy, index), (coord3).z)
          #define SAMPLE_TEXTURECUBE_SHADOW(textureName, samplerName, coord4)                 textureName.SampleCmpLevelZero(samplerName, (coord4).xyz, (coord4).w)
          #define SAMPLE_TEXTURECUBE_ARRAY_SHADOW(textureName, samplerName, coord4, index)    textureName.SampleCmpLevelZero(samplerName, float4((coord4).xyz, index), (coord4).w)
        
        
          #define LOAD_TEXTURE2D(textureName, unCoord2)                                       textureName.Load(int3(unCoord2, 0))
          #define LOAD_TEXTURE2D_LOD(textureName, unCoord2, lod)                              textureName.Load(int3(unCoord2, lod))
          #define LOAD_TEXTURE2D_MSAA(textureName, unCoord2, sampleIndex)                     textureName.Load(unCoord2, sampleIndex)
          #define LOAD_TEXTURE2D_ARRAY(textureName, unCoord2, index)                          textureName.Load(int4(unCoord2, index, 0))
          #define LOAD_TEXTURE2D_ARRAY_MSAA(textureName, unCoord2, index, sampleIndex)        textureName.Load(int3(unCoord2, index), sampleIndex)
          #define LOAD_TEXTURE2D_ARRAY_LOD(textureName, unCoord2, index, lod)                 textureName.Load(int4(unCoord2, index, lod))
          #define LOAD_TEXTURE3D(textureName, unCoord3)                                       textureName.Load(int4(unCoord3, 0))
          #define LOAD_TEXTURE3D_LOD(textureName, unCoord3, lod)                              textureName.Load(int4(unCoord3, lod))
        
          #if GLES3_1_AEP
            #define PLATFORM_SUPPORT_GATHER
            #define GATHER_TEXTURE2D(textureName, samplerName, coord2)                  textureName.Gather(samplerName, coord2)
            #define GATHER_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)     textureName.Gather(samplerName, float3(coord2, index))
            #define GATHER_TEXTURECUBE(textureName, samplerName, coord3)                textureName.Gather(samplerName, coord3)
            #define GATHER_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)   textureName.Gather(samplerName, float4(coord3, index))
            #define GATHER_RED_TEXTURE2D(textureName, samplerName, coord2)              textureName.GatherRed(samplerName, coord2)
            #define GATHER_GREEN_TEXTURE2D(textureName, samplerName, coord2)            textureName.GatherGreen(samplerName, coord2)
            #define GATHER_BLUE_TEXTURE2D(textureName, samplerName, coord2)             textureName.GatherBlue(samplerName, coord2)
            #define GATHER_ALPHA_TEXTURE2D(textureName, samplerName, coord2)            textureName.GatherAlpha(samplerName, coord2)
          #else
            #define GATHER_TEXTURE2D(textureName, samplerName, coord2)                  ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_TEXTURE2D)
            #define GATHER_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)     ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_TEXTURE2D_ARRAY)
            #define GATHER_TEXTURECUBE(textureName, samplerName, coord3)                ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_TEXTURECUBE)
            #define GATHER_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)   ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_TEXTURECUBE_ARRAY)
            #define GATHER_RED_TEXTURE2D(textureName, samplerName, coord2)              ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_RED_TEXTURE2D)
            #define GATHER_GREEN_TEXTURE2D(textureName, samplerName, coord2)            ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_GREEN_TEXTURE2D)
            #define GATHER_BLUE_TEXTURE2D(textureName, samplerName, coord2)             ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_BLUE_TEXTURE2D)
            #define GATHER_ALPHA_TEXTURE2D(textureName, samplerName, coord2)            ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_ALPHA_TEXTURE2D)
          #endif
        
        
        #elif defined(SHADER_API_GLES)
        
        
          #define uint int
        
          #define rcp(x) 1.0 / (x)
          #define ddx_fine ddx
          #define ddy_fine ddy
          #define asfloat
          #define asuint(x) asint(x)
          #define f32tof16
          #define f16tof32
        
          #define ERROR_ON_UNSUPPORTED_FUNCTION(funcName) #error #funcName is not supported on GLES 2.0
        
          // Initialize arbitrary structure with zero values.
          // Do not exist on some platform, in this case we need to have a standard name that call a function that will initialize all parameters to 0
          #define ZERO_INITIALIZE(type, name) name = (type)0;
          #define ZERO_INITIALIZE_ARRAY(type, name, arraySize) { for (int arrayIndex = 0; arrayIndex < arraySize; arrayIndex++) { name[arrayIndex] = (type)0; } }
        
        
          // Texture util abstraction
        
          #define CALCULATE_TEXTURE2D_LOD(textureName, samplerName, coord2) #error calculate Level of Detail not supported in GLES2
        
          // Texture abstraction
        
          #define TEXTURE2D(textureName)                          sampler2D textureName
          #define TEXTURE2D_ARRAY(textureName)                    samplerCUBE textureName // No support to texture2DArray
          #define TEXTURECUBE(textureName)                        samplerCUBE textureName
          #define TEXTURECUBE_ARRAY(textureName)                  samplerCUBE textureName // No supoport to textureCubeArray and can't emulate with texture2DArray
          #define TEXTURE3D(textureName)                          sampler3D textureName
        
          #define TEXTURE2D_FLOAT(textureName)                    sampler2D_float textureName
          #define TEXTURE2D_ARRAY_FLOAT(textureName)              TEXTURECUBE_FLOAT(textureName) // No support to texture2DArray
          #define TEXTURECUBE_FLOAT(textureName)                  samplerCUBE_float textureName
          #define TEXTURECUBE_ARRAY_FLOAT(textureName)            TEXTURECUBE_FLOAT(textureName) // No support to textureCubeArray
          #define TEXTURE3D_FLOAT(textureName)                    sampler3D_float textureName
        
          #define TEXTURE2D_HALF(textureName)                     sampler2D_half textureName
          #define TEXTURE2D_ARRAY_HALF(textureName)               TEXTURECUBE_HALF(textureName) // No support to texture2DArray
          #define TEXTURECUBE_HALF(textureName)                   samplerCUBE_half textureName
          #define TEXTURECUBE_ARRAY_HALF(textureName)             TEXTURECUBE_HALF(textureName) // No support to textureCubeArray
          #define TEXTURE3D_HALF(textureName)                     sampler3D_half textureName
        
          #define TEXTURE2D_SHADOW(textureName)                   SHADOW2D_TEXTURE_AND_SAMPLER textureName
          #define TEXTURE2D_ARRAY_SHADOW(textureName)             TEXTURECUBE_SHADOW(textureName) // No support to texture array
          #define TEXTURECUBE_SHADOW(textureName)                 SHADOWCUBE_TEXTURE_AND_SAMPLER textureName
          #define TEXTURECUBE_ARRAY_SHADOW(textureName)           TEXTURECUBE_SHADOW(textureName) // No support to texture array
        
          #define RW_TEXTURE2D(type, textureNam)                  ERROR_ON_UNSUPPORTED_FUNCTION(RWTexture2D)
          #define RW_TEXTURE2D_ARRAY(type, textureName)           ERROR_ON_UNSUPPORTED_FUNCTION(RWTexture2DArray)
          #define RW_TEXTURE3D(type, textureNam)                  ERROR_ON_UNSUPPORTED_FUNCTION(RWTexture3D)
        
          #define SAMPLER(samplerName)
          #define SAMPLER_CMP(samplerName)
        
          #define TEXTURE2D_PARAM(textureName, samplerName)                sampler2D textureName
          #define TEXTURE2D_ARRAY_PARAM(textureName, samplerName)          samplerCUBE textureName
          #define TEXTURECUBE_PARAM(textureName, samplerName)              samplerCUBE textureName
          #define TEXTURECUBE_ARRAY_PARAM(textureName, samplerName)        samplerCUBE textureName
          #define TEXTURE3D_PARAM(textureName, samplerName)                sampler3D textureName
          #define TEXTURE2D_SHADOW_PARAM(textureName, samplerName)         SHADOW2D_TEXTURE_AND_SAMPLER textureName
          #define TEXTURE2D_ARRAY_SHADOW_PARAM(textureName, samplerName)   SHADOWCUBE_TEXTURE_AND_SAMPLER textureName
          #define TEXTURECUBE_SHADOW_PARAM(textureName, samplerName)       SHADOWCUBE_TEXTURE_AND_SAMPLER textureName
        
          #define TEXTURE2D_ARGS(textureName, samplerName)               textureName
          #define TEXTURE2D_ARRAY_ARGS(textureName, samplerName)         textureName
          #define TEXTURECUBE_ARGS(textureName, samplerName)             textureName
          #define TEXTURECUBE_ARRAY_ARGS(textureName, samplerName)       textureName
          #define TEXTURE3D_ARGS(textureName, samplerName)               textureName
          #define TEXTURE2D_SHADOW_ARGS(textureName, samplerName)        textureName
          #define TEXTURE2D_ARRAY_SHADOW_ARGS(textureName, samplerName)  textureName
          #define TEXTURECUBE_SHADOW_ARGS(textureName, samplerName)      textureName
        
          #define SAMPLE_TEXTURE2D(textureName, samplerName, coord2) tex2D(textureName, coord2)
        
          #if (SHADER_TARGET >= 30)
            #define SAMPLE_TEXTURE2D_LOD(textureName, samplerName, coord2, lod) tex2Dlod(textureName, float4(coord2, 0, lod))
          #else
            // No lod support. Very poor approximation with bias.
            #define SAMPLE_TEXTURE2D_LOD(textureName, samplerName, coord2, lod) SAMPLE_TEXTURE2D_BIAS(textureName, samplerName, coord2, lod)
          #endif
        
          #define SAMPLE_TEXTURE2D_BIAS(textureName, samplerName, coord2, bias)                       tex2Dbias(textureName, float4(coord2, 0, bias))
          #define SAMPLE_TEXTURE2D_GRAD(textureName, samplerName, coord2, ddx, ddy)                   SAMPLE_TEXTURE2D(textureName, samplerName, coord2)
          #define SAMPLE_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)                     ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURE2D_ARRAY)
          #define SAMPLE_TEXTURE2D_ARRAY_LOD(textureName, samplerName, coord2, index, lod)            ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURE2D_ARRAY_LOD)
          #define SAMPLE_TEXTURE2D_ARRAY_BIAS(textureName, samplerName, coord2, index, bias)          ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURE2D_ARRAY_BIAS)
          #define SAMPLE_TEXTURE2D_ARRAY_GRAD(textureName, samplerName, coord2, index, dpdx, dpdy)    ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURE2D_ARRAY_GRAD)
          #define SAMPLE_TEXTURECUBE(textureName, samplerName, coord3)                                texCUBE(textureName, coord3)
          // No lod support. Very poor approximation with bias.
          #define SAMPLE_TEXTURECUBE_LOD(textureName, samplerName, coord3, lod)                       SAMPLE_TEXTURECUBE_BIAS(textureName, samplerName, coord3, lod)
          #define SAMPLE_TEXTURECUBE_BIAS(textureName, samplerName, coord3, bias)                     texCUBEbias(textureName, float4(coord3, bias))
          #define SAMPLE_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)                   ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURECUBE_ARRAY)
          #define SAMPLE_TEXTURECUBE_ARRAY_LOD(textureName, samplerName, coord3, index, lod)          ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURECUBE_ARRAY_LOD)
          #define SAMPLE_TEXTURECUBE_ARRAY_BIAS(textureName, samplerName, coord3, index, bias)        ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURECUBE_ARRAY_BIAS)
          #define SAMPLE_TEXTURE3D(textureName, samplerName, coord3)                                  tex3D(textureName, coord3)
          #define SAMPLE_TEXTURE3D_LOD(textureName, samplerName, coord3, lod)                         ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURE3D_LOD)
        
          #define SAMPLE_TEXTURE2D_SHADOW(textureName, samplerName, coord3)                           SHADOW2D_SAMPLE(textureName, samplerName, coord3)
          #define SAMPLE_TEXTURE2D_ARRAY_SHADOW(textureName, samplerName, coord3, index)              ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURE2D_ARRAY_SHADOW)
          #define SAMPLE_TEXTURECUBE_SHADOW(textureName, samplerName, coord4)                         SHADOWCUBE_SAMPLE(textureName, samplerName, coord4)
          #define SAMPLE_TEXTURECUBE_ARRAY_SHADOW(textureName, samplerName, coord4, index)            ERROR_ON_UNSUPPORTED_FUNCTION(SAMPLE_TEXTURECUBE_ARRAY_SHADOW)
        
        
          // Not supported. Can't define as error because shader library is calling these functions.
          #define LOAD_TEXTURE2D(textureName, unCoord2)                                               half4(0, 0, 0, 0)
          #define LOAD_TEXTURE2D_LOD(textureName, unCoord2, lod)                                      half4(0, 0, 0, 0)
          #define LOAD_TEXTURE2D_MSAA(textureName, unCoord2, sampleIndex)                             half4(0, 0, 0, 0)
          #define LOAD_TEXTURE2D_ARRAY(textureName, unCoord2, index)                                  half4(0, 0, 0, 0)
          #define LOAD_TEXTURE2D_ARRAY_MSAA(textureName, unCoord2, index, sampleIndex)                half4(0, 0, 0, 0)
          #define LOAD_TEXTURE2D_ARRAY_LOD(textureName, unCoord2, index, lod)                         half4(0, 0, 0, 0)
          #define LOAD_TEXTURE3D(textureName, unCoord3)                                               ERROR_ON_UNSUPPORTED_FUNCTION(LOAD_TEXTURE3D)
          #define LOAD_TEXTURE3D_LOD(textureName, unCoord3, lod)                                      ERROR_ON_UNSUPPORTED_FUNCTION(LOAD_TEXTURE3D_LOD)
        
          // Gather not supported. Fallback to regular texture sampling.
          #define GATHER_TEXTURE2D(textureName, samplerName, coord2)                  ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_TEXTURE2D)
          #define GATHER_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index)     ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_TEXTURE2D_ARRAY)
          #define GATHER_TEXTURECUBE(textureName, samplerName, coord3)                ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_TEXTURECUBE)
          #define GATHER_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index)   ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_TEXTURECUBE_ARRAY)
          #define GATHER_RED_TEXTURE2D(textureName, samplerName, coord2)              ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_RED_TEXTURE2D)
          #define GATHER_GREEN_TEXTURE2D(textureName, samplerName, coord2)            ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_GREEN_TEXTURE2D)
          #define GATHER_BLUE_TEXTURE2D(textureName, samplerName, coord2)             ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_BLUE_TEXTURE2D)
          #define GATHER_ALPHA_TEXTURE2D(textureName, samplerName, coord2)            ERROR_ON_UNSUPPORTED_FUNCTION(GATHER_ALPHA_TEXTURE2D)
        
        #else
            #error unsupported shader api
        #endif
        // Sampling Library Module End
        
        
        #ifndef UNITY_BRANCH
            #define UNITY_BRANCH
        #endif
        #ifndef UNITY_FLATTEN
            #define UNITY_FLATTEN
        #endif
        #ifndef UNITY_UNROLL
            #define UNITY_UNROLL
        #endif
        #ifndef UNITY_UNROLLX
            #define UNITY_UNROLLX(_x)
        #endif
        #ifndef UNITY_LOOP
            #define UNITY_LOOP
        #endif
        // Library Functions
        // BiRP to URP Library Module Start
        
        //--------------------------------------------------------------
        // Macros to redefine built-in macros to those used by the URP
        //--------------------------------------------------------------
        
        #if !defined(BIRP_TO_URP)
        #define BIRP_TO_URP
        
        //-----------------------------------------------------------------------------
        //-----------------------------------------------------------------------------
        // StdLib.hlsl ----------------------------------------------------------------
        //-----------------------------------------------------------------------------
        //-----------------------------------------------------------------------------
        
        #define HALF_MAX        65504.0 // (2 - 2^-10) * 2^15
        #define HALF_MAX_MINUS1 65472.0 // (2 - 2^-9) * 2^15
        #define EPSILON         1.0e-4
        #define PI              3.14159265359
        #define TWO_PI          6.28318530718
        #define FOUR_PI         12.56637061436
        #define INV_PI          0.31830988618
        #define INV_TWO_PI      0.15915494309
        #define INV_FOUR_PI     0.07957747155
        #define HALF_PI         1.57079632679
        #define INV_HALF_PI     0.636619772367
        
        #define FLT_EPSILON     1.192092896e-07 // Smallest positive number, such that 1.0 + FLT_EPSILON != 1.0
        #define FLT_MIN         1.175494351e-38 // Minimum representable positive floating-point number
        #define FLT_MAX         3.402823466e+38 // Maximum representable floating-point number
        
        
        
        //-----------------------------------------------------------------------------
        //-----------------------------------------------------------------------------
        // Common.hlsl ----------------------------------------------------------------
        //-----------------------------------------------------------------------------
        //-----------------------------------------------------------------------------
        /*
        #define half min16float
        #define half2 min16float2
        #define half3 min16float3
        #define half4 min16float4
        #define half2x2 min16float2x2
        #define half2x3 min16float2x3
        #define half3x2 min16float3x2
        #define half3x3 min16float3x3
        #define half3x4 min16float3x4
        #define half4x3 min16float4x3
        #define half4x4 min16float4x4
        */
        #define real half
        #define real2 half2
        #define real3 half3
        #define real4 half4
        #define real2x2 half2x2
        #define real2x3 half2x3
        #define real2x4 half2x4
        #define real3x2 half3x2
        #define real3x3 half3x3
        #define real3x4 half3x4
        #define real4x3 half4x3
        #define real4x4 half4x4
        
        
        float3 SafeNormalize(float3 inVec)
        {
            float dp3 = max(FLT_MIN, dot(inVec, inVec));
            return inVec * rsqrt(dp3);
        }
        
        // BiRP to URP Sampling Macros Start
        #if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
        
            #define SLICE_ARRAY_INDEX   unity_StereoEyeIndex
        
            #define TEXTURE2D_X(textureName)                                        TEXTURE2D_ARRAY(textureName)
            #define TEXTURE2D_X_PARAM(textureName, samplerName)                     TEXTURE2D_ARRAY_PARAM(textureName, samplerName)
            #define TEXTURE2D_X_ARGS(textureName, samplerName)                      TEXTURE2D_ARRAY_ARGS(textureName, samplerName)
            #define TEXTURE2D_X_HALF(textureName)                                   TEXTURE2D_ARRAY_HALF(textureName)
            #define TEXTURE2D_X_FLOAT(textureName)                                  TEXTURE2D_ARRAY_FLOAT(textureName)
        
            #define LOAD_TEXTURE2D_X(textureName, unCoord2)                         LOAD_TEXTURE2D_ARRAY(textureName, unCoord2, SLICE_ARRAY_INDEX)
            #define LOAD_TEXTURE2D_X_LOD(textureName, unCoord2, lod)                LOAD_TEXTURE2D_ARRAY_LOD(textureName, unCoord2, SLICE_ARRAY_INDEX, lod)
            #define SAMPLE_TEXTURE2D_X(textureName, samplerName, coord2)            SAMPLE_TEXTURE2D_ARRAY(textureName, samplerName, coord2, SLICE_ARRAY_INDEX)
            #define SAMPLE_TEXTURE2D_X_LOD(textureName, samplerName, coord2, lod)   SAMPLE_TEXTURE2D_ARRAY_LOD(textureName, samplerName, coord2, SLICE_ARRAY_INDEX, lod)
            #define GATHER_TEXTURE2D_X(textureName, samplerName, coord2)            GATHER_TEXTURE2D_ARRAY(textureName, samplerName, coord2, SLICE_ARRAY_INDEX)
            #define GATHER_RED_TEXTURE2D_X(textureName, samplerName, coord2)        GATHER_RED_TEXTURE2D(textureName, samplerName, float3(coord2, SLICE_ARRAY_INDEX))
            #define GATHER_GREEN_TEXTURE2D_X(textureName, samplerName, coord2)      GATHER_GREEN_TEXTURE2D(textureName, samplerName, float3(coord2, SLICE_ARRAY_INDEX))
            #define GATHER_BLUE_TEXTURE2D_X(textureName, samplerName, coord2)       GATHER_BLUE_TEXTURE2D(textureName, samplerName, float3(coord2, SLICE_ARRAY_INDEX))
        
        #else
            #define SLICE_ARRAY_INDEX       0
        
            #define TEXTURE2D_X(textureName)                                        TEXTURE2D(textureName)
            #define TEXTURE2D_X_PARAM(textureName, samplerName)                     TEXTURE2D_PARAM(textureName, samplerName)
            #define TEXTURE2D_X_ARGS(textureName, samplerName)                      TEXTURE2D_ARGS(textureName, samplerName)
            #define TEXTURE2D_X_HALF(textureName)                                   TEXTURE2D_HALF(textureName)
            #define TEXTURE2D_X_FLOAT(textureName)                                  TEXTURE2D_FLOAT(textureName)
        
            #define LOAD_TEXTURE2D_X(textureName, unCoord2)                         LOAD_TEXTURE2D(textureName, unCoord2)
            #define LOAD_TEXTURE2D_X_LOD(textureName, unCoord2, lod)                LOAD_TEXTURE2D_LOD(textureName, unCoord2, lod)
            #define SAMPLE_TEXTURE2D_X(textureName, samplerName, coord2)            SAMPLE_TEXTURE2D(textureName, samplerName, coord2)
            #define SAMPLE_TEXTURE2D_X_LOD(textureName, samplerName, coord2, lod)   SAMPLE_TEXTURE2D_LOD(textureName, samplerName, coord2, lod)
            #define GATHER_TEXTURE2D_X(textureName, samplerName, coord2)            GATHER_TEXTURE2D(textureName, samplerName, coord2)
            #define GATHER_RED_TEXTURE2D_X(textureName, samplerName, coord2)        GATHER_RED_TEXTURE2D(textureName, samplerName, coord2)
            #define GATHER_GREEN_TEXTURE2D_X(textureName, samplerName, coord2)      GATHER_GREEN_TEXTURE2D(textureName, samplerName, coord2)
            #define GATHER_BLUE_TEXTURE2D_X(textureName, samplerName, coord2)       GATHER_BLUE_TEXTURE2D(textureName, samplerName, coord2)
        #endif
        // BiRP to URP Sampling Macros End
        
        
        //-----------------------------------------------------------------------------
        //-----------------------------------------------------------------------------
        // SpaceTransforms.hlsl ----------------------------------------------------------------
        //-----------------------------------------------------------------------------
        //-----------------------------------------------------------------------------
        
        
        float4x4 GetObjectToWorldMatrix()
        {
            return UNITY_MATRIX_M;
        }
        
        #define UNITY_MATRIX_I_M unity_WorldToObject
        float4x4 GetWorldToObjectMatrix()
        {
            return UNITY_MATRIX_I_M;
        }
        /* Does not exist in BiRP
        float4x4 GetPrevObjectToWorldMatrix()
        {
            return UNITY_PREV_MATRIX_M;
        }
        
        float4x4 GetPrevWorldToObjectMatrix()
        {
            return UNITY_PREV_MATRIX_I_M;
        }
        */
        
        float4x4 GetWorldToViewMatrix()
        {
            return UNITY_MATRIX_V;
        }
        
        float4x4 GetViewToWorldMatrix()
        {
            return UNITY_MATRIX_I_V;
        }
        
        // Transform to homogenous clip space
        float4x4 GetWorldToHClipMatrix()
        {
            return UNITY_MATRIX_VP;
        }
        
        // Transform to homogenous clip space
        float4x4 GetViewToHClipMatrix()
        {
            return UNITY_MATRIX_P;
        }
        
        // This function always return the absolute position in WS
        float3 GetAbsolutePositionWS(float3 positionRWS)
        {
        #if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
            positionRWS += _WorldSpaceCameraPos.xyz;
        #endif
            return positionRWS;
        }
        
        // This function return the camera relative position in WS
        float3 GetCameraRelativePositionWS(float3 positionWS)
        {
        #if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
            positionWS -= _WorldSpaceCameraPos.xyz;
        #endif
            return positionWS;
        }
        
        half GetOddNegativeScale()
        {
            // FIXME: We should be able to just return unity_WorldTransformParams.w, but it is not
            // properly set at the moment, when doing ray-tracing; once this has been fixed in cpp,
            // we can revert back to the former implementation.
            return unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0;
        }
        
        float3 TransformObjectToWorld(float3 positionOS)
        {
            #if defined(SHADER_STAGE_RAY_TRACING)
            return mul(ObjectToWorld3x4(), float4(positionOS, 1.0)).xyz;
            #else
            return mul(GetObjectToWorldMatrix(), float4(positionOS, 1.0)).xyz;
            #endif
        }
        
        float3 TransformWorldToObject(float3 positionWS)
        {
            #if defined(SHADER_STAGE_RAY_TRACING)
            return mul(WorldToObject3x4(), float4(positionWS, 1.0)).xyz;
            #else
            return mul(GetWorldToObjectMatrix(), float4(positionWS, 1.0)).xyz;
            #endif
        }
        
        float3 TransformWorldToView(float3 positionWS)
        {
            return mul(GetWorldToViewMatrix(), float4(positionWS, 1.0)).xyz;
        }
        
        float3 TransformViewToWorld(float3 positionVS)
        {
            return mul(GetViewToWorldMatrix(), float4(positionVS, 1.0)).xyz;
        }
        
        // Transforms position from object space to homogenous space
        float4 TransformObjectToHClip(float3 positionOS)
        {
            // More efficient than computing M*VP matrix product
            return mul(GetWorldToHClipMatrix(), mul(GetObjectToWorldMatrix(), float4(positionOS, 1.0)));
        }
        
        // Transforms position from world space to homogenous space
        float4 TransformWorldToHClip(float3 positionWS)
        {
            return mul(GetWorldToHClipMatrix(), float4(positionWS, 1.0));
        }
        
        // Transforms position from view space to homogenous space
        float4 TransformWViewToHClip(float3 positionVS)
        {
            return mul(GetViewToHClipMatrix(), float4(positionVS, 1.0));
        }
        
        // Normalize to support uniform scaling
        float3 TransformObjectToWorldDir(float3 dirOS, bool doNormalize = true)
        {
            #ifndef SHADER_STAGE_RAY_TRACING
            float3 dirWS = mul((float3x3)GetObjectToWorldMatrix(), dirOS);
            #else
            float3 dirWS = mul((float3x3)ObjectToWorld3x4(), dirOS);
            #endif
            if (doNormalize)
                return SafeNormalize(dirWS);
            return dirWS;
        }
        
        // Normalize to support uniform scaling
        float3 TransformWorldToObjectDir(float3 dirWS, bool doNormalize = true)
        {
            #ifndef SHADER_STAGE_RAY_TRACING
            float3 dirOS = mul((float3x3)GetWorldToObjectMatrix(), dirWS);
            #else
            float3 dirOS = mul((float3x3)WorldToObject3x4(), dirWS);
            #endif
            if (doNormalize)
                return normalize(dirOS);
        
            return dirOS;
        }
        
        // Transforms vector from world space to view space
        float3 TransformWorldToViewDir(float3 dirWS, bool doNormalize = false)
        {
            float3 dirVS = mul( (float3x3)UNITY_MATRIX_V, dirWS).xyz;
            if (doNormalize)
                return normalize(dirVS);
        
            return dirVS;
        }
        
        // Transforms vector from view space to world space
        float3 TransformViewToWorldDir(float3 dirVS, bool doNormalize = false)
        {
            float3 dirWS = mul((float3x3)GetViewToWorldMatrix(), dirVS).xyz;
            if (doNormalize)
                return normalize(dirWS);
        
            return dirWS;
        }
        
        // Transforms normal from world space to view space
        float3 TransformWorldToViewNormal(float3 normalWS, bool doNormalize = false)
        {
            // assuming view matrix is uniformly scaled, we can use direction transform
            return TransformWorldToViewDir(normalWS, doNormalize);
        }
        
        // Transforms normal from view space to world space
        float3 TransformViewToWorldNormal(float3 normalVS, bool doNormalize = false)
        {
            // assuming view matrix is uniformly scaled, we can use direction transform
            return TransformViewToWorldDir(normalVS, doNormalize);
        }
        
        // Transforms vector from world space to homogenous space
        float3 TransformWorldToHClipDir(float3 directionWS, bool doNormalize = false)
        {
            float3 dirHCS = mul((float3x3)GetWorldToHClipMatrix(), directionWS).xyz;
            if (doNormalize)
                return normalize(dirHCS);
        
            return dirHCS;
        }
        
        // Transforms normal from object to world space
        float3 TransformObjectToWorldNormal(float3 normalOS, bool doNormalize = true)
        {
        #ifdef UNITY_ASSUME_UNIFORM_SCALING
            return TransformObjectToWorldDir(normalOS, doNormalize);
        #else
            // Normal need to be multiply by inverse transpose
            float3 normalWS = mul(normalOS, (float3x3)GetWorldToObjectMatrix());
            if (doNormalize)
                return SafeNormalize(normalWS);
        
            return normalWS;
        #endif
        }
        
        // Transforms normal from world to object space
        float3 TransformWorldToObjectNormal(float3 normalWS, bool doNormalize = true)
        {
        #ifdef UNITY_ASSUME_UNIFORM_SCALING
            return TransformWorldToObjectDir(normalWS, doNormalize);
        #else
            // Normal need to be multiply by inverse transpose
            float3 normalOS = mul(normalWS, (float3x3)GetObjectToWorldMatrix());
            if (doNormalize)
                return SafeNormalize(normalOS);
        
            return normalOS;
        #endif
        }
        
        float3x3 CreateTangentToWorld(float3 normal, float3 tangent, float flipSign)
        {
            // For odd-negative scale transforms we need to flip the sign
            float sgn = flipSign * GetOddNegativeScale();
            float3 bitangent = cross(normal, tangent) * sgn;
        
            return float3x3(tangent, bitangent, normal);
        }
        
        // this function is intended to work on Normals (handles non-uniform scale)
        // tangentToWorld is the matrix representing the transformation of a normal from tangent to world space
        float3 TransformTangentToWorld(float3 normalTS, float3x3 tangentToWorld, bool doNormalize = false)
        {
            // Note matrix is in row major convention with left multiplication as it is build on the fly
            float3 result = mul(normalTS, tangentToWorld);
            if (doNormalize)
                return SafeNormalize(result);
            return result;
        }
        
        // this function is intended to work on Normals (handles non-uniform scale)
        // This function does the exact inverse of TransformTangentToWorld() and is
        // also decribed within comments in mikktspace.h and it follows implicitly
        // from the scalar triple product (google it).
        // tangentToWorld is the matrix representing the transformation of a normal from tangent to world space
        float3 TransformWorldToTangent(float3 normalWS, float3x3 tangentToWorld, bool doNormalize = true)
        {
            // Note matrix is in row major convention with left multiplication as it is build on the fly
            float3 row0 = tangentToWorld[0];
            float3 row1 = tangentToWorld[1];
            float3 row2 = tangentToWorld[2];
        
            // these are the columns of the inverse matrix but scaled by the determinant
            float3 col0 = cross(row1, row2);
            float3 col1 = cross(row2, row0);
            float3 col2 = cross(row0, row1);
        
            float determinant = dot(row0, col0);
        
            // inverse transposed but scaled by determinant
            // Will remove transpose part by using matrix as the first arg in the mul() below
            // this makes it the exact inverse of what TransformTangentToWorld() does.
            float3x3 matTBN_I_T = float3x3(col0, col1, col2);
            float3 result = mul(matTBN_I_T, normalWS);
            if (doNormalize)
            {
                float sgn = determinant < 0.0 ? (-1.0) : 1.0;
                return SafeNormalize(sgn * result);
            }
            else
                return result / determinant;
        }
        
        // this function is intended to work on Vectors/Directions
        // tangentToWorld is the matrix representing the transformation of a normal from tangent to world space
        float3 TransformWorldToTangentDir(float3 dirWS, float3x3 tangentToWorld, bool doNormalize = false)
        {
            // Note matrix is in row major convention with left multiplication as it is build on the fly
            float3 result = mul(tangentToWorld, dirWS);
            if (doNormalize)
                return SafeNormalize(result);
            return result;
        }
        
        // this function is intended to work on Vectors/Directions
        // This function does the exact inverse of TransformWorldToTangentDir()
        // tangentToWorld is the matrix representing the transformation of a normal from tangent to world space
        float3 TransformTangentToWorldDir(float3 dirWS, float3x3 tangentToWorld, bool doNormalize = false)
        {
            // Note matrix is in row major convention with left multiplication as it is build on the fly
            float3 row0 = tangentToWorld[0];
            float3 row1 = tangentToWorld[1];
            float3 row2 = tangentToWorld[2];
        
            // these are the columns of the inverse matrix but scaled by the determinant
            float3 col0 = cross(row1, row2);
            float3 col1 = cross(row2, row0);
            float3 col2 = cross(row0, row1);
        
            float determinant = dot(row0, col0);
        
            // inverse transposed but scaled by determinant
            // Will remove transpose part by using matrix as the second arg in the mul() below
            // this makes it the exact inverse of what TransformWorldToTangentDir() does.
            float3x3 matTBN_I_T = float3x3(col0, col1, col2);
            float3 result = mul(dirWS, matTBN_I_T);
            if (doNormalize)
            {
                float sgn = determinant < 0.0 ? (-1.0) : 1.0;
                return SafeNormalize(sgn * result);
            }
            else
                return result / determinant;
        }
        
        // tangentToWorld is the matrix representing the transformation of a normal from tangent to world space
        float3 TransformTangentToObject(float3 dirTS, float3x3 tangentToWorld)
        {
            // Note matrix is in row major convention with left multiplication as it is build on the fly
            float3 normalWS = TransformTangentToWorld(dirTS, tangentToWorld);
            return TransformWorldToObjectNormal(normalWS);
        }
        
        // tangentToWorld is the matrix representing the transformation of a normal from tangent to world space
        float3 TransformObjectToTangent(float3 dirOS, float3x3 tangentToWorld)
        {
            // Note matrix is in row major convention with left multiplication as it is build on the fly
        
            // don't normalize, as normalWS will be normalized after TransformWorldToTangent
            float3 normalWS = TransformObjectToWorldNormal(dirOS, false);
        
            // transform from world to tangent
            return TransformWorldToTangent(normalWS, tangentToWorld);
        }
        
        // orels1 additions
        
        float3 GetObjectScale()
        {
            float4x4 objToWorld = GetObjectToWorldMatrix();
            return float3(
                length(objToWorld._m00_m10_m20),
                length(objToWorld._m01_m11_m21),
                length(objToWorld._m02_m12_m22)
            );
        }
        
        float4 GetScreenPosition(float4 positionCS)
        {
            float4 ndc = positionCS * 0.5f;
            ndc.xy = float2(ndc.x, ndc.y * _ProjectionParams.x) + ndc.w;
            ndc.zw = positionCS.zw;
        
            ndc.xy = TransformStereoScreenSpaceTex(ndc.xy, ndc.w);
            return ndc;
        }
        
        float4 GetGrabScreenPosition(float4 positionCS)
        {
            #if UNITY_UV_STARTS_AT_TOP
            float scale = -1.0;
            #else
            float scale = 1.0;
            #endif
            float4 ndc = positionCS * 0.5f;
            ndc.xy = float2(ndc.x, ndc.y * scale) + ndc.w;
            ndc.zw = positionCS.zw;
        
            ndc.xy = TransformStereoScreenSpaceTex(ndc.xy, ndc.w);
            return ndc;
        }
        
        // Delcare things in-place so that the sampler/texture can be used in the function below
        TEXTURE2D_X_FLOAT(_CameraDepthTexture);
        SAMPLER(sampler_CameraDepthTexture);
        
        float SampleSceneDepth(float2 uv)
        {
            return SAMPLE_TEXTURE2D_X(_CameraDepthTexture, sampler_CameraDepthTexture, uv).r;
        }
        
        float2 SampleSceneDepthRGDecoded(float2 uv)
        {
            float2 depthRG = SAMPLE_TEXTURE2D_X(_CameraDepthTexture, sampler_CameraDepthTexture, uv).rg;
            return dot(depthRG, float2(1.0, 1/255.0));
        }
        
        float4 ComputeClipSpacePosition(float2 positionNDC, float deviceDepth)
        {
            float4 positionCS = float4(positionNDC * 2.0 - 1.0, deviceDepth, 1.0);
        
        #if UNITY_UV_STARTS_AT_TOP
            // Our world space, view space, screen space and NDC space are Y-up.
            // Our clip space is flipped upside-down due to poor legacy Unity design.
            // The flip is baked into the projection matrix, so we only have to flip
            // manually when going from CS to NDC and back.
            positionCS.y = -positionCS.y;
        #endif
        
            return positionCS;
        }
        
        float3 ComputeWorldSpacePosition(float2 positionNDC, float deviceDepth, float4x4 invViewProjMatrix)
        {
            float4 positionCS  = ComputeClipSpacePosition(positionNDC, deviceDepth);
            float4 hpositionWS = mul(invViewProjMatrix, positionCS);
            return hpositionWS.xyz / hpositionWS.w;
        }
        
        // We need this so that we can replace `UNITY_LIGHT_ATTENUATION`
        struct Light
        {
            float3   direction;
            half3   color;
            half    shadowAttenuation;
        };
        
        Light GetMainLight()
        {
            Light light;
        
            light.direction = _WorldSpaceLightPos0.xyz;
            light.shadowAttenuation = 1.0;
            light.color = _LightColor0.rgb;
        
            return light;
        }
        
        struct __BridgeShadowStruct
        {
            float4 pos;
            float4 _ShadowCoord;
        };
        
        Light GetMainLight(float4 shadowCoord)
        {
            Light light = GetMainLight();
        
            __BridgeShadowStruct input = (__BridgeShadowStruct) 0;
            input._ShadowCoord = shadowCoord;
            UNITY_LIGHT_ATTENUATION(lightAttenuation, input, 0..xxx);
            light.shadowAttenuation = lightAttenuation;
            return light;
        }
        
        Light GetMainLight(float4 shadowCoord, float3 positionWS, half4 shadowMask)
        {
            Light light = GetMainLight();
        
            // In BIRP we consider all lights "main lights", so we utilize world space position to get final light direction
            #ifndef USING_DIRECTIONAL_LIGHT
            light.direction = normalize(UnityWorldSpaceLightDir(positionWS));
            #endif
        
            __BridgeShadowStruct input = (__BridgeShadowStruct) 0;
            input._ShadowCoord = shadowCoord;
            UNITY_LIGHT_ATTENUATION(lightAttenuation, input, positionWS);
        
            light.shadowAttenuation = lightAttenuation;
        
            return light;
        }
        
        float3 UnpackNormalScale(float4 packedNormal, float scale)
        {
            return UnpackScaleNormal(packedNormal, scale);
        }
        
        void LODFadeCrossFade(float2 positionCS)
        {
            #if defined(LOD_FADE_CROSSFADE)
            UnityApplyDitherCrossFade(positionCS.xy);
            #endif
        }
        #endif
        
        // BiRP to URP Library Module End
        
        #define FLT_EPSILON     1.192092896e-07
        
        // Helpful Macros
        #define DEBUG_FC(x) FinalColor.rgb *= 0.0001; \
                         FinalColor.rgb += x; \
                         return
        
        half3 BlendOverlay(half3 target, half3 source)
        {
            return (target > 0.5) * (1 - (1 - 2 * (target - 0.5)) * (1 - source)) + (target <= 0.5) * (2 * target * source);
        }
        
        bool isVR()
        {
        #if UNITY_SINGLE_PASS_STEREO
            return true;
        #else
            return false;
        #endif
        }
        
        bool isStereoView() {
        #ifdef USING_STEREO_MATRICES
            return true;
        #else
            return UNITY_MATRIX_P._13 != 0;
        #endif
        }
        
        half3 BlendLighten(half3 target, half3 source) {
            return max(target, source);
        }
        
        half3 BlendScreen(half3 target, half3 source) {
            return 1 - (1 - target) * (1 - source);
        }
        
        half invLerp(half a, half b, half v)
        {
            return (v - a) / (b - a);
        }
        
        half3 invLerp(half3 a, half3 b, half3 v)
        {
            return (v - a) / (b - a);
        }
        
        
        // w0, w1, w2, and w3 are the four cubic B-spline basis functions
        half w0(half a)
        {
          //    return (1.0f/6.0f)*(-a*a*a + 3.0f*a*a - 3.0f*a + 1.0f);
            return (1.0f / 6.0f) * (a * (a * (-a + 3.0f) - 3.0f) + 1.0f);   // optimized
        
        }
        
        half w1(half a)
        {
          //    return (1.0f/6.0f)*(3.0f*a*a*a - 6.0f*a*a + 4.0f);
            return (1.0f / 6.0f) * (a * a * (3.0f * a - 6.0f) + 4.0f);
        }
        
        half w2(half a)
        {
          //    return (1.0f/6.0f)*(-3.0f*a*a*a + 3.0f*a*a + 3.0f*a + 1.0f);
            return (1.0f / 6.0f) * (a * (a * (-3.0f * a + 3.0f) + 3.0f) + 1.0f);
        }
        
        half w3(half a)
        {
            return (1.0f / 6.0f) * (a * a * a);
        }
        
        // g0 and g1 are the two amplitude functions
        half g0(half a)
        {
            return w0(a) + w1(a);
        }
        
        half g1(half a)
        {
            return w2(a) + w3(a);
        }
        
        // h0 and h1 are the two offset functions
        half h0(half a)
        {
          // note +0.5 offset to compensate for CUDA linear filtering convention
            return -1.0f + w1(a) / (w0(a) + w1(a)) + 0.5f;
        }
        
        half h1(half a)
        {
            return 1.0f + w3(a) / (w2(a) + w3(a)) + 0.5f;
        }
        
        half4 tex2DFastBicubicSample(TEXTURE2D_PARAM(tex, samplertex), float2 uv)
        {
            #if !defined(PLAT_QUEST) && defined(BICUBIC_LIGHTMAP)
            half width;
            half height;
            tex.GetDimensions(width, height);
            half x = uv.x * width;
            half y = uv.y * height;
        
        
        
            x -= 0.5f;
            y -= 0.5f;
            half px = floor(x);
            half py = floor(y);
            half fx = x - px;
            half fy = y - py;
        
            // note: we could store these functions in a lookup table texture, but maths is cheap
            half g0x = g0(fx);
            half g1x = g1(fx);
            half h0x = h0(fx);
            half h1x = h1(fx);
            half h0y = h0(fy);
            half h1y = h1(fy);
        
            half4 r = g0(fy) * (g0x * SAMPLE_TEXTURE2D(tex, samplertex, (half2(px + h0x, py + h0y) * 1.0f / width)) +
            g1x * SAMPLE_TEXTURE2D(tex, samplertex, (half2(px + h1x, py + h0y) * 1.0f / width))) +
            g1(fy) * (g0x * SAMPLE_TEXTURE2D(tex, samplertex, (half2(px + h0x, py + h1y) * 1.0f / width)) +
            g1x * SAMPLE_TEXTURE2D(tex, samplertex, (half2(px + h1x, py + h1y) * 1.0f / width)));
            return r;
            #else
            return SAMPLE_TEXTURE2D(tex, samplertex, uv);
            #endif
        }
        
        float4 tex2DFastBicubicSampleNoChecks(TEXTURE2D_PARAM(tex, samplertex), float2 uv)
        {
            half width;
            half height;
            tex.GetDimensions(width, height);
            half x = uv.x * width;
            half y = uv.y * height;
        
        
        
            x -= 0.5f;
            y -= 0.5f;
            half px = floor(x);
            half py = floor(y);
            half fx = x - px;
            half fy = y - py;
        
            // note: we could store these functions in a lookup table texture, but maths is cheap
            half g0x = g0(fx);
            half g1x = g1(fx);
            half h0x = h0(fx);
            half h1x = h1(fx);
            half h0y = h0(fy);
            half h1y = h1(fy);
        
            half4 r = g0(fy) * (g0x * SAMPLE_TEXTURE2D(tex, samplertex, (half2(px + h0x, py + h0y) * 1.0f / width)) +
            g1x * SAMPLE_TEXTURE2D(tex, samplertex, (half2(px + h1x, py + h0y) * 1.0f / width))) +
            g1(fy) * (g0x * SAMPLE_TEXTURE2D(tex, samplertex, (half2(px + h0x, py + h1y) * 1.0f / width)) +
            g1x * SAMPLE_TEXTURE2D(tex, samplertex, (half2(px + h1x, py + h1y) * 1.0f / width)));
            return r;
        }
        
        half4 tex2DFastBicubicSampleLevel(TEXTURE2D_PARAM(tex, samplertex), float2 uv, int level)
        {
            #if !defined(PLAT_QUEST) && defined(BICUBIC_LIGHTMAP)
            half width;
            half height;
            tex.GetDimensions(width, height);
            half x = uv.x * width;
            half y = uv.y * height;
        
        
        
            x -= 0.5f;
            y -= 0.5f;
            half px = floor(x);
            half py = floor(y);
            half fx = x - px;
            half fy = y - py;
        
            // note: we could store these functions in a lookup table texture, but maths is cheap
            half g0x = g0(fx);
            half g1x = g1(fx);
            half h0x = h0(fx);
            half h1x = h1(fx);
            half h0y = h0(fy);
            half h1y = h1(fy);
        
            half4 r = g0(fy) * (g0x * SAMPLE_TEXTURE2D_LOD(tex, samplertex, (half2(px + h0x, py + h0y) * 1.0f / width), level) +
            g1x * SAMPLE_TEXTURE2D_LOD(tex, samplertex, (half2(px + h1x, py + h0y) * 1.0f / width), level)) +
            g1(fy) * (g0x * SAMPLE_TEXTURE2D_LOD(tex, samplertex, (half2(px + h0x, py + h1y) * 1.0f / width), level) +
            g1x * SAMPLE_TEXTURE2D_LOD(tex, samplertex, (half2(px + h1x, py + h1y) * 1.0f / width), level));
            return r;
            #else
            return SAMPLE_TEXTURE2D_LOD(tex, samplertex, uv, level);
            #endif
        }
        
        half getBakedNoise(TEXTURE2D_PARAM(noiseTex, samplernoiseTex), float3 p)
        {
            float3 i = floor(p); p -= i; p *= p * (3. - 2. * p);
            float2 uv = (p.xy + i.xy + float2(37, 17) * i.z + .5) / 256.;
            uv.y *= -1;
            p.xy = SAMPLE_TEXTURE2D_LOD(noiseTex, samplernoiseTex, uv, 0).yx;
            return lerp(p.x, p.y, p.z);
        }
        
        // Manual bilinear sampling to avoid 8 bit precision issues
        // Based on https://www.shadertoy.com/view/MllSzX
        half getBakedNoiseBilinear(TEXTURE2D_PARAM(noiseTex, samplernoiseTex), float4 texSize, float3 p)
        {
            float3 i = floor(p); p -= i; p *= p * (3. - 2. * p);
            float2 uv = (p.xy + i.xy + float2(37, 17) * i.z + .5) / 256.;
            uv.y *= -1;
        
            float2 pixelUv = uv * texSize.zw + 0.5;
            float2 pixelUvFrac = frac(pixelUv);
        
            pixelUv = (floor(pixelUv) / texSize.zw) - texSize.xy * 0.5;
        
            float4 sample0 = SAMPLE_TEXTURE2D_LOD(noiseTex, samplernoiseTex, pixelUv, 0);
            float4 sample1 = SAMPLE_TEXTURE2D_LOD(noiseTex, samplernoiseTex, pixelUv + float2(texSize.x, 0), 0);
            float4 sample2 = SAMPLE_TEXTURE2D_LOD(noiseTex, samplernoiseTex, pixelUv + float2(0, texSize.y), 0);
            float4 sample3 = SAMPLE_TEXTURE2D_LOD(noiseTex, samplernoiseTex, pixelUv + float2(texSize.x, texSize.y), 0);
        
            float4 filtered1 = lerp(sample0, sample1, pixelUvFrac.x);
            float4 filtered2 = lerp(sample2, sample3, pixelUvFrac.x);
            float4 filtered = lerp(filtered1, filtered2, pixelUvFrac.y);
        
            p.xy = filtered.yx;
            return lerp(p.x, p.y, p.z);
        }
        
        half getBakedNoiseBicubic(TEXTURE2D_PARAM(noiseTex, samplernoiseTex), float3 p)
        {
            float3 i = floor(p); p -= i; p *= p * (3. - 2. * p);
            float2 uv = (p.xy + i.xy + float2(37, 17) * i.z + .5) / 256.;
            uv.y *= -1;
            p.xy = tex2DFastBicubicSampleLevel(TEXTURE2D_ARGS(noiseTex, samplernoiseTex), uv, 0).yx;
            return lerp(p.x, p.y, p.z);
        }
        
        half remap(half s, half a1, half a2, half b1, half b2)
        {
            return b1 + (s - a1) * (b2 - b1) / (a2 - a1);
        }
        
        half3 ApplyLut2D(TEXTURE2D_PARAM(lut2d, samplerlut2d), half3 uvw)
        {
            half3 scaleOffset = half3(1.0 / 1024.0, 1.0 / 32.0, 31.0);
            // Strip format where `height = sqrt(width)`
            uvw.z *= scaleOffset.z;
            half shift = floor(uvw.z);
            uvw.xy = uvw.xy * scaleOffset.z * scaleOffset.xy + scaleOffset.xy * 0.5;
            uvw.x += shift * scaleOffset.y;
            uvw.xyz = lerp(
                SAMPLE_TEXTURE2D(lut2d, samplerlut2d, uvw.xy).rgb,
                SAMPLE_TEXTURE2D(lut2d, samplerlut2d, uvw.xy + half2(scaleOffset.y, 0.0)).rgb,
                uvw.z - shift
            );
            return uvw;
        }
        
        half3 HSV2RGB(half3 hsv)
        {
            return hsv.z + hsv.z * hsv.y * (clamp(abs(fmod(hsv.x * 6.0 + half3(0,4,2), 6.0) - 3.0) - 1.0,0.0,1.0) - 1.0);
        }
        
        half3 RGB2HSV(half3 rgb)
        {
            half4 K = half4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
            half4 p = lerp(half4(rgb.bg, K.wz), half4(rgb.gb, K.xy), step(rgb.b, rgb.g));
            half4 q = lerp(half4(p.xyw, rgb.r), half4(rgb.r, p.yzx), step(p.x, rgb.r));
        
            half d = q.x - min(q.w, q.y);
            half e = 1.0e-10;
            return half3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
        }
        
        half3 HSVAdjust(half3 hsv, half3 adjustment)
        {
            hsv.x = frac(hsv.x + adjustment.x);
            hsv.y = saturate(hsv.y + adjustment.y);
            hsv.z = saturate(hsv.z + adjustment.z);
            return hsv;
        }
        
        half3 AdjustContrast(half3 color, half contrast)
        {
            color = saturate(lerp(half3(0.5, 0.5, 0.5), color, contrast));
            return color;
        }
        
        half3 AdjustSaturation(half3 color, half saturation)
        {
            half3 intensity = dot(color.rgb, half3(0.299, 0.587, 0.114));
            color = lerp(intensity, color.rgb, saturation);
            return color;
        }
        
        half3 AdjustBrightness(half3 color, half brightness)
        {
            color += brightness;
            return color;
        }
        
        struct ParamsLogC
        {
            half cut;
            half a, b, c, d, e, f;
        };
        
        static const ParamsLogC LogC = {
            0.011361, // cut
            5.555556, // a
            0.047996, // b
            0.244161, // c
            0.386036, // d
            5.301883, // e
            0.092819  // f
        
        };
        
        half LinearToLogC_Precise(half x)
        {
            half o;
            if (x > LogC.cut)
                o = LogC.c * log10(LogC.a * x + LogC.b) + LogC.d;
            else
                o = LogC.e * x + LogC.f;
            return o;
        }
        
        half PositivePow(half base, half power)
        {
            return pow(max(abs(base), half(FLT_EPSILON)), power);
        }
        
        half3 LinearToLogC(half3 x)
        {
            return LogC.c * log10(LogC.a * x + LogC.b) + LogC.d;
        }
        
        half3 LinerToSRGB(half3 c)
        {
            return c * (c * (c * 0.305306011 + 0.682171111) + 0.012522878);
        }
        
        half3 SRGBToLinear(half3 c)
        {
            return max(1.055 * PositivePow(c, 0.416666667) - 0.055, 0.0);
        }
        
        half3 LogCToLinear(half3 c)
        {
            return (pow(10.0, (c - LogC.d) / LogC.c) - LogC.b) / LogC.a;
        }
        
        // Specular stuff taken from https://github.com/z3y/shaders/
        float pow5(float x)
        {
            float x2 = x * x;
            return x2 * x2 * x;
        }
        
        float sq(float x)
        {
            return x * x;
        }
        
        struct Gradient
        {
            int type;
            int colorsLength;
            int alphasLength;
            half4 colors[8];
            half2 alphas[8];
        };
        
        Gradient NewGradient(
            int type, int colorsLength, int alphasLength,
            half4 colors0, half4 colors1, half4 colors2, half4 colors3, half4 colors4, half4 colors5, half4 colors6, half4 colors7,
            half2 alphas0, half2 alphas1, half2 alphas2, half2 alphas3, half2 alphas4, half2 alphas5, half2 alphas6, half2 alphas7)
        {
            Gradient g;
            g.type = type;
            g.colorsLength = colorsLength;
            g.alphasLength = alphasLength;
            g.colors[ 0 ] = colors0;
            g.colors[ 1 ] = colors1;
            g.colors[ 2 ] = colors2;
            g.colors[ 3 ] = colors3;
            g.colors[ 4 ] = colors4;
            g.colors[ 5 ] = colors5;
            g.colors[ 6 ] = colors6;
            g.colors[ 7 ] = colors7;
            g.alphas[ 0 ] = alphas0;
            g.alphas[ 1 ] = alphas1;
            g.alphas[ 2 ] = alphas2;
            g.alphas[ 3 ] = alphas3;
            g.alphas[ 4 ] = alphas4;
            g.alphas[ 5 ] = alphas5;
            g.alphas[ 6 ] = alphas6;
            g.alphas[ 7 ] = alphas7;
            return g;
        }
        
        half4 SampleGradient(Gradient gradient, half time)
        {
            half3 color = gradient.colors[0].rgb;
        
            UNITY_UNROLL
            for (int c = 1; c < 8; c++)
            {
                half colorPos = saturate((time - gradient.colors[c - 1].w) / (0.00001 + (gradient.colors[c].w - gradient.colors[c - 1].w)) * step(c, (half)gradient.colorsLength - 1));
                color = lerp(color, gradient.colors[c].rgb, lerp(colorPos, step(0.01, colorPos), gradient.type));
            }
        
            #ifndef UNITY_COLORSPACE_GAMMA
            color = half3(GammaToLinearSpaceExact(color.r), GammaToLinearSpaceExact(color.g), GammaToLinearSpaceExact(color.b));
            #endif
        
            half alpha = gradient.alphas[0].x;
        
            UNITY_UNROLL
            for (int a = 1; a < 8; a++)
            {
                half alphaPos = saturate((time - gradient.alphas[a - 1].y) / (0.00001 + (gradient.alphas[a].y - gradient.alphas[a - 1].y)) * step(a, (half)gradient.alphasLength - 1));
                alpha = lerp(alpha, gradient.alphas[a].x, lerp(alphaPos, step(0.01, alphaPos), gradient.type));
            }
            return half4(color, alpha);
        }
        
        float3 RotateAroundAxis(float3 center, float3 original, float3 u, float angle)
        {
            original -= center;
            float C = cos(angle);
            float S = sin(angle);
            float t = 1 - C;
            float m00 = t * u.x * u.x + C;
            float m01 = t * u.x * u.y - S * u.z;
            float m02 = t * u.x * u.z + S * u.y;
            float m10 = t * u.x * u.y + S * u.z;
            float m11 = t * u.y * u.y + C;
            float m12 = t * u.y * u.z - S * u.x;
            float m20 = t * u.x * u.z - S * u.y;
            float m21 = t * u.y * u.z + S * u.x;
            float m22 = t * u.z * u.z + C;
            float3x3 finalMatrix = float3x3(m00, m01, m02, m10, m11, m12, m20, m21, m22);
            return mul(finalMatrix, original) + center;
        }
        
        void GetTriplanarUV(half3 position, out half2 uvX, out half2 uvY, out half2 uvZ)
        {
            uvX = half2(position.z, position.y + 0.5);
            uvY = position.xz;
            uvZ = half2(position.x + 0.5, position.y + 0.5);
        }
        
        void GetTriplanarWeights(half3 normal, out half weightX, out half weightY, out half weightZ)
        {
            half3 absNormal = abs(normal);
            half3 sum = absNormal / (absNormal.x + absNormal.y + absNormal.z);
            weightX = sum.x;
            weightY = sum.y;
            weightZ = sum.z;
        }
        
        half2 Rotate2D(half2 source, half angle)
        {
            half2x2 rotMat = { cos(angle), -sin(angle), sin(angle), cos(angle) };
            return mul(rotMat, source);
        }
        
        float2 Rotate2DFloat(float2 source, float angle)
        {
            float2x2 rotMat = { cos(angle), -sin(angle), sin(angle), cos(angle) };
            return mul(rotMat, source);
        }
        
        struct ORL_UVChannelData
        {
            #if !defined(NEED_FLOAT4_UV)
            float2 uv0;
            float2 uv1;
            float2 uv2;
            float2 uv3;
            #else
            float4 uv0;
            float4 uv1;
            float4 uv2;
            float4 uv3;
            #endif
        };
        
        float2 RotateAroundCenter2D(float2 source, float angle)
        {
            angle = radians(angle);
            float sinAngle = sin(angle);
            float cosAngle = cos(angle);
            float2x2 rotationMatrix = { cosAngle, -sinAngle, sinAngle, cosAngle };
            source -= 0.5;
            source = mul(rotationMatrix, source);
            source += 0.5;
            return source;
        }
        
        float GLSLMod(float x, float y)
        {
            return (((x)-(y)*floor((x)/(y))));
        }
        
        float2 GLSLMod(float2 x, float2 y)
        {
            return (((x)-(y)*floor((x)/(y))));
        }
        
        // Found in this article on tonemapping: https://mini.gmshaders.com/p/tonemaps
        // Narkowicz 2015, "ACES Filmic Tone Mapping Curve"
        float3 Tonemap_ACES(float3 x)
        {
            float a = 2.51;
            float b = 0.03;
            float c = 2.43;
            float d = 0.59;
            float e = 0.14;
            return (x * (a * x + b)) / (x * (c * x + d) + e);
        }
        
        // Hable 2010, "Filmic Tonemapping Operators"
        float3 Tonemap_Uncharted2(float3 x)
        {
            x *= 16.0;
            float A = 0.15;
            float B = 0.50;
            float C = 0.10;
            float D = 0.20;
            float E = 0.02;
            float F = 0.30;
        
            return ((x*(A*x+C*B)+D*E)/(x*(A*x+B)+D*F))-E/F;
        }
        
        float3 Tonemap_Unreal(float3 x)
        {
            // Unreal 3, Documentation: "Color Grading"
            // Adapted to be close to Tonemap_ACES, with similar range
            // Gamma 2.2 correction is baked in, don't use with sRGB conversion!
            return x / (x + 0.155) * 1.019;
        }
        
        // https://github.com/yuki-koyama/enhancer
        // MIT License
        
        // Copyright (c) 2018 Yuki Koyama
        
        // Permission is hereby granted, free of charge, to any person obtaining a copy
        // of this software and associated documentation files (the "Software"), to deal
        // in the Software without restriction, including without limitation the rights
        // to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        // copies of the Software, and to permit persons to whom the Software is
        // furnished to do so, subject to the following conditions:
        
        // The above copyright notice and this permission notice shall be included in all
        // copies or substantial portions of the Software.
        
        // THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        // IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        // FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        // AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        // LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        // SOFTWARE.
        float3 applyLiftGammaGainEffect(float3 linear_rgb, float3 lift, float3 gamma, float3 gain)
        {
            float3 lift_applied_linear_rgb  = clamp((linear_rgb - 1.0) * (2.0 - lift) + 1.0, 0.0, 1.0);
            float3 gain_applied_linear_rgb  = lift_applied_linear_rgb * gain;
            float3 gamma_applied_linear_rgb = pow(gain_applied_linear_rgb, 1.0 / gamma);
        
            return gamma_applied_linear_rgb;
        }
        
        
        // https://github.com/MochiesCode/Mochies-Unity-Shaders/
        // MIT License
        
        // Copyright (c) 2020 MochiesCode
        
        // Permission is hereby granted, free of charge, to any person obtaining a copy
        // of this software and associated documentation files (the "Software"), to deal
        // in the Software without restriction, including without limitation the rights
        // to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        // copies of the Software, and to permit persons to whom the Software is
        // furnished to do so, subject to the following conditions:
        
        // The above copyright notice and this permission notice shall be included in all
        // copies or substantial portions of the Software.
        
        // THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        // IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        // FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        // AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        // LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        // SOFTWARE.
        float3 GetSpritesheetUV(float2 uv, float2 rowsColumns, float fps, int pauseFrames, int frameOffset){
            float2 size = float2(1/rowsColumns.x, 1/rowsColumns.y);
            uint totalFrames = rowsColumns.x * rowsColumns.y;
            uint index = 0;
            index = (_Time.y * fps + frameOffset) % (totalFrames + pauseFrames);
        
            if (index > totalFrames) {
                index = totalFrames;
            }
        
            uint indexX = index % rowsColumns.x;
            uint indexY = floor((index % totalFrames) / rowsColumns.x);
            float2 offset = float2(size.x*indexX,-size.y*indexY);
            float2 uv1 = uv*size;
            uv1.y = uv1.y + size.y*(rowsColumns.y - 1);
            uv = uv1 + offset;
            return float3(uv,0);
        }
        
        // SDFS
        // https://iquilezles.org/articles/distfunctions2d/
        float SDFBox(float2 p, float2 b )
        {
            float2 d = abs(p)-b;
            return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
        }
        
        float SDFCircle(float2 p, float r)
        {
            return length(p) - r;
        }
        
        // from CoreRP Packing.hlsl
        // com.unity.render-pipelines.core copyright © 2020 Unity Technologies ApS
        //
        // Licensed under the Unity Companion License for Unity-dependent projects--see [Unity Companion License](http://www.unity3d.com/legal/licenses/Unity_Companion_License).
        //
        // Unless expressly provided otherwise, the Software under this license is made available strictly on an “AS IS” BASIS WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED. Please review the license for details on these and other terms and conditions.
        half3 UnpackNormalAG(half4 packedNormal, half scale = 1.0)
        {
          half3 normal;
          normal.xy = packedNormal.ag * 2.0 - 1.0;
          normal.z = max(1.0e-16, sqrt(1.0 - saturate(dot(normal.xy, normal.xy))));
        
          // must scale after reconstruction of normal.z which also
          // mirrors UnpackNormalRGB(). This does imply normal is not returned
          // as a unit length vector but doesn't need it since it will get normalized after TBN transformation.
          // If we ever need to blend contributions with built-in shaders for URP
          // then we should consider using UnpackDerivativeNormalAG() instead like
          // HDRP does since derivatives do not use renormalization and unlike tangent space
          // normals allow you to blend, accumulate and scale contributions correctly.
          normal.xy *= scale;
          return normal;
        }
        
        #ifndef AUDIOLINK_CGINC_INCLUDED
            #define AUDIOLINK_CGINC_INCLUDED
        
            // Map of where features in AudioLink are.
            #define ALPASS_DFT                      uint2(0,4)  //Size: 128, 2
            #define ALPASS_WAVEFORM                 uint2(0,6)  //Size: 128, 16
            #define ALPASS_AUDIOLINK                uint2(0,0)  //Size: 128, 4
            #define ALPASS_AUDIOBASS                uint2(0,0)  //Size: 128, 1
            #define ALPASS_AUDIOLOWMIDS             uint2(0,1)  //Size: 128, 1
            #define ALPASS_AUDIOHIGHMIDS            uint2(0,2)  //Size: 128, 1
            #define ALPASS_AUDIOTREBLE              uint2(0,3)  //Size: 128, 1
            #define ALPASS_AUDIOLINKHISTORY         uint2(1,0)  //Size: 127, 4
            #define ALPASS_GENERALVU                uint2(0,22) //Size: 12, 1
            #define ALPASS_GENERALVU_INSTANCE_TIME  uint2(2,22)
            #define ALPASS_GENERALVU_LOCAL_TIME     uint2(3,22)
            #define ALPASS_GENERALVU_NETWORK_TIME   uint2(4,22)
            #define ALPASS_GENERALVU_PLAYERINFO     uint2(6,22)
            #define ALPASS_THEME_COLOR0             uint2(0,23)
            #define ALPASS_THEME_COLOR1             uint2(1,23)
            #define ALPASS_THEME_COLOR2             uint2(2,23)
            #define ALPASS_THEME_COLOR3             uint2(3,23)
            #define ALPASS_GENERALVU_UNIX_DAYS      uint2(5,23)
            #define ALPASS_GENERALVU_UNIX_SECONDS   uint2(6,23)
            #define ALPASS_GENERALVU_SOURCE_POS     uint2(7,23)
            #define ALPASS_MEDIASTATE               uint2(5,22)
        
            #define ALPASS_CCINTERNAL               uint2(12,22) //Size: 12, 2
            #define ALPASS_CCCOLORS                 uint2(25,22) //Size: 12, 1 (Note Color #0 is always black, Colors start at 1)
            #define ALPASS_CCSTRIP                  uint2(0,24)  //Size: 128, 1
            #define ALPASS_CCLIGHTS                 uint2(0,25)  //Size: 128, 2
            #define ALPASS_AUTOCORRELATOR           uint2(0,27)  //Size: 128, 1
            #define ALPASS_FILTEREDAUDIOLINK        uint2(0,28)  //Size: 16, 4
            #define ALPASS_CHRONOTENSITY            uint2(16,28) //Size: 8, 4
            #define ALPASS_FILTEREDVU               uint2(24,28) //Size: 4, 4
            #define ALPASS_FILTEREDVU_INTENSITY     uint2(24,28) //Size: 4, 1
            #define ALPASS_FILTEREDVU_MARKER        uint2(24,29) //Size: 4, 1
            #define ALPASS_GLOBAL_STRINGS           uint2(40,28) //Size: 8, 4
        
            // Some basic constants to use (Note, these should be compatible with
            // future version of AudioLink, but may change.
            #define AUDIOLINK_SAMPHIST              3069        // Internal use for algos, do not change.
            #define AUDIOLINK_SAMPLEDATA24          2046
            #define AUDIOLINK_EXPBINS               24
            #define AUDIOLINK_EXPOCT                10
            #define AUDIOLINK_ETOTALBINS            (AUDIOLINK_EXPBINS * AUDIOLINK_EXPOCT)
            #define AUDIOLINK_WIDTH                 128
            #define AUDIOLINK_SPS                   48000       // Samples per second
            #define AUDIOLINK_ROOTNOTE              0
            #define AUDIOLINK_4BAND_FREQFLOOR       0.123
            #define AUDIOLINK_4BAND_FREQCEILING     1
            #define AUDIOLINK_BOTTOM_FREQUENCY      13.75
            #define AUDIOLINK_BASE_AMPLITUDE        2.5
            #define AUDIOLINK_DELAY_COEFFICIENT_MIN 0.3
            #define AUDIOLINK_DELAY_COEFFICIENT_MAX 0.9
            #define AUDIOLINK_DFT_Q                 4.0
            #define AUDIOLINK_TREBLE_CORRECTION     5.0
            #define AUDIOLINK_4BAND_TARGET_RATE     90.0
        
            // Text constants
            #define AUDIOLINK_STRING_MAX_CHARS      32
            #define AUDIOLINK_STRING_LOCALPLAYER    0
            #define AUDIOLINK_STRING_MASTER         1
            #define AUDIOLINK_STRING_CUSTOM1        2
            #define AUDIOLINK_STRING_CUSTOM2        3
        
            // ColorChord constants
            #define COLORCHORD_EMAXBIN              192
            #define COLORCHORD_NOTE_CLOSEST         3.0
            #define COLORCHORD_NEW_NOTE_GAIN        8.0
            #define COLORCHORD_MAX_NOTES            10
        
            // We use glsl_mod for most calculations because it behaves better
            // on negative numbers, and in some situations actually outperforms
            // HLSL's modf().
            #ifndef glsl_mod
                #define glsl_mod(x,y) (((x)-(y)*floor((x)/(y))))
            #endif
        
            uniform float4               _AudioTexture_TexelSize;
        
            #ifdef SHADER_TARGET_SURFACE_ANALYSIS
                #define AUDIOLINK_STANDARD_INDEXING
            #endif
        
            // Mechanism to index into texture.
            #ifdef AUDIOLINK_STANDARD_INDEXING
                sampler2D _AudioTexture;
                #define AudioLinkData(xycoord) tex2Dlod(_AudioTexture, float4(uint2(xycoord) * _AudioTexture_TexelSize.xy, 0, 0))
            #else
                uniform Texture2D<float4>   _AudioTexture;
                #define AudioLinkData(xycoord) _AudioTexture[uint2(xycoord)]
            #endif
        
            // Convenient mechanism to read from the AudioLink texture that handles reading off the end of one line and onto the next above it.
            float4 AudioLinkDataMultiline(uint2 xycoord) { return AudioLinkData(uint2(xycoord.x % AUDIOLINK_WIDTH, xycoord.y + xycoord.x/AUDIOLINK_WIDTH)); }
        
            // Mechanism to sample between two adjacent pixels and lerp between them, like "linear" supesampling
            float4 AudioLinkLerp(float2 xy) { return lerp( AudioLinkData(xy), AudioLinkData(xy+int2(1,0)), frac( xy.x ) ); }
        
            // Same as AudioLinkLerp but properly handles multiline reading.
            float4 AudioLinkLerpMultiline(float2 xy) { return lerp(AudioLinkDataMultiline(xy), AudioLinkDataMultiline(xy+float2(1,0)), frac(xy.x)); }
        
            //Tests to see if Audio Link texture is available
            bool AudioLinkIsAvailable()
            {
                #if !defined(AUDIOLINK_STANDARD_INDEXING)
                    int width, height;
                    _AudioTexture.GetDimensions(width, height);
                    return width > 16;
                #else
                    return _AudioTexture_TexelSize.z > 16;
                #endif
            }
        
            // DEPRECATED! Use AudioLinkGetVersionMajor and AudioLinkGetVersionMinor() instead.
            //Get version of audiolink present in the world, 0 if no audiolink is present
            float AudioLinkGetVersion()
            {
                int2 dims;
                #if !defined(AUDIOLINK_STANDARD_INDEXING)
                    _AudioTexture.GetDimensions(dims.x, dims.y);
                #else
                    dims = _AudioTexture_TexelSize.zw;
                #endif
        
                if (dims.x >= 128)
                    return AudioLinkData(ALPASS_GENERALVU).x;
                else if (dims.x > 16)
                    return 1;
                else
                    return 0;
            }
        
            float AudioLinkGetVersionMajor()
            {
                return AudioLinkData(ALPASS_GENERALVU).y;
            }
        
            float AudioLinkGetVersionMinor()
            {
                // If the major version is 1 or greater, we are using the new versioning system.
                if (AudioLinkGetVersionMajor() > 0)
                {
                    return AudioLinkData(ALPASS_GENERALVU).w;
                }
                // Otherwise, defer to the old logic for determining version.
                else
                {
                    int2 dims;
                    #if !defined(AUDIOLINK_STANDARD_INDEXING)
                        _AudioTexture.GetDimensions(dims.x, dims.y);
                    #else
                        dims = _AudioTexture_TexelSize.zw;
                    #endif
        
                    if (dims.x >= 128)
                        return AudioLinkData(ALPASS_GENERALVU).x;
                    else if (dims.x > 16)
                        return 1;
                    else
                        return 0;
                }
            }
        
            // This pulls data from this texture.
            #define AudioLinkGetSelfPixelData(xy) _SelfTexture2D[xy]
        
            // Extra utility functions for time.
            uint AudioLinkDecodeDataAsUInt(uint2 indexloc)
            {
                uint4 rpx = AudioLinkData(indexloc);
                return rpx.x + rpx.y*1024 + rpx.z * 1048576 + rpx.w * 1073741824;
            }
        
            //Note: This will truncate time to every 134,217.728 seconds (~1.5 days of an instance being up) to prevent floating point aliasing.
            // if your code will alias sooner, you will need to use a different function.  It should be safe to use this on all times.
            float AudioLinkDecodeDataAsSeconds(uint2 indexloc)
            {
                uint time = AudioLinkDecodeDataAsUInt(indexloc) & 0x7ffffff;
                //Can't just divide by float.  Bug in Unity's HLSL compiler.
                return float(time / 1000) + float( time % 1000 ) / 1000.; 
            }
        
            #define ALDecodeDataAsSeconds( x ) AudioLinkDecodeDataAsSeconds( x )
            #define ALDecodeDataAsUInt( x ) AudioLinkDecodeDataAsUInt( x )
        
            float AudioLinkRemap(float t, float a, float b, float u, float v) { return ((t-a) / (b-a)) * (v-u) + u; }
        
            float3 AudioLinkHSVtoRGB(float3 HSV)
            {
                float3 RGB = 0;
                float C = HSV.z * HSV.y;
                float H = HSV.x * 6;
                float X = C * (1 - abs(fmod(H, 2) - 1));
                if (HSV.y != 0)
                {
                    float I = floor(H);
                    if (I == 0) { RGB = float3(C, X, 0); }
                    else if (I == 1) { RGB = float3(X, C, 0); }
                    else if (I == 2) { RGB = float3(0, C, X); }
                    else if (I == 3) { RGB = float3(0, X, C); }
                    else if (I == 4) { RGB = float3(X, 0, C); }
                    else { RGB = float3(C, 0, X); }
                }
                float M = HSV.z - C;
                return RGB + M;
            }
        
            float3 AudioLinkCCtoRGB(float bin, float intensity, int rootNote)
            {
                float note = bin / AUDIOLINK_EXPBINS;
        
                float hue = 0.0;
                note *= 12.0;
                note = glsl_mod(4. - note + rootNote, 12.0);
                {
                    if(note < 4.0)
                    {
                        //Needs to be YELLOW->RED
                        hue = (note) / 24.0;
                    }
                    else if(note < 8.0)
                    {
                        //            [4]  [8]
                        //Needs to be RED->BLUE
                        hue = (note-2.0) / 12.0;
                    }
                    else
                    {
                        //             [8] [12]
                        //Needs to be BLUE->YELLOW
                        hue = (note - 4.0) / 8.0;
                    }
                }
                float val = intensity - 0.1;
                return AudioLinkHSVtoRGB(float3(fmod(hue, 1.0), 1.0, clamp(val, 0.0, 1.0)));
            }
        
            // Sample the amplitude of a given frequency in the DFT, supports frequencies in [13.75; 14080].
            float4 AudioLinkGetAmplitudeAtFrequency(float hertz)
            {
                float note = AUDIOLINK_EXPBINS * log2(hertz / AUDIOLINK_BOTTOM_FREQUENCY);
                return AudioLinkLerpMultiline(ALPASS_DFT + float2(note, 0));
            }
        
            // Sample the amplitude of a given quartertone in an octave. Octave is in [0; 9] while quarter is [0; 23].
            float4 AudioLinkGetAmplitudeAtQuarterNote(float octave, float quarter)
            {
                return AudioLinkLerpMultiline(ALPASS_DFT + float2(octave * AUDIOLINK_EXPBINS + quarter, 0));
            }
        
            // Sample the amplitude of a given semitone in an octave. Octave is in [0; 9] while note is [0; 11].
            float4 AudioLinkGetAmplitudeAtNote(float octave, float note)
            {
                float quarter = note * 2.0;
                return AudioLinkGetAmplitudeAtQuarterNote(octave, quarter);
            }
        
            // Sample the amplitude of a given quartertone across all octaves. Quarter is [0; 23].
            float4 AudioLinkGetAmplitudesAtQuarterNote(float quarter)
            {
                float amplitude = 0;
                UNITY_UNROLL
                for (int i = 0; i < AUDIOLINK_EXPOCT; i++)
                {
                    amplitude += AudioLinkGetAmplitudeAtQuarterNote(i,quarter);
                }
                return amplitude;
            }
        
            // Sample the amplitude of a given semitone across all octaves. Note is [0; 11].
            float4 AudioLinkGetAmplitudesAtNote(float note)
            {
                float quarter = note * 2.0;
                return AudioLinkGetAmplitudesAtQuarterNote(quarter);
            }
        
            // Get a reasonable drop-in replacement time value for _Time.y with the
            // given chronotensity index [0; 7] and AudioLink band [0; 3].
            float AudioLinkGetChronoTime(uint index, uint band)
            {
                return (AudioLinkDecodeDataAsUInt(ALPASS_CHRONOTENSITY + uint2(index, band))) / 100000.0;
            }
        
            // Get a chronotensity value in the interval [0; 1], modulated by the speed input, 
            // with the given chronotensity index [0; 7] and AudioLink band [0; 3].
            float AudioLinkGetChronoTimeNormalized(uint index, uint band, float speed)
            {
                return frac(AudioLinkGetChronoTime(index, band) * speed);
            }
        
            // Get a chronotensity value in the interval [0; interval], modulated by the speed input, 
            // with the given chronotensity index [0; 7] and AudioLink band [0; 3].
            float AudioLinkGetChronoTimeInterval(uint index, uint band, float speed, float interval)
            {
                return AudioLinkGetChronoTimeNormalized(index, band, speed) * interval;
            }
        
            // Get time of day. The return value is a float4 with the values float3(hour, minute, second).
            float3 AudioLinkGetTimeOfDay()
            {
                float value = AudioLinkDecodeDataAsSeconds(ALPASS_GENERALVU_UNIX_SECONDS);
                float hour = floor(value / 3600.0);
                float minute = floor(value / 60.0) % 60.0;
                float second = value % 60.0;
                return float3(hour, minute, second);
            }
        
            // Get a character from a globally synced string, given an index of string in range [0; 3], and
            // a character index in range [0; 31]. The string at the 0th index is the local player name.
            // The 1st index is the master name, and index 2 and 3 are custom strings.
            // Returns a unsigned integer represented a unicode codepoint, i.e. UTF32.
            uint AudioLinkGetGlobalStringChar(uint stringIndex, uint charIndex)
            {
                uint4 fourChars = asuint(AudioLinkData(ALPASS_GLOBAL_STRINGS + uint2(charIndex / 4, stringIndex)));
                return fourChars[charIndex % 4];
            }
        
            // Get a character from the local player name given a character index in the range [0; 31].
            // Returns a unsigned integer represented a unicode codepoint, i.e. UTF32.
            uint AudioLinkGetLocalPlayerNameChar(uint charIndex)
            {
                return AudioLinkGetGlobalStringChar(AUDIOLINK_STRING_LOCALPLAYER, charIndex);
            }
        
            // Get a character from the master player name given a character index in the range [0; 31].
            // Returns a unsigned integer represented a unicode codepoint, i.e. UTF32.
            uint AudioLinkGetMasterNameChar(uint charIndex)
            {
                return AudioLinkGetGlobalStringChar(AUDIOLINK_STRING_MASTER, charIndex);
            }
        
            // Get a character from the first custom string given a character index in the range [0; 31].
            // Returns a unsigned integer represented a unicode codepoint, i.e. UTF32.
            uint AudioLinkGetCustomString1Char(uint charIndex)
            {
                return AudioLinkGetGlobalStringChar(AUDIOLINK_STRING_CUSTOM1, charIndex);
            }
        
            // Get a character from the second custom string given a character index in the range [0; 31].
            // Returns a unsigned integer represented a unicode codepoint, i.e. UTF32.
            uint AudioLinkGetCustomString2Char(uint charIndex)
            {
                return AudioLinkGetGlobalStringChar(AUDIOLINK_STRING_CUSTOM2, charIndex);
            }
        
            // Returns the position of the AudioLink AudioSource in world space.
            float4 AudioLinkGetAudioSourcePosition()
            {
                return float4(AudioLinkData(ALPASS_GENERALVU_SOURCE_POS).xyz,1);
            }
        #endif
        
        #ifndef AUDIOLINK_CGINC_INCLUDED
            #define AUDIOLINK_CGINC_INCLUDED
        
            // Map of where features in AudioLink are.
            #define ALPASS_DFT                      uint2(0,4)  //Size: 128, 2
            #define ALPASS_WAVEFORM                 uint2(0,6)  //Size: 128, 16
            #define ALPASS_AUDIOLINK                uint2(0,0)  //Size: 128, 4
            #define ALPASS_AUDIOBASS                uint2(0,0)  //Size: 128, 1
            #define ALPASS_AUDIOLOWMIDS             uint2(0,1)  //Size: 128, 1
            #define ALPASS_AUDIOHIGHMIDS            uint2(0,2)  //Size: 128, 1
            #define ALPASS_AUDIOTREBLE              uint2(0,3)  //Size: 128, 1
            #define ALPASS_AUDIOLINKHISTORY         uint2(1,0)  //Size: 127, 4
            #define ALPASS_GENERALVU                uint2(0,22) //Size: 12, 1
            #define ALPASS_GENERALVU_INSTANCE_TIME  uint2(2,22)
            #define ALPASS_GENERALVU_LOCAL_TIME     uint2(3,22)
            #define ALPASS_GENERALVU_NETWORK_TIME   uint2(4,22)
            #define ALPASS_GENERALVU_PLAYERINFO     uint2(6,22)
            #define ALPASS_THEME_COLOR0             uint2(0,23)
            #define ALPASS_THEME_COLOR1             uint2(1,23)
            #define ALPASS_THEME_COLOR2             uint2(2,23)
            #define ALPASS_THEME_COLOR3             uint2(3,23)
            #define ALPASS_GENERALVU_UNIX_DAYS      uint2(5,23)
            #define ALPASS_GENERALVU_UNIX_SECONDS   uint2(6,23)
            #define ALPASS_GENERALVU_SOURCE_POS     uint2(7,23)
            #define ALPASS_MEDIASTATE               uint2(5,22)
        
            #define ALPASS_CCINTERNAL               uint2(12,22) //Size: 12, 2
            #define ALPASS_CCCOLORS                 uint2(25,22) //Size: 12, 1 (Note Color #0 is always black, Colors start at 1)
            #define ALPASS_CCSTRIP                  uint2(0,24)  //Size: 128, 1
            #define ALPASS_CCLIGHTS                 uint2(0,25)  //Size: 128, 2
            #define ALPASS_AUTOCORRELATOR           uint2(0,27)  //Size: 128, 1
            #define ALPASS_FILTEREDAUDIOLINK        uint2(0,28)  //Size: 16, 4
            #define ALPASS_CHRONOTENSITY            uint2(16,28) //Size: 8, 4
            #define ALPASS_FILTEREDVU               uint2(24,28) //Size: 4, 4
            #define ALPASS_FILTEREDVU_INTENSITY     uint2(24,28) //Size: 4, 1
            #define ALPASS_FILTEREDVU_MARKER        uint2(24,29) //Size: 4, 1
            #define ALPASS_GLOBAL_STRINGS           uint2(40,28) //Size: 8, 4
        
            // Some basic constants to use (Note, these should be compatible with
            // future version of AudioLink, but may change.
            #define AUDIOLINK_SAMPHIST              3069        // Internal use for algos, do not change.
            #define AUDIOLINK_SAMPLEDATA24          2046
            #define AUDIOLINK_EXPBINS               24
            #define AUDIOLINK_EXPOCT                10
            #define AUDIOLINK_ETOTALBINS            (AUDIOLINK_EXPBINS * AUDIOLINK_EXPOCT)
            #define AUDIOLINK_WIDTH                 128
            #define AUDIOLINK_SPS                   48000       // Samples per second
            #define AUDIOLINK_ROOTNOTE              0
            #define AUDIOLINK_4BAND_FREQFLOOR       0.123
            #define AUDIOLINK_4BAND_FREQCEILING     1
            #define AUDIOLINK_BOTTOM_FREQUENCY      13.75
            #define AUDIOLINK_BASE_AMPLITUDE        2.5
            #define AUDIOLINK_DELAY_COEFFICIENT_MIN 0.3
            #define AUDIOLINK_DELAY_COEFFICIENT_MAX 0.9
            #define AUDIOLINK_DFT_Q                 4.0
            #define AUDIOLINK_TREBLE_CORRECTION     5.0
            #define AUDIOLINK_4BAND_TARGET_RATE     90.0
        
            // Text constants
            #define AUDIOLINK_STRING_MAX_CHARS      32
            #define AUDIOLINK_STRING_LOCALPLAYER    0
            #define AUDIOLINK_STRING_MASTER         1
            #define AUDIOLINK_STRING_CUSTOM1        2
            #define AUDIOLINK_STRING_CUSTOM2        3
        
            // ColorChord constants
            #define COLORCHORD_EMAXBIN              192
            #define COLORCHORD_NOTE_CLOSEST         3.0
            #define COLORCHORD_NEW_NOTE_GAIN        8.0
            #define COLORCHORD_MAX_NOTES            10
        
            // We use glsl_mod for most calculations because it behaves better
            // on negative numbers, and in some situations actually outperforms
            // HLSL's modf().
            #ifndef glsl_mod
                #define glsl_mod(x,y) (((x)-(y)*floor((x)/(y))))
            #endif
        
            uniform float4               _AudioTexture_TexelSize;
        
            #ifdef SHADER_TARGET_SURFACE_ANALYSIS
                #define AUDIOLINK_STANDARD_INDEXING
            #endif
        
            // Mechanism to index into texture.
            #ifdef AUDIOLINK_STANDARD_INDEXING
                sampler2D _AudioTexture;
                #define AudioLinkData(xycoord) tex2Dlod(_AudioTexture, float4(uint2(xycoord) * _AudioTexture_TexelSize.xy, 0, 0))
            #else
                uniform Texture2D<float4>   _AudioTexture;
                #define AudioLinkData(xycoord) _AudioTexture[uint2(xycoord)]
            #endif
        
            // Convenient mechanism to read from the AudioLink texture that handles reading off the end of one line and onto the next above it.
            float4 AudioLinkDataMultiline(uint2 xycoord) { return AudioLinkData(uint2(xycoord.x % AUDIOLINK_WIDTH, xycoord.y + xycoord.x/AUDIOLINK_WIDTH)); }
        
            // Mechanism to sample between two adjacent pixels and lerp between them, like "linear" supesampling
            float4 AudioLinkLerp(float2 xy) { return lerp( AudioLinkData(xy), AudioLinkData(xy+int2(1,0)), frac( xy.x ) ); }
        
            // Same as AudioLinkLerp but properly handles multiline reading.
            float4 AudioLinkLerpMultiline(float2 xy) { return lerp(AudioLinkDataMultiline(xy), AudioLinkDataMultiline(xy+float2(1,0)), frac(xy.x)); }
        
            //Tests to see if Audio Link texture is available
            bool AudioLinkIsAvailable()
            {
                #if !defined(AUDIOLINK_STANDARD_INDEXING)
                    int width, height;
                    _AudioTexture.GetDimensions(width, height);
                    return width > 16;
                #else
                    return _AudioTexture_TexelSize.z > 16;
                #endif
            }
        
            // DEPRECATED! Use AudioLinkGetVersionMajor and AudioLinkGetVersionMinor() instead.
            //Get version of audiolink present in the world, 0 if no audiolink is present
            float AudioLinkGetVersion()
            {
                int2 dims;
                #if !defined(AUDIOLINK_STANDARD_INDEXING)
                    _AudioTexture.GetDimensions(dims.x, dims.y);
                #else
                    dims = _AudioTexture_TexelSize.zw;
                #endif
        
                if (dims.x >= 128)
                    return AudioLinkData(ALPASS_GENERALVU).x;
                else if (dims.x > 16)
                    return 1;
                else
                    return 0;
            }
        
            float AudioLinkGetVersionMajor()
            {
                return AudioLinkData(ALPASS_GENERALVU).y;
            }
        
            float AudioLinkGetVersionMinor()
            {
                // If the major version is 1 or greater, we are using the new versioning system.
                if (AudioLinkGetVersionMajor() > 0)
                {
                    return AudioLinkData(ALPASS_GENERALVU).w;
                }
                // Otherwise, defer to the old logic for determining version.
                else
                {
                    int2 dims;
                    #if !defined(AUDIOLINK_STANDARD_INDEXING)
                        _AudioTexture.GetDimensions(dims.x, dims.y);
                    #else
                        dims = _AudioTexture_TexelSize.zw;
                    #endif
        
                    if (dims.x >= 128)
                        return AudioLinkData(ALPASS_GENERALVU).x;
                    else if (dims.x > 16)
                        return 1;
                    else
                        return 0;
                }
            }
        
            // This pulls data from this texture.
            #define AudioLinkGetSelfPixelData(xy) _SelfTexture2D[xy]
        
            // Extra utility functions for time.
            uint AudioLinkDecodeDataAsUInt(uint2 indexloc)
            {
                uint4 rpx = AudioLinkData(indexloc);
                return rpx.x + rpx.y*1024 + rpx.z * 1048576 + rpx.w * 1073741824;
            }
        
            //Note: This will truncate time to every 134,217.728 seconds (~1.5 days of an instance being up) to prevent floating point aliasing.
            // if your code will alias sooner, you will need to use a different function.  It should be safe to use this on all times.
            float AudioLinkDecodeDataAsSeconds(uint2 indexloc)
            {
                uint time = AudioLinkDecodeDataAsUInt(indexloc) & 0x7ffffff;
                //Can't just divide by float.  Bug in Unity's HLSL compiler.
                return float(time / 1000) + float( time % 1000 ) / 1000.; 
            }
        
            #define ALDecodeDataAsSeconds( x ) AudioLinkDecodeDataAsSeconds( x )
            #define ALDecodeDataAsUInt( x ) AudioLinkDecodeDataAsUInt( x )
        
            float AudioLinkRemap(float t, float a, float b, float u, float v) { return ((t-a) / (b-a)) * (v-u) + u; }
        
            float3 AudioLinkHSVtoRGB(float3 HSV)
            {
                float3 RGB = 0;
                float C = HSV.z * HSV.y;
                float H = HSV.x * 6;
                float X = C * (1 - abs(fmod(H, 2) - 1));
                if (HSV.y != 0)
                {
                    float I = floor(H);
                    if (I == 0) { RGB = float3(C, X, 0); }
                    else if (I == 1) { RGB = float3(X, C, 0); }
                    else if (I == 2) { RGB = float3(0, C, X); }
                    else if (I == 3) { RGB = float3(0, X, C); }
                    else if (I == 4) { RGB = float3(X, 0, C); }
                    else { RGB = float3(C, 0, X); }
                }
                float M = HSV.z - C;
                return RGB + M;
            }
        
            float3 AudioLinkCCtoRGB(float bin, float intensity, int rootNote)
            {
                float note = bin / AUDIOLINK_EXPBINS;
        
                float hue = 0.0;
                note *= 12.0;
                note = glsl_mod(4. - note + rootNote, 12.0);
                {
                    if(note < 4.0)
                    {
                        //Needs to be YELLOW->RED
                        hue = (note) / 24.0;
                    }
                    else if(note < 8.0)
                    {
                        //            [4]  [8]
                        //Needs to be RED->BLUE
                        hue = (note-2.0) / 12.0;
                    }
                    else
                    {
                        //             [8] [12]
                        //Needs to be BLUE->YELLOW
                        hue = (note - 4.0) / 8.0;
                    }
                }
                float val = intensity - 0.1;
                return AudioLinkHSVtoRGB(float3(fmod(hue, 1.0), 1.0, clamp(val, 0.0, 1.0)));
            }
        
            // Sample the amplitude of a given frequency in the DFT, supports frequencies in [13.75; 14080].
            float4 AudioLinkGetAmplitudeAtFrequency(float hertz)
            {
                float note = AUDIOLINK_EXPBINS * log2(hertz / AUDIOLINK_BOTTOM_FREQUENCY);
                return AudioLinkLerpMultiline(ALPASS_DFT + float2(note, 0));
            }
        
            // Sample the amplitude of a given quartertone in an octave. Octave is in [0; 9] while quarter is [0; 23].
            float4 AudioLinkGetAmplitudeAtQuarterNote(float octave, float quarter)
            {
                return AudioLinkLerpMultiline(ALPASS_DFT + float2(octave * AUDIOLINK_EXPBINS + quarter, 0));
            }
        
            // Sample the amplitude of a given semitone in an octave. Octave is in [0; 9] while note is [0; 11].
            float4 AudioLinkGetAmplitudeAtNote(float octave, float note)
            {
                float quarter = note * 2.0;
                return AudioLinkGetAmplitudeAtQuarterNote(octave, quarter);
            }
        
            // Sample the amplitude of a given quartertone across all octaves. Quarter is [0; 23].
            float4 AudioLinkGetAmplitudesAtQuarterNote(float quarter)
            {
                float amplitude = 0;
                UNITY_UNROLL
                for (int i = 0; i < AUDIOLINK_EXPOCT; i++)
                {
                    amplitude += AudioLinkGetAmplitudeAtQuarterNote(i,quarter);
                }
                return amplitude;
            }
        
            // Sample the amplitude of a given semitone across all octaves. Note is [0; 11].
            float4 AudioLinkGetAmplitudesAtNote(float note)
            {
                float quarter = note * 2.0;
                return AudioLinkGetAmplitudesAtQuarterNote(quarter);
            }
        
            // Get a reasonable drop-in replacement time value for _Time.y with the
            // given chronotensity index [0; 7] and AudioLink band [0; 3].
            float AudioLinkGetChronoTime(uint index, uint band)
            {
                return (AudioLinkDecodeDataAsUInt(ALPASS_CHRONOTENSITY + uint2(index, band))) / 100000.0;
            }
        
            // Get a chronotensity value in the interval [0; 1], modulated by the speed input, 
            // with the given chronotensity index [0; 7] and AudioLink band [0; 3].
            float AudioLinkGetChronoTimeNormalized(uint index, uint band, float speed)
            {
                return frac(AudioLinkGetChronoTime(index, band) * speed);
            }
        
            // Get a chronotensity value in the interval [0; interval], modulated by the speed input, 
            // with the given chronotensity index [0; 7] and AudioLink band [0; 3].
            float AudioLinkGetChronoTimeInterval(uint index, uint band, float speed, float interval)
            {
                return AudioLinkGetChronoTimeNormalized(index, band, speed) * interval;
            }
        
            // Get time of day. The return value is a float4 with the values float3(hour, minute, second).
            float3 AudioLinkGetTimeOfDay()
            {
                float value = AudioLinkDecodeDataAsSeconds(ALPASS_GENERALVU_UNIX_SECONDS);
                float hour = floor(value / 3600.0);
                float minute = floor(value / 60.0) % 60.0;
                float second = value % 60.0;
                return float3(hour, minute, second);
            }
        
            // Get a character from a globally synced string, given an index of string in range [0; 3], and
            // a character index in range [0; 31]. The string at the 0th index is the local player name.
            // The 1st index is the master name, and index 2 and 3 are custom strings.
            // Returns a unsigned integer represented a unicode codepoint, i.e. UTF32.
            uint AudioLinkGetGlobalStringChar(uint stringIndex, uint charIndex)
            {
                uint4 fourChars = asuint(AudioLinkData(ALPASS_GLOBAL_STRINGS + uint2(charIndex / 4, stringIndex)));
                return fourChars[charIndex % 4];
            }
        
            // Get a character from the local player name given a character index in the range [0; 31].
            // Returns a unsigned integer represented a unicode codepoint, i.e. UTF32.
            uint AudioLinkGetLocalPlayerNameChar(uint charIndex)
            {
                return AudioLinkGetGlobalStringChar(AUDIOLINK_STRING_LOCALPLAYER, charIndex);
            }
        
            // Get a character from the master player name given a character index in the range [0; 31].
            // Returns a unsigned integer represented a unicode codepoint, i.e. UTF32.
            uint AudioLinkGetMasterNameChar(uint charIndex)
            {
                return AudioLinkGetGlobalStringChar(AUDIOLINK_STRING_MASTER, charIndex);
            }
        
            // Get a character from the first custom string given a character index in the range [0; 31].
            // Returns a unsigned integer represented a unicode codepoint, i.e. UTF32.
            uint AudioLinkGetCustomString1Char(uint charIndex)
            {
                return AudioLinkGetGlobalStringChar(AUDIOLINK_STRING_CUSTOM1, charIndex);
            }
        
            // Get a character from the second custom string given a character index in the range [0; 31].
            // Returns a unsigned integer represented a unicode codepoint, i.e. UTF32.
            uint AudioLinkGetCustomString2Char(uint charIndex)
            {
                return AudioLinkGetGlobalStringChar(AUDIOLINK_STRING_CUSTOM2, charIndex);
            }
        
            // Returns the position of the AudioLink AudioSource in world space.
            float4 AudioLinkGetAudioSourcePosition()
            {
                return float4(AudioLinkData(ALPASS_GENERALVU_SOURCE_POS).xyz,1);
            }
        #endif
        
        // Parts of the source taken from
        // [Xiexe-Unity-Shaders](https://github.com/Xiexe/Xiexes-Unity-Shaders) (c) Xiexe (MIT)
        // [z3y shaders](https://github.com/z3y/shaders) (c) z3y (MIT)
        
        // Default shading mode
        float D_GGX(float NoH, float roughness)
        {
            float a = NoH * roughness;
            float k = roughness / (1.0 - NoH * NoH + a * a);
            return k * k * (1.0 / UNITY_PI);
        }
        
        half D_GGX_Anisotropic(half NoH, const half3 h, const half3 t, const half3 b, half at, half ab)
        {
            half ToH = dot(t, h);
            half BoH = dot(b, h);
            half a2 = at * ab;
            half3 v = half3(ab * ToH, at * BoH, a2 * NoH);
            half v2 = dot(v, v);
            half w2 = a2 / v2;
            return a2 * w2 * w2 * (1.0 / UNITY_PI);
        }
        
        half V_SmithGGXCorrelated(half NoV, half NoL, half roughness)
        {
            half a2 = roughness * roughness;
            half GGXV = NoL * sqrt(NoV * NoV * (1.0 - a2) + a2);
            half GGXL = NoV * sqrt(NoL * NoL * (1.0 - a2) + a2);
            return 0.5 / (GGXV + GGXL);
        }
        
        // Clear Coat visibility
        float V_Kelemen(float LoH) {
            // Kelemen 2001, "A Microfacet Based Coupled Specular-Matte BRDF Model with Importance Sampling"
            return min((0.25 / (LoH * LoH)), 65504.0);
        }
        
        // Cloth shading mode
        half D_Ashikhmin(half roughness, half NoH) {
            // Ashikhmin 2007, "Distribution-based BRDFs"
            half a2 = roughness * roughness;
            half cos2h = NoH * NoH;
            half sin2h = max(1.0 - cos2h, 0.0078125); // 2^(-14/2), so sin2h^2 > 0 in fp16
            half sin4h = sin2h * sin2h;
            half cot2 = -cos2h / (a2 * sin2h);
            return 1.0 / (UNITY_PI * (4.0 * a2 + 1.0) * sin4h) * (4.0 * exp(cot2) + sin4h);
        }
        
        half D_Charlie(half roughness, half NoH) {
            // Estevez and Kulla 2017, "Production Friendly Microfacet Sheen BRDF"
            half invAlpha  = 1.0 / roughness;
            half cos2h = NoH * NoH;
            half sin2h = max(1.0 - cos2h, 0.0078125); // 2^(-14/2), so sin2h^2 > 0 in fp16
            return (2.0 + invAlpha) * pow(sin2h, invAlpha * 0.5) / (2.0 * UNITY_PI);
        }
        
        half V_Neubelt(half NoV, half NoL) {
            // Neubelt and Pettineo 2013, "Crafting a Next-gen Material Pipeline for The Order: 1886"
            return min(1.0 / (4.0 * (NoL + NoV - NoL * NoV)), 65504.0);
        }
        
        float Fd_Wrap(float NoL, float w) {
            return saturate((NoL + w) / ((1.0 + w) * (1.0 + w)));
        }
        
        half3 F_Schlick(half u, half3 f0)
        {
            return f0 + (1.0 - f0) * pow(1.0 - u, 5.0);
        }
        
        half3 F_Schlick(half3 f0, half f90, half VoH)
        {
            // Schlick 1994, "An Inexpensive BRDF Model for Physically-Based Rendering"
            return f0 + (f90 - f0) * pow(1.0 - VoH, 5);
        }
        
        float F_Schlick(float f0, float f90, float VoH) {
            return f0 + (f90 - f0) * pow5(1.0 - VoH);
        }
        
        half3 fresnel(half3 f0, half LoH)
        {
            half f90 = saturate(dot(f0, half(50.0 / 3).xxx));
            return F_Schlick(f0, f90, LoH);
        }
        
        half Fd_Burley(half perceptualRoughness, half NoV, half NoL, half LoH)
        {
            // Burley 2012, "Physically-Based Shading at Disney"
            half f90 = 0.5 + 2.0 * perceptualRoughness * LoH * LoH;
            half lightScatter = F_Schlick(1.0, f90, NoL);
            half viewScatter = F_Schlick(1.0, f90, NoV);
            return lightScatter * viewScatter;
        }
        
        // These are taken from David M's improved box projection code https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections
        //SOURCE - https://github.com/Unity-Technologies/Graphics/blob/504e639c4e07492f74716f36acf7aad0294af16e/Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightEvaluation.hlsl
        //From Moving Frostbite to PBR document
        //This function fakes the roughness based integration of reflection probes by adjusting the roughness value
        //NOTE: Untouched from HDRP
        float ComputeDistanceBaseRoughness(float distanceIntersectionToShadedPoint, float distanceIntersectionToProbeCenter, float perceptualRoughness)
        {
            float newPerceptualRoughness = clamp(distanceIntersectionToShadedPoint / distanceIntersectionToProbeCenter * perceptualRoughness, 0, perceptualRoughness);
            return lerp(newPerceptualRoughness, perceptualRoughness, perceptualRoughness);
        }
        
        //SOURCE - https://github.com/Unity-Technologies/Graphics/blob/504e639c4e07492f74716f36acf7aad0294af16e/Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl#L78
        //This simplified version assume that we care about the result only when we are inside the box
        //NOTE: Untouched from HDRP
        float IntersectRayAABBSimple(float3 start, float3 dir, float3 boxMin, float3 boxMax)
        {
            float3 invDir = rcp(dir);
        
            // Find the ray intersection with box plane
            float3 rbmin = (boxMin - start) * invDir;
            float3 rbmax = (boxMax - start) * invDir;
        
            float3 rbminmax = float3((dir.x > 0.0) ? rbmax.x : rbmin.x, (dir.y > 0.0) ? rbmax.y : rbmin.y, (dir.z > 0.0) ? rbmax.z : rbmin.z);
        
            return min(min(rbminmax.x, rbminmax.y), rbminmax.z);
        }
        
        //SOURCE - https://github.com/Unity-Technologies/Graphics/blob/504e639c4e07492f74716f36acf7aad0294af16e/Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightEvaluation.hlsl
        //return projectionDistance, can be used in ComputeDistanceBaseRoughness formula
        //return in R the unormalized corrected direction which is used to fetch cubemap but also its length represent the distance of the capture point to the intersection
        //Length R can be reuse as a parameter of ComputeDistanceBaseRoughness for distIntersectionToProbeCenter
        //NOTE: Modified to be much simpler, and to work with the Built-In Render Pipeline (BIRP)
        float EvaluateLight_EnvIntersection(float3 worldSpacePosition, inout float3 R, float4 probePosition, float4 boxMin, float4 boxMax)
        {
            float projectionDistance = IntersectRayAABBSimple(worldSpacePosition, R, boxMin.xyz, boxMax.xyz);
        
            R = (worldSpacePosition + projectionDistance * R) - probePosition.xyz;
        
            return projectionDistance;
        }
        
        half3 getBoxProjection(half3 direction, half3 position, half4 cubemapPosition, half3 boxMin, half3 boxMax)
        {
            #if defined(UNITY_SPECCUBE_BOX_PROJECTION) && !defined(UNITY_PBS_USE_BRDF2) || defined(FORCE_BOX_PROJECTION)
            if (cubemapPosition.w > 0)
            {
                half3 factors = ((direction > 0 ? boxMax : boxMin) - position) / direction;
                half scalar = min(min(factors.x, factors.y), factors.z);
                direction = direction * scalar + (position - cubemapPosition.xyz);
            }
            #endif
        
            return direction;
        }
        
        half3 getEnvReflectionDirect(float3 reflDir, half3 worldSpacePosition, half3 normal, half roughness, int mip, inout half4 rawProbe0)
        {
            half3 env = 0;
        
            float mipLevel = (float) mip;
            if (mip == -1)
            {
                mipLevel = perceptualRoughnessToMipmapLevel(roughness*(1.7 - 0.7*roughness));
            }
        
            half3 reflectionUV1 = getBoxProjection(reflDir, worldSpacePosition, unity_SpecCube0_ProbePosition, unity_SpecCube0_BoxMin.xyz, unity_SpecCube0_BoxMax.xyz);
            half4 probe0 = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflectionUV1, mipLevel);
            rawProbe0 = probe0;
            half3 probe0sample = DecodeHDR(probe0, unity_SpecCube0_HDR);
        
            half3 indirectSpecular;
            half interpolator = unity_SpecCube0_BoxMin.w;
        
            indirectSpecular = probe0sample;
        
            #if defined(UNITY_SPECCUBE_BLENDING) || defined(FORCE_BOX_PROJECTION)
            UNITY_BRANCH
            if (interpolator < 0.99999)
            {
                half3 reflectionUV2 = getBoxProjection(reflDir, worldSpacePosition, unity_SpecCube1_ProbePosition, unity_SpecCube1_BoxMin.xyz, unity_SpecCube1_BoxMax.xyz);
                half4 probe1 = UNITY_SAMPLE_TEXCUBE_SAMPLER_LOD(unity_SpecCube1, unity_SpecCube0, reflectionUV2, mipLevel);
                half3 probe1sample = DecodeHDR(probe1, unity_SpecCube1_HDR);
                indirectSpecular = lerp(probe1sample, probe0sample, interpolator);
            }
            #endif
        
            env = indirectSpecular;
            return env;
        }
        
        half3 getEnvReflectionDirect(float3 reflDir, half3 worldSpacePosition, half3 normal, half roughness, int mip)
        {
            half4 rawProbe0;
            return getEnvReflectionDirect(reflDir, worldSpacePosition, normal, roughness, mip, rawProbe0);
        }
        
        half3 getEnvReflectionHardened(float3 reflDir, half3 worldSpacePosition, half roughness, half hardenStrength)
        {
            float3 boxProjectedReflDir = reflDir;
            float projectionDistance = EvaluateLight_EnvIntersection(worldSpacePosition, boxProjectedReflDir, unity_SpecCube0_ProbePosition, unity_SpecCube0_BoxMin, unity_SpecCube0_BoxMax);
            float distanceBasedRoughness = ComputeDistanceBaseRoughness(projectionDistance, length(boxProjectedReflDir), roughness);
        
            distanceBasedRoughness = lerp(roughness, distanceBasedRoughness, hardenStrength);
            float mipLevel = perceptualRoughnessToMipmapLevel(distanceBasedRoughness * (1.7 - 0.7 * distanceBasedRoughness));
        
            half4 probe0data = SAMPLE_TEXTURECUBE_LOD(unity_SpecCube0, samplerunity_SpecCube0, boxProjectedReflDir, mipLevel);
            half3 probe0 = DecodeHDR(probe0data, unity_SpecCube0_HDR);
        
            half3 indirectSpecular = probe0;
        
        
            #if defined(UNITY_SPECCUBE_BLENDING) || defined(FORCE_BOX_PROJECTION)
            UNITY_BRANCH
            if (unity_SpecCube0_BoxMin.w < 0.99999)
            {
                boxProjectedReflDir = reflDir;
                distanceBasedRoughness = roughness;
                if (unity_SpecCube1_ProbePosition.w > 0)
                {
                    projectionDistance = EvaluateLight_EnvIntersection(worldSpacePosition, boxProjectedReflDir, unity_SpecCube1_ProbePosition, unity_SpecCube1_BoxMin, unity_SpecCube1_BoxMax);
                    distanceBasedRoughness = ComputeDistanceBaseRoughness(projectionDistance, length(boxProjectedReflDir), roughness);
                    distanceBasedRoughness = lerp(roughness, distanceBasedRoughness, hardenStrength);
                }
        
                mipLevel = perceptualRoughnessToMipmapLevel(distanceBasedRoughness * (1.7 - 0.7 * distanceBasedRoughness));
                half4 probe1data = SAMPLE_TEXTURECUBE_LOD(unity_SpecCube1, samplerunity_SpecCube0, boxProjectedReflDir, mipLevel);
                half3 probe1 = DecodeHDR(probe1data, unity_SpecCube1_HDR);
        
                indirectSpecular = lerp(probe1, probe0, unity_SpecCube0_BoxMin.w);
            }
            #endif
            return indirectSpecular;
        }
        
        half3 getEnvReflection(half3 worldSpaceViewDir, half3 worldSpacePosition, half3 normal, half smoothness)
        {
            float3 reflDir = reflect(worldSpaceViewDir, normal);
            half perceptualRoughness = 1 - smoothness;
            reflDir = lerp(reflDir, normal, max(perceptualRoughness * perceptualRoughness, 0.002));
            perceptualRoughness = perceptualRoughness * (1.7 - 0.7 * perceptualRoughness);
        
            return getEnvReflectionDirect(reflDir, worldSpacePosition, normal, perceptualRoughness, -1);
        }
        
        half3 getEnvReflection(half3 worldSpaceViewDir, half3 worldSpacePosition, half3 normal, half smoothness, int mip)
        {
            float3 reflDir = reflect(worldSpaceViewDir, normal);
            half perceptualRoughness = 1 - smoothness;
            reflDir = lerp(reflDir, normal, max(perceptualRoughness * perceptualRoughness, 0.002));
            perceptualRoughness = perceptualRoughness * (1.7 - 0.7 * perceptualRoughness);
        
            return getEnvReflectionDirect(reflDir, worldSpacePosition, normal, perceptualRoughness, mip);
        }
        
        half3 EnvBRDFMultiscatter(half2 dfg, half3 f0)
        {
            return lerp(dfg.xxx, dfg.yyy, f0);
        }
        
        half3 EnvBRDFApprox(half perceptualRoughness, half NoV, half3 f0)
        {
            half g = 1 - perceptualRoughness;
            //https://blog.selfshadow.com/publications/s2013-shading-course/lazarov/s2013_pbs_black_ops_2_notes.pdf
            half4 t = half4(1 / 0.96, 0.475, (0.0275 - 0.25 * 0.04) / 0.96, 0.25);
            t *= half4(g, g, g, g);
            t += half4(0, 0, (0.015 - 0.75 * 0.04) / 0.96, 0.75);
            half a0 = t.x * min(t.y, exp2(-9.28 * NoV)) + t.z;
            half a1 = t.w;
            return saturate(lerp(a0, a1, f0));
        }
        
        half GSAA_Filament(half3 worldNormal, half perceptualRoughness, half inputVariance, half threshold)
        {
            // Kaplanyan 2016, "Stable specular highlights"
            // Tokuyoshi 2017, "Error Reduction and Simplification for Shading Anti-Aliasing"
            // Tokuyoshi and Kaplanyan 2019, "Improved Geometric Specular Antialiasing"
        
            // This implementation is meant for deferred rendering in the original paper but
            // we use it in forward rendering as well (as discussed in Tokuyoshi and Kaplanyan
            // 2019). The main reason is that the forward version requires an expensive transform
            // of the half vector by the tangent frame for every light. This is therefore an
            // approximation but it works well enough for our needs and provides an improvement
            // over our original implementation based on Vlachos 2015, "Advanced VR Rendering".
        
            half3 du = ddx(worldNormal);
            half3 dv = ddy(worldNormal);
        
            half variance = inputVariance * (dot(du, du) + dot(dv, dv));
        
            half roughness = perceptualRoughness * perceptualRoughness;
            half kernelRoughness = min(2.0 * variance, threshold);
            half squareRoughness = saturate(roughness * roughness + kernelRoughness);
        
            return sqrt(sqrt(squareRoughness));
        }
        
        //https://ndotl.wordpress.com/2018/08/29/baking-artifact-free-lightmaps
        half3 tex2DFastBicubicLightmap(half2 uv, inout half4 bakedColorTex)
        {
            #if !defined(PLAT_QUEST) && defined(BICUBIC_LIGHTMAP)
            half width;
            half height;
            unity_Lightmap.GetDimensions(width, height);
            half x = uv.x * width;
            half y = uv.y * height;
        
        
        
            x -= 0.5f;
            y -= 0.5f;
            half px = floor(x);
            half py = floor(y);
            half fx = x - px;
            half fy = y - py;
        
            // note: we could store these functions in a lookup table texture, but maths is cheap
            half g0x = g0(fx);
            half g1x = g1(fx);
            half h0x = h0(fx);
            half h1x = h1(fx);
            half h0y = h0(fy);
            half h1y = h1(fy);
        
            half4 r = g0(fy) * (g0x * UNITY_SAMPLE_TEX2D(unity_Lightmap, (half2(px + h0x, py + h0y) * 1.0f / width)) +
            g1x * UNITY_SAMPLE_TEX2D(unity_Lightmap, (half2(px + h1x, py + h0y) * 1.0f / width))) +
            g1(fy) * (g0x * UNITY_SAMPLE_TEX2D(unity_Lightmap, (half2(px + h0x, py + h1y) * 1.0f / width)) +
            g1x * UNITY_SAMPLE_TEX2D(unity_Lightmap, (half2(px + h1x, py + h1y) * 1.0f / width)));
            bakedColorTex = r;
            return DecodeLightmap(r);
            #else
            bakedColorTex = UNITY_SAMPLE_TEX2D(unity_Lightmap, uv);
            return DecodeLightmap(bakedColorTex);
            #endif
        }
        
        half3 GetSpecularHighlights(half3 lightColor, half3 f0, float3 worldNormal, float3 halfVector, half LoH, half NoL, half NoV, half roughness, half3 energyCompensation)
        {
            half NoH = saturate(dot(worldNormal, halfVector));
            half3 F = F_Schlick(LoH, f0);
            float D = D_GGX(NoH, roughness);
            half V = V_SmithGGXCorrelated(NoV, NoL, roughness);
            F *= energyCompensation;
        
            return max(0, D * V * F) * lightColor * UNITY_PI;
        }
        
        half3 GetSpecularHighlightsAnisotropic(half3 lightColor, half3 f0, float3 worldNormal, float3 worldTangent, float3 bitangent, float3 halfVector, half LoH, half NoL, half NoV, half roughness, half3 energyCompensation, half anisotropy)
        {
            half NoH = saturate(dot(worldNormal, halfVector));
            half3 F = F_Schlick(LoH, f0);
            float at = max(roughness * (1.0 + anisotropy), 0.001);
            float ab = max(roughness * (1.0 - anisotropy), 0.001);
            float D = D_GGX_Anisotropic(NoH, halfVector, worldTangent, bitangent, at, ab);
            half V = V_SmithGGXCorrelated(NoV, NoL, roughness);
            F *= energyCompensation;
        
            return max(0, D * V * F) * lightColor * UNITY_PI;
        }
        
        half3 GetSpecularHighlightsClearCoat(half3 lightColor, half3 f0, float3 worldNormal, float3 halfVector, half LoH, half roughness, half strength, inout half clearCoatAttenuation)
        {
            half NoH = saturate(dot(worldNormal, halfVector));
            half3 F = F_Schlick(0.04, 1.0, LoH) * strength;
            float D = D_GGX(NoH, roughness);
            half V = V_Kelemen(LoH);
        
            clearCoatAttenuation = 1.0 - F;
        
            return max(0, D * V * F) * lightColor * UNITY_PI;
        }
        
        half3 GetSpecularHighlightsCloth(half3 lightColor, float3 worldNormal, float3 halfVector, half NoL, half NoV, half roughness, half3 energyCompensation, half3 albedoSqrt, int customSheen, half3 sheenColor)
        {
            half NoH = saturate(dot(worldNormal, halfVector));
            half3 F = customSheen ? sheenColor : albedoSqrt;
            float D = D_Charlie(roughness, NoH);
            half V = V_Neubelt(NoV, NoL);
        
            return max(0, D * V * F) * lightColor * UNITY_PI;
        }
        
        half3 GetSpecularHighlights(float3 worldNormal, half3 lightColor, float3 lightDirection, half3 f0, float3 viewDir, half clampedRoughness, half NoV, half3 energyCompensation)
        {
            float3 halfVector = Unity_SafeNormalize(lightDirection + viewDir);
        
            half NoH = saturate(dot(worldNormal, halfVector));
            half NoL = saturate(dot(worldNormal, lightDirection));
            half LoH = saturate(dot(lightDirection, halfVector));
        
            half3 F = F_Schlick(LoH, f0);
            float D = D_GGX(NoH, clampedRoughness);
            half V = V_SmithGGXCorrelated(NoV, NoL, clampedRoughness);
        
            #ifndef UNITY_PBS_USE_BRDF2
            F *= energyCompensation;
            #endif
        
            return max(0, (D * V) * F) * lightColor * NoL * UNITY_PI;
        }
        
        half3 GetSpecularHighlightsCloth(float3 worldNormal, half3 lightColor, float3 lightDirection, half3 f0, float3 viewDir, half clampedRoughness, half NoV, half3 albedoSqrt, int customSheen, half3 sheenColor)
        {
            float3 halfVector = Unity_SafeNormalize(lightDirection + viewDir);
        
            half NoH = saturate(dot(worldNormal, halfVector));
            half NoL = saturate(dot(worldNormal, lightDirection));
            half LoH = saturate(dot(lightDirection, halfVector));
        
            half3 F = customSheen ? sheenColor : albedoSqrt;
            float D = D_Charlie(clampedRoughness, NoH);
            half V = V_Neubelt(NoV, NoL);
        
            return max(0, (D * V) * F) * lightColor * NoL * UNITY_PI;
        }
        
        #ifdef DYNAMICLIGHTMAP_ON
        half3 getRealtimeLightmap(half2 uv, half3 worldNormal)
        {
            half2 realtimeUV = uv;
            half4 bakedCol = tex2DFastBicubicSample(TEXTURE2D_ARGS(unity_DynamicLightmap, samplerunity_DynamicLightmap), realtimeUV);
            half3 realtimeLightmap = DecodeRealtimeLightmap(bakedCol);
        
            #ifdef DIRLIGHTMAP_COMBINED
            half4 realtimeDirTex = tex2DFastBicubicSample(TEXTURE2D_ARGS(unity_DynamicDirectionality, samplerunity_DynamicLightmap), realtimeUV);
            realtimeLightmap += DecodeDirectionalLightmap(realtimeLightmap, realtimeDirTex, worldNormal);
            #endif
        
            return realtimeLightmap;
        }
        #endif
        
        #ifdef DYNAMICLIGHTMAP_ON
        half3 getRealtimeLightmap(half2 uv, half3 worldNormal, int disableBicubic)
        {
            half2 realtimeUV = uv;
            half4 bakedCol;
        
            // Sample main lightmap
            #if defined(BICUBIC_LIGHTMAP)
            [branch]
            if (disableBicubic)
            {
                bakedCol = SAMPLE_TEXTURE2D(unity_DynamicLightmap, samplerunity_DynamicLightmap, realtimeUV);
            } else {
                bakedCol = tex2DFastBicubicSample(TEXTURE2D_ARGS(unity_DynamicLightmap, samplerunity_DynamicLightmap), realtimeUV);
            }
            #else
            bakedCol = SAMPLE_TEXTURE2D(unity_DynamicLightmap, samplerunity_DynamicLightmap, realtimeUV);
            #endif
            half3 realtimeLightmap = DecodeRealtimeLightmap(bakedCol);
        
            // Sample directional lightmap
            #ifdef DIRLIGHTMAP_COMBINED
            {
                half4 realtimeDirTex;
                #if defined(BICUBIC_LIGHTMAP)
                [branch]
                if (disableBicubic)
                {
                    realtimeDirTex = SAMPLE_TEXTURE2D(unity_DynamicDirectionality, samplerunity_DynamicLightmap, realtimeUV);
                } else {
                    realtimeDirTex = tex2DFastBicubicSample(TEXTURE2D_ARGS(unity_DynamicDirectionality, samplerunity_DynamicLightmap), realtimeUV);
                }
                #else
                realtimeDirTex = SAMPLE_TEXTURE2D(unity_DynamicDirectionality, samplerunity_DynamicLightmap, realtimeUV);
                #endif
                realtimeLightmap += DecodeDirectionalLightmap(realtimeLightmap, realtimeDirTex, worldNormal);
            }
            #endif
        
            return realtimeLightmap;
        }
        #endif
        
        half computeSpecularAO(half NoV, half ao, half roughness)
        {
            return saturate(pow(NoV + ao, exp2(-16.0 * roughness - 1.0)) - 1.0 + ao);
        }
        
        half3 gtaoMultiBounce(half visibility, half3 albedo) {
            // Jimenez et al. 2016, "Practical Realtime Strategies for Accurate Indirect Occlusion"
            half3 a =  2.0404 * albedo - 0.3324;
            half3 b = -4.7951 * albedo + 0.6417;
            half3 c =  2.7552 * albedo + 0.6903;
        
            return max((visibility), ((visibility * a + b) * visibility + c) * visibility);
        }
        
        half shEvaluateDiffuseL1Geomerics(half L0, half3 L1, float3 n)
        {
            // average energy
            half R0 = max(0,L0);
        
            // avg direction of incoming light
            half3 R1 = 0.5f * L1;
        
            // directional brightness
            half lenR1 = length(R1);
        
            // linear angle between normal and direction 0-1
            //half q = 0.5f * (1.0f + dot(R1 / lenR1, n));
            //half q = dot(R1 / lenR1, n) * 0.5 + 0.5;
            half q = dot(normalize(R1), n) * 0.5 + 0.5;
            q = isnan(q) ? 1 : q;
            q = saturate(q); // Thanks to ScruffyRuffles for the bug identity.
        
            // power for q
            // lerps from 1 (linear) to 3 (cubic) based on directionality
            half p = 1.0f + 2.0f * (lenR1 / R0);
        
            // dynamic range constant
            // should vary between 4 (highly directional) and 0 (ambient)
            half a = (1.0f - lenR1 / R0) / (1.0f + lenR1 / R0);
        
            return max(0, R0 * (a + (1.0f - a) * (p + 1.0f) * pow(q, p)));
        }
        
        half3 GetNonLinearSH(half3 L0, half3 L1r, half3 L1g, half3 L1b, float3 n)
        {
            half3 result;
            result.r = shEvaluateDiffuseL1Geomerics(L0.r, L1r.xyz, n);
            result.g = shEvaluateDiffuseL1Geomerics(L0.g, L1g.xyz, n);
            result.b = shEvaluateDiffuseL1Geomerics(L0.b, L1b.xyz, n);
            return result;
        }
        
        // Based on bakery's suggestion - use multiply instead of min for the darkest color
        half3 SubtractMainLightWithRealtimeAttenuationFromLightmapMultiply(half3 lightmap, half attenuation, half4 bakedColorTex, half3 normalWorld)
        {
            // Let's try to make realtime shadows work on a surface, which already contains
            // baked lighting and shadowing from the main sun light.
            half3 shadowColor = unity_ShadowColor.rgb;
            half shadowStrength = _LightShadowData.x;
        
            // Summary:
            // 1) Calculate possible value in the shadow by subtracting estimated light contribution from the places occluded by realtime shadow:
            //      a) preserves other baked lights and light bounces
            //      b) eliminates shadows on the geometry facing away from the light
            // 2) Clamp against user defined ShadowColor.
            // 3) Pick original lightmap value, if it is the darkest one.
        
        
            // 1) Gives good estimate of illumination as if light would've been shadowed during the bake.
            //    Preserves bounce and other baked lights
            //    No shadows on the geometry facing away from the light
            half ndotl = LambertTerm (normalWorld, _WorldSpaceLightPos0.xyz);
            half3 estimatedLightContributionMaskedByInverseOfShadow = ndotl * (1- attenuation) * _LightColor0.rgb;
            half3 subtractedLightmap = lightmap - estimatedLightContributionMaskedByInverseOfShadow;
        
            // 2) Allows user to define overall ambient of the scene and control situation when realtime shadow becomes too dark.
            half3 realtimeShadow = max(subtractedLightmap, shadowColor);
            realtimeShadow = lerp(realtimeShadow, lightmap, shadowStrength);
        
            // 3) Pick darkest color
            return lightmap * realtimeShadow;
        }
        
        float4x4 getVertexLightsDir(float3 worldPos) {
            float3 toLightX = float3(unity_4LightPosX0.x, unity_4LightPosY0.x, unity_4LightPosZ0.x);
            float3 toLightY = float3(unity_4LightPosX0.y, unity_4LightPosY0.y, unity_4LightPosZ0.y);
            float3 toLightZ = float3(unity_4LightPosX0.z, unity_4LightPosY0.z, unity_4LightPosZ0.z);
            float3 toLightW = float3(unity_4LightPosX0.w, unity_4LightPosY0.w, unity_4LightPosZ0.w);
        
            float3 dirX = normalize(toLightX - worldPos);
            float3 dirY = length(toLightY) > 0 ? normalize(toLightY - worldPos) : 0;
            float3 dirZ = length(toLightZ) > 0 ? normalize(toLightZ - worldPos) : 0;
            float3 dirW = length(toLightW) > 0 ? normalize(toLightW - worldPos) : 0;
        
            float4x4 retval = 0;
                retval[0] = float4(dirX, 0);
                retval[1] = float4(dirY, 0);
                retval[2] = float4(dirZ, 0);
                retval[3] = float4(dirW, 0);
            return retval;
        }
        
        float4x4 getVertexLightsColors(float3 worldPos, float3 normal, bool usendl = true)
        {
            float4 toLightX = unity_4LightPosX0 - worldPos.x;
            float4 toLightY = unity_4LightPosY0 - worldPos.y;
            float4 toLightZ = unity_4LightPosZ0 - worldPos.z;
        
            float4 lengthSq = 0;
            lengthSq += toLightX * toLightX;
            lengthSq += toLightY * toLightY;
            lengthSq += toLightZ * toLightZ;
            lengthSq = max(lengthSq, 0.000001);
        
            float4 ndl = 0;
            UNITY_BRANCH
            if (usendl) {
                ndl += toLightX * normal.x;
                ndl += toLightY * normal.y;
                ndl += toLightZ * normal.z;
                ndl = max (float4(0,0,0,0), ndl * rsqrt(lengthSq));
                ndl = ndl*0.5+0.5;
            }
        
            float4 atten = 1.0 / (1.0 + lengthSq * unity_4LightAtten0);
            float4 atten2 = saturate(1 - (unity_4LightAtten0 * lengthSq / 25)); // Black magic
            atten = min(atten, atten2 * atten2); // more black magic
            atten *= usendl ? ndl : 1;
        
            float4x4 retval = 0;
                retval[0] = unity_LightColor[0] * atten.x;
                retval[1] = unity_LightColor[1] * atten.y;
                retval[2] = unity_LightColor[2] * atten.z;
                retval[3] = unity_LightColor[3] * atten.w;
            return retval;
        }
        
        float4x4 getVertexLightsColors(float3 worldPos, float3 normal, out float4 attenuation, bool usendl = true)
        {
            float4 toLightX = unity_4LightPosX0 - worldPos.x;
            float4 toLightY = unity_4LightPosY0 - worldPos.y;
            float4 toLightZ = unity_4LightPosZ0 - worldPos.z;
        
            float4 lengthSq = 0;
            lengthSq += toLightX * toLightX;
            lengthSq += toLightY * toLightY;
            lengthSq += toLightZ * toLightZ;
            lengthSq = max(lengthSq, 0.000001);
        
            float4 ndl = 0;
            UNITY_BRANCH
            if (usendl) {
                ndl += toLightX * normal.x;
                ndl += toLightY * normal.y;
                ndl += toLightZ * normal.z;
                ndl = max (float4(0,0,0,0), ndl * rsqrt(lengthSq));
                ndl = ndl*0.5+0.5;
            }
        
            float4 atten = 1.0 / (1.0 + lengthSq * unity_4LightAtten0);
            float4 atten2 = saturate(1 - (unity_4LightAtten0 * lengthSq / 25)); // Black magic
            atten = min(atten, atten2 * atten2); // more black magic
            atten *= usendl ? ndl : 1;
        
            attenuation = atten;
        
            float4x4 retval = 0;
                retval[0] = unity_LightColor[0] * atten.x;
                retval[1] = unity_LightColor[1] * atten.y;
                retval[2] = unity_LightColor[2] * atten.z;
                retval[3] = unity_LightColor[3] * atten.w;
            return retval;
        }
        
        float4 getVertexLightRanges()
        {
            float4 ranges = 5.0 * (1.0 / sqrt(unity_4LightAtten0.xyzw));
        
            if (all(!isnan(ranges))) return ranges;
        
            return float4(
                isnan(ranges.x) ? 0.0 : ranges.x,
                isnan(ranges.y) ? 0.0 : ranges.y,
                isnan(ranges.z) ? 0.0 : ranges.z,
                isnan(ranges.w) ? 0.0 : ranges.w
            );
        }
        
        // Taken from Poiyomi Toon Shader
        // https://github.com/poiyomi/PoiyomiToonShader
        // MIT License
        
        // Copyright (c) 2023 Poiyomi Inc.
        
        // Permission is hereby granted, free of charge, to any person obtaining a copy
        // of this software and associated documentation files (the "Software"), to deal
        // in the Software without restriction, including without limitation the rights
        // to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        // copies of the Software, and to permit persons to whom the Software is
        // furnished to do so, subject to the following conditions:
        
        // The above copyright notice and this permission notice shall be included in all
        // copies or substantial portions of the Software.
        
        // THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        // IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        // FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        // AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        // LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        // SOFTWARE.
        
        void ApplyUnityFog(float2 fogData, inout half4 FinalColor)
        {
            float fogFactor = 1.0;
            float depth = UNITY_Z_0_FAR_FROM_CLIPSPACE(fogData.x);
        
            // Is Linear fog active?
            if (unity_FogParams.z != unity_FogParams.w)
            {
                fogFactor = depth * unity_FogParams.z + unity_FogParams.w;
            }
            else if (fogData.y)
            {
                float exponent_val = unity_FogParams.x * depth;
                fogFactor = exp2(-exponent_val * exponent_val);
            }
            else if (unity_FogParams.y != 0.0f)
            {
                float exponent = unity_FogParams.y * depth;
                fogFactor = exp2(-exponent);
            }
        
            fixed3 appliedFogColor = unity_FogColor.rgb;
        
            #if defined(UNITY_PASS_FORWARDADD)
            appliedFogColor = fixed3(0, 0, 0);
            #endif
        
            FinalColor.rgb = lerp(appliedFogColor, FinalColor.rgb, saturate(fogFactor));
        }
        
        // https://assetstore.unity.com/packages/tools/level-design/bakery-gpu-lightmapper-122218
        
        #if defined(BAKERY_ENABLED)
        
        //float2 bakeryLightmapSize;
        #define BAKERYMODE_DEFAULT 0
        #define BAKERYMODE_VERTEXLM 1.0f
        #define BAKERYMODE_RNM 2.0f
        #define BAKERYMODE_SH 3.0f
        
        #define rnmBasis0 float3(0.816496580927726f, 0, 0.5773502691896258f)
        #define rnmBasis1 float3(-0.4082482904638631f, 0.7071067811865475f, 0.5773502691896258f)
        #define rnmBasis2 float3(-0.4082482904638631f, -0.7071067811865475f, 0.5773502691896258f)
        
        #if defined(BAKERY_DOMINANT)
          #undef BAKERY_RNM
          #undef BAKERY_SH
          #undef BAKERY_MONOSH
        #endif
        
        #ifdef BICUBIC_LIGHTMAP
            #define BAKERY_BICUBIC
        #endif
        
        //#define BAKERY_SSBUMP
        
        // can't fit vertexLM SH to sm3_0 interpolators
        #ifndef SHADER_API_D3D11
            #undef BAKERY_VERTEXLMSH
        #endif
        
        // can't do stuff on sm2_0 due to standard shader alrady taking up all instructions
        #if SHADER_TARGET < 30
            #undef BAKERY_BICUBIC
            #undef BAKERY_LMSPEC
        
            #undef BAKERY_RNM
            #undef BAKERY_SH
            #undef BAKERY_MONOSH
            #undef BAKERY_VERTEXLM
        #endif
        
        #if !defined(BAKERY_SH) && !defined(BAKERY_RNM)
            #undef BAKERY_BICUBIC
        #endif
        
        #ifndef UNITY_SHOULD_SAMPLE_SH
            #undef BAKERY_PROBESHNONLINEAR
        #endif
        
        #if defined(BAKERY_RNM) && defined(BAKERY_LMSPEC)
        #define BAKERY_RNMSPEC
        #endif
        
        #ifndef BAKERY_VERTEXLM
            #undef BAKERY_VERTEXLMDIR
            #undef BAKERY_VERTEXLMSH
            #undef BAKERY_VERTEXLMMASK
        #endif
        
        #define lumaConv float3(0.2125f, 0.7154f, 0.0721f)
        
        struct BakeryVolumeData
        {
            float3 L0;
            float3 L1x;
            float3 L1y;
            float3 L1z;
                
            float4 tex0;
            float4 tex1;
            float4 tex2;
            float4 tex3;
        
            float3 viewDir;
            float3 normal;
            float3 uv;
            float occlusion;
        };
        
        struct BakeryVolumeSpecularData
        {
            float3 direction;
            float3 color;
            float NoV;
        };
        
        #ifdef BAKERY_BICUBIC
        float BakeryBicubic_w0(float a)
        {
            return (1.0f/6.0f)*(a*(a*(-a + 3.0f) - 3.0f) + 1.0f);
        }
        
        float BakeryBicubic_w1(float a)
        {
            return (1.0f/6.0f)*(a*a*(3.0f*a - 6.0f) + 4.0f);
        }
        
        float BakeryBicubic_w2(float a)
        {
            return (1.0f/6.0f)*(a*(a*(-3.0f*a + 3.0f) + 3.0f) + 1.0f);
        }
        
        float BakeryBicubic_w3(float a)
        {
            return (1.0f/6.0f)*(a*a*a);
        }
        
        float BakeryBicubic_g0(float a)
        {
            return BakeryBicubic_w0(a) + BakeryBicubic_w1(a);
        }
        
        float BakeryBicubic_g1(float a)
        {
            return BakeryBicubic_w2(a) + BakeryBicubic_w3(a);
        }
        
        float BakeryBicubic_h0(float a)
        {
            return -1.0f + BakeryBicubic_w1(a) / (BakeryBicubic_w0(a) + BakeryBicubic_w1(a)) + 0.5f;
        }
        
        float BakeryBicubic_h1(float a)
        {
            return 1.0f + BakeryBicubic_w3(a) / (BakeryBicubic_w2(a) + BakeryBicubic_w3(a)) + 0.5f;
        }
        #endif
        
        #ifdef BAKERY_BICUBIC
            // Bicubic
            float4 BakeryTex2D(sampler2D tex, float2 uv, float4 texelSize)
            {
                float x = uv.x * texelSize.z;
                float y = uv.y * texelSize.z;
        
                x -= 0.5f;
                y -= 0.5f;
        
                float px = floor(x);
                float py = floor(y);
        
                float fx = x - px;
                float fy = y - py;
        
                float g0x = BakeryBicubic_g0(fx);
                float g1x = BakeryBicubic_g1(fx);
                float h0x = BakeryBicubic_h0(fx);
                float h1x = BakeryBicubic_h1(fx);
                float h0y = BakeryBicubic_h0(fy);
                float h1y = BakeryBicubic_h1(fy);
        
                return     BakeryBicubic_g0(fy) * ( g0x * tex2D(tex, (float2(px + h0x, py + h0y) * texelSize.x))   +
                                      g1x * tex2D(tex, (float2(px + h1x, py + h0y) * texelSize.x))) +
        
                           BakeryBicubic_g1(fy) * ( g0x * tex2D(tex, (float2(px + h0x, py + h1y) * texelSize.x))   +
                                      g1x * tex2D(tex, (float2(px + h1x, py + h1y) * texelSize.x)));
            }
            float4 BakeryTex2D(Texture2D tex, SamplerState s, float2 uv, float4 texelSize)
            {
                float x = uv.x * texelSize.z;
                float y = uv.y * texelSize.z;
        
                x -= 0.5f;
                y -= 0.5f;
        
                float px = floor(x);
                float py = floor(y);
        
                float fx = x - px;
                float fy = y - py;
        
                float g0x = BakeryBicubic_g0(fx);
                float g1x = BakeryBicubic_g1(fx);
                float h0x = BakeryBicubic_h0(fx);
                float h1x = BakeryBicubic_h1(fx);
                float h0y = BakeryBicubic_h0(fy);
                float h1y = BakeryBicubic_h1(fy);
        
                return     BakeryBicubic_g0(fy) * ( g0x * tex.Sample(s, (float2(px + h0x, py + h0y) * texelSize.x))   +
                                      g1x * tex.Sample(s, (float2(px + h1x, py + h0y) * texelSize.x))) +
        
                           BakeryBicubic_g1(fy) * ( g0x * tex.Sample(s, (float2(px + h0x, py + h1y) * texelSize.x))   +
                                      g1x * tex.Sample(s, (float2(px + h1x, py + h1y) * texelSize.x)));
            }
        #else
            // Bilinear
            float4 BakeryTex2D(sampler2D tex, float2 uv, float4 texelSize)
            {
                return tex2D(tex, uv);
            }
            float4 BakeryTex2D(Texture2D tex, SamplerState s, float2 uv, float4 texelSize)
            {
                return tex.Sample(s, uv);
            }
        #endif
        
        #endif
        //BAKERY_ENABLED
        ENDCG
        // Global Include End

        // PrePasses

        // Exra PrePasses

        Pass
        {
            Tags { "LightMode" = "ForwardBase"  }

            // ForwardBase Pass Start
            CGPROGRAM
            #pragma target 4.5
            #pragma multi_compile_instancing
            #pragma multi_compile_fwdbase
            #pragma multi_compile_vertex _ FOG_EXP2
            #pragma vertex Vertex
            #pragma fragment Fragment
            #pragma shader_feature_local_fragment _EMISSION
            
            #pragma shader_feature_local_fragment PARALLAX
            #pragma shader_feature_local_fragment _PARALLAXSTEPS_EIGHT _PARALLAXSTEPS_SIXTEEN _PARALLAXSTEPS_THIRTYTWO _PARALLAXSTEPS_SIXTYFOUR
            
            #pragma shader_feature_local_fragment DETAILS_OVERLAY
            #pragma shader_feature_local_fragment _ DETAILS_MODE_PACKED DETAILS_MODE_SEPARATED
            
            #pragma shader_feature_local_vertex VRC_FEATURES
            
               
             #pragma shader_feature_local_fragment VRCLIGHTVOLUMES
            
             // Global keyword to enable in the project
             #pragma shader_feature_fragment DISABLE_VRCLIGHTVOLUMES
            
            #pragma shader_feature_local_fragment _ AL_EFFECT_BAND_SELECTION AL_EFFECT_UV_BASED AL_EFFECT_WAVEFORM AL_EFFECT_PULSE AL_EFFECT_BAR
            
            #pragma shader_feature_local_fragment INTEGRATE_LTCGI
            
            #pragma shader_feature_local_fragment BAKERY_ENABLED
            #pragma shader_feature_local_fragment _ BAKERY_RNM BAKERY_SH BAKERY_MONOSH
            #pragma shader_feature_local_fragment BAKERY_SHNONLINEAR
            #pragma shader_feature_local_fragment BAKERY_VOLUME
            #pragma shader_feature_local_fragment BAKERY_COMPRESSED_VOLUME
            #pragma shader_feature_local_fragment BAKERY_VOLROTATIONY
            
            #pragma shader_feature_local_fragment BAKED_SPECULAR
            #pragma shader_feature_local_fragment GSAA
            #pragma shader_feature_local_fragment NONLINEAR_SH
            #pragma shader_feature_local_fragment SHADE_VERTEXLIGHTS
            #pragma shader_feature_local_fragment SHADING_MODE_DEFAULT SHADING_MODE_CLOTH
            #pragma shader_feature_local_fragment CLEARCOAT
                
            // PC Only Features
            #if !defined(UNITY_PBS_USE_BRDF2) && !defined(SHADER_API_MOBILE)
                #pragma shader_feature_local_fragment BICUBIC_LIGHTMAP
            #endif
            
            // Mobile Only Features
            #if defined(UNITY_PBS_USE_BRDF2) || defined(SHADER_API_MOBILE)
                #pragma shader_feature_local_fragment FORCE_BOX_PROJECTION
                #pragma shader_feature_local_fragment APPLY_COLOR_CORRECTION
                #pragma shader_feature_local_fragment MOBILE_TONEMAP_ACES MOBILE_TONEMAP_UNREAL MOBILE_TONEMAP_UNCHARTED
            #endif
            
            #if defined(SHADE_VERTEXLIGHTS)
                #pragma multi_compile_fragment _ VERTEXLIGHT_ON
            #endif
            
            #if !defined(MOBILE_TONEMAP_ACES) && !defined(MOBILE_TONEMAP_UNREAL) && !defined(MOBILE_TONEMAP_UNCHARTED)
                #define MOBILE_TONEMAP_ACES
            #endif

            #define UNITY_INSTANCED_LOD_FADE
            #define UNITY_INSTANCED_SH
            #define UNITY_INSTANCED_LIGHTMAPSTS

            #ifndef UNITY_PASS_FORWARDBASE
                #define UNITY_PASS_FORWARDBASE
            #endif

            // ShaderDefines
            #define _MASKMAP_SAMPLED
            
            #if !defined(DETAILS_MODE_PACKED) && !defined(DETAILS_MODE_SEPARATED)
              #define DETAILS_MODE_PACKED
            #endif
            
            #define VRCLV_VERSION 2
            #define VRCLV_MAX_VOLUMES_COUNT 32
            #define VRCLV_MAX_LIGHTS_COUNT 128
            
            #if !defined(DISABLE_VRCLIGHTVOLUMES) && defined(VRCLIGHTVOLUMES)
                #define INTEGRATE_VRCLIGHTVOLUMES
            
                #define LV_PI 3.141592653589793f
                #define LV_PI2 6.283185307179586f
            
                #define _INTEGRATE_CUSTOMPROBES
                #define _INTEGRATE_CUSTOMGI_FLEX
            #endif
            
            #if !defined(AL_EFFECT_BAND_SELECTION) && !defined(AL_EFFECT_UV_BASED) && !defined(AL_EFFECT_WAVEFORM) && !defined(AL_EFFECT_PULSE) && !defined(AL_EFFECT_BAR)
            #define AL_EFFECT_NONE
            #endif
            
            #if defined(INTEGRATE_LTCGI)
                #define _INTEGRATE_CUSTOMGI_FLEX
            #endif
            
            #define INCLUDE_LTCGI defined(INTEGRATE_LTCGI)
            
            #if INCLUDE_LTCGI
                #include "Packages/at.pimaker.ltcgi/Shaders/LTCGI_structs.cginc"
            #endif
            
            #if !defined(LIGHTMAP_ON) || !defined(UNITY_PASS_FORWARDBASE)
              #undef BAKERY_SH
              #undef BAKERY_RNM
            #endif
            
            #ifdef LIGHTMAP_ON
              #undef BAKERY_VOLUME
            #endif
            
            #ifdef LIGHTMAP_ON
                #if defined(BAKERY_ENABLED)
                    #if defined(BAKERY_RNM) || defined(BAKERY_SH) || defined(BAKERY_VERTEXLM) || defined(BAKERY_MONOSH)
                        #define BAKERYLM_ENABLED
                        #if !defined(BAKERY_MONOSH)
                            #undef DIRLIGHTMAP_COMBINED
                        #endif
                    #endif
                #endif
            #endif
            
            #if defined(BAKERY_SH) || defined(BAKERY_RNM) || defined(BAKERY_VOLUME) || defined(BAKERY_MONOSH)
              #ifdef BAKED_SPECULAR
                #define _BAKERY_LMSPEC
                #define BAKERY_LMSPEC
              #endif
            #endif
            
            #define ORL_LIGHTING_MODEL_PBR
                
            #if defined(UNITY_PBS_USE_BRDF2) || defined(SHADER_API_MOBILE)
                #define PLAT_QUEST
            #else
                #ifdef PLAT_QUEST
                    #undef PLAT_QUEST
                #endif
            #endif
            
            #define ORL_MIN_ROUGHNESS 0.002025
            #if defined(PLAT_QUEST)
                #define ORL_MIN_ROUGHNESS 0.007921
            #endif
            
            #if !defined(SHADING_MODE_DEFAULT) && !defined(SHADING_MODE_CLOTH)
                #define SHADING_MODE_DEFAULT
            #endif
            
            #define NEED_SCREEN_POS
            #if !defined(NEED_FRAGMENT_IN_SHADOW)
                #define NEED_FRAGMENT_IN_SHADOW
            #endif
            #include "Assets/Xuan25/PosterDisplay/Shader/Inc/PosterDisplay.cginc"

            // DataStructs
            struct VertexData
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float4 color : COLOR;
                float4 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 uv2 : TEXCOORD2;
                float4 uv3 : TEXCOORD3;
                #if defined(NEED_UV4)
                float4 uv4 : TEXCOORD4;
                #endif
                #if defined(NEED_UV5)
                float4 uv5 : TEXCOORD5;
                #endif
                #if defined(NEED_UV6)
                float4 uv6 : TEXCOORD6;
                #endif
                #if defined(NEED_UV7)
                float4 uv7 : TEXCOORD7;
                #endif
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            
            struct FragmentData
            {
                #if defined(UNITY_PASS_SHADOWCASTER)
                V2F_SHADOW_CASTER;
                #else
                float4 pos : SV_POSITION;
                #endif
            
                float3 normal : RAW_NORMAL;
            
                #if !defined(NEED_FLOAT4_UV)
                // by default all UVs are float 2s
                float2 uv0 : TEXCOORD1;
                float2 uv1 : TEXCOORD2;
                float2 uv2 : TEXCOORD3;
                float2 uv3 : TEXCOORD4;
                #if defined(NEED_UV4)
                float2 uv4 : TEXCOORD5;
                #endif
                #if defined(NEED_UV5)
                float2 uv5 : TEXCOORD6;
                #endif
                #if defined(NEED_UV6)
                float2 uv6 : TEXCOORD7;
                #endif
                #if defined(NEED_UV7)
                float2 uv7 : TEXCOORD8;
                #endif
            
                #else // #if !defined(NEED_FLOAT4_UV)
            
                // Shaders can request to get float4 UVs using
                // #define NEED_FLOAT4_UV
                float4 uv0 : TEXCOORD1;
                float4 uv1 : TEXCOORD2;
                float4 uv2 : TEXCOORD3;
                float4 uv3 : TEXCOORD4;
                #if defined(NEED_UV4)
                float4 uv4 : TEXCOORD5;
                #endif
                #if defined(NEED_UV5)
                float4 uv5 : TEXCOORD6;
                #endif
                #if defined(NEED_UV6)
                float4 uv6 : TEXCOORD7;
                #endif
                #if defined(NEED_UV7)
                float4 uv7 : TEXCOORD8;
                #endif
            
                #endif // #if !defined(NEED_FLOAT4_UV)
            
                float3 worldPos : WORLD_POS;
                float3 worldNormal : WORLD_NORMAL;
                float4 worldTangent : WORLD_TANGENT;
            
                #if !defined(UNITY_PASS_SHADOWCASTER)
                float4 lightmapUv : LM_UV;
                #endif
            
                centroid float4 vertexColor : VERTEX_COLOR;
            
                #if !defined(UNITY_PASS_META)
                UNITY_LIGHTING_COORDS(9, 10)
                float2 fogData : FOG_DATA;
                #endif
            
                #if defined(EDITOR_VISUALIZATION)
                float2 vizUV : VIZ_UV;
                float4 lightCoord : LIGHT_COORD;
                #endif
            
                #if defined(NEED_SCREEN_POS)
                float4 screenPos: SCREENPOS;
                #endif
            
                #if defined(EXTRA_V2F_0)
                float4 extraV2F0 : EXTRA_V2F_BLOCK0;
                #endif
                #if defined(EXTRA_V2F_1)
                float4 extraV2F1 : EXTRA_V2F_BLOCK1;
                #endif
                #if defined(EXTRA_V2F_2)
                float4 extraV2F2 : EXTRA_V2F_BLOCK2;
                #endif
                #if defined(EXTRA_V2F_3)
                float4 extraV2F3 : EXTRA_V2F_BLOCK3;
                #endif
            
                // Additional Fragment Data
                
                // Additional Fragment Data End
            
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };
            
            struct LTCGIAccumulatorStruct {
                float3 diffuse;
                float3 specular;
            };
            
            #define LTCGI_V2_CUSTOM_INPUT LTCGIAccumulatorStruct
            
            struct SurfaceData
            {
                half3 Albedo;
                half3 Emission;
                half Metallic;
                half Smoothness;
                half Occlusion;
                float3 Normal;
                half Alpha;
            
                // Additional Surface Data
                #if defined(INTEGRATE_VRCLIGHTVOLUMES)
                float3 VRCLV_L0;
                float3 VRCLV_L1r;
                float3 VRCLV_L1g;
                float3 VRCLV_L1b;
                #endif
                // Additional Surface Data End
            };
            
            SurfaceData CreateSurfaceData()
            {
                SurfaceData o = (SurfaceData) 0;
                o.Albedo = 1;
                o.Occlusion = 1;
                o.Normal = float3(0, 0, 1);
                o.Smoothness = 0.5;
                o.Alpha = 1;
                return o;
            }
            
            struct MeshData
            {
                #if !defined(NEED_FLOAT4_UV)
                // by default all UVs are float 2s
                float2 uv0;
                float2 uv1;
                float2 uv2;
                float2 uv3;
                #if defined(NEED_UV4)
                float2 uv4;
                #endif
                #if defined(NEED_UV5)
                float2 uv5;
                #endif
                #if defined(NEED_UV6)
                float2 uv6;
                #endif
                #if defined(NEED_UV7)
                float2 uv7;
                #endif
            
                #else // #if !defined(NEED_FLOAT4_UV)
            
                // Shaders can request to get float4 UVs using
                // #define NEED_FLOAT4_UV
                float4 uv0;
                float4 uv1;
                float4 uv2;
                float4 uv3;
                #if defined(NEED_UV4)
                float4 uv4;
                #endif
                #if defined(NEED_UV5)
                float4 uv5;
                #endif
                #if defined(NEED_UV6)
                float4 uv6;
                #endif
                #if defined(NEED_UV7)
                float4 uv7;
                #endif
            
                #endif // #if !defined(NEED_FLOAT4_UV)
            
                #if !defined(UNITY_PASS_SHADOWCASTER)
                half4 lightmapUv;
                #endif
                half4 vertexColor;
                half3 normal;
                half3 worldNormal;
                half3 localSpacePosition;
                half3 worldSpacePosition;
                half3 worldSpaceViewDir;
                half3 tangentSpaceViewDir;
                float3x3 TBNMatrix;
                float4 extraV2F0;
                float4 extraV2F1;
                float4 extraV2F2;
                float4 extraV2F3;
                float4 screenPos;
            
                // Additional Mesh Data
                
                // Additional Mesh Data End
            };
            
            MeshData CreateMeshData(FragmentData i, bool facing)
            {
                MeshData d = (MeshData) 0;
                d.uv0 = i.uv0;
                d.uv1 = i.uv1;
                d.uv2 = i.uv2;
                d.uv3 = i.uv3;
                #if defined(NEED_UV4)
                d.uv4 = i.uv4;
                #endif
                #if defined(NEED_UV5)
                d.uv5 = i.uv5;
                #endif
                #if defined(NEED_UV6)
                d.uv6 = i.uv6;
                #endif
                #if defined(NEED_UV7)
                d.uv7 = i.uv7;
                #endif
                #if !defined(UNITY_PASS_SHADOWCASTER)
                d.lightmapUv = i.lightmapUv;
                #endif
                d.worldNormal = normalize(i.worldNormal);
                d.localSpacePosition = mul(unity_WorldToObject, float4(i.worldPos, 1)).xyz;
                d.worldSpacePosition = i.worldPos;
                d.worldSpaceViewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
            
                d.normal = i.normal;
                d.vertexColor = i.vertexColor;
            
                #if !defined(UNITY_PASS_SHADOWCASTER)
                float3 bitangent = cross(d.worldNormal, i.worldTangent.xyz) * (i.worldTangent.w > 0.0 ? 1.0 : - 1.0);
                d.TBNMatrix = float3x3(normalize(i.worldTangent.xyz), bitangent, d.worldNormal);
                d.TBNMatrix[2].xyz *= facing ? 1 : -1;
                d.tangentSpaceViewDir = mul(d.TBNMatrix, d.worldSpaceViewDir);
                #endif
            
                #if defined(EXTRA_V2F_0)
                d.extraV2F0 = i.extraV2F0;
                #endif
                #if defined(EXTRA_V2F_1)
                d.extraV2F1 = i.extraV2F1;
                #endif
                #if defined(EXTRA_V2F_2)
                d.extraV2F2 = i.extraV2F2;
                #endif
                #if defined(EXTRA_V2F_3)
                d.extraV2F3 = i.extraV2F3;
                #endif
                #if defined(NEED_SCREEN_POS)
                d.screenPos = i.screenPos;
                #endif
            
                // Additional Mesh Data Creator
                
                // Additional Mesh Data Creator End
            
                return d;
            }
            // GlobalVariables

            // Variables
            half4 _Color;
            half4 _MainTex_ST;
            int _AlbedoChannel;
            int _MappingSpace;
            int _PlanarAxisX;
            int _PlanarAxisY;
            int _MetalChannel;
            int _AOChannel;
            int _DetailMaskChannel;
            int _SmoothChannel;
            int _RoughnessMode;
            half _Smoothness;
            half _Metallic;
            half4 _MetallicRemap;
            half4 _SmoothnessRemap;
            half4 _MaskMap_TexelSize;
            half _OcclusionStrength;
            int _DetailAsTintMask;
            half _BumpScale;
            int _FlipBumpY;
            half4 _EmissionColor;
            int _EmissionChannel;
            float2 GLOBAL_uv;
            half4 GLOBAL_maskMap;
            #if defined(PARALLAX)
            half _HeightScale;
            half _HeightRefPlane;
            int _ParallaxScaleBasedOnAngle;
            #endif
            float2 GLOBAL_parallaxUv;
            half GLOBAL_heightMask;
            half GLOBAL_heightMaskSmoothing;
            int GLOBAL_heightSet;
            half GLOBAL_height; 
            #if defined(DETAILS_OVERLAY)
            int _DIgnoreMask;
            half4 _DDetailsMap_ST;
            int _DMappingSpace;
            int _DUVChannel;
            int _DPlanarAxisX;
            int _DPlanarAxisY;
            half _DAlbedoScale;
            half _DNormalScale;
            int _DNormalFlipY;
            half _DSmoothScale;
            int _DAlbedoMixingLegacy;
            #endif
            int _VRCHideInVR;
            int _VRCHideInDesktop;
            int _VRCHideInVRCamera;
            int _VRCHideInDesktopCamera;
            int _VRCHideInVRMirror;
            int _VRCHideInDesktopMirror;
            float _VRChatCameraMode;
            float _VRChatMirrorMode;
            #if defined(INTEGRATE_VRCLIGHTVOLUMES)
            float _VRCLightVolumesSurfacePushoff;
            cbuffer LightVolumeUniforms {
                float _UdonLightVolumeEnabled;
                float _UdonLightVolumeVersion;
                float _UdonLightVolumeCount;
                float _UdonLightVolumeAdditiveMaxOverdraw;
                float _UdonLightVolumeAdditiveCount;
                float _UdonLightVolumeProbesBlend;
                float _UdonLightVolumeSharpBounds;
                float4x4 _UdonLightVolumeInvWorldMatrix[VRCLV_MAX_VOLUMES_COUNT];
                float4 _UdonLightVolumeRotation[VRCLV_MAX_VOLUMES_COUNT * 2];
                float3 _UdonLightVolumeInvLocalEdgeSmooth[VRCLV_MAX_VOLUMES_COUNT];
                float3 _UdonLightVolumeUvw[VRCLV_MAX_VOLUMES_COUNT * 6];
                float4 _UdonLightVolumeOcclusionUvw[VRCLV_MAX_VOLUMES_COUNT];
                float4 _UdonLightVolumeColor[VRCLV_MAX_VOLUMES_COUNT];
                float _UdonPointLightVolumeCount;
                float _UdonPointLightVolumeCubeCount;
                float4 _UdonPointLightVolumePosition[VRCLV_MAX_LIGHTS_COUNT];
                float4 _UdonPointLightVolumeColor[VRCLV_MAX_LIGHTS_COUNT];
                float4 _UdonPointLightVolumeDirection[VRCLV_MAX_LIGHTS_COUNT];
                float3 _UdonPointLightVolumeCustomID[VRCLV_MAX_LIGHTS_COUNT];
                float _UdonLightBrightnessCutoff;
                float _UdonLightVolumeOcclusionCount;
            }
            #endif
            sampler2D _PosterTex;
            float4 _PosterTex_ST;
            float4 _PosterTint;
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
            int _ALUVChannel;
            int _BandFrequency;
            int _BandScrollAxis;
            half _BandHistoryRange;
            half _UVHistoryRange;
            int _UVFlipXY;
            int _UVUseThemeColors;
            int _WVFRMMiddleLine;
            half _WVFRMMiddleLineWidth;
            int _WVFRMFlip;
            half _WVFRMOffset;
            half _WVFRMScale;
            int _WVFRMFlipUVDirection;
            int _PulseBand;
            int _PulseSmoothing;
            int _PulseMode;
            half _PulseStrength;
            int _PulseEmissionMode;
            int _PulseTextureAdjustment;
            half4 _PulseTextureDirection;
            int _BarBand;
            int _BarSmoothing;
            int _BarAxis;
            half _BarScale;
            int _KillEffects;
            half4 _ALTint;
            int _LTCGIEnableOnMobile;
            int _LTCGIClampBrightness;
            half _LTCGIMaxBrightness;
            half _LTCGIDiffuseIntensity;
            half _LTCGISpecularIntensity;
            half _LTCGIRoughnessModifier;
            int _LTCGIAlphaPremultiply;
            #if defined(BAKERY_ENABLED)
                #if defined(BAKERY_RNM) || defined(BAKERY_SH)
            float4 _RNM0_TexelSize;
                #endif
            #endif
            #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME)
            half3 _VolumeMin;
            half3 _VolumeInvSize;
            half3 _GlobalVolumeMin;
            int _Udon_GlobalVolumeAdapterEnabled;
            half3 _Udon_GlobalVolumeMin;
            half3 _GlobalVolumeInvSize;
            half3 _Udon_GlobalVolumeInvSize;
            #if defined(BAKERY_VOLROTATION)
            float4x4 _GlobalVolumeMatrix;
            float4x4 _Udon_GlobalVolumeMatrix;
            float4x4 _VolumeMatrix;
            #endif
            #if defined(BAKERY_VOLROTATIONY)
            float2 _GlobalVolumeRY;
            float2 _Udon_GlobalVolumeRY;
            float2 _VolumeRY;
            #endif
            #endif
            #if defined(GSAA)
            half _GSAAVariance;
            half _GSAAThreshold;
            int _GSAAIncludeNormalMaps;
            #endif
            #if defined(APPLY_COLOR_CORRECTION)
            half _ColorCorrLift;
            half _ColorCorrGamma;
            half _ColorCorrGain;
            #endif
            #if defined(CLEARCOAT)
            half _ClearCoatStrength;
            float _ClearCoatSmoothness;
            half4 _ClearCoatMask_ST;
            int _ClearCoatMaskChannel;
            int _HasClearCoatMask;
            #endif
            #if defined(SHADING_MODE_CLOTH)
            int _ClothHasCustomSheen;
            half4 _ClothSheenColor;
            int _ClothHasSubsurface;
            half4 _ClothSubsurfaceColor;
            #endif
            half _SpecOcclusion;
            half _RealtimeShadowSpecOcclusion;
            float _BakedSpecularOcclusion;
            half _SpecularRoughnessMod;
            int _BoxProjectionContactHardening;
            half _BoxProjectionContactHardeningStrength;
            half _GIEmissiveBoost;
            int _IgnoreRealtimeGI;
            int _RealtimeGIDisableBicubic;
            int _RenderType;
            half _Cutoff;

            // Textures
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            TEXTURE2D(_MaskMap);
            SAMPLER(sampler_MaskMap);
            TEXTURE2D(_BumpMap);
            SAMPLER(sampler_BumpMap);
            TEXTURE2D(_EmissionMap);
            SAMPLER(sampler_EmissionMap);
            #if defined(PARALLAX)
            TEXTURE2D(_Height);
            SAMPLER(sampler_Height);
            #endif
            #if defined(DETAILS_OVERLAY)
            TEXTURE2D(_DDetailsMap);
            SAMPLER(sampler_DDetailsMap);
            TEXTURE2D(_DDetailsNormal);
            SAMPLER(sampler_DDetailsNormal);
            #endif
            #if defined(INTEGRATE_VRCLIGHTVOLUMES)
            TEXTURE3D(_UdonLightVolume);
            TEXTURE2D_ARRAY(_UdonPointLightVolumeTexture);
            SAMPLER(sampler_UdonLightVolume);
            #define LV_SAMPLE(tex, uvw) tex.SampleLevel(sampler_UdonLightVolume, uvw, 0)
            #endif
            TEXTURE2D(_ALMask);
            SAMPLER(sampler_ALMask);
            TEXTURE2D(_WVFRMBottomColor);
            TEXTURE2D(_WVFRMTopColor);
            TEXTURE2D(_WVFRMMiddleColor);
            SAMPLER(sampler_WVFRMBottomColor);
            TEXTURE2D(_PulseTexture);
            SAMPLER(sampler_PulseTexture);
            TEXTURE2D(_BarColor);
            SAMPLER(sampler_BarColor);
            #if defined(BAKERY_ENABLED)
                #if defined(BAKERY_RNM) || defined(BAKERY_SH)
            TEXTURE2D(_RNM0);
            TEXTURE2D(_RNM1);
            TEXTURE2D(_RNM2);
            SAMPLER(sampler_RNM0);
                #endif
            #endif
            #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME)
            TEXTURE3D(_Volume0);
            TEXTURE3D(_Volume1);
            TEXTURE3D(_Volume2);
            TEXTURE3D(_VolumeMask);
                #if defined(BAKERY_COMPRESSED_VOLUME)
            TEXTURE3D(_Volume3);
                #endif
            SAMPLER(sampler_Volume0);
            SAMPLER(sampler_VolumeMask);
            #endif
            TEXTURE2D(_DFG);
            SAMPLER(sampler_DFG);
            TEXTURE2D(_ClearCoatMask);

            // PassFunctions
            #if defined(INTEGRATE_VRCLIGHTVOLUMES)
            
            float LV_Smoothstep01(float x) {
                return x * x * (3 - 2 * x);
            }
            
            float3 LV_MultiplyVectorByQuaternion(float3 v, float4 q) {
                float3 t = 2.0 * cross(q.xyz, v);
                return v + q.w * t + cross(q.xyz, t);
            }
            
            float3 LV_MultiplyVectorByMatrix2x3(float3 v, float3 r0, float3 r1) {
                float3 r2 = cross(r0, r1);
                return float3(dot(v, r0), dot(v, r1), dot(v, r2));
            }
            
            float LV_FastAcos(float x) {
                float absX = abs(x); 
                float res = -0.156583f * absX + LV_PI * 0.5f;
                res *= sqrt(1.0f - absX); 
                return (x >= 0) ? res : (LV_PI - res);
            }
            
            float LV_DistributionGGX(float NoH, float roughness) {
                float f = (roughness - 1) * ((roughness + 1) * (NoH * NoH)) + 1;
                return (roughness * roughness) / ((float) LV_PI * f * f);
            }
            
            bool LV_PointLocalAABB(float3 localUVW) {
                return all(abs(localUVW) <= 0.5);
            }
            
            float3 LV_LocalFromVolume(uint volumeID, float3 worldPos) {
                return mul(_UdonLightVolumeInvWorldMatrix[volumeID], float4(worldPos, 1.0)).xyz;
            }
            
            float LV_EvaluateSH(float L0, float3 L1, float3 n) {
                return L0 + dot(L1, n);
            }
            
            float4 LV_SampleCubemapArray(uint id, float3 dir) {
                float3 absDir = abs(dir);
                float2 uv;
                uint face;
                if (absDir.x >= absDir.y && absDir.x >= absDir.z) {
                    face = dir.x > 0 ? 0 : 1;
                    uv = float2((dir.x > 0 ? -dir.z : dir.z), -dir.y) * rcp(absDir.x);
                } else if (absDir.y >= absDir.z) {
                    face = dir.y > 0 ? 2 : 3;
                    uv = float2(dir.x, (dir.y > 0 ? dir.z : -dir.z)) * rcp(absDir.y);
                } else {
                    face = dir.z > 0 ? 4 : 5;
                    uv = float2((dir.z > 0 ? dir.x : -dir.x), -dir.y) * rcp(absDir.z);
                }
                float3 uvid = float3(uv * 0.5 + 0.5, id * 6 + face);
                return LV_SAMPLE(_UdonPointLightVolumeTexture, uvid);
            }
            
            float4 LV_ProjectQuadLightIrradianceSH(float3 shadingPosition, float3 lightVertices[4]) {
                // Transform the vertices into local space centered on the shading position,
                // project, the polygon onto the unit sphere.
                [unroll] for (uint edge0 = 0; edge0 < 4; edge0++) {
                    lightVertices[edge0] = normalize(lightVertices[edge0] - shadingPosition);
                }
                
                // Precomputed directions of rotated zonal harmonics,
                // and associated weights for each basis function.
                // I.E. \omega_{l,d} and \alpha_{l,d}^m in the paper respectively.
                const float3 zhDir0 = float3(0.866025, -0.500001, -0.000004);
                const float3 zhDir1 = float3(-0.759553, 0.438522, -0.480394);
                const float3 zhDir2 = float3(-0.000002, 0.638694,  0.769461);
                const float3 zhWeightL1y = float3(2.1995339f, 2.50785367f, 1.56572711f);
                const float3 zhWeightL1z = float3(-1.82572523f, -2.08165037f, 0.00000000f);
                const float3 zhWeightL1x = float3(2.42459869f, 1.44790525f, 0.90397552f);
                
                float solidAngle = 0.0;
                float3 surfaceIntegral = 0.0;
                [loop] for (uint edge1 = 0; edge1 < 4; edge1++) {
                    uint next = (edge1 + 1) % 4;
                    uint prev = (edge1 + 4 - 1) % 4;
                    float3 prevVert = lightVertices[prev];
                    float3 thisVert = lightVertices[edge1];
                    float3 nextVert = lightVertices[next];
                
                    // Compute the solid angle subtended by the polygon at the shading position,
                    // using Arvo's formula (5.1) https://dl.acm.org/doi/pdf/10.1145/218380.218467.
                    // The L0 term is directly proportional to the solid angle.
                    float3 a = cross(thisVert, prevVert);
                    float3 b = cross(thisVert, nextVert);
                    float lenA = length(a);
                    float lenB = length(b);
                    solidAngle += LV_FastAcos(clamp(dot(a, b) / (lenA * lenB), -1, 1));
                
                    // Compute the integral of the legendre polynomials over the surface of the
                    // projected polygon for each zonal harmonic direction (S_l in the paper).
                    // Computed as a sum of line integrals over the edges of the polygon.
                    float3 mu = b * rcp(lenB);
                    float cosGamma = dot(thisVert, nextVert);
                    float gamma = LV_FastAcos(clamp(cosGamma, -1, 1));
                    surfaceIntegral.x += gamma * dot(zhDir0, mu);
                    surfaceIntegral.y += gamma * dot(zhDir1, mu);
                    surfaceIntegral.z += gamma * dot(zhDir2, mu);
                }
                solidAngle = solidAngle - LV_PI2;
                surfaceIntegral *= 0.5;
                
                // The L0 term is just the projection of the solid angle onto the L0 basis function.
                const float normalizationL0 = 0.5f * sqrt(1.0f / LV_PI);
                float l0 = normalizationL0 * solidAngle;
                    
                // Combine each surface (sub)integral with the associated weights to get
                // full surface integral for each L1 SH basis function.
                float l1y = dot(zhWeightL1y, surfaceIntegral);
                float l1z = dot(zhWeightL1z, surfaceIntegral);
                float l1x = dot(zhWeightL1x, surfaceIntegral);
                
                // The l0, l1y, l1z, l1x are raw SH coefficients for radiance from the polygon.
                // We need to apply some more transformations before we are done:
                // (1) We want the coefficients for irradiance, so we need to convolve with the
                //     clamped cosine kernel, as detailed in https://cseweb.ucsd.edu/~ravir/papers/envmap/envmap.pdf.
                //     The kernel has coefficients PI and 2/3*PI for L0 and L1 respectively.
                // (2) Unity's area lights underestimate the irradiance by a factor of PI for historical reasons.
                //     We need to divide by PI to match this 'incorrect' behavior.
                // (3) Unity stores SH coefficients (unity_SHAr..unity_SHC) pre-multiplied with the constant
                //     part of each SH basis function, so we need to multiply by constant part to match it.
                const float cosineKernelL0 = LV_PI; // (1)
                const float cosineKernelL1 = LV_PI2 / 3.0f; // (1)
                const float oneOverPi = 1.0f / LV_PI; // (2)
                const float normalizationL1 = 0.5f * sqrt(3.0f / LV_PI); // (3)
                const float weightL0 = cosineKernelL0 * normalizationL0 * oneOverPi; // (1), (2), (3)
                const float weightL1 = cosineKernelL1 * normalizationL1 * oneOverPi; // (1), (2), (3)
                l0  *= weightL0;
                l1y *= weightL1;
                l1z *= weightL1;
                l1x *= weightL1;
                    
                return float4(l1x, l1y, l1z, l0);
            }
            
            void LV_QuadLight(float3 worldPos, float3 centroidPos, float4 rotationQuat, float2 size, float3 color, float sqMaxDist, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float3 lightToWorldPos = worldPos - centroidPos;
                    
                // Normal culling
                float3 normal = LV_MultiplyVectorByQuaternion(float3(0, 0, 1), rotationQuat);
                [branch] if (dot(normal, lightToWorldPos) < 0.0) return;
                    
                // Attenuate the light based on distance to the bounding sphere, so we don't get hard seam at the edge.
                float sqCutoffDist = sqMaxDist - dot(lightToWorldPos, lightToWorldPos);
                color.rgb *= saturate(sqCutoffDist / sqMaxDist) * LV_PI * occlusion;
                        
                // Compute the vertices of the quad
                float2 halfSize = size * 0.5f;
                float3 xAxis = LV_MultiplyVectorByQuaternion(float3(1, 0, 0), rotationQuat);
                float3 yAxis = cross(normal, xAxis);
                float3 verts[4];
                verts[0] = centroidPos + (-halfSize.x * xAxis) + ( halfSize.y * yAxis);
                verts[1] = centroidPos + ( halfSize.x * xAxis) + ( halfSize.y * yAxis);
                verts[2] = centroidPos + ( halfSize.x * xAxis) + (-halfSize.y * yAxis);
                verts[3] = centroidPos + (-halfSize.x * xAxis) + (-halfSize.y * yAxis);
                
                // Project irradiance from the area light
                float4 areaLightSH = LV_ProjectQuadLightIrradianceSH(worldPos, verts);
                
                // If the magnitude of L1 is greater than L0, we may get negative values
                // when reconstructing. To avoid, normalize L1. This is effectively de-ringing.
                float lenL1 = length(areaLightSH.xyz);
                if (lenL1 > areaLightSH.w) areaLightSH.xyz *= areaLightSH.w / lenL1;
                    
                L0  += areaLightSH.w * color.rgb;
                L1r += areaLightSH.xyz * color.r;
                L1g += areaLightSH.xyz * color.g;
                L1b += areaLightSH.xyz * color.b;
                    
                count++;
            }
            
            float3 LV_PointLightAttenuation(float sqdist, float sqlightSize, float3 color, float brightnessCutoff, float sqMaxDist) {
                float mask = saturate(1 - sqdist / sqMaxDist);
                return mask * mask * color * sqlightSize / (sqdist + sqlightSize);
            }
            
            float LV_PointLightSolidAngle(float sqdist, float sqlightSize) {
                return saturate(sqrt(sqdist / (sqlightSize + sqdist)));
            }
            
            void LV_SphereLight(float sqdist, float3 dirN, float sqlightSize, float3 color, float occlusion, float sqMaxDist, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float3 att = LV_PointLightAttenuation(sqdist, sqlightSize, color, _UdonLightBrightnessCutoff, sqMaxDist);
                
                float3 l0 = att * occlusion;
                float3 l1 = dirN * LV_PointLightSolidAngle(sqdist, sqlightSize);
                    
                L0 += l0;
                L1r += l0.r * l1;
                L1g += l0.g * l1;
                L1b += l0.b * l1;
                count++;
                    
            }
            
            void LV_SphereSpotLight(float sqdist, float3 dirN, float sqlightSize, float3 att, float spotMask, float cosAngle, float coneFalloff, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float smoothedCone = LV_Smoothstep01(saturate(spotMask * coneFalloff));
                float3 l0 = att * (occlusion * smoothedCone);
                float3 l1 = dirN * LV_PointLightSolidAngle(sqdist, sqlightSize * saturate(1 - cosAngle));
                    
                L0 += l0;
                L1r += l0.r * l1;
                L1g += l0.g * l1;
                L1b += l0.b * l1;
                count++;
                    
            }
            
            void LV_SphereSpotLightCookie(float sqdist, float3 dirN, float sqlightSize, float3 att, float4 lightRot, float tanAngle, uint customId, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float3 localDir = LV_MultiplyVectorByQuaternion(-dirN, lightRot);
                float2 uv = localDir.xy * rcp(localDir.z * tanAngle);
                [branch] if (
                    localDir.z <= 0.0 || // Culling by direction
                    abs(uv.x) > 1.0 || abs(uv.y) > 1.0 // Culling by UV
                ) return;
                        
                uint id = (uint) _UdonPointLightVolumeCubeCount * 5 - customId - 1;
                float3 uvid = float3(uv * 0.5 + 0.5, id);        
                float angleSize = saturate(rsqrt(1 + tanAngle * tanAngle));
                float4 cookie = LV_SAMPLE(_UdonPointLightVolumeTexture, uvid);
                        
                float3 l0 = att * cookie.rgb * (cookie.a * occlusion);
                float3 l1 = dirN * LV_PointLightSolidAngle(sqdist, sqlightSize * (1 - angleSize));
                    
                L0 += l0;
                L1r += l0.r * l1;
                L1g += l0.g * l1;
                L1b += l0.b * l1;
                count++;
                    
            }
            
            void LV_SphereSpotLightAttenuationLUT(float sqdist, float3 dirN, float sqlightSize, float3 color, float spotMask, float cosAngle, uint customId, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float dirRadius = sqdist * abs(sqlightSize);
                float spot = 1 - saturate(spotMask * rcp(1 - cosAngle));
                uint id = (uint) _UdonPointLightVolumeCubeCount * 5 + customId - 1;
                float3 uvid = float3(sqrt(float2(spot, dirRadius)), id);
                float3 att = color.rgb * LV_SAMPLE(_UdonPointLightVolumeTexture, uvid).xyz * occlusion;
                    
                L0 += att;
                L1r += dirN * att.r;
                L1g += dirN * att.g;
                L1b += dirN * att.b;
                    
                count++;
                    
            }
            
            void LV_PointLight(uint id, float3 worldPos, float4 occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                // IDs and range data
                float3 customID_data = _UdonPointLightVolumeCustomID[id];
                int shadowId = (int) customID_data.y; // Shadowmask id
                int customId = (int) customID_data.x; // Custom Texture ID
                float sqrRange = customID_data.z; // Squared culling distance
                    
                float4 pos = _UdonPointLightVolumePosition[id]; // Light position and inversed squared range 
                float3 dir = pos.xyz - worldPos;
                float sqlen = max(dot(dir, dir), 1e-6);
                [branch] if (sqlen > sqrRange) return; // Early distance based culling
                float3 dirN = dir * rsqrt(sqlen);
                    
                // Processing lights occlusion
                float lightOcclusion = 1;
                if (_UdonLightVolumeOcclusionCount != 0 && shadowId >= 0) {
                    lightOcclusion = dot(occlusion, float4(shadowId == 0, shadowId == 1, shadowId == 2, shadowId == 3));
                }
                    
                float4 color = _UdonPointLightVolumeColor[id]; // Color, angle
                float4 ldir = _UdonPointLightVolumeDirection[id]; // Dir + falloff or Rotation
                    
                [branch] if (pos.w < 0) { // It is a spot light
                
                    float angle = color.w;
                    float spotMask = dot(ldir.xyz, -dirN) - angle;
                    [branch] if(customId >= 0 && spotMask < 0) return; // Spot cone based culling
                        
                    [branch] if (customId > 0) {  // If it uses Attenuation LUT
                            
                        LV_SphereSpotLightAttenuationLUT(sqlen, dirN, -pos.w, color.rgb, spotMask, angle, customId, lightOcclusion, L0, L1r, L1g, L1b, count);
                            
                    } else { // If it uses default parametric attenuation
                
                        float3 att = LV_PointLightAttenuation(sqlen, -pos.w, color.rgb, _UdonLightBrightnessCutoff, sqrRange);
                
                        [branch] if (customId < 0) { // If uses cookie
                                
                            LV_SphereSpotLightCookie(sqlen, dirN, -pos.w, att, ldir, angle, customId, lightOcclusion, L0, L1r, L1g, L1b, count);
                                
                        } else { // If it uses default parametric attenuation
                                
                            LV_SphereSpotLight(sqlen, dirN, -pos.w, att, spotMask, angle, ldir.w, lightOcclusion, L0, L1r, L1g, L1b, count);
                                
                        }
                            
                    }
                        
                } else if (color.w <= 1.5f) { // It is a point light
                        
                    [branch] if (customId > 0) { // Using LUT
                            
                        float invSqRange = abs(pos.w); // Sign of range defines if it's point light (positive) or a spot light (negative)
                        float dirRadius = sqlen * invSqRange;
                        uint id = (uint) _UdonPointLightVolumeCubeCount * 5 + customId;
                        float3 uvid = float3(sqrt(float2(0, dirRadius)), id);
                        float3 att = color.rgb * LV_SAMPLE(_UdonPointLightVolumeTexture, uvid).xyz * lightOcclusion;
                            
                        L0 += att;
                        L1r += dirN * att.r;
                        L1g += dirN * att.g;
                        L1b += dirN * att.b;
                            
                        count++;
                            
                    } else { // If it uses default parametric attenuation
                            
                        float3 l0 = 0, l1r = 0, l1g = 0, l1b = 0;
                        LV_SphereLight(sqlen, dirN, pos.w, color.rgb, lightOcclusion, sqrRange, l0, l1r, l1g, l1b, count);
                
                        float3 cubeColor = 1;
                        [branch] if (customId < 0) { // If it uses a cubemap
                            uint id = -customId - 1; // Cubemap ID starts from zero and should not take in count texture array slices count.
                            cubeColor = LV_SampleCubemapArray(id, LV_MultiplyVectorByQuaternion(dirN, ldir)).xyz;
                        }
                
                        L0 += l0 * cubeColor;
                        L1r += l1r * cubeColor.r;
                        L1g += l1g * cubeColor.g;
                        L1b += l1b * cubeColor.b;
                    }
                        
                } else { // It is an area light
                        
                    LV_QuadLight(worldPos, pos.xyz, ldir, float2(pos.w, color.w - 2.0f), color.rgb, sqrRange, lightOcclusion, L0, L1r, L1g, L1b, count);
                        
                }
                
            }
            
            void LV_SampleLightVolumeTex(float3 uvw0, float3 uvw1, float3 uvw2, out float3 L0, out float3 L1r, out float3 L1g, out float3 L1b) {
                // Sampling 3D Atlas
                float4 tex0 = LV_SAMPLE(_UdonLightVolume, uvw0);
                float4 tex1 = LV_SAMPLE(_UdonLightVolume, uvw1);
                float4 tex2 = LV_SAMPLE(_UdonLightVolume, uvw2);
                // Packing final data
                L0 = tex0.rgb;
                L1r = float3(tex1.r, tex2.r, tex0.a);
                L1g = float3(tex1.g, tex2.g, tex1.a);
                L1b = float3(tex1.b, tex2.b, tex2.a);
            }
            
            float LV_BoundsMask(float3 localUVW, float3 invLocalEdgeSmooth) {
                float3 distToMin = (localUVW + 0.5) * invLocalEdgeSmooth;
                float3 distToMax = (0.5 - localUVW) * invLocalEdgeSmooth;
                float3 fade = saturate(min(distToMin, distToMax));
                return fade.x * fade.y * fade.z;
            }
            
            void LV_SampleLightProbe(inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b) {
                L0 += float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                L1r += unity_SHAr.xyz;
                L1g += unity_SHAg.xyz;
                L1b += unity_SHAb.xyz;
            }
            
            void LV_SampleLightProbeDering(inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b) {
                L0 += float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                L1r += unity_SHAr.xyz * 0.565f;
                L1g += unity_SHAg.xyz * 0.565f;
                L1b += unity_SHAb.xyz * 0.565f;
            }
            
            void LV_SampleVolume(uint id, float3 localUVW, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, out float4 occlusion) {
                    
                // Additive UVW
                //uint uvwID = id * 3;
                //float4 uvwPos0 = _UdonLightVolumeUvwScale[uvwID];
                //float4 uvwPos1 = _UdonLightVolumeUvwScale[uvwID + 1];
                //float4 uvwPos2 = _UdonLightVolumeUvwScale[uvwID + 2];
                //float3 uvwScale = float3(uvwPos0.w, uvwPos1.w, uvwPos2.w);
                    
                //float3 uvwScaled = saturate(localUVW + 0.5) * uvwScale;
                //float3 uvw0 = uvwPos0.xyz + uvwScaled;
                //float3 uvw1 = uvwPos1.xyz + uvwScaled;
                //float3 uvw2 = uvwPos2.xyz + uvwScaled;
                    
                // Legacy! Commented code above will be used in future releases! Legacy!
                uint uvwID = id * 6;
                float3 uvwScaled = saturate(localUVW + 0.5) * (_UdonLightVolumeUvw[uvwID + 1].xyz - _UdonLightVolumeUvw[uvwID].xyz);
                float3 uvw0 = uvwScaled + _UdonLightVolumeUvw[uvwID].xyz;
                float3 uvw1 = uvwScaled + _UdonLightVolumeUvw[uvwID + 2].xyz;
                float3 uvw2 = uvwScaled + _UdonLightVolumeUvw[uvwID + 4].xyz;
                    
                // Sample additive
                float3 l0, l1r, l1g, l1b;
                LV_SampleLightVolumeTex(uvw0, uvw1, uvw2, l0, l1r, l1g, l1b);
                
                // Sample occlusion
                float4 uvwOcclusion = _UdonLightVolumeOcclusionUvw[id];
                [branch] if (uvwOcclusion.x >= 0) {
                    occlusion = 1.0f - LV_SAMPLE(_UdonLightVolume, uvwOcclusion.xyz + uvwScaled * uvwOcclusion.w);
                } else {
                    occlusion = 1;
                }
                    
                // Color correction
                float4 color = _UdonLightVolumeColor[id];
                L0 += l0 * color.rgb;
                l1r *= color.r;
                l1g *= color.g;
                l1b *= color.b;
                    
                // Rotate if needed
                if (color.a != 0) {
                    //float4 r = _UdonLightVolumeRotationQuaternion[id];
                    //L1r = LV_MultiplyVectorByQuaternion(L1r, r);
                    //L1g = LV_MultiplyVectorByQuaternion(L1g, r);
                    //L1b = LV_MultiplyVectorByQuaternion(L1b, r);
                        
                    // Legacy to support older light volumes worlds! Commented code above will be used in future releases! Legacy!
                    float3 r0 = _UdonLightVolumeRotation[id * 2].xyz;
                    float3 r1 = _UdonLightVolumeRotation[id * 2 + 1].xyz;
                    L1r += LV_MultiplyVectorByMatrix2x3(l1r, r0, r1);
                    L1g += LV_MultiplyVectorByMatrix2x3(l1g, r0, r1);
                    L1b += LV_MultiplyVectorByMatrix2x3(l1b, r0, r1);
                } else {
                    L1r += l1r;
                    L1g += l1g;
                    L1b += l1b;
                }
                                
            }
            
            float4 LV_SampleVolumeOcclusion(uint id, float3 localUVW) {
                    
                // Sample occlusion
                float4 uvwOcclusion = _UdonLightVolumeOcclusionUvw[id];
                    
                [branch] if (uvwOcclusion.x >= 0) {
                    //uint uvwID = id * 3;
                    //float4 uvwPos0 = _UdonLightVolumeUvwScale[uvwID];
                    //float4 uvwPos1 = _UdonLightVolumeUvwScale[uvwID + 1];
                    //float4 uvwPos2 = _UdonLightVolumeUvwScale[uvwID + 2];
                    //float3 uvwScale = float3(uvwPos0.w, uvwPos1.w, uvwPos2.w);
                    //float3 uvwScaled = saturate(localUVW + 0.5) * uvwScale;
                        
                    // Legacy to support older light volumes worlds! Commented code above will be used in future releases! Legacy!
                    uint uvwID = id * 6;
                    float3 uvwScaled = saturate(localUVW + 0.5) * (_UdonLightVolumeUvw[uvwID + 1].xyz - _UdonLightVolumeUvw[uvwID].xyz);
                        
                    return 1.0f - LV_SAMPLE(_UdonLightVolume, uvwOcclusion.xyz + uvwScaled * uvwOcclusion.w);
                } else {
                    return 1;
                }
                    
            }
            
            void LV_PointLightVolumeSH(float3 worldPos, float4 occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b) {
                    
                uint pointCount = min((uint) _UdonPointLightVolumeCount, VRCLV_MAX_LIGHTS_COUNT);
                [branch] if (pointCount == 0) return;
                    
                uint maxOverdraw = min((uint) _UdonLightVolumeAdditiveMaxOverdraw, VRCLV_MAX_LIGHTS_COUNT);
                uint pcount = 0; // Point lights counter
                
                [loop] for (uint pid = 0; pid < pointCount && pcount < maxOverdraw; pid++) {
                    LV_PointLight(pid, worldPos, occlusion, L0, L1r, L1g, L1b, pcount);
                }
                    
            }
            
            void LV_LightVolumeSH(float3 worldPos, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, out float4 occlusion) {
                
                // Initializing output variables
                occlusion = 1;
                float4 mOcclusion = 1; // Multiplicative occlusion. Applies on top of regular occlusion
                    
                // Clamping gloabal iteration counts
                uint volumesCount = min((uint) _UdonLightVolumeCount, VRCLV_MAX_VOLUMES_COUNT);
                    
                //if (_UdonLightVolumeVersion < VRCLV_VERSION || volumesCount == 0 ) { // Fallback to default light probes if Light Volume are not enabled or a version is too old to have a support
                [branch] if (volumesCount == 0) { // Legacy! Fallback to default light probes if Light Volume are not enabled or a version is too old to have a support. Legacy!
                    LV_SampleLightProbe(L0, L1r, L1g, L1b);
                    return;
                }
                    
                uint maxOverdraw = min((uint) _UdonLightVolumeAdditiveMaxOverdraw, VRCLV_MAX_VOLUMES_COUNT);
                uint additiveCount = min((uint) _UdonLightVolumeAdditiveCount, VRCLV_MAX_VOLUMES_COUNT);
                bool lightProbesBlend = _UdonLightVolumeProbesBlend;
                    
                uint volumeID_A = -1; // Main, dominant volume ID
                uint volumeID_B = -1; // Secondary volume ID to blend main with
                
                float3 localUVW   = 0; // Last local UVW to use in disabled Light Probes mode
                float3 localUVW_A = 0; // Main local UVW
                float3 localUVW_B = 0; // Secondary local UVW
                    
                // Are A and B volumes NOT found?
                bool isNoA = true;
                bool isNoB = true;
                    
                // Additive volumes variables
                uint addVolumesCount = 0;
                    
                // Iterating through all light volumes with simplified algorithm requiring Light Volumes to be sorted by weight in descending order
                [loop] for (uint id = 0; id < volumesCount; id++) {
                    localUVW = LV_LocalFromVolume(id, worldPos);
                    [branch] if (LV_PointLocalAABB(localUVW)) { // Intersection test
                        [branch] if (id < additiveCount) { // Sampling additive volumes
                            [branch] if (addVolumesCount < maxOverdraw) {
                                float4 occ; // Multiplicative occlusion
                                LV_SampleVolume(id, localUVW, L0, L1r, L1g, L1b, occ);
                                mOcclusion *= occ;
                                addVolumesCount++;
                            } 
                        } else if (isNoA) { // First, searching for volume A
                            volumeID_A = id;
                            localUVW_A = localUVW;
                            isNoA = false;
                        } else { // Next, searching for volume B if A found
                            volumeID_B = id;
                            localUVW_B = localUVW;
                            isNoB = false;
                            break;
                        }
                    }
                }
                
                // If no volumes found, using Light Probes as fallback
                [branch] if (isNoA && lightProbesBlend) {
                    LV_SampleLightProbe(L0, L1r, L1g, L1b);
                    occlusion *= mOcclusion;
                    return;
                }
                        
                // Fallback to lowest weight light volume if outside of every volume
                localUVW_A = isNoA ? localUVW : localUVW_A;
                volumeID_A = isNoA ? volumesCount - 1 : volumeID_A;
                
                // Volume A SH components, occlusion, and mask to blend volume sides
                float3 L0_A  = 0;
                float3 L1r_A = 0;
                float3 L1g_A = 0;
                float3 L1b_A = 0;
                float4 occlusion_A = 1;
                    
                // Sampling Light Volume A
                LV_SampleVolume(volumeID_A, localUVW_A, L0_A, L1r_A, L1g_A, L1b_A, occlusion_A);
                    
                float mask = LV_BoundsMask(localUVW_A, _UdonLightVolumeInvLocalEdgeSmooth[volumeID_A]);
                [branch] if (mask == 1 || isNoA || (_UdonLightVolumeSharpBounds && isNoB)) { // Returning SH A result if it's the center of mask or out of bounds
                    L0  += L0_A;
                    L1r += L1r_A;
                    L1g += L1g_A;
                    L1b += L1b_A;
                    occlusion = occlusion_A;
                    occlusion *= mOcclusion;
                    return;
                }
                    
                // Volume B SH components and occlusion
                float3 L0_B  = 0;
                float3 L1r_B = 0;
                float3 L1g_B = 0;
                float3 L1b_B = 0;
                float4 occlusion_B = 1;
                
                [branch] if (isNoB && lightProbesBlend) { // No Volume found and light volumes blending enabled
                
                    // Sample Light Probes B
                    LV_SampleLightProbe(L0_B, L1r_B, L1g_B, L1b_B);
                
                } else { // Blending Volume A and Volume B
                            
                    // If no volume b found, use last one found to fallback
                    localUVW_B = isNoB ? localUVW : localUVW_B;
                    volumeID_B = isNoB ? volumesCount - 1 : volumeID_B;
                            
                    // Sampling Light Volume B
                    LV_SampleVolume(volumeID_B, localUVW_B, L0_B, L1r_B, L1g_B, L1b_B, occlusion_B);
                        
                }
                
                // Lerping occlusion
                occlusion = lerp(occlusion_B, occlusion_A, mask);
                occlusion *= mOcclusion;
                
                // Lerping SH components
                L0  += lerp(L0_B,  L0_A,  mask);
                L1r += lerp(L1r_B, L1r_A, mask);
                L1g += lerp(L1g_B, L1g_A, mask);
                L1b += lerp(L1b_B, L1b_A, mask);
                
            }
            
            void LV_LightVolumeAdditiveSH(float3 worldPos, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, out float4 occlusion) {
                
                // Initializing output variables
                occlusion = 1;
                float4 mOcclusion = 1; // Multiplicative occlusion. Applies on top of regular occlusion
                    
                // Clamping gloabal iteration counts
                uint additiveCount = min((uint) _UdonLightVolumeAdditiveCount, VRCLV_MAX_VOLUMES_COUNT);
                //if (_UdonLightVolumeVersion < VRCLV_VERSION || (additiveCount == 0 && pointCount == 0)) return;
                [branch] if (additiveCount == 0 && (uint) _UdonPointLightVolumeCount == 0) return; // Legacy!
                
                uint volumesCount = min((uint) _UdonLightVolumeCount, VRCLV_MAX_VOLUMES_COUNT);
                uint maxOverdraw = min((uint) _UdonLightVolumeAdditiveMaxOverdraw, VRCLV_MAX_VOLUMES_COUNT);
                    
                uint volumeID_A = -1; // Main, dominant volume ID
                uint volumeID_B = -1; // Secondary volume ID to blend main with
                
                float3 localUVW   = 0; // Last local UVW to use in disabled Light Probes mode
                float3 localUVW_A = 0; // Main local UVW for Y Axis and Free rotations
                float3 localUVW_B = 0; // Secondary local UVW
                    
                // Are A and B volumes NOT found?
                bool isNoA = true;
                bool isNoB = true;
                    
                // Additive volumes variables
                uint addVolumesCount = 0;
                
                // Iterating through all light volumes with simplified algorithm requiring Light Volumes to be sorted by weight in descending order
                uint count = min(_UdonLightVolumeOcclusionCount == 0 ? additiveCount : volumesCount, VRCLV_MAX_VOLUMES_COUNT); // Only use all volumes if occlusion volumes are enabled
                [loop] for (uint id = 0; id < count; id++) {
                    localUVW = LV_LocalFromVolume(id, worldPos);
                    [branch] if (LV_PointLocalAABB(localUVW)) { // Intersection test
                        [branch] if (id < additiveCount) { // Sampling additive volumes
                            [branch] if (addVolumesCount < maxOverdraw) {
                                float4 occ; // Multiplicative occlusion
                                LV_SampleVolume(id, localUVW, L0, L1r, L1g, L1b, occ);
                                mOcclusion *= occ;
                                addVolumesCount++;
                            } 
                        } else if (isNoA) { // First, searching for volume A
                            volumeID_A = id;
                            localUVW_A = localUVW;
                            isNoA = false;
                        } else { // Next, searching for volume B if A found
                            volumeID_B = id;
                            localUVW_B = localUVW;
                            isNoB = false;
                            break;
                        }
                    }
                }
                
                // If no volumes found, or we don't need the occlusion data, we are done
                [branch] if (isNoA || _UdonLightVolumeOcclusionCount == 0) {
                    occlusion *= mOcclusion;
                    return;
                }
                    
                // Fallback to lowest weight light volume if outside of every volume
                localUVW_A = isNoA ? localUVW : localUVW_A;
                volumeID_A = isNoA ? volumesCount - 1 : volumeID_A;
                
                // Sampling Light Volume A
                occlusion = LV_SampleVolumeOcclusion(volumeID_A, localUVW_A);
                float mask = LV_BoundsMask(localUVW_A, _UdonLightVolumeInvLocalEdgeSmooth[volumeID_A]);
                    
                [branch] if (mask == 1 || (_UdonLightVolumeSharpBounds && isNoB)) {
                    occlusion *= mOcclusion;
                    return; // Returning A result if it's the center of mask or out of bounds
                }
                
                // Blending Volume A and Volume B
                [branch] if (isNoB) occlusion = lerp(1, occlusion, mask);
                else occlusion = lerp(LV_SampleVolumeOcclusion(volumeID_B, localUVW_B), occlusion, mask);
                
                occlusion *= mOcclusion;
                    
            }
            
            float3 LightVolumeSpecular(float3 f0, float smoothness, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                    
                float3 specColor = max(float3(dot(reflect(-L1r, worldNormal), viewDir), dot(reflect(-L1g, worldNormal), viewDir), dot(reflect(-L1b, worldNormal), viewDir)), 0);
                    
                float3 rDir = normalize(normalize(L1r) + viewDir);
                float3 gDir = normalize(normalize(L1g) + viewDir);
                float3 bDir = normalize(normalize(L1b) + viewDir);
                    
                float rNh = saturate(dot(worldNormal, rDir));
                float gNh = saturate(dot(worldNormal, gDir));
                float bNh = saturate(dot(worldNormal, bDir));
                    
                float roughness = 1 - smoothness * 0.9f;
                float roughExp = roughness * roughness;
                    
                float rSpec = LV_DistributionGGX(rNh, roughExp);
                float gSpec = LV_DistributionGGX(gNh, roughExp);
                float bSpec = LV_DistributionGGX(bNh, roughExp);
                    
                float3 specs = (rSpec + gSpec + bSpec) * f0;
                float3 coloredSpecs = specs * specColor;
                    
                float3 a = coloredSpecs + specs * L0;
                float3 b = coloredSpecs * 3;
                    
                return max(lerp(a, b, smoothness) * 0.5f, 0.0);
                    
            }
            
            float3 LightVolumeSpecular(float3 albedo, float smoothness, float metallic, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                float3 specularf0 = lerp(0.04f, albedo, metallic);
                return LightVolumeSpecular(specularf0, smoothness, worldNormal, viewDir, L0, L1r, L1g, L1b);
            }
            
            float3 LightVolumeSpecularDominant(float3 f0, float smoothness, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                    
                float3 dominantDir = L1r + L1g + L1b;
                float3 dir = normalize(normalize(dominantDir) + viewDir);
                float nh = saturate(dot(worldNormal, dir));
                    
                float roughness = 1 - smoothness * 0.9f;
                float roughExp = roughness * roughness;
                    
                float spec = LV_DistributionGGX(nh, roughExp);
                    
                return max(spec * L0 * f0, 0.0) * 1.5f;
                    
            }
            
            float3 LightVolumeSpecularDominant(float3 albedo, float smoothness, float metallic, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                float3 specularf0 = lerp(0.04f, albedo, metallic);
                return LightVolumeSpecularDominant(specularf0, smoothness, worldNormal, viewDir, L0, L1r, L1g, L1b);
            }
            
            float3 LightVolumeEvaluate(float3 worldNormal, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                return float3(LV_EvaluateSH(L0.r, L1r, worldNormal), LV_EvaluateSH(L0.g, L1g, worldNormal), LV_EvaluateSH(L0.b, L1b, worldNormal));
            }
            
            void LightVolumeSH(float3 worldPos, out float3 L0, out float3 L1r, out float3 L1g, out float3 L1b, float3 worldPosOffset = 0) {
                L0 = 0; L1r = 0; L1g = 0; L1b = 0;
                if (_UdonLightVolumeEnabled == 0) {
                    LV_SampleLightProbeDering(L0, L1r, L1g, L1b);
                } else {
                    float4 occlusion = 1;
                    LV_LightVolumeSH(worldPos + worldPosOffset, L0, L1r, L1g, L1b, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, L1r, L1g, L1b);
                }
            }
            
            void LightVolumeAdditiveSH(float3 worldPos, out float3 L0, out float3 L1r, out float3 L1g, out float3 L1b, float3 worldPosOffset = 0) {
                L0 = 0; L1r = 0; L1g = 0; L1b = 0;
                if (_UdonLightVolumeEnabled != 0) {
                    float4 occlusion = 1;
                    LV_LightVolumeAdditiveSH(worldPos + worldPosOffset, L0, L1r, L1g, L1b, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, L1r, L1g, L1b);
                }
            }
            
            float3 LightVolumeSH_L0(float3 worldPos, float3 worldPosOffset = 0) {
                if (_UdonLightVolumeEnabled == 0) {
                    return float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                } else {
                    float3 L0 = 0; float4 occlusion = 1;
                    float3 unused_L1; // Let's just pray that compiler will strip everything x.x
                    LV_LightVolumeSH(worldPos + worldPosOffset, L0, unused_L1, unused_L1, unused_L1, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, unused_L1, unused_L1, unused_L1);
                    return L0;
                }
            }
            
            float3 LightVolumeAdditiveSH_L0(float3 worldPos, float3 worldPosOffset = 0) {
                if (_UdonLightVolumeEnabled == 0) {
                    return 0;
                } else {
                    float3 L0 = 0; float4 occlusion = 1;
                    float3 unused_L1; // Let's just pray that compiler will strip everything x.x
                    LV_LightVolumeAdditiveSH(worldPos + worldPosOffset, L0, unused_L1, unused_L1, unused_L1, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, unused_L1, unused_L1, unused_L1);
                    return L0;
                }
            }
            
            float LightVolumesEnabled() {
                return _UdonLightVolumeEnabled;
            }
            
            float LightVolumesVersion() {
                return _UdonLightVolumeVersion == 0 ? _UdonLightVolumeEnabled : _UdonLightVolumeVersion;
            }
            
            #endif
            
            #if INCLUDE_LTCGI
            
            void LTCGICallbackDiffuse(inout LTCGIAccumulatorStruct acc, in ltcgi_output output)
            {
                acc.diffuse += output.intensity * output.color;
            }
            
            void LTCGICallbackSpecular(inout LTCGIAccumulatorStruct acc, in ltcgi_output output)
            {
                acc.specular += output.intensity * output.color;
            }    
            
            #define LTCGI_V2_DIFFUSE_CALLBACK LTCGICallbackDiffuse
            #define LTCGI_V2_SPECULAR_CALLBACK LTCGICallbackSpecular
                
            #include "Packages/at.pimaker.ltcgi/Shaders/LTCGI.cginc"
            #endif
            
            // Bakery volume helpers
            #if defined(BAKERY_ENABLED)
            #if defined(BAKERY_VOLUME)
            BakeryVolumeData GetBakeryVolumeTextureData(BakeryVolumeData data)
            {
                #ifdef BAKERY_COMPRESSED_VOLUME
                    data.tex0 = _Volume0.Sample(sampler_Volume0, data.uv);
                    data.tex1 = _Volume1.Sample(sampler_Volume0, data.uv) * 2 - 1;
                    data.tex2 = _Volume2.Sample(sampler_Volume0, data.uv) * 2 - 1;
                    data.tex3 = _Volume3.Sample(sampler_Volume0, data.uv) * 2 - 1;
                    data.L0 = data.tex0.xyz;
                    data.L1x = data.tex1.xyz * data.L0 * 2;
                    data.L1y = data.tex2.xyz * data.L0 * 2;
                    data.L1z = data.tex3.xyz * data.L0 * 2;
                #else
                    data.tex0 = _Volume0.Sample(sampler_Volume0, data.uv);
                    data.tex1 = _Volume1.Sample(sampler_Volume0, data.uv);
                    data.tex2 = _Volume2.Sample(sampler_Volume0, data.uv);
                    data.L0 = data.tex0.xyz;
                    data.L1x = data.tex1.xyz;
                    data.L1y = data.tex2.xyz;
                    data.L1z = float3(data.tex0.w, data.tex1.w, data.tex2.w);
                #endif
                return data;
            }
            
            BakeryVolumeSpecularData GetBakeryVolumeSpecularData(BakeryVolumeData data)
            {
                BakeryVolumeSpecularData ret = (BakeryVolumeSpecularData) 0;
            
                float3 nL1x = data.L1x / data.L0;
                float3 nL1y = data.L1y / data.L0;
                float3 nL1z = data.L1z / data.L0;
                ret.direction = float3(dot(nL1x, lumaConv), dot(nL1y, lumaConv), dot(nL1z, lumaConv));
                ret.color = data.L0 + ret.direction.x * data.L1x + ret.direction.y * data.L1y + ret.direction.z * data.L1z;
                ret.NoV = dot(data.normal, data.viewDir);
                ret.NoV = max(ret.NoV, 0.0001);
                return ret;
            }
            
            #endif
            
            #endif

            // Functions
            void PBRFragment(MeshData d, inout SurfaceData o) {
                // this allows us to handle things like parallax nicely
                #if defined(PARALLAX)
                    GLOBAL_uv = GLOBAL_parallaxUv;
                #else
                    GLOBAL_uv = d.uv0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                #endif
            
                // Do Triplanar
                if (_MappingSpace == 3)
                {
                    // Fast (bad) Triplanar
                    float3 axisProjection = mul(float3(0.0001, 0.0001, 1), d.TBNMatrix);
                    axisProjection = abs(axisProjection);
                    axisProjection = pow(axisProjection, 160);
                    axisProjection /= axisProjection.x + axisProjection.y + axisProjection.z;
                    axisProjection = saturate(invLerp(axisProjection, 0.5, 0.5001));
                    axisProjection.z += saturate(1 - length(axisProjection));
            
                    float3 pos = d.worldSpacePosition * _MainTex_ST.x;
                    GLOBAL_uv = pos.zy;
                    GLOBAL_uv *= axisProjection.x;
                    GLOBAL_uv += pos.xz * axisProjection.y;
                    GLOBAL_uv += pos.xy * axisProjection.z;
            
                }
                else if (_MappingSpace > 0)
                {
                    GLOBAL_uv = (_MappingSpace - 1) ? half2(d.worldSpacePosition[_PlanarAxisX], d.worldSpacePosition[_PlanarAxisY]) : half2(d.localSpacePosition[_PlanarAxisX], d.localSpacePosition[_PlanarAxisY]);
                    GLOBAL_uv *= _MainTex_ST.xy + _MainTex_ST.zw;
                }
                half4 albedo = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, GLOBAL_uv);
                if (_AlbedoChannel > 0)
                {
                    albedo.rgb = albedo[_AlbedoChannel - 1].xxx;
                }
                half4 masks = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, GLOBAL_uv);
                float4 normalTex = SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, GLOBAL_uv);
                if (_FlipBumpY)
                {
                    normalTex.y = 1 - normalTex.y;
                }
                    
                float3 normal = UnpackNormalScale(normalTex, _BumpScale);
            
                half3 emission = SAMPLE_TEXTURE2D(_EmissionMap, sampler_EmissionMap, GLOBAL_uv).rgb;
                if (_EmissionChannel > 0)
                {
                    emission.rgb = emission[_EmissionChannel - 1].xxx;
                }
                int hasMasks = _MaskMap_TexelSize.z > 8;
                half metal = masks[_MetalChannel];
                half smooth = masks[_SmoothChannel];
                if (_RoughnessMode)
                {
                    smooth = 1 - smooth;
                }
                half detailMask = masks[_DetailMaskChannel];
                half occlusion = masks[_AOChannel];
                metal = remap(metal, 0, 1, _MetallicRemap.x, _MetallicRemap.y);
                smooth = remap(smooth, 0, 1, _SmoothnessRemap.x, _SmoothnessRemap.y);
                GLOBAL_maskMap = half4(metal, occlusion, detailMask, smooth);
                o.Metallic = lerp(_Metallic, metal, hasMasks);
                o.Smoothness = lerp(_Smoothness, smooth, hasMasks);
                o.Occlusion = lerp(1, occlusion, _OcclusionStrength);
                o.Normal = normal;
                if (!_DetailAsTintMask)
                {
                    o.Albedo *= albedo.rgb * _Color.rgb;
                }
                else
                {
                    o.Albedo *= lerp(albedo, albedo.rgb * _Color.rgb, detailMask);
                }
                // Fix BC7 compression issues, unity PLS fix
                {
                    uint a = uint(o.Alpha * 255.0);
                    a = a > 254 ? 255 : a;
                    a = a < 5 ? 0 : a;
                    o.Alpha =  a / 255.0;
                }
            
                o.Alpha *= albedo.a * _Color.a;
                #if defined(_EMISSION)
                    o.Emission = emission * pow(_EmissionColor,2.2);
                #endif
            }
            

            #if defined(_PARALLAXSTEPS_EIGHT)
                #define PARALLAX_STEPS 8
            #elif defined(_PARALLAXSTEPS_SIXTEEN)
                #define PARALLAX_STEPS 16
            #elif defined(_PARALLAXSTEPS_THIRTYTWO)
                #define PARALLAX_STEPS 32
            #elif defined(_PARALLAXSTEPS_SIXTYFOUR)
                #define PARALLAX_STEPS 64
            #else
                #define PARALLAX_STEPS 1
            #endif
            
            float2 POM_simple(TEXTURE2D_PARAM(heightMap, heightSampler), float currentHeight, float scale, float2 uv, float3 tangetSpaceViewDir, float refPlane, out float heightOffset)
            {
                heightOffset = 0;
                float2 uvOffset = 0;
                float stepSize = 1.0 / PARALLAX_STEPS;
                float stepHeight = 1;
                tangetSpaceViewDir.xy /= (tangetSpaceViewDir.z + 0.42);
                float2 uvDelta = tangetSpaceViewDir.xy * (stepSize * scale);
            
                float2 derivatives = float2(ddx(uv.x), ddy(uv.y));
            
                [unroll(PARALLAX_STEPS)]
                for (int i = 1; i <= PARALLAX_STEPS && stepHeight > currentHeight; i++)
                {
                    uvOffset -= uvDelta;
                    stepHeight -= stepSize;
                    currentHeight = SAMPLE_TEXTURE2D_GRAD(heightMap, heightSampler, uv + uvOffset, derivatives.x, derivatives.y).r + refPlane;
                }
            
                [unroll(3)]
                for (int k = 0; k < 3; k++)
                {
                    uvDelta *= 0.5;
                    stepSize *= 0.5;
            
                    if (stepHeight < currentHeight)
                    {
                        uvOffset += uvDelta;
                        stepHeight += stepSize;
                    } else {
                        uvOffset -= uvDelta;
                        stepHeight -= stepSize;
                    }
                    currentHeight = SAMPLE_TEXTURE2D_GRAD(heightMap, heightSampler, uv + uvOffset, derivatives.x, derivatives.y).r + refPlane;
                }
            
                heightOffset = currentHeight;
                return uvOffset;
            }
            
            void ParallaxFragment(MeshData d, FragmentData i)
            {
                // this is a bit "magical" but basically we just push to global UVs
                // and then any other module will read from them
                // we use FragmentQueue to push the actual function call above the other modules
                GLOBAL_parallaxUv = d.uv0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                #if defined(PARALLAX) && !defined(PLAT_QUEST)
                {
                    float customHeight = 0;
                    if (_ParallaxScaleBasedOnAngle)
                    {
                        float3 forwardRay = TransformViewToWorldDir(float3(0,0,1));
                        _HeightScale *= pow(saturate(dot(d.worldNormal, forwardRay)), 1.0/1.5);
                    }
                    half startingPoint = SAMPLE_TEXTURE2D(_Height, sampler_Height, GLOBAL_parallaxUv).r;
                    float2 uvOffset = POM_simple(TEXTURE2D_ARGS(_Height, sampler_Height), startingPoint, _HeightScale, GLOBAL_parallaxUv, d.tangentSpaceViewDir, _HeightRefPlane, customHeight);
                    GLOBAL_parallaxUv += uvOffset;
            
                    GLOBAL_height = customHeight;
                    GLOBAL_heightSet = 1;
                }
                #endif
            }
            

            void DetailsFragment(MeshData d, inout SurfaceData o)
            {
                #if !defined(DETAILS_OVERLAY)
                    return;
                #else
                half masks = 0;
            
                // we can grab the mask map from the Base Shader if it was present
                #if defined(_MASKMAP_SAMPLED)
                masks = GLOBAL_maskMap.b;
                #else
                masks = 1;
                #endif
            
                half mask = lerp(masks, 1, _DIgnoreMask);
                float2 uv = d.uv0.xy;
                switch(_DUVChannel)
                {
                    case 1: uv = d.uv1.xy; break;
                    case 2: uv = d.uv2.xy; break;
                    case 3: uv = d.uv3.xy; break;
                    default: uv = d.uv0.xy; break;
                }
                uv = uv * _DDetailsMap_ST.xy + _DDetailsMap_ST.zw;
                if (_DMappingSpace > 0)
                {
                    uv = (_DMappingSpace - 1) ? half2(d.worldSpacePosition[_DPlanarAxisX], d.worldSpacePosition[_DPlanarAxisY]) : half2(d.localSpacePosition[_DPlanarAxisX], d.localSpacePosition[_DPlanarAxisY]);
                    uv = uv * _DDetailsMap_ST.xy + _DDetailsMap_ST.zw;
                }
            
                half4 detailsMap = SAMPLE_TEXTURE2D(_DDetailsMap, sampler_DDetailsMap, uv);
            
                #if defined(DETAILS_MODE_PACKED)
                    
                // 0.5 is the neutral value
                half detailAlbedo = detailsMap.r * 2.0 - 1.0;
                half detailSmooth = detailsMap.b * 2.0 - 1.0;
                half3 detailNormal = 0;
                if (_DNormalFlipY)
                {
                    detailsMap.g = 1 - detailsMap.g;
                }
                detailNormal = UnpackNormalScale(float4(detailsMap.ag, 1, 1), _DNormalScale);
                half detailAlbedoSpeed = saturate(abs(detailAlbedo) * _DAlbedoScale);
                half3 albedoOverlay = lerp(sqrt(o.Albedo), (detailAlbedo < 0.0) ? 0.0.xxx : 1.0.xxx, detailAlbedoSpeed * detailAlbedoSpeed);
                albedoOverlay *= albedoOverlay;
            
                // Packed mode only supports HDRP-style albedo mixing
                o.Albedo = lerp(o.Albedo, saturate(albedoOverlay), mask);
            
                #elif defined(DETAILS_MODE_SEPARATED)        
                half detailSmooth = detailsMap.a * 2.0 - 1.0;
            
                half4 packedNormal = SAMPLE_TEXTURE2D(_DDetailsNormal, sampler_DDetailsNormal, uv);
                if (_DNormalFlipY)
                {
                    packedNormal.g = 1 - packedNormal.g;
                }
                half3 detailNormal = UnpackNormalScale(packedNormal, _DNormalScale);
            
                // Separated mdoe supports BIRP-style 2x albedo mixing
                if (_DAlbedoMixingLegacy) {
                    o.Albedo *= LerpWhiteTo(detailsMap.rgb * unity_ColorSpaceDouble.rgb, mask * _DAlbedoScale);
                } else {
                    half3 detailAlbedo = detailsMap.rgb * 2.0 - 1.0;
                    half3 detailAlbedoSpeed = saturate(abs(detailAlbedo) * _DAlbedoScale);
                    half3 albedoOverlay = lerp(sqrt(o.Albedo), (detailAlbedo < 0.0) ? 0.0.xxx : 1.0.xxx, detailAlbedoSpeed * detailAlbedoSpeed);
                    albedoOverlay *= albedoOverlay;
                    o.Albedo = lerp(o.Albedo, saturate(albedoOverlay), mask);
                }
                #endif
            
                // do the smooth details
                half detailSmoothSpeed = saturate(abs(detailSmooth) * _DSmoothScale);
                half smoothOverlay = lerp(o.Smoothness, (detailSmooth < 0.0) ? 0.0 : 1.0, detailSmoothSpeed * detailSmoothSpeed);
                o.Smoothness = lerp(o.Smoothness, saturate(smoothOverlay), mask);
            
                // do the normal details
                o.Normal = lerp(o.Normal, BlendNormals(o.Normal, detailNormal), mask);
                #endif
            }
            

            bool isVR__local()
            {
            #if UNITY_SINGLE_PASS_STEREO
                return true;
            #else
                return false;
            #endif
            }
            
            void VRCFeaturesVertex(inout VertexData v)
            {
                #if defined(VRC_FEATURES)
                bool isMainView = _VRChatCameraMode == 0 && _VRChatMirrorMode == 0;
                bool isInVRHandCam = _VRChatCameraMode == 1;
                bool isInDesktopHandCam = _VRChatCameraMode == 2;
                bool isInVR = isVR__local();
                bool isInDesktop = !isInVR && !isInDesktopHandCam;
                bool isInVRMirror = _VRChatMirrorMode == 1;
                bool isInDesktopMirror = _VRChatMirrorMode == 2;
            
                if (_VRCHideInVR && isInVR && isMainView)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInDesktop && isInDesktop && isMainView)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInVRCamera && isInVRHandCam)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInDesktopCamera && isInDesktopHandCam)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInVRMirror && isInVRMirror)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInDesktopMirror && isInDesktopMirror)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                #endif
            }
            

            void VRCLightVolumesCustomProbesSetup(MeshData d, inout SurfaceData o)
            {
                #if defined(INTEGRATE_VRCLIGHTVOLUMES) && !defined(ORL_LIGHTING_MODEL_UI)
                {
                    float3 L0, L1r, L1g, L1b;
                    LightVolumeSH(d.worldSpacePosition + d.worldNormal * _VRCLightVolumesSurfacePushoff, L0, L1r, L1g, L1b);
                    o.VRCLV_L0 = L0;
                    o.VRCLV_L1r = L1r;
                    o.VRCLV_L1g = L1g;
                    o.VRCLV_L1b = L1b;
            
                    // Since toon shaders can derive light directions from probes
                    // we need to directly modify these values
                    #if defined(ORL_LIGHTING_MODEL_TOON_V2)
                    unity_SHAr = float4(L1r, L0.r);
                    unity_SHAg = float4(L1g, L0.g);
                    unity_SHAb = float4(L1b, L0.b);
                    #endif
                }
                #endif
            }
            

            void VRCLightVolumesCustomProbes(SurfaceData o, MeshData d, inout half3 indirectDiffuse)
            {
                // Custom Probes
                #if defined(INTEGRATE_VRCLIGHTVOLUMES) && !defined(ORL_LIGHTING_MODEL_UI)
                {
                    #if defined(ORL_LIGHTING_MODEL_TOON_V2)
                    {
                        o.Normal = _IgnoreLightprobeNormal ? float3(0, 0.5, 0) : o.WorldNormal;
                    }
                    #endif
                    indirectDiffuse = LightVolumeEvaluate(o.Normal, o.VRCLV_L0, o.VRCLV_L1r, o.VRCLV_L1g, o.VRCLV_L1b);
                }
                #endif
            }
            

            void VRCLightVolumesCustomProbesBakedSpecular(SurfaceData o, MeshData d, inout half3 indirectSpecular, inout half3 bakedSpecularColor, inout half3 bakedDominantDirection)
            {
                #if defined(INTEGRATE_VRCLIGHTVOLUMES) && !defined(ORL_LIGHTING_MODEL_UI)
                bakedSpecularColor = o.VRCLV_L0;
                bakedDominantDirection = o.VRCLV_L1r.xyz + o.VRCLV_L1g.xyz + o.VRCLV_L1b.xyz;
                #endif
            }
            

            void VRCLightVolumesCustomGI(SurfaceData o, MeshData d, inout half3 indirectDiffuse)
            {
                #if defined(INTEGRATE_VRCLIGHTVOLUMES)
                {
                    #if defined(LIGHTMAP_ON)
                    {
                        float3 L0, L1r, L1g, L1b;
                        LightVolumeAdditiveSH(d.worldSpacePosition + d.worldNormal * _VRCLightVolumesSurfacePushoff, L0, L1r, L1g, L1b);
                        indirectDiffuse += LightVolumeEvaluate(o.Normal, L0, L1r, L1g, L1b);
                    }
                    #endif
                }
                #endif
            }
            

            void VRCLightVolumesColor(MeshData d, bool facing, inout half4 FinalColor)
            {
                #if !defined(UNITY_PASS_FORWARDBASE)
                return;
                #endif
                #if !defined(ORL_LIGHTING_MODEL_UI)
                return;
                #endif
            
                #if defined(INTEGRATE_VRCLIGHTVOLUMES)
                {
                    float3 L0, L1r, L1g, L1b;
                    float3 worldNormal = d.worldNormal;
                    if (!facing) {
                        worldNormal = -worldNormal;
                    }
                    LightVolumeSH(d.worldSpacePosition + worldNormal * _VRCLightVolumesSurfacePushoff, L0, L1r, L1g, L1b);
                    half3 indirectDiffuse = LightVolumeEvaluate(worldNormal, L0, L1r, L1g, L1b);
                    FinalColor.rgb *= indirectDiffuse;
                }
                #endif
            
            }
            

            void PosterDisplayFragment(FragmentData i, inout SurfaceData o)
            {
                fixed4 col = GetPosterColor(
                    i.uv0.xy,
                    _TimeOffset,
                    _DurationStatic,
                    _DurationEase,
                    _GridHorizontal,
                    _GridVertical,
                    _CellMargin,
                    _EaseFunction,
                    _EaseAnimation,
                    _PosterTex, _PosterTex_ST, _PosterTint,
                    _IdleTex, _IdleTex_ST, _IdleTint,
                    _Idling
                );
            
                o.Albedo *= col;
                o.Emission *= col;
            }
            

            
                void ALFragment(MeshData d, inout SurfaceData o)
                {
                    UNITY_BRANCH
                    if (_KillEffects) return;
            
                    UNITY_BRANCH
                    if (!AudioLinkIsAvailable()) return;
            
                    half3 finalEmission = 0;
                    half finalAlpha = 1;
                    float2 uv = 0;
                    switch(_ALUVChannel)
                    {
                        case 0: uv = d.uv0.xy; break;
                        case 1: uv = d.uv1.xy; break;
                        case 2: uv = d.uv2.xy; break;
                        case 3: uv = d.uv3.xy; break;
                    }
                    half4 mask = SAMPLE_TEXTURE2D(_ALMask, sampler_ALMask, uv);
                    
                    #if defined(AL_EFFECT_BAND_SELECTION)
            
                    half uvSource = lerp(uv.x, lerp(uv.y, lerp(1 - uv.x, 1 - uv.y, saturate(_BandScrollAxis - 2)), saturate(_BandScrollAxis - 1)), saturate(_BandScrollAxis));
                    half scaledUv = (uvSource * _BandHistoryRange) % 128.0;
                    half4 bandData = AudioLinkLerp(float2(scaledUv, clamp(_BandFrequency - 1, 0, 3)));
                    finalEmission = bandData.rgb * _ALTint;
                    finalAlpha = bandData.r;
            
                    #elif defined(AL_EFFECT_UV_BASED)
            
                    float2 scaledUv = float2(lerp(uv.x, uv.y, _UVFlipXY) * _UVHistoryRange % 128, floor(lerp(uv.y, uv.x, _UVFlipXY) * 4));
                    half4 bandData = AudioLinkLerp(scaledUv).rrra;
                    if (_UVUseThemeColors)
                    {
                        int band = clamp(floor(scaledUv.y), 0, 3);
                        switch(band)
                        {
                            case 0:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR0);
                                break;
                            case 1:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR1);
                                break;
                            case 2:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR2);
                                break;
                            case 3:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR3);
                                break;
                        }
                    }
                    finalEmission = bandData.rgb * _ALTint;
                    finalAlpha = bandData.r;
            
                    #elif defined(AL_EFFECT_WAVEFORM)
            
                    half noteno = abs(uv.x) * AUDIOLINK_ETOTALBINS;
                    half wvfrm = AudioLinkLerpMultiline(ALPASS_DFT + half2(noteno, 0)).z * _WVFRMScale;
                    half2 gradientUvs = uv;
                    if (_WVFRMFlipUVDirection) {
                        gradientUvs = half2(gradientUvs.y, gradientUvs.x);
                    }
                    half4 bottomColor = SAMPLE_TEXTURE2D(_WVFRMBottomColor, sampler_WVFRMBottomColor, gradientUvs);
                    half4 topColor = SAMPLE_TEXTURE2D(_WVFRMTopColor, sampler_WVFRMBottomColor, gradientUvs);
                    half4 midColor = SAMPLE_TEXTURE2D(_WVFRMMiddleColor, sampler_WVFRMBottomColor, gradientUvs);
                    half4 finalBlend = lerp(lerp(bottomColor, midColor, _WVFRMMiddleLine > 0 && lerp(uv.y, 1 - uv.y, _WVFRMFlip) > (wvfrm + _WVFRMOffset) - _WVFRMMiddleLineWidth), topColor, lerp(uv.y, 1 - uv.y, _WVFRMFlip) > (wvfrm + _WVFRMOffset));
                    finalEmission = finalBlend.rgb;
                    finalEmission *= _ALTint;
                    finalAlpha = finalBlend.a;
            
                    #elif defined(AL_EFFECT_PULSE)
            
                    half pulseData = 0;
                    UNITY_BRANCH
                    if (_PulseSmoothing == 0) {
                        pulseData = AudioLinkData(int2(0, clamp(_PulseBand - 1, 0, 3))).r;
                    } else {
                        pulseData = AudioLinkData(ALPASS_FILTEREDAUDIOLINK + int2(16 - _PulseSmoothing, clamp(_PulseBand - 1, 0, 3))).r;
                    }
                    if (_PulseMode == 0)
                    {
                        if (!_PulseEmissionMode)
                        {
                            finalEmission = o.Emission + pulseData * _ALTint * _PulseStrength;
                        }
                        else
                        {
                            finalEmission = o.Emission * pulseData * _ALTint * _PulseStrength;
                        }
                    }
                    else
                    {
                        finalEmission = pulseData * _PulseStrength * _ALTint;
                        if (_PulseTextureAdjustment == 0)
                        {
                            uv += _PulseTextureDirection.xy * pulseData;
                        }
                        else
                        {
                            float chrono = (AudioLinkDecodeDataAsUInt(ALPASS_CHRONOTENSITY + uint2(1, 0)) % 1000000) / 1000000.0;
                            uv += _PulseTextureDirection.xy * chrono;
                        }
                        finalEmission += SAMPLE_TEXTURE2D(_PulseTexture, sampler_PulseTexture, uv) * _ALTint;
                    }
            
                    #elif defined(AL_EFFECT_BAR)
            
                    float uvSource = lerp(uv.x, lerp(uv.y, lerp(1 - uv.x, 1 - uv.y, saturate(_BarAxis - 2)), saturate(_BarAxis - 1)), saturate(_BarAxis));
                    half3 color = SAMPLE_TEXTURE2D(_BarColor, sampler_BarColor, half2(uvSource, 0)).rgb;
                    half bandData = 0;
                    UNITY_BRANCH
                    if (_BarSmoothing == 0) {
                        bandData = saturate(AudioLinkData(int2(0, clamp(_BarBand - 1, 0, 3))).r * _BarScale);
                    } else {
                        bandData = saturate(AudioLinkData(ALPASS_FILTEREDAUDIOLINK + int2(16 - _BarSmoothing, clamp(_BarBand - 1, 0, 3))).r * _BarScale);
                    }
                    half barData = smoothstep((1 - bandData), (1 - bandData) + 0.01, uvSource);
                    finalEmission = lerp(0, barData.xxx * _ALTint.rgb * color.rgb, bandData);
                    finalAlpha = barData * bandData;
            
                    #endif
            
                    o.Emission = lerp(o.Emission, finalEmission, mask.r);
                    #if defined(AL_CUTOUT)
                    o.Alpha = finalAlpha;
                    #endif
                }
            

            void LTCGICustomGI(MeshData d, SurfaceData o, inout half3 customGISpecular, inout half3 customGIDiffuse)
            {
                #if !defined(ORL_LIGHTING_MODEL_VFX)
                {
                    #if defined(PLAT_QUEST)
                    if (!_LTCGIEnableOnMobile) return;
                    #endif
            
                    #if defined(INTEGRATE_LTCGI)
                        LTCGIAccumulatorStruct ltcgiData = (LTCGIAccumulatorStruct) 0;
            
                        LTCGI_Contribution(
                            ltcgiData,
                            d.worldSpacePosition.xyz,
                            o.Normal.xyz,
                            d.worldSpaceViewDir,
                            saturate((1 - o.Smoothness) + _LTCGIRoughnessModifier),
                            d.uv1.xy
                        );
            
                        if (_LTCGIClampBrightness) {
                            half3 hsv = RGB2HSV(ltcgiData.specular);
                            hsv.z = tanh(hsv.z) * max(0, _LTCGIMaxBrightness);
                            customGISpecular += HSV2RGB(hsv) * _LTCGISpecularIntensity;
                        } else {
                            customGISpecular += ltcgiData.specular * _LTCGISpecularIntensity;
                        }
                        customGIDiffuse += ltcgiData.diffuse * _LTCGIDiffuseIntensity;
                    #endif
                }
                #endif
            }
            

            void LTCGIColor(MeshData d, FragmentData i, inout half4 FinalColor, bool facing)
            {
                #if defined(ORL_LIGHTING_MODEL_VFX)
                {
                    #if defined(PLAT_QUEST)
                    if (!_LTCGIEnableOnMobile) return;
                    #endif
            
                    #if defined(INTEGRATE_LTCGI)
                        LTCGIAccumulatorStruct ltcgiData = (LTCGIAccumulatorStruct) 0;
            
                        float3 viewDir = d.worldSpaceViewDir;
                        if (!facing)
                        {
                            viewDir = -d.worldSpaceViewDir;
                        }
            
                        LTCGI_Contribution(
                            ltcgiData,
                            d.worldSpacePosition.xyz,
                            d.worldNormal.xyz,
                            viewDir,
                            saturate(0.5 + _LTCGIRoughnessModifier),
                            d.uv1.xy
                        );
            
                        if (_LTCGIClampBrightness) {
                            half3 hsv = RGB2HSV(ltcgiData.specular);
                            hsv.z = tanh(hsv.z) * max(0, _LTCGIMaxBrightness);
                            FinalColor.rgb += HSV2RGB(hsv) * _LTCGISpecularIntensity;
                        } else {
                            FinalColor.rgb += ltcgiData.specular * _LTCGISpecularIntensity;
                        }
                        FinalColor.rgb += ltcgiData.diffuse * _LTCGIDiffuseIntensity;
                        if (_LTCGIAlphaPremultiply)
                        {
                            FinalColor.rgb *= FinalColor.a;
                        }
                    #endif
                }
                #endif
            }
            

            void FragmentBase(MeshData d, FragmentData i, SurfaceData o, inout half4 FinalColor)
            {
                #if defined(UNITY_PASS_SHADOWCASTER)
                    return;
                #else
            
                half reflectance = 0.5;
                float oneMinusReflectivity = 1.0 - 0.04 - o.Metallic * (1.0 - 0.04);
                half3 f0 = 0.16 * reflectance * reflectance * oneMinusReflectivity + o.Albedo * o.Metallic;
            
                half3 indirectDiffuse = 0;
                half3 indirectSpecular = 0;
                    
                half occlusion = o.Occlusion;
            
                half perceptualRoughness = 1 - o.Smoothness;
            
                float3 tangentNormal = o.Normal;
            
                #if defined(SHADING_MODE_CLOTH)
                half3 albedoSqrt = sqrt(o.Albedo);
                #endif
                    
                o.Normal = Unity_SafeNormalize(mul(o.Normal, d.TBNMatrix));
            
                #ifndef USING_DIRECTIONAL_LIGHT
                float3 lightDir = Unity_SafeNormalize(UnityWorldSpaceLightDir(d.worldSpacePosition));
                #else
                float3 lightDir = Unity_SafeNormalize(_WorldSpaceLightPos0.xyz);
                #endif
            
                #if defined(GSAA)
                perceptualRoughness = GSAA_Filament(_GSAAIncludeNormalMaps ? o.Normal : d.worldNormal, perceptualRoughness, _GSAAVariance, _GSAAThreshold);
                #endif
            
                UNITY_LIGHT_ATTENUATION(lightAttenuation, i, d.worldSpacePosition);
                half3 lightColor = lightAttenuation * _LightColor0.rgb;
            
                float3 lightHalfVector = Unity_SafeNormalize(lightDir + d.worldSpaceViewDir);
                half lightNoL = saturate(dot(o.Normal, lightDir));
                half lightLoH = saturate(dot(lightDir, lightHalfVector));
            
                half NoV = abs(dot(o.Normal, d.worldSpaceViewDir)) + 1e-5;
            
                // Standard BRDF Setup
                half3 dfguv = half3(NoV, perceptualRoughness, 0);
                float2 dfg = SAMPLE_TEXTURE2D(_DFG, sampler_DFG, dfguv).xy;
                half3 energyCompensation = 1.0 + f0 * (1.0 / dfg.y - 1.0);
            
                float rough = perceptualRoughness * perceptualRoughness;
                half clampedRoughness = max(rough, ORL_MIN_ROUGHNESS);
            
                // Clear Coat BRDF Setup
                #if defined(CLEARCOAT)
                half3 clearcoatdfguv = 0;
                float2 clearcoatdfg = 0;
            
                float clearCoatAttenuation = 1.0;
                float clearCoatRoughness = 1.0 - _ClearCoatSmoothness;
                half clampedClearCoatRoughness = max(clearCoatRoughness * clearCoatRoughness, ORL_MIN_ROUGHNESS);
                half3 clearCoatMainLightSpecular = 0;
                half3 clearCoatIndirectSpecular = 0;
                #endif
            
                half3 mainLightDiffuse = 0;
                half3 mainLightSpecular = 0;
            
                mainLightDiffuse = Fd_Burley(perceptualRoughness, NoV, lightNoL, lightLoH);
            
                #if defined(SHADING_MODE_CLOTH)
                {
                    if (_ClothHasSubsurface)
                    {
                        mainLightDiffuse *= Fd_Wrap(dot(o.Normal, lightDir), 0.5);
                        mainLightDiffuse *= saturate(_ClothSubsurfaceColor.rgb + lightNoL);
                    } else {
                        mainLightDiffuse *= lightNoL;
                    }
                    mainLightDiffuse *= lightColor;
                }
                #else
                mainLightDiffuse *= lightColor * lightNoL;
                #endif
            
            
                // Collect Vertex Light Data and calculate direct diffuse
                #if defined(SHADE_VERTEXLIGHTS) &&defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                float4x4 vLightColors = getVertexLightsColors(d.worldSpacePosition, o.Normal, false);
                float4x4 vLightDirections = getVertexLightsDir(d.worldSpacePosition);
                float4x4 vLightHalfVectors = 0;
                float4 vLightNoLs = 0;
                float4 vLightLoHs = 0;
            
                half3 vertexLightDiffuse = 0;
                half3 vertexLightSpecular = 0;
                half3 clearCoatVertexLightSpecular = 0;
            
                [unroll(4)]
                for (int i = 0; i < 4; i++)
                {
                    vLightHalfVectors[i].rgb = Unity_SafeNormalize(vLightDirections[i] + d.worldSpaceViewDir);
                    vLightLoHs[i] = saturate(dot(vLightDirections[i], vLightHalfVectors[i]));
                    vLightNoLs[i] = saturate(dot(o.Normal, vLightDirections[i]));
            
                    half3 vLightDiffuse = Fd_Burley(perceptualRoughness, NoV, vLightNoLs[i], vLightLoHs[i]);
            
                    #if defined(SHADING_MODE_CLOTH)
                    {
                        if (_ClothHasSubsurface)
                        {
                            vLightColors[i].rgb *= Fd_Wrap(dot(o.Normal, vLightDirections[i]), 0.5);
                            vLightColors[i].rgb *= saturate(_ClothSubsurfaceColor.rgb + vLightNoLs[i]);
                        } else {
                            vLightDiffuse *= vLightNoLs[i];
                        }
                        vLightDiffuse *= vLightColors[i];
                    }
                    #else
                    vLightDiffuse *= vLightColors[i] * vLightNoLs[i];
                    #endif
            
                    vertexLightDiffuse += vLightDiffuse;
                }
                #endif
            
                // https://assetstore.unity.com/packages/tools/level-design/bakery-gpu-lightmapper-122218
                #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME)
                    BakeryVolumeData volumeData = (BakeryVolumeData) 0;
            
                    if (_Udon_GlobalVolumeAdapterEnabled == 1)
                    {
                        _GlobalVolumeMin = _Udon_GlobalVolumeMin;
                        _GlobalVolumeInvSize = _Udon_GlobalVolumeInvSize;
            
                        // Arbitrary rotation (runtime only)
                        #if defined(BAKERY_VOLROTATION)
                        _GlobalVolumeMatrix = _Udon_GlobalVolumeMatrix;
                        #endif
            
                        // Y Rotation (baked)
                        #if defined(BAKERY_VOLROTATIONY)
                        _GlobalVolumeRY = _Udon_GlobalVolumeRY;
                        #endif
                    }
                        
                    bool isGlobalVolume = _VolumeInvSize.x > 1000000; // ~inf
                    volumeData.viewDir = Unity_SafeNormalize(d.worldSpaceViewDir);
                        
                    // Runtime volume rotation
                    // Requires a special adapter to work in VRChat
                    #if defined(BAKERY_VOLROTATION)
                        float4x4 volMatrix = (isGlobalVolume ? _GlobalVolumeMatrix : _VolumeMatrix);
                        float3 volInvSize = (isGlobalVolume ? _GlobalVolumeInvSize : _VolumeInvSize);
                        volumeData.uv = mul(volMatrix, float4(d.worldSpacePosition,1)).xyz * volInvSize + 0.5f;
            
                        volumeData.normal = mul((float3x3)volMatrix, o.Normal);
                        volumeData.normal = Unity_SafeNormalize(volumeData.normal);
                            
                        #if defined(BAKED_SPECULAR)
                            volumeData.viewDir = mul((float3x3)volMatrix, volumeData.viewDir);
                        #endif
                    #else
                        volumeData.uv = d.worldSpacePosition - (isGlobalVolume ? _GlobalVolumeMin : _VolumeMin);
                        #if defined(BAKERY_VOLROTATIONY)
                            float2 sc = (isGlobalVolume ? _GlobalVolumeRY : _VolumeRY);
                            volumeData.uv.xz = mul(float2x2(sc.y, -sc.x, sc.x, sc.y), volumeData.uv.xz);
                        #endif
                        volumeData.uv *= (isGlobalVolume ? _GlobalVolumeInvSize : _VolumeInvSize);
                        volumeData.normal = o.Normal;
                    #endif
            
                    volumeData.occlusion = saturate(dot(_VolumeMask.Sample(sampler_VolumeMask, volumeData.uv), unity_OcclusionMaskSelector));
            
                    lightColor *= volumeData.occlusion;
                    mainLightDiffuse *= volumeData.occlusion;
            
                    #if defined(SHADE_VERTEXLIGHTS) &&defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                    {
                        vertexLightDiffuse *= volumeData.occlusion;
                    }
                    #endif
            
                #endif    
            
                // READ THE LIGHTMAP
                // Can be Baked, Realtime, both or either
                #if (defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)) && defined(UNITY_PASS_FORWARDBASE)
                    half3 lightMap = 0;
                    half4 bakedColorTex = 0;
                    half2 lightmapUV = d.lightmapUv.xy;
            
                    // explicitly checking for lightmap on because we can be in rtgi only mode
                    #if defined(LIGHTMAP_ON)
                        
                    // UNITY LIGHTMAPPING
                    #if !defined(BAKERYLM_ENABLED) || !defined(BAKERY_ENABLED)
                        lightMap = tex2DFastBicubicLightmap(lightmapUV, bakedColorTex);
                    #endif
            
                    // BAKERY RNM MODE
                    #if defined(BAKERY_RNM) && defined(BAKERY_ENABLED)
                        float3 rnm0 = DecodeLightmap(BakeryTex2D(_RNM0, sampler_RNM0, lightmapUV, _RNM0_TexelSize));
                        float3 rnm1 = DecodeLightmap(BakeryTex2D(_RNM1, sampler_RNM0, lightmapUV, _RNM0_TexelSize));
                        float3 rnm2 = DecodeLightmap(BakeryTex2D(_RNM2, sampler_RNM0, lightmapUV, _RNM0_TexelSize));
                            
                        lightMap = saturate(dot(rnmBasis0, tangentNormal)) * rnm0 +
                        saturate(dot(rnmBasis1, tangentNormal)) * rnm1 +
                        saturate(dot(rnmBasis2, tangentNormal)) * rnm2;
                    #endif
            
                    // BAKERY SH MODE (these are also used for the specular)
                    #if defined(BAKERY_SH) && defined(BAKERY_ENABLED)
                        half3 L0 = DecodeLightmap(BakeryTex2D(unity_Lightmap, samplerunity_Lightmap, lightmapUV, _RNM0_TexelSize));
                            
                        half3 nL1x = BakeryTex2D(_RNM0, sampler_RNM0, lightmapUV, _RNM0_TexelSize) * 2.0 - 1.0;
                        half3 nL1y = BakeryTex2D(_RNM1, sampler_RNM0, lightmapUV, _RNM0_TexelSize) * 2.0 - 1.0;
                        half3 nL1z = BakeryTex2D(_RNM2, sampler_RNM0, lightmapUV, _RNM0_TexelSize) * 2.0 - 1.0;
                        half3 L1x = nL1x * L0 * 2.0;
                        half3 L1y = nL1y * L0 * 2.0;
                        half3 L1z = nL1z * L0 * 2.0;
                            
                        // Non-Linear mode
                        #if defined(BAKERY_SHNONLINEAR)
                        half lumaL0 = dot(L0, half(1));
                        half lumaL1x = dot(L1x, half(1));
                        half lumaL1y = dot(L1y, half(1));
                        half lumaL1z = dot(L1z, half(1));
                        half lumaSH = shEvaluateDiffuseL1Geomerics(lumaL0, half3(lumaL1x, lumaL1y, lumaL1z), o.Normal);
                            
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        half regularLumaSH = dot(lightMap, 1.0);
                        lightMap *= lerp(1.0, lumaSH / regularLumaSH, saturate(regularLumaSH * 16.0));
                        #else
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        #endif
                    #endif
            
                    // Load directional lightmap
                    #if defined(DIRLIGHTMAP_COMBINED)
                        half4 lightMapDirection = tex2DFastBicubicSample(TEXTURE2D_ARGS(unity_LightmapInd, samplerunity_Lightmap), lightmapUV);
                        #if !defined(BAKERY_MONOSH)
                            lightMap = DecodeDirectionalLightmap(lightMap, lightMapDirection, o.Normal);
                        #endif
                    #endif
            
                    // Unity+Bakery often results in a full clear of DIRLIGHTMAP_COMBINED keyword
                    // which in turn results in no lightmap being applied when MONOSH is enabled
                    // this is an escape hatch for such a case to improve dev experience
                    #if defined(BAKERY_MONOSH) && defined(BAKERY_ENABLED) && !defined(DIRLIGHTMAP_COMBINED)
                        lightMap = tex2DFastBicubicLightmap(lightmapUV, bakedColorTex);
                    #endif
            
                    // Bakery MonoSH handling
                    #if defined(BAKERY_MONOSH) && defined(BAKERY_ENABLED) && defined(DIRLIGHTMAP_COMBINED)
                        half3 L0 = tex2DFastBicubicLightmap(lightmapUV, bakedColorTex);
                        half3 nL1 = lightMapDirection.xyz * 2.0 - 1.0;
                        half3 L1x = nL1.x * L0 * 2.0;
                        half3 L1y = nL1.y * L0 * 2.0;
                        half3 L1z = nL1.z * L0 * 2.0;
            
                        #if defined(BAKERY_SHNONLINEAR)
                        half lumaL0 = dot(L0, 1);
                        half lumaL1x = dot(L1x, 1);
                        half lumaL1y = dot(L1y, 1);
                        half lumaL1z = dot(L1z, 1);
                        half lumaSH = shEvaluateDiffuseL1Geomerics(lumaL0, half3(lumaL1x, lumaL1y, lumaL1z), o.Normal);
            
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        half regularLumaSH = dot(lightMap, 1);
                        lightMap *= lerp(1, lumaSH / regularLumaSH, saturate(regularLumaSH*16));
                        #else
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        #endif
            
                        lightMap = max(lightMap, 0.0);
                    #endif
            
                    #endif // defined(LIGHTMAP_ON)
            
                    // Handle RTGI specifically
                    #if defined(DYNAMICLIGHTMAP_ON) && !defined(PLAT_QUEST)
                        // only branch on non-meta passes
                        #if !defined(UNITY_PASS_META)
                        {
                            [branch]
                            if (!_IgnoreRealtimeGI) {
                                half3 realtimeLightMap = getRealtimeLightmap(d.lightmapUv.zw, o.Normal, _RealtimeGIDisableBicubic);
                                lightMap += realtimeLightMap;
                            }
                        }
                        #else
                        {
                            half3 realtimeLightMap = getRealtimeLightmap(d.lightmapUv.zw, o.Normal);
                            lightMap += realtimeLightMap;
                        }
                        #endif
                    #endif
            
                    #if defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN)
                        mainLightDiffuse = 0;
                        lightMap = SubtractMainLightWithRealtimeAttenuationFromLightmapMultiply(lightMap, lightAttenuation, bakedColorTex, o.Normal);
                    #endif
            
                    indirectDiffuse = lightMap;
            
                // Lightmapping end
            
                // Bakery Volume Sampling (replaces probes and LPPVs)
                #elif defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME) && defined(UNITY_PASS_FORWARDBASE)
                    // Sample the volume textures
                    volumeData = GetBakeryVolumeTextureData(volumeData);
                    // Sample using Geomerics approach, similar to lightprobes and LPPVs
                    indirectDiffuse = max(0, GetNonLinearSH(
                        volumeData.L0, 
                        float3(volumeData.L1x.r, volumeData.L1y.r, volumeData.L1z.r),
                        float3(volumeData.L1x.g, volumeData.L1y.g, volumeData.L1z.g),
                        float3(volumeData.L1x.b, volumeData.L1y.b, volumeData.L1z.b),
                        volumeData.normal)
                    );
            
                // Lightprobes Sampling
                #elif defined(UNITY_PASS_FORWARDBASE)
                    #if defined(_INTEGRATE_CUSTOMPROBES)
                    {
                        VRCLightVolumesCustomProbesSetup(d, o);
                    }
                    #endif
                    // LPPV support
                    #if UNITY_LIGHT_PROBE_PROXY_VOLUME
                    {
                        UNITY_BRANCH
                        if (unity_ProbeVolumeParams.x == 1)
                        {
                            indirectDiffuse = SHEvalLinearL0L1_SampleProbeVolume(half4(o.Normal, 1), d.worldSpacePosition);
                        }
                        else // Mesh has BlendProbes instead of LPPV
                        {
                            // Enable Integration of Custom Lightprobe solutions
                            #if defined(_INTEGRATE_CUSTOMPROBES)
                            {
                                VRCLightVolumesCustomProbes(o, d, indirectDiffuse);
                            }
                            #else
                            {
                                #if defined(NONLINEAR_SH)
                                {
                                    half3 L0 = half3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                                    half3 L0L2 = half3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0;
                                    L0 = L0+L0L2;
                                    indirectDiffuse = max(0, GetNonLinearSH(L0, unity_SHAr, unity_SHAg, unity_SHAb, o.Normal));
                                    indirectDiffuse += SHEvalLinearL2(float4(o.Normal, 1));
                                }
                                #else
                                {
                                    indirectDiffuse = max(0, ShadeSH9(half4(o.Normal, 1)));   
                                }
                                #endif
                            }
                            #endif
                        }
                    }
                    #else // No LPPVs enabled project-wide
                    {
                        // Enable Integration of Custom Lightprobe solutions
                        #if defined(_INTEGRATE_CUSTOMPROBES)
                        {
                            VRCLightVolumesCustomProbes(o, d, indirectDiffuse);
                        }
                        #else
                        {
                            #if defined(NONLINEAR_SH)
                            {
                                half3 L0 = half3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                                half3 L0L2 = half3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0;
                                L0 = L0+L0L2;
                                indirectDiffuse = max(0, GetNonLinearSH(L0, unity_SHAr, unity_SHAg, unity_SHAb, o.Normal));
                                indirectDiffuse += SHEvalLinearL2(float4(o.Normal, 1));
                            }
                            #else
                            {
                                indirectDiffuse = max(0, ShadeSH9(half4(o.Normal, 1)));   
                            }
                            #endif
                        }
                        #endif
                    }
                    #endif
                #endif // end of #if defined(LIGHTMAP_ON) && !defined(UNITY_PASS_FORWARDADD)
            
                // Attenuate main light diffuse by shadowmask
                float3 forwardShadows = 1;
                #if defined(LIGHTMAP_SHADOW_MIXING) && defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) && defined(LIGHTMAP_ON) && !defined(UNITY_PASS_FORWARDADD)
                {
                    forwardShadows = UnityComputeForwardShadows(d.lightmapUv.xy, d.worldSpacePosition, d.screenPos);
                    mainLightDiffuse *= forwardShadows;
                }
                #endif
            
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                clearcoatdfguv = half3(NoV, clearCoatRoughness, 0);
                clearcoatdfg = SAMPLE_TEXTURE2D(_DFG, sampler_DFG, clearcoatdfguv).xy;
            
                half clearCoatMask = _ClearCoatStrength;
                [branch]
                if (_HasClearCoatMask)
                {
                    clearCoatMask *= SAMPLE_TEXTURE2D(_ClearCoatMask, sampler_MainTex, d.uv0.xy * _ClearCoatMask_ST.xy + _ClearCoatMask_ST.zw)[_ClearCoatMaskChannel];
                }
                #endif
            
                // DIRECT REALTIME SPECULAR
                #if !defined(SPECULAR_HIGHLIGHTS_OFF) && defined(USING_LIGHT_MULTI_COMPILE)
                {
                    // Main Light
                    {
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            mainLightSpecular = GetSpecularHighlights(lightColor, f0, o.Normal, lightHalfVector, lightLoH, lightNoL, NoV, clampedRoughness, energyCompensation);
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            mainLightSpecular = GetSpecularHighlightsCloth(lightColor, o.Normal, lightHalfVector, lightNoL, NoV, clampedRoughness, energyCompensation, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                        }
                        #endif
            
                        mainLightSpecular *= lightNoL;
            
                        #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                        {
                            clearCoatMainLightSpecular = GetSpecularHighlightsClearCoat(lightColor, f0, d.worldNormal, lightHalfVector, lightLoH, clampedClearCoatRoughness, clearCoatMask, clearCoatAttenuation);
                            clearCoatMainLightSpecular *= saturate(dot(d.worldNormal, lightDir));
                        }
                        #endif
                    }
            
                    // Vertex Lights
                    #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                    {
                        [unroll(4)]
                        for (int i = 0; i < 4; i++)
                        {
                            #if defined(SHADING_MODE_DEFAULT)
                            {
                                vertexLightSpecular += vLightNoLs[i] * GetSpecularHighlights(vLightColors[i], f0, o.Normal, vLightHalfVectors[i], vLightLoHs[i], vLightNoLs[i], NoV, clampedRoughness, energyCompensation);
                            }
                            #elif defined(SHADING_MODE_CLOTH)
                            {
                                vertexLightSpecular += vLightNoLs[i] * GetSpecularHighlightsCloth(vLightColors[i], o.Normal, vLightHalfVectors[i], vLightNoLs[i], NoV, clampedRoughness, energyCompensation, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                            }
                            #endif
            
                            // Clear Coat
                            #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                            {
                                clearCoatVertexLightSpecular += GetSpecularHighlightsClearCoat(vLightColors[i], f0, d.worldNormal, vLightHalfVectors[i], vLightLoHs[i], clampedClearCoatRoughness, clearCoatMask, clearCoatAttenuation) * saturate(dot(d.worldNormal, vLightDirections[i]));
                            }
                            #endif
                        }
                    }
                    #endif
                }
                #endif
            
                // Attenuate main light specular by shadowmask
                #if defined(LIGHTMAP_SHADOW_MIXING) && defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) && defined(LIGHTMAP_ON) && !defined(UNITY_PASS_FORWARDADD)
                {
                    mainLightSpecular *= forwardShadows;
                }
                #endif
            
                // BAKED SPECULAR
                half3 bakedDirectSpecular = 0;
                #if defined(BAKED_SPECULAR) && !defined(BAKERYLM_ENABLED) && defined(UNITY_PASS_FORWARDBASE)
                {
                    half3 bakedDominantDirection = 1;
                    half3 bakedSpecularColor = 0;
            
                    // only do it if we have a directional lightmap
                    #if defined(DIRLIGHTMAP_COMBINED) && defined(LIGHTMAP_ON)
                    bakedDominantDirection = (lightMapDirection.xyz) * 2 - 1;
                    half directionality = max(0.001, length(bakedDominantDirection));
                    bakedDominantDirection /= directionality;
                    bakedSpecularColor = indirectDiffuse;
                    #endif
            
                    // if we do not have lightmap - derive the specular from probes
                    #if !defined(LIGHTMAP_ON)
                    bakedSpecularColor = half3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                    bakedDominantDirection = unity_SHAr.xyz + unity_SHAg.xyz + unity_SHAb.xyz;
            
                    // Enable Custom Lightprobes to write to baked specular
                    #if defined(_INTEGRATE_CUSTOMPROBES)
                    {
                        VRCLightVolumesCustomProbesBakedSpecular(o, d, indirectSpecular, bakedSpecularColor, bakedDominantDirection);
                    }
                    #endif
                    #endif
            
                    bakedDominantDirection = normalize(bakedDominantDirection);
                    #if defined(SHADING_MODE_DEFAULT)
                    {
                        bakedDirectSpecular = GetSpecularHighlights(o.Normal, bakedSpecularColor, bakedDominantDirection, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, energyCompensation);
                    }
                    #elif defined(SHADING_MODE_CLOTH)
                    {
                        bakedDirectSpecular = GetSpecularHighlightsCloth(o.Normal, bakedSpecularColor, bakedDominantDirection, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                    }
                    #endif
                }
                #endif
            
                // BAKERY DIRECT SPECULAR
                #if defined(LIGHTMAP_ON) && defined(BAKERY_LMSPEC) && defined(BAKERY_ENABLED) && defined(UNITY_PASS_FORWARDBASE)
                    #if defined(BAKERY_RNM)
                    {
                        float3 viewDirTangent = -Unity_SafeNormalize(d.tangentSpaceViewDir);
                        float3 dominantDirTangent = rnmBasis0 * dot(rnm0, lumaConv) +
                        rnmBasis1 * dot(rnm1, lumaConv) +
                        rnmBasis2 * dot(rnm2, lumaConv);
            
                        float3 dominantDirTangentNormalized = Unity_SafeNormalize(dominantDirTangent);
            
                        half3 specColor = saturate(dot(rnmBasis0, dominantDirTangentNormalized)) * rnm0 +
                        saturate(dot(rnmBasis1, dominantDirTangentNormalized)) * rnm1 +
                        saturate(dot(rnmBasis2, dominantDirTangentNormalized)) * rnm2;
            
                        float3 halfVector = Unity_SafeNormalize(dominantDirTangentNormalized - viewDirTangent);
                        float NoH = saturate(dot(tangentNormal, halfVector));
                        half3 F = 0
                        float D = 0;
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            F =  F_Schlick(NoV, f0);
                            D = D_GGX(NoH, lerp(1, clampedRoughness, _SpecularRoughnessMod)) * energyCompensation;
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            F = _ClothHasCustomSheen ? _ClothSheenColor : albedoSqrt;
                            D = D_Charlie(lerp(1, clampedRoughness, _SpecularRoughnessMod), NoH);
                        }
                        #endif
                        bakedDirectSpecular += D * specColor * F;
                    }
                    #endif
            
                    #if defined(BAKERY_SH)
                    {
                        half3 dominantDir = half3(dot(nL1x, lumaConv), dot(nL1y, lumaConv), dot(L1z, lumaConv));
                        half3 sh = L0 + dominantDir.x * L1x + dominantDir.y * L1y + dominantDir.z * L1z;
                        dominantDir = normalize(dominantDir);
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            bakedDirectSpecular += GetSpecularHighlights(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, energyCompensation);
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            bakedDirectSpecular += GetSpecularHighlightsCloth(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                        }
                        #endif
                    }
                    #endif
            
                    #if defined(BAKERY_MONOSH) && defined(DIRLIGHTMAP_COMBINED)
                    {
                        half3 dominantDir = nL1;
                        half3 sh = L0 + dominantDir.x * L1x + dominantDir.y * L1y + dominantDir.z * L1z;
                        dominantDir = normalize(dominantDir);
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            bakedDirectSpecular += GetSpecularHighlights(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, energyCompensation);
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            bakedDirectSpecular += GetSpecularHighlightsCloth(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                        }
                        #endif
                    }
                    #endif
                #endif // End of #if defined(BAKERY_LMSPEC) && defined(BAKERY_ENABLED) && !defined(UNITY_PASS_FORWARDADD)
            
                // BAKERY VOLUME SPECULAR
                #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME) && defined(BAKERY_LMSPEC) && defined(UNITY_PASS_FORWARDBASE)
                    BakeryVolumeSpecularData volumeSpecularData = GetBakeryVolumeSpecularData(volumeData);
                    #if defined(SHADING_MODE_DEFAULT)
                    {
                        bakedDirectSpecular += GetSpecularHighlights(volumeData.normal, volumeSpecularData.color, volumeSpecularData.direction, f0, volumeData.viewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), volumeSpecularData.NoV, energyCompensation);
                    }
                    #elif defined(SHADING_MODE_CLOTH)
                    {
                        bakedDirectSpecular += GetSpecularHighlightsCloth(volumeData.normal, volumeSpecularData.color, volumeSpecularData.direction, f0, volumeData.viewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), volumeSpecularData.NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                    }
                    #endif
                #endif
            
                // REFLECTIONS
                #if !defined(UNITY_PASS_FORWARDADD)
                float3 reflDir = reflect(-d.worldSpaceViewDir, o.Normal);
            
                // Box projection contact hardening is only available on PC
                #if !defined(PLAT_QUEST)
                {
                    // This is based on David M's improved box projection code https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections
                    // Licensed under MIT license, see https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections/blob/master/LICENSE for details
                    // Only used if probe is set to be box projected
                    if (_BoxProjectionContactHardening && unity_SpecCube0_ProbePosition.w > 0)
                    {
                        indirectSpecular = getEnvReflectionHardened(reflDir, d.worldSpacePosition, perceptualRoughness, _BoxProjectionContactHardeningStrength);
                    } else {
                        indirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, o.Normal, perceptualRoughness, -1);
                    }
                }
                #else
                {
                    indirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, o.Normal, perceptualRoughness, -1);
                }
                #endif
            
                half horizon = min(1 + dot(reflDir, o.Normal), 1);
                indirectSpecular *= horizon * horizon;
            
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                {
                    // Clear Coat uses a different roughness and a mesh normal instead of the normal map
                    reflDir = reflect(-d.worldSpaceViewDir, d.worldNormal);
            
                    // Box projection contact hardening is only available on PC
                    #if !defined(PLAT_QUEST)
                    {
                        // This is based on David M's improved box projection code https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections
                        // Licensed under MIT license, see https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections/blob/master/LICENSE for details
                        // Only used if probe is set to be box projected
                        if (_BoxProjectionContactHardening && unity_SpecCube0_ProbePosition.w > 0)
                        {
                            clearCoatIndirectSpecular = getEnvReflectionHardened(reflDir, d.worldSpacePosition, clearCoatRoughness, _BoxProjectionContactHardeningStrength);
                        } else {
                            clearCoatIndirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, d.worldNormal, clearCoatRoughness, -1);
                        }
                    }
                    #else
                    {
                        clearCoatIndirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, d.worldNormal, clearCoatRoughness, -1);
                    }
                    #endif
            
                    half clearCoatHorizon = min(1 + dot(reflDir, d.worldNormal), 1);
                    clearCoatIndirectSpecular *= clearCoatHorizon * clearCoatHorizon;
                    clearCoatIndirectSpecular *= clearCoatMask;
                }
                #endif
            
                half indirectSpecularOcclusion = saturate(length(indirectDiffuse) * (1.0 / _SpecOcclusion));
            
                // We should only add dfg _after_ we calculated spec occlusion factors
                half3 envBRDF = EnvBRDFMultiscatter(dfg, f0);
                indirectDiffuse *= 1.0 - envBRDF;
                indirectSpecular *= envBRDF;
            
                indirectSpecularOcclusion *= lerp(1, lightAttenuation, _RealtimeShadowSpecOcclusion);
            
                half computedSpecularOcclusion = computeSpecularAO(NoV, o.Occlusion * indirectSpecularOcclusion, clampedRoughness);
                computedSpecularOcclusion *= energyCompensation;
                    
                #if defined(BAKED_SPECULAR)
                {
                    bakedDirectSpecular *= saturate(lerp(1, computedSpecularOcclusion, _BakedSpecularOcclusion));
                }
                #endif
            
                indirectSpecular *= gtaoMultiBounce(computedSpecularOcclusion, f0);
            
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                {
                    half clearcoatNoV = abs(dot(d.worldNormal, d.worldSpaceViewDir)) + 1e-5;
                    computedSpecularOcclusion = computeSpecularAO(clearcoatNoV, o.Occlusion * indirectSpecularOcclusion, clampedRoughness);
                    computedSpecularOcclusion *= energyCompensation;
            
                    half3 envBRDF = EnvBRDFMultiscatter(clearcoatdfg, f0);
                    clearCoatIndirectSpecular *= envBRDF;
                    clearCoatIndirectSpecular *= gtaoMultiBounce(computedSpecularOcclusion, f0);
                }
                #endif
            
                #endif // !defined(UNITY_PASS_FORWARDADD)
            
                // Standard-Like transparent (premult alpha)
                if (_RenderType == 2)
                {
                    o.Albedo.rgb *= o.Alpha;
                    o.Alpha = 1 - (oneMinusReflectivity) + o.Alpha * (oneMinusReflectivity);
                }
            
                #if !defined(_NATIVE_A2C) || (!defined(UNITY_PASS_FORWARDBASE))
                {
                    // Standard-Like cutout
                    if (_RenderType == 1)
                    {
                        clip(o.Alpha - _Cutoff);
                    }
                }
                #endif
            
                FinalColor.rgb = o.Albedo.rgb * (oneMinusReflectivity);
            
                half3 customGIDiffuse = 0;
                half3 customGISpecular = 0;
                // Custom GI
                {
                    #if defined(_INTEGRATE_CUSTOMGI) && !defined(UNITY_PASS_FORWARDADD)
                    IntegrateCustomGI(d, o, indirectSpecular, indirectDiffuse);
                    #endif
            
                    #if defined (_INTEGRATE_CUSTOMGI_FLEX) && !defined(UNITY_PASS_FORWARDADD)
                    VRCLightVolumesCustomGI(o, d, indirectDiffuse);
            
                    LTCGICustomGI(d, o, customGISpecular, customGIDiffuse);
                    #endif
                }
            
                // Diffuse Contributions
                half3 diffuseContributions = 0;
                diffuseContributions += mainLightDiffuse;
                diffuseContributions += indirectDiffuse * occlusion;
                diffuseContributions += customGIDiffuse * occlusion;
            
                // Add vertex Lights
                #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                {
                    diffuseContributions += vertexLightDiffuse;
                }
                #endif
            
                // Specular Contributions
                half3 specularContributions = 0;
                specularContributions += mainLightSpecular;
                specularContributions += bakedDirectSpecular;
                specularContributions += indirectSpecular;
                specularContributions += customGISpecular;
            
                // Add vertex Lights
                #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                {
                    specularContributions += vertexLightSpecular;
                }
                #endif
            
                // Add clear coat layer
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                {
                    specularContributions += clearCoatMainLightSpecular;
                    specularContributions += clearCoatIndirectSpecular;
            
                    // Add vertex Lights
                    #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                    {
                        specularContributions += clearCoatVertexLightSpecular;
                    }
                #endif
                }
                #endif
            
                // Compositing
                FinalColor.rgb *= diffuseContributions;
                FinalColor.rgb += specularContributions;
            
                if (_RenderType > 1)
                {
                    FinalColor.a = o.Alpha;
                }
                    
                #if defined(UNITY_PASS_FORWARDBASE)
                FinalColor.rgb += o.Emission;
                #endif
            
                // Premulty output by alpha for correct `Fade` mode
                #if defined(UNITY_PASS_FORWARDADD)
                if (_RenderType == 3)
                {
                    FinalColor.rgb *= o.Alpha;
                }
                #endif
            
                #endif // shadowcaster check
            }
            

            void FragmentBaseMetaColor(inout SurfaceData o)
            {
                // Boost emissive for Meta (mostly for RTGI)
                #if defined(UNITY_PASS_META)
                o.Emission *= pow(_GIEmissiveBoost, 2.2);
                #endif
            }
            

            void FragmentBaseColorCorr(inout half4 FinalColor) {
                #if defined(APPLY_COLOR_CORRECTION) && defined(PLAT_QUEST)
                    
                #if defined(MOBILE_TONEMAP_ACES)
                FinalColor.rgb = Tonemap_ACES(FinalColor.rgb);
                #elif defined(MOBILE_TONEMAP_UNREAL)
                FinalColor.rgb = pow(Tonemap_Unreal(FinalColor.rgb), 2.2);
                #elif defined(MOBILE_TONEMAP_UNCHARTED)
                FinalColor.rgb = pow(Tonemap_Uncharted2(FinalColor.rgb),2.2);
                #endif
            
                FinalColor.rgb = applyLiftGammaGainEffect(FinalColor.rgb, _ColorCorrLift, _ColorCorrGamma, _ColorCorrGain);
                #endif
            }
            

            void PBRBaseShadow(SurfaceData o) {
                if (_RenderType == 1)
                {
                    clip(o.Alpha - _Cutoff);
                }
            }
            

            void VertexBase(inout VertexData v, inout FragmentData o)
            {
            
                #if defined(UNITY_PASS_META) && !defined(UNITY_PASS_BAKERY_META)
                o.pos = UnityMetaVertexPosition(v.vertex, v.uv1.xy, v.uv2.xy, unity_LightmapST, unity_DynamicLightmapST);
                #else
                o.pos = TransformObjectToHClip(v.vertex);
                #endif
                o.normal = v.normal;
                o.uv0 = v.uv0;
                o.uv1 = v.uv1;
                o.uv2 = v.uv2;
                o.uv3 = v.uv3;
                #if defined(NEED_UV4)
                o.uv4 = v.uv4;
                #endif
                #if defined(NEED_UV5)
                o.uv5 = v.uv5;
                #endif
                #if defined(NEED_UV6)
                o.uv6 = v.uv6;
                #endif
                #if defined(NEED_UV7)
                o.uv7 = v.uv7;
                #endif
                o.worldPos = mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1));
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldTangent.xyz = UnityObjectToWorldDir(v.tangent.xyz);
                o.worldTangent.w = v.tangent.w * unity_WorldTransformParams.w;
                o.vertexColor = v.color;
            
                #if defined(EDITOR_VISUALIZATION)
                o.vizUV = 0;
                o.lightCoord = 0;
                if (unity_VisualizationMode == EDITORVIZ_TEXTURE)
                {
                    o.vizUV = UnityMetaVizUV(unity_EditorViz_UVIndex, v.uv0.xy, v.uv1.xy, v.uv2.xy, unity_EditorViz_Texture_ST);
                }
                else if (unity_VisualizationMode == EDITORVIZ_SHOWLIGHTMASK)
                {
                    o.vizUV = v.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.lightCoord = mul(unity_EditorViz_WorldToLight, mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1)));
                }
                #endif
            
                #if defined(NEED_SCREEN_POS)
                o.screenPos = GetScreenPosition(o.pos);
                o.screenPos.z = -TransformWorldToView(TransformObjectToWorld(v.vertex)).z;
                #endif
            
                #if !defined(UNITY_PASS_META)
                    #if defined(LIGHTMAP_ON)
                    o.lightmapUv.xy = v.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    #endif
                    #if defined(DYNAMICLIGHTMAP_ON)
                    o.lightmapUv.zw = v.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                    #endif
            
                    UNITY_TRANSFER_LIGHTING(o, v.uv1.xy);
            
                    o.fogData.x = o.pos.z;
                    #if defined(FOG_EXP2)
                    o.fogData.y = 1;
                    #else
                    o.fogData.y = 0;
                    #endif
                #endif
            }
            

            // FreeFunctions

            // ForwardBase Vertex
            #if !defined(TESS_ENABLED)
            FragmentData Vertex(VertexData v)
            {
                UNITY_SETUP_INSTANCE_ID(v);
                FragmentData o;
                UNITY_INITIALIZE_OUTPUT(FragmentData, o);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                // ForwardBase Vertex Chain
                VRCFeaturesVertex(v);

                // ForwardBase VertexBase
                VertexBase(v, o);

                // ForwardBase PostVertex Chain

                return o;
            }
            #endif

            // ForwardBase Fragment
            half4 Fragment(FragmentData i, bool facing: SV_IsFrontFace
                #if defined(NEED_SV_DEPTH)
                , out float depth: SV_Depth
                #endif
                #if defined(NEED_SV_DEPTH_LEQUAL)
                , out float depth: SV_DepthLessEqual
                #endif
            ) : SV_TARGET
            {
                #if !defined(NEED_SV_DEPTH) && !defined(NEED_SV_DEPTH_LEQUAL)
                float depth = 0;
                #endif
                UNITY_SETUP_INSTANCE_ID(i);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

                SurfaceData o = CreateSurfaceData();
                MeshData d = CreateMeshData(i, facing);
                half4 FinalColor = 1;

                // ForwardBase Fragment Chain
                ParallaxFragment(d, i);

                PBRFragment(d, o);

                DetailsFragment(d, o);

                PosterDisplayFragment(i, o);

                ALFragment(d, o);

                // ForwardBase FragmentBase
                FragmentBase(d, i, o, FinalColor);

                ApplyUnityFog(i.fogData, FinalColor);

                // ForwardBase Color Chain
                VRCLightVolumesColor(d, facing, FinalColor);

                LTCGIColor(d, i, FinalColor, facing);

                FragmentBaseMetaColor(o);

                FragmentBaseColorCorr(FinalColor);

                return FinalColor;
            }

            ENDCG
            // ForwardBase Pass End
        }

        Pass
        {
            Tags { "LightMode" = "ForwardAdd"  }
            ZWrite Off
            Blend One One

            // ForwardAdd Pass Start
            CGPROGRAM
            #pragma target 4.5
            #pragma multi_compile_instancing
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_vertex _ FOG_EXP2
            #pragma vertex Vertex
            #pragma fragment Fragment
            #pragma shader_feature_local_fragment _EMISSION
            
            #pragma shader_feature_local_fragment PARALLAX
            #pragma shader_feature_local_fragment _PARALLAXSTEPS_EIGHT _PARALLAXSTEPS_SIXTEEN _PARALLAXSTEPS_THIRTYTWO _PARALLAXSTEPS_SIXTYFOUR
            
            #pragma shader_feature_local_fragment DETAILS_OVERLAY
            #pragma shader_feature_local_fragment _ DETAILS_MODE_PACKED DETAILS_MODE_SEPARATED
            
            #pragma shader_feature_local_vertex VRC_FEATURES
            
               
             #pragma shader_feature_local_fragment VRCLIGHTVOLUMES
            
             // Global keyword to enable in the project
             #pragma shader_feature_fragment DISABLE_VRCLIGHTVOLUMES
            
            #pragma shader_feature_local_fragment _ AL_EFFECT_BAND_SELECTION AL_EFFECT_UV_BASED AL_EFFECT_WAVEFORM AL_EFFECT_PULSE AL_EFFECT_BAR
            
            #pragma shader_feature_local_fragment INTEGRATE_LTCGI
            
            #pragma shader_feature_local_fragment BAKERY_ENABLED
            #pragma shader_feature_local_fragment _ BAKERY_RNM BAKERY_SH BAKERY_MONOSH
            #pragma shader_feature_local_fragment BAKERY_SHNONLINEAR
            #pragma shader_feature_local_fragment BAKERY_VOLUME
            #pragma shader_feature_local_fragment BAKERY_COMPRESSED_VOLUME
            #pragma shader_feature_local_fragment BAKERY_VOLROTATIONY
            
            #pragma shader_feature_local_fragment BAKED_SPECULAR
            #pragma shader_feature_local_fragment GSAA
            #pragma shader_feature_local_fragment NONLINEAR_SH
            #pragma shader_feature_local_fragment SHADE_VERTEXLIGHTS
            #pragma shader_feature_local_fragment SHADING_MODE_DEFAULT SHADING_MODE_CLOTH
            #pragma shader_feature_local_fragment CLEARCOAT
                
            // PC Only Features
            #if !defined(UNITY_PBS_USE_BRDF2) && !defined(SHADER_API_MOBILE)
                #pragma shader_feature_local_fragment BICUBIC_LIGHTMAP
            #endif
            
            // Mobile Only Features
            #if defined(UNITY_PBS_USE_BRDF2) || defined(SHADER_API_MOBILE)
                #pragma shader_feature_local_fragment FORCE_BOX_PROJECTION
                #pragma shader_feature_local_fragment APPLY_COLOR_CORRECTION
                #pragma shader_feature_local_fragment MOBILE_TONEMAP_ACES MOBILE_TONEMAP_UNREAL MOBILE_TONEMAP_UNCHARTED
            #endif
            
            #if defined(SHADE_VERTEXLIGHTS)
                #pragma multi_compile_fragment _ VERTEXLIGHT_ON
            #endif
            
            #if !defined(MOBILE_TONEMAP_ACES) && !defined(MOBILE_TONEMAP_UNREAL) && !defined(MOBILE_TONEMAP_UNCHARTED)
                #define MOBILE_TONEMAP_ACES
            #endif

            #define UNITY_INSTANCED_LOD_FADE
            #define UNITY_INSTANCED_SH
            #define UNITY_INSTANCED_LIGHTMAPSTS

            #ifndef UNITY_PASS_FORWARDADD
                #define UNITY_PASS_FORWARDADD
            #endif

            // ShaderDefines
            #define _MASKMAP_SAMPLED
            
            #if !defined(DETAILS_MODE_PACKED) && !defined(DETAILS_MODE_SEPARATED)
              #define DETAILS_MODE_PACKED
            #endif
            
            #define VRCLV_VERSION 2
            #define VRCLV_MAX_VOLUMES_COUNT 32
            #define VRCLV_MAX_LIGHTS_COUNT 128
            
            #if !defined(DISABLE_VRCLIGHTVOLUMES) && defined(VRCLIGHTVOLUMES)
                #define INTEGRATE_VRCLIGHTVOLUMES
            
                #define LV_PI 3.141592653589793f
                #define LV_PI2 6.283185307179586f
            
                #define _INTEGRATE_CUSTOMPROBES
                #define _INTEGRATE_CUSTOMGI_FLEX
            #endif
            
            #if !defined(AL_EFFECT_BAND_SELECTION) && !defined(AL_EFFECT_UV_BASED) && !defined(AL_EFFECT_WAVEFORM) && !defined(AL_EFFECT_PULSE) && !defined(AL_EFFECT_BAR)
            #define AL_EFFECT_NONE
            #endif
            
            #if defined(INTEGRATE_LTCGI)
                #define _INTEGRATE_CUSTOMGI_FLEX
            #endif
            
            #define INCLUDE_LTCGI defined(INTEGRATE_LTCGI)
            
            #if INCLUDE_LTCGI
                #include "Packages/at.pimaker.ltcgi/Shaders/LTCGI_structs.cginc"
            #endif
            
            #if !defined(LIGHTMAP_ON) || !defined(UNITY_PASS_FORWARDBASE)
              #undef BAKERY_SH
              #undef BAKERY_RNM
            #endif
            
            #ifdef LIGHTMAP_ON
              #undef BAKERY_VOLUME
            #endif
            
            #ifdef LIGHTMAP_ON
                #if defined(BAKERY_ENABLED)
                    #if defined(BAKERY_RNM) || defined(BAKERY_SH) || defined(BAKERY_VERTEXLM) || defined(BAKERY_MONOSH)
                        #define BAKERYLM_ENABLED
                        #if !defined(BAKERY_MONOSH)
                            #undef DIRLIGHTMAP_COMBINED
                        #endif
                    #endif
                #endif
            #endif
            
            #if defined(BAKERY_SH) || defined(BAKERY_RNM) || defined(BAKERY_VOLUME) || defined(BAKERY_MONOSH)
              #ifdef BAKED_SPECULAR
                #define _BAKERY_LMSPEC
                #define BAKERY_LMSPEC
              #endif
            #endif
            
            #define ORL_LIGHTING_MODEL_PBR
                
            #if defined(UNITY_PBS_USE_BRDF2) || defined(SHADER_API_MOBILE)
                #define PLAT_QUEST
            #else
                #ifdef PLAT_QUEST
                    #undef PLAT_QUEST
                #endif
            #endif
            
            #define ORL_MIN_ROUGHNESS 0.002025
            #if defined(PLAT_QUEST)
                #define ORL_MIN_ROUGHNESS 0.007921
            #endif
            
            #if !defined(SHADING_MODE_DEFAULT) && !defined(SHADING_MODE_CLOTH)
                #define SHADING_MODE_DEFAULT
            #endif
            
            #define NEED_SCREEN_POS
            #if !defined(NEED_FRAGMENT_IN_SHADOW)
                #define NEED_FRAGMENT_IN_SHADOW
            #endif
            #include "Assets/Xuan25/PosterDisplay/Shader/Inc/PosterDisplay.cginc"

            // DataStructs
            struct VertexData
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float4 color : COLOR;
                float4 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 uv2 : TEXCOORD2;
                float4 uv3 : TEXCOORD3;
                #if defined(NEED_UV4)
                float4 uv4 : TEXCOORD4;
                #endif
                #if defined(NEED_UV5)
                float4 uv5 : TEXCOORD5;
                #endif
                #if defined(NEED_UV6)
                float4 uv6 : TEXCOORD6;
                #endif
                #if defined(NEED_UV7)
                float4 uv7 : TEXCOORD7;
                #endif
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            
            struct FragmentData
            {
                #if defined(UNITY_PASS_SHADOWCASTER)
                V2F_SHADOW_CASTER;
                #else
                float4 pos : SV_POSITION;
                #endif
            
                float3 normal : RAW_NORMAL;
            
                #if !defined(NEED_FLOAT4_UV)
                // by default all UVs are float 2s
                float2 uv0 : TEXCOORD1;
                float2 uv1 : TEXCOORD2;
                float2 uv2 : TEXCOORD3;
                float2 uv3 : TEXCOORD4;
                #if defined(NEED_UV4)
                float2 uv4 : TEXCOORD5;
                #endif
                #if defined(NEED_UV5)
                float2 uv5 : TEXCOORD6;
                #endif
                #if defined(NEED_UV6)
                float2 uv6 : TEXCOORD7;
                #endif
                #if defined(NEED_UV7)
                float2 uv7 : TEXCOORD8;
                #endif
            
                #else // #if !defined(NEED_FLOAT4_UV)
            
                // Shaders can request to get float4 UVs using
                // #define NEED_FLOAT4_UV
                float4 uv0 : TEXCOORD1;
                float4 uv1 : TEXCOORD2;
                float4 uv2 : TEXCOORD3;
                float4 uv3 : TEXCOORD4;
                #if defined(NEED_UV4)
                float4 uv4 : TEXCOORD5;
                #endif
                #if defined(NEED_UV5)
                float4 uv5 : TEXCOORD6;
                #endif
                #if defined(NEED_UV6)
                float4 uv6 : TEXCOORD7;
                #endif
                #if defined(NEED_UV7)
                float4 uv7 : TEXCOORD8;
                #endif
            
                #endif // #if !defined(NEED_FLOAT4_UV)
            
                float3 worldPos : WORLD_POS;
                float3 worldNormal : WORLD_NORMAL;
                float4 worldTangent : WORLD_TANGENT;
            
                #if !defined(UNITY_PASS_SHADOWCASTER)
                float4 lightmapUv : LM_UV;
                #endif
            
                centroid float4 vertexColor : VERTEX_COLOR;
            
                #if !defined(UNITY_PASS_META)
                UNITY_LIGHTING_COORDS(9, 10)
                float2 fogData : FOG_DATA;
                #endif
            
                #if defined(EDITOR_VISUALIZATION)
                float2 vizUV : VIZ_UV;
                float4 lightCoord : LIGHT_COORD;
                #endif
            
                #if defined(NEED_SCREEN_POS)
                float4 screenPos: SCREENPOS;
                #endif
            
                #if defined(EXTRA_V2F_0)
                float4 extraV2F0 : EXTRA_V2F_BLOCK0;
                #endif
                #if defined(EXTRA_V2F_1)
                float4 extraV2F1 : EXTRA_V2F_BLOCK1;
                #endif
                #if defined(EXTRA_V2F_2)
                float4 extraV2F2 : EXTRA_V2F_BLOCK2;
                #endif
                #if defined(EXTRA_V2F_3)
                float4 extraV2F3 : EXTRA_V2F_BLOCK3;
                #endif
            
                // Additional Fragment Data
                
                // Additional Fragment Data End
            
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };
            
            struct LTCGIAccumulatorStruct {
                float3 diffuse;
                float3 specular;
            };
            
            #define LTCGI_V2_CUSTOM_INPUT LTCGIAccumulatorStruct
            
            struct SurfaceData
            {
                half3 Albedo;
                half3 Emission;
                half Metallic;
                half Smoothness;
                half Occlusion;
                float3 Normal;
                half Alpha;
            
                // Additional Surface Data
                #if defined(INTEGRATE_VRCLIGHTVOLUMES)
                float3 VRCLV_L0;
                float3 VRCLV_L1r;
                float3 VRCLV_L1g;
                float3 VRCLV_L1b;
                #endif
                // Additional Surface Data End
            };
            
            SurfaceData CreateSurfaceData()
            {
                SurfaceData o = (SurfaceData) 0;
                o.Albedo = 1;
                o.Occlusion = 1;
                o.Normal = float3(0, 0, 1);
                o.Smoothness = 0.5;
                o.Alpha = 1;
                return o;
            }
            
            struct MeshData
            {
                #if !defined(NEED_FLOAT4_UV)
                // by default all UVs are float 2s
                float2 uv0;
                float2 uv1;
                float2 uv2;
                float2 uv3;
                #if defined(NEED_UV4)
                float2 uv4;
                #endif
                #if defined(NEED_UV5)
                float2 uv5;
                #endif
                #if defined(NEED_UV6)
                float2 uv6;
                #endif
                #if defined(NEED_UV7)
                float2 uv7;
                #endif
            
                #else // #if !defined(NEED_FLOAT4_UV)
            
                // Shaders can request to get float4 UVs using
                // #define NEED_FLOAT4_UV
                float4 uv0;
                float4 uv1;
                float4 uv2;
                float4 uv3;
                #if defined(NEED_UV4)
                float4 uv4;
                #endif
                #if defined(NEED_UV5)
                float4 uv5;
                #endif
                #if defined(NEED_UV6)
                float4 uv6;
                #endif
                #if defined(NEED_UV7)
                float4 uv7;
                #endif
            
                #endif // #if !defined(NEED_FLOAT4_UV)
            
                #if !defined(UNITY_PASS_SHADOWCASTER)
                half4 lightmapUv;
                #endif
                half4 vertexColor;
                half3 normal;
                half3 worldNormal;
                half3 localSpacePosition;
                half3 worldSpacePosition;
                half3 worldSpaceViewDir;
                half3 tangentSpaceViewDir;
                float3x3 TBNMatrix;
                float4 extraV2F0;
                float4 extraV2F1;
                float4 extraV2F2;
                float4 extraV2F3;
                float4 screenPos;
            
                // Additional Mesh Data
                
                // Additional Mesh Data End
            };
            
            MeshData CreateMeshData(FragmentData i, bool facing)
            {
                MeshData d = (MeshData) 0;
                d.uv0 = i.uv0;
                d.uv1 = i.uv1;
                d.uv2 = i.uv2;
                d.uv3 = i.uv3;
                #if defined(NEED_UV4)
                d.uv4 = i.uv4;
                #endif
                #if defined(NEED_UV5)
                d.uv5 = i.uv5;
                #endif
                #if defined(NEED_UV6)
                d.uv6 = i.uv6;
                #endif
                #if defined(NEED_UV7)
                d.uv7 = i.uv7;
                #endif
                #if !defined(UNITY_PASS_SHADOWCASTER)
                d.lightmapUv = i.lightmapUv;
                #endif
                d.worldNormal = normalize(i.worldNormal);
                d.localSpacePosition = mul(unity_WorldToObject, float4(i.worldPos, 1)).xyz;
                d.worldSpacePosition = i.worldPos;
                d.worldSpaceViewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
            
                d.normal = i.normal;
                d.vertexColor = i.vertexColor;
            
                #if !defined(UNITY_PASS_SHADOWCASTER)
                float3 bitangent = cross(d.worldNormal, i.worldTangent.xyz) * (i.worldTangent.w > 0.0 ? 1.0 : - 1.0);
                d.TBNMatrix = float3x3(normalize(i.worldTangent.xyz), bitangent, d.worldNormal);
                d.TBNMatrix[2].xyz *= facing ? 1 : -1;
                d.tangentSpaceViewDir = mul(d.TBNMatrix, d.worldSpaceViewDir);
                #endif
            
                #if defined(EXTRA_V2F_0)
                d.extraV2F0 = i.extraV2F0;
                #endif
                #if defined(EXTRA_V2F_1)
                d.extraV2F1 = i.extraV2F1;
                #endif
                #if defined(EXTRA_V2F_2)
                d.extraV2F2 = i.extraV2F2;
                #endif
                #if defined(EXTRA_V2F_3)
                d.extraV2F3 = i.extraV2F3;
                #endif
                #if defined(NEED_SCREEN_POS)
                d.screenPos = i.screenPos;
                #endif
            
                // Additional Mesh Data Creator
                
                // Additional Mesh Data Creator End
            
                return d;
            }
            // GlobalVariables

            // Variables
            half4 _Color;
            half4 _MainTex_ST;
            int _AlbedoChannel;
            int _MappingSpace;
            int _PlanarAxisX;
            int _PlanarAxisY;
            int _MetalChannel;
            int _AOChannel;
            int _DetailMaskChannel;
            int _SmoothChannel;
            int _RoughnessMode;
            half _Smoothness;
            half _Metallic;
            half4 _MetallicRemap;
            half4 _SmoothnessRemap;
            half4 _MaskMap_TexelSize;
            half _OcclusionStrength;
            int _DetailAsTintMask;
            half _BumpScale;
            int _FlipBumpY;
            half4 _EmissionColor;
            int _EmissionChannel;
            float2 GLOBAL_uv;
            half4 GLOBAL_maskMap;
            #if defined(PARALLAX)
            half _HeightScale;
            half _HeightRefPlane;
            int _ParallaxScaleBasedOnAngle;
            #endif
            float2 GLOBAL_parallaxUv;
            half GLOBAL_heightMask;
            half GLOBAL_heightMaskSmoothing;
            int GLOBAL_heightSet;
            half GLOBAL_height; 
            #if defined(DETAILS_OVERLAY)
            int _DIgnoreMask;
            half4 _DDetailsMap_ST;
            int _DMappingSpace;
            int _DUVChannel;
            int _DPlanarAxisX;
            int _DPlanarAxisY;
            half _DAlbedoScale;
            half _DNormalScale;
            int _DNormalFlipY;
            half _DSmoothScale;
            int _DAlbedoMixingLegacy;
            #endif
            int _VRCHideInVR;
            int _VRCHideInDesktop;
            int _VRCHideInVRCamera;
            int _VRCHideInDesktopCamera;
            int _VRCHideInVRMirror;
            int _VRCHideInDesktopMirror;
            float _VRChatCameraMode;
            float _VRChatMirrorMode;
            #if defined(INTEGRATE_VRCLIGHTVOLUMES)
            float _VRCLightVolumesSurfacePushoff;
            cbuffer LightVolumeUniforms {
                float _UdonLightVolumeEnabled;
                float _UdonLightVolumeVersion;
                float _UdonLightVolumeCount;
                float _UdonLightVolumeAdditiveMaxOverdraw;
                float _UdonLightVolumeAdditiveCount;
                float _UdonLightVolumeProbesBlend;
                float _UdonLightVolumeSharpBounds;
                float4x4 _UdonLightVolumeInvWorldMatrix[VRCLV_MAX_VOLUMES_COUNT];
                float4 _UdonLightVolumeRotation[VRCLV_MAX_VOLUMES_COUNT * 2];
                float3 _UdonLightVolumeInvLocalEdgeSmooth[VRCLV_MAX_VOLUMES_COUNT];
                float3 _UdonLightVolumeUvw[VRCLV_MAX_VOLUMES_COUNT * 6];
                float4 _UdonLightVolumeOcclusionUvw[VRCLV_MAX_VOLUMES_COUNT];
                float4 _UdonLightVolumeColor[VRCLV_MAX_VOLUMES_COUNT];
                float _UdonPointLightVolumeCount;
                float _UdonPointLightVolumeCubeCount;
                float4 _UdonPointLightVolumePosition[VRCLV_MAX_LIGHTS_COUNT];
                float4 _UdonPointLightVolumeColor[VRCLV_MAX_LIGHTS_COUNT];
                float4 _UdonPointLightVolumeDirection[VRCLV_MAX_LIGHTS_COUNT];
                float3 _UdonPointLightVolumeCustomID[VRCLV_MAX_LIGHTS_COUNT];
                float _UdonLightBrightnessCutoff;
                float _UdonLightVolumeOcclusionCount;
            }
            #endif
            sampler2D _PosterTex;
            float4 _PosterTex_ST;
            float4 _PosterTint;
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
            int _ALUVChannel;
            int _BandFrequency;
            int _BandScrollAxis;
            half _BandHistoryRange;
            half _UVHistoryRange;
            int _UVFlipXY;
            int _UVUseThemeColors;
            int _WVFRMMiddleLine;
            half _WVFRMMiddleLineWidth;
            int _WVFRMFlip;
            half _WVFRMOffset;
            half _WVFRMScale;
            int _WVFRMFlipUVDirection;
            int _PulseBand;
            int _PulseSmoothing;
            int _PulseMode;
            half _PulseStrength;
            int _PulseEmissionMode;
            int _PulseTextureAdjustment;
            half4 _PulseTextureDirection;
            int _BarBand;
            int _BarSmoothing;
            int _BarAxis;
            half _BarScale;
            int _KillEffects;
            half4 _ALTint;
            int _LTCGIEnableOnMobile;
            int _LTCGIClampBrightness;
            half _LTCGIMaxBrightness;
            half _LTCGIDiffuseIntensity;
            half _LTCGISpecularIntensity;
            half _LTCGIRoughnessModifier;
            int _LTCGIAlphaPremultiply;
            #if defined(BAKERY_ENABLED)
                #if defined(BAKERY_RNM) || defined(BAKERY_SH)
            float4 _RNM0_TexelSize;
                #endif
            #endif
            #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME)
            half3 _VolumeMin;
            half3 _VolumeInvSize;
            half3 _GlobalVolumeMin;
            int _Udon_GlobalVolumeAdapterEnabled;
            half3 _Udon_GlobalVolumeMin;
            half3 _GlobalVolumeInvSize;
            half3 _Udon_GlobalVolumeInvSize;
            #if defined(BAKERY_VOLROTATION)
            float4x4 _GlobalVolumeMatrix;
            float4x4 _Udon_GlobalVolumeMatrix;
            float4x4 _VolumeMatrix;
            #endif
            #if defined(BAKERY_VOLROTATIONY)
            float2 _GlobalVolumeRY;
            float2 _Udon_GlobalVolumeRY;
            float2 _VolumeRY;
            #endif
            #endif
            #if defined(GSAA)
            half _GSAAVariance;
            half _GSAAThreshold;
            int _GSAAIncludeNormalMaps;
            #endif
            #if defined(APPLY_COLOR_CORRECTION)
            half _ColorCorrLift;
            half _ColorCorrGamma;
            half _ColorCorrGain;
            #endif
            #if defined(CLEARCOAT)
            half _ClearCoatStrength;
            float _ClearCoatSmoothness;
            half4 _ClearCoatMask_ST;
            int _ClearCoatMaskChannel;
            int _HasClearCoatMask;
            #endif
            #if defined(SHADING_MODE_CLOTH)
            int _ClothHasCustomSheen;
            half4 _ClothSheenColor;
            int _ClothHasSubsurface;
            half4 _ClothSubsurfaceColor;
            #endif
            half _SpecOcclusion;
            half _RealtimeShadowSpecOcclusion;
            float _BakedSpecularOcclusion;
            half _SpecularRoughnessMod;
            int _BoxProjectionContactHardening;
            half _BoxProjectionContactHardeningStrength;
            half _GIEmissiveBoost;
            int _IgnoreRealtimeGI;
            int _RealtimeGIDisableBicubic;
            int _RenderType;
            half _Cutoff;

            // Textures
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            TEXTURE2D(_MaskMap);
            SAMPLER(sampler_MaskMap);
            TEXTURE2D(_BumpMap);
            SAMPLER(sampler_BumpMap);
            TEXTURE2D(_EmissionMap);
            SAMPLER(sampler_EmissionMap);
            #if defined(PARALLAX)
            TEXTURE2D(_Height);
            SAMPLER(sampler_Height);
            #endif
            #if defined(DETAILS_OVERLAY)
            TEXTURE2D(_DDetailsMap);
            SAMPLER(sampler_DDetailsMap);
            TEXTURE2D(_DDetailsNormal);
            SAMPLER(sampler_DDetailsNormal);
            #endif
            #if defined(INTEGRATE_VRCLIGHTVOLUMES)
            TEXTURE3D(_UdonLightVolume);
            TEXTURE2D_ARRAY(_UdonPointLightVolumeTexture);
            SAMPLER(sampler_UdonLightVolume);
            #define LV_SAMPLE(tex, uvw) tex.SampleLevel(sampler_UdonLightVolume, uvw, 0)
            #endif
            TEXTURE2D(_ALMask);
            SAMPLER(sampler_ALMask);
            TEXTURE2D(_WVFRMBottomColor);
            TEXTURE2D(_WVFRMTopColor);
            TEXTURE2D(_WVFRMMiddleColor);
            SAMPLER(sampler_WVFRMBottomColor);
            TEXTURE2D(_PulseTexture);
            SAMPLER(sampler_PulseTexture);
            TEXTURE2D(_BarColor);
            SAMPLER(sampler_BarColor);
            #if defined(BAKERY_ENABLED)
                #if defined(BAKERY_RNM) || defined(BAKERY_SH)
            TEXTURE2D(_RNM0);
            TEXTURE2D(_RNM1);
            TEXTURE2D(_RNM2);
            SAMPLER(sampler_RNM0);
                #endif
            #endif
            #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME)
            TEXTURE3D(_Volume0);
            TEXTURE3D(_Volume1);
            TEXTURE3D(_Volume2);
            TEXTURE3D(_VolumeMask);
                #if defined(BAKERY_COMPRESSED_VOLUME)
            TEXTURE3D(_Volume3);
                #endif
            SAMPLER(sampler_Volume0);
            SAMPLER(sampler_VolumeMask);
            #endif
            TEXTURE2D(_DFG);
            SAMPLER(sampler_DFG);
            TEXTURE2D(_ClearCoatMask);

            // PassFunctions
            #if defined(INTEGRATE_VRCLIGHTVOLUMES)
            
            float LV_Smoothstep01(float x) {
                return x * x * (3 - 2 * x);
            }
            
            float3 LV_MultiplyVectorByQuaternion(float3 v, float4 q) {
                float3 t = 2.0 * cross(q.xyz, v);
                return v + q.w * t + cross(q.xyz, t);
            }
            
            float3 LV_MultiplyVectorByMatrix2x3(float3 v, float3 r0, float3 r1) {
                float3 r2 = cross(r0, r1);
                return float3(dot(v, r0), dot(v, r1), dot(v, r2));
            }
            
            float LV_FastAcos(float x) {
                float absX = abs(x); 
                float res = -0.156583f * absX + LV_PI * 0.5f;
                res *= sqrt(1.0f - absX); 
                return (x >= 0) ? res : (LV_PI - res);
            }
            
            float LV_DistributionGGX(float NoH, float roughness) {
                float f = (roughness - 1) * ((roughness + 1) * (NoH * NoH)) + 1;
                return (roughness * roughness) / ((float) LV_PI * f * f);
            }
            
            bool LV_PointLocalAABB(float3 localUVW) {
                return all(abs(localUVW) <= 0.5);
            }
            
            float3 LV_LocalFromVolume(uint volumeID, float3 worldPos) {
                return mul(_UdonLightVolumeInvWorldMatrix[volumeID], float4(worldPos, 1.0)).xyz;
            }
            
            float LV_EvaluateSH(float L0, float3 L1, float3 n) {
                return L0 + dot(L1, n);
            }
            
            float4 LV_SampleCubemapArray(uint id, float3 dir) {
                float3 absDir = abs(dir);
                float2 uv;
                uint face;
                if (absDir.x >= absDir.y && absDir.x >= absDir.z) {
                    face = dir.x > 0 ? 0 : 1;
                    uv = float2((dir.x > 0 ? -dir.z : dir.z), -dir.y) * rcp(absDir.x);
                } else if (absDir.y >= absDir.z) {
                    face = dir.y > 0 ? 2 : 3;
                    uv = float2(dir.x, (dir.y > 0 ? dir.z : -dir.z)) * rcp(absDir.y);
                } else {
                    face = dir.z > 0 ? 4 : 5;
                    uv = float2((dir.z > 0 ? dir.x : -dir.x), -dir.y) * rcp(absDir.z);
                }
                float3 uvid = float3(uv * 0.5 + 0.5, id * 6 + face);
                return LV_SAMPLE(_UdonPointLightVolumeTexture, uvid);
            }
            
            float4 LV_ProjectQuadLightIrradianceSH(float3 shadingPosition, float3 lightVertices[4]) {
                // Transform the vertices into local space centered on the shading position,
                // project, the polygon onto the unit sphere.
                [unroll] for (uint edge0 = 0; edge0 < 4; edge0++) {
                    lightVertices[edge0] = normalize(lightVertices[edge0] - shadingPosition);
                }
                
                // Precomputed directions of rotated zonal harmonics,
                // and associated weights for each basis function.
                // I.E. \omega_{l,d} and \alpha_{l,d}^m in the paper respectively.
                const float3 zhDir0 = float3(0.866025, -0.500001, -0.000004);
                const float3 zhDir1 = float3(-0.759553, 0.438522, -0.480394);
                const float3 zhDir2 = float3(-0.000002, 0.638694,  0.769461);
                const float3 zhWeightL1y = float3(2.1995339f, 2.50785367f, 1.56572711f);
                const float3 zhWeightL1z = float3(-1.82572523f, -2.08165037f, 0.00000000f);
                const float3 zhWeightL1x = float3(2.42459869f, 1.44790525f, 0.90397552f);
                
                float solidAngle = 0.0;
                float3 surfaceIntegral = 0.0;
                [loop] for (uint edge1 = 0; edge1 < 4; edge1++) {
                    uint next = (edge1 + 1) % 4;
                    uint prev = (edge1 + 4 - 1) % 4;
                    float3 prevVert = lightVertices[prev];
                    float3 thisVert = lightVertices[edge1];
                    float3 nextVert = lightVertices[next];
                
                    // Compute the solid angle subtended by the polygon at the shading position,
                    // using Arvo's formula (5.1) https://dl.acm.org/doi/pdf/10.1145/218380.218467.
                    // The L0 term is directly proportional to the solid angle.
                    float3 a = cross(thisVert, prevVert);
                    float3 b = cross(thisVert, nextVert);
                    float lenA = length(a);
                    float lenB = length(b);
                    solidAngle += LV_FastAcos(clamp(dot(a, b) / (lenA * lenB), -1, 1));
                
                    // Compute the integral of the legendre polynomials over the surface of the
                    // projected polygon for each zonal harmonic direction (S_l in the paper).
                    // Computed as a sum of line integrals over the edges of the polygon.
                    float3 mu = b * rcp(lenB);
                    float cosGamma = dot(thisVert, nextVert);
                    float gamma = LV_FastAcos(clamp(cosGamma, -1, 1));
                    surfaceIntegral.x += gamma * dot(zhDir0, mu);
                    surfaceIntegral.y += gamma * dot(zhDir1, mu);
                    surfaceIntegral.z += gamma * dot(zhDir2, mu);
                }
                solidAngle = solidAngle - LV_PI2;
                surfaceIntegral *= 0.5;
                
                // The L0 term is just the projection of the solid angle onto the L0 basis function.
                const float normalizationL0 = 0.5f * sqrt(1.0f / LV_PI);
                float l0 = normalizationL0 * solidAngle;
                    
                // Combine each surface (sub)integral with the associated weights to get
                // full surface integral for each L1 SH basis function.
                float l1y = dot(zhWeightL1y, surfaceIntegral);
                float l1z = dot(zhWeightL1z, surfaceIntegral);
                float l1x = dot(zhWeightL1x, surfaceIntegral);
                
                // The l0, l1y, l1z, l1x are raw SH coefficients for radiance from the polygon.
                // We need to apply some more transformations before we are done:
                // (1) We want the coefficients for irradiance, so we need to convolve with the
                //     clamped cosine kernel, as detailed in https://cseweb.ucsd.edu/~ravir/papers/envmap/envmap.pdf.
                //     The kernel has coefficients PI and 2/3*PI for L0 and L1 respectively.
                // (2) Unity's area lights underestimate the irradiance by a factor of PI for historical reasons.
                //     We need to divide by PI to match this 'incorrect' behavior.
                // (3) Unity stores SH coefficients (unity_SHAr..unity_SHC) pre-multiplied with the constant
                //     part of each SH basis function, so we need to multiply by constant part to match it.
                const float cosineKernelL0 = LV_PI; // (1)
                const float cosineKernelL1 = LV_PI2 / 3.0f; // (1)
                const float oneOverPi = 1.0f / LV_PI; // (2)
                const float normalizationL1 = 0.5f * sqrt(3.0f / LV_PI); // (3)
                const float weightL0 = cosineKernelL0 * normalizationL0 * oneOverPi; // (1), (2), (3)
                const float weightL1 = cosineKernelL1 * normalizationL1 * oneOverPi; // (1), (2), (3)
                l0  *= weightL0;
                l1y *= weightL1;
                l1z *= weightL1;
                l1x *= weightL1;
                    
                return float4(l1x, l1y, l1z, l0);
            }
            
            void LV_QuadLight(float3 worldPos, float3 centroidPos, float4 rotationQuat, float2 size, float3 color, float sqMaxDist, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float3 lightToWorldPos = worldPos - centroidPos;
                    
                // Normal culling
                float3 normal = LV_MultiplyVectorByQuaternion(float3(0, 0, 1), rotationQuat);
                [branch] if (dot(normal, lightToWorldPos) < 0.0) return;
                    
                // Attenuate the light based on distance to the bounding sphere, so we don't get hard seam at the edge.
                float sqCutoffDist = sqMaxDist - dot(lightToWorldPos, lightToWorldPos);
                color.rgb *= saturate(sqCutoffDist / sqMaxDist) * LV_PI * occlusion;
                        
                // Compute the vertices of the quad
                float2 halfSize = size * 0.5f;
                float3 xAxis = LV_MultiplyVectorByQuaternion(float3(1, 0, 0), rotationQuat);
                float3 yAxis = cross(normal, xAxis);
                float3 verts[4];
                verts[0] = centroidPos + (-halfSize.x * xAxis) + ( halfSize.y * yAxis);
                verts[1] = centroidPos + ( halfSize.x * xAxis) + ( halfSize.y * yAxis);
                verts[2] = centroidPos + ( halfSize.x * xAxis) + (-halfSize.y * yAxis);
                verts[3] = centroidPos + (-halfSize.x * xAxis) + (-halfSize.y * yAxis);
                
                // Project irradiance from the area light
                float4 areaLightSH = LV_ProjectQuadLightIrradianceSH(worldPos, verts);
                
                // If the magnitude of L1 is greater than L0, we may get negative values
                // when reconstructing. To avoid, normalize L1. This is effectively de-ringing.
                float lenL1 = length(areaLightSH.xyz);
                if (lenL1 > areaLightSH.w) areaLightSH.xyz *= areaLightSH.w / lenL1;
                    
                L0  += areaLightSH.w * color.rgb;
                L1r += areaLightSH.xyz * color.r;
                L1g += areaLightSH.xyz * color.g;
                L1b += areaLightSH.xyz * color.b;
                    
                count++;
            }
            
            float3 LV_PointLightAttenuation(float sqdist, float sqlightSize, float3 color, float brightnessCutoff, float sqMaxDist) {
                float mask = saturate(1 - sqdist / sqMaxDist);
                return mask * mask * color * sqlightSize / (sqdist + sqlightSize);
            }
            
            float LV_PointLightSolidAngle(float sqdist, float sqlightSize) {
                return saturate(sqrt(sqdist / (sqlightSize + sqdist)));
            }
            
            void LV_SphereLight(float sqdist, float3 dirN, float sqlightSize, float3 color, float occlusion, float sqMaxDist, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float3 att = LV_PointLightAttenuation(sqdist, sqlightSize, color, _UdonLightBrightnessCutoff, sqMaxDist);
                
                float3 l0 = att * occlusion;
                float3 l1 = dirN * LV_PointLightSolidAngle(sqdist, sqlightSize);
                    
                L0 += l0;
                L1r += l0.r * l1;
                L1g += l0.g * l1;
                L1b += l0.b * l1;
                count++;
                    
            }
            
            void LV_SphereSpotLight(float sqdist, float3 dirN, float sqlightSize, float3 att, float spotMask, float cosAngle, float coneFalloff, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float smoothedCone = LV_Smoothstep01(saturate(spotMask * coneFalloff));
                float3 l0 = att * (occlusion * smoothedCone);
                float3 l1 = dirN * LV_PointLightSolidAngle(sqdist, sqlightSize * saturate(1 - cosAngle));
                    
                L0 += l0;
                L1r += l0.r * l1;
                L1g += l0.g * l1;
                L1b += l0.b * l1;
                count++;
                    
            }
            
            void LV_SphereSpotLightCookie(float sqdist, float3 dirN, float sqlightSize, float3 att, float4 lightRot, float tanAngle, uint customId, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float3 localDir = LV_MultiplyVectorByQuaternion(-dirN, lightRot);
                float2 uv = localDir.xy * rcp(localDir.z * tanAngle);
                [branch] if (
                    localDir.z <= 0.0 || // Culling by direction
                    abs(uv.x) > 1.0 || abs(uv.y) > 1.0 // Culling by UV
                ) return;
                        
                uint id = (uint) _UdonPointLightVolumeCubeCount * 5 - customId - 1;
                float3 uvid = float3(uv * 0.5 + 0.5, id);        
                float angleSize = saturate(rsqrt(1 + tanAngle * tanAngle));
                float4 cookie = LV_SAMPLE(_UdonPointLightVolumeTexture, uvid);
                        
                float3 l0 = att * cookie.rgb * (cookie.a * occlusion);
                float3 l1 = dirN * LV_PointLightSolidAngle(sqdist, sqlightSize * (1 - angleSize));
                    
                L0 += l0;
                L1r += l0.r * l1;
                L1g += l0.g * l1;
                L1b += l0.b * l1;
                count++;
                    
            }
            
            void LV_SphereSpotLightAttenuationLUT(float sqdist, float3 dirN, float sqlightSize, float3 color, float spotMask, float cosAngle, uint customId, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float dirRadius = sqdist * abs(sqlightSize);
                float spot = 1 - saturate(spotMask * rcp(1 - cosAngle));
                uint id = (uint) _UdonPointLightVolumeCubeCount * 5 + customId - 1;
                float3 uvid = float3(sqrt(float2(spot, dirRadius)), id);
                float3 att = color.rgb * LV_SAMPLE(_UdonPointLightVolumeTexture, uvid).xyz * occlusion;
                    
                L0 += att;
                L1r += dirN * att.r;
                L1g += dirN * att.g;
                L1b += dirN * att.b;
                    
                count++;
                    
            }
            
            void LV_PointLight(uint id, float3 worldPos, float4 occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                // IDs and range data
                float3 customID_data = _UdonPointLightVolumeCustomID[id];
                int shadowId = (int) customID_data.y; // Shadowmask id
                int customId = (int) customID_data.x; // Custom Texture ID
                float sqrRange = customID_data.z; // Squared culling distance
                    
                float4 pos = _UdonPointLightVolumePosition[id]; // Light position and inversed squared range 
                float3 dir = pos.xyz - worldPos;
                float sqlen = max(dot(dir, dir), 1e-6);
                [branch] if (sqlen > sqrRange) return; // Early distance based culling
                float3 dirN = dir * rsqrt(sqlen);
                    
                // Processing lights occlusion
                float lightOcclusion = 1;
                if (_UdonLightVolumeOcclusionCount != 0 && shadowId >= 0) {
                    lightOcclusion = dot(occlusion, float4(shadowId == 0, shadowId == 1, shadowId == 2, shadowId == 3));
                }
                    
                float4 color = _UdonPointLightVolumeColor[id]; // Color, angle
                float4 ldir = _UdonPointLightVolumeDirection[id]; // Dir + falloff or Rotation
                    
                [branch] if (pos.w < 0) { // It is a spot light
                
                    float angle = color.w;
                    float spotMask = dot(ldir.xyz, -dirN) - angle;
                    [branch] if(customId >= 0 && spotMask < 0) return; // Spot cone based culling
                        
                    [branch] if (customId > 0) {  // If it uses Attenuation LUT
                            
                        LV_SphereSpotLightAttenuationLUT(sqlen, dirN, -pos.w, color.rgb, spotMask, angle, customId, lightOcclusion, L0, L1r, L1g, L1b, count);
                            
                    } else { // If it uses default parametric attenuation
                
                        float3 att = LV_PointLightAttenuation(sqlen, -pos.w, color.rgb, _UdonLightBrightnessCutoff, sqrRange);
                
                        [branch] if (customId < 0) { // If uses cookie
                                
                            LV_SphereSpotLightCookie(sqlen, dirN, -pos.w, att, ldir, angle, customId, lightOcclusion, L0, L1r, L1g, L1b, count);
                                
                        } else { // If it uses default parametric attenuation
                                
                            LV_SphereSpotLight(sqlen, dirN, -pos.w, att, spotMask, angle, ldir.w, lightOcclusion, L0, L1r, L1g, L1b, count);
                                
                        }
                            
                    }
                        
                } else if (color.w <= 1.5f) { // It is a point light
                        
                    [branch] if (customId > 0) { // Using LUT
                            
                        float invSqRange = abs(pos.w); // Sign of range defines if it's point light (positive) or a spot light (negative)
                        float dirRadius = sqlen * invSqRange;
                        uint id = (uint) _UdonPointLightVolumeCubeCount * 5 + customId;
                        float3 uvid = float3(sqrt(float2(0, dirRadius)), id);
                        float3 att = color.rgb * LV_SAMPLE(_UdonPointLightVolumeTexture, uvid).xyz * lightOcclusion;
                            
                        L0 += att;
                        L1r += dirN * att.r;
                        L1g += dirN * att.g;
                        L1b += dirN * att.b;
                            
                        count++;
                            
                    } else { // If it uses default parametric attenuation
                            
                        float3 l0 = 0, l1r = 0, l1g = 0, l1b = 0;
                        LV_SphereLight(sqlen, dirN, pos.w, color.rgb, lightOcclusion, sqrRange, l0, l1r, l1g, l1b, count);
                
                        float3 cubeColor = 1;
                        [branch] if (customId < 0) { // If it uses a cubemap
                            uint id = -customId - 1; // Cubemap ID starts from zero and should not take in count texture array slices count.
                            cubeColor = LV_SampleCubemapArray(id, LV_MultiplyVectorByQuaternion(dirN, ldir)).xyz;
                        }
                
                        L0 += l0 * cubeColor;
                        L1r += l1r * cubeColor.r;
                        L1g += l1g * cubeColor.g;
                        L1b += l1b * cubeColor.b;
                    }
                        
                } else { // It is an area light
                        
                    LV_QuadLight(worldPos, pos.xyz, ldir, float2(pos.w, color.w - 2.0f), color.rgb, sqrRange, lightOcclusion, L0, L1r, L1g, L1b, count);
                        
                }
                
            }
            
            void LV_SampleLightVolumeTex(float3 uvw0, float3 uvw1, float3 uvw2, out float3 L0, out float3 L1r, out float3 L1g, out float3 L1b) {
                // Sampling 3D Atlas
                float4 tex0 = LV_SAMPLE(_UdonLightVolume, uvw0);
                float4 tex1 = LV_SAMPLE(_UdonLightVolume, uvw1);
                float4 tex2 = LV_SAMPLE(_UdonLightVolume, uvw2);
                // Packing final data
                L0 = tex0.rgb;
                L1r = float3(tex1.r, tex2.r, tex0.a);
                L1g = float3(tex1.g, tex2.g, tex1.a);
                L1b = float3(tex1.b, tex2.b, tex2.a);
            }
            
            float LV_BoundsMask(float3 localUVW, float3 invLocalEdgeSmooth) {
                float3 distToMin = (localUVW + 0.5) * invLocalEdgeSmooth;
                float3 distToMax = (0.5 - localUVW) * invLocalEdgeSmooth;
                float3 fade = saturate(min(distToMin, distToMax));
                return fade.x * fade.y * fade.z;
            }
            
            void LV_SampleLightProbe(inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b) {
                L0 += float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                L1r += unity_SHAr.xyz;
                L1g += unity_SHAg.xyz;
                L1b += unity_SHAb.xyz;
            }
            
            void LV_SampleLightProbeDering(inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b) {
                L0 += float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                L1r += unity_SHAr.xyz * 0.565f;
                L1g += unity_SHAg.xyz * 0.565f;
                L1b += unity_SHAb.xyz * 0.565f;
            }
            
            void LV_SampleVolume(uint id, float3 localUVW, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, out float4 occlusion) {
                    
                // Additive UVW
                //uint uvwID = id * 3;
                //float4 uvwPos0 = _UdonLightVolumeUvwScale[uvwID];
                //float4 uvwPos1 = _UdonLightVolumeUvwScale[uvwID + 1];
                //float4 uvwPos2 = _UdonLightVolumeUvwScale[uvwID + 2];
                //float3 uvwScale = float3(uvwPos0.w, uvwPos1.w, uvwPos2.w);
                    
                //float3 uvwScaled = saturate(localUVW + 0.5) * uvwScale;
                //float3 uvw0 = uvwPos0.xyz + uvwScaled;
                //float3 uvw1 = uvwPos1.xyz + uvwScaled;
                //float3 uvw2 = uvwPos2.xyz + uvwScaled;
                    
                // Legacy! Commented code above will be used in future releases! Legacy!
                uint uvwID = id * 6;
                float3 uvwScaled = saturate(localUVW + 0.5) * (_UdonLightVolumeUvw[uvwID + 1].xyz - _UdonLightVolumeUvw[uvwID].xyz);
                float3 uvw0 = uvwScaled + _UdonLightVolumeUvw[uvwID].xyz;
                float3 uvw1 = uvwScaled + _UdonLightVolumeUvw[uvwID + 2].xyz;
                float3 uvw2 = uvwScaled + _UdonLightVolumeUvw[uvwID + 4].xyz;
                    
                // Sample additive
                float3 l0, l1r, l1g, l1b;
                LV_SampleLightVolumeTex(uvw0, uvw1, uvw2, l0, l1r, l1g, l1b);
                
                // Sample occlusion
                float4 uvwOcclusion = _UdonLightVolumeOcclusionUvw[id];
                [branch] if (uvwOcclusion.x >= 0) {
                    occlusion = 1.0f - LV_SAMPLE(_UdonLightVolume, uvwOcclusion.xyz + uvwScaled * uvwOcclusion.w);
                } else {
                    occlusion = 1;
                }
                    
                // Color correction
                float4 color = _UdonLightVolumeColor[id];
                L0 += l0 * color.rgb;
                l1r *= color.r;
                l1g *= color.g;
                l1b *= color.b;
                    
                // Rotate if needed
                if (color.a != 0) {
                    //float4 r = _UdonLightVolumeRotationQuaternion[id];
                    //L1r = LV_MultiplyVectorByQuaternion(L1r, r);
                    //L1g = LV_MultiplyVectorByQuaternion(L1g, r);
                    //L1b = LV_MultiplyVectorByQuaternion(L1b, r);
                        
                    // Legacy to support older light volumes worlds! Commented code above will be used in future releases! Legacy!
                    float3 r0 = _UdonLightVolumeRotation[id * 2].xyz;
                    float3 r1 = _UdonLightVolumeRotation[id * 2 + 1].xyz;
                    L1r += LV_MultiplyVectorByMatrix2x3(l1r, r0, r1);
                    L1g += LV_MultiplyVectorByMatrix2x3(l1g, r0, r1);
                    L1b += LV_MultiplyVectorByMatrix2x3(l1b, r0, r1);
                } else {
                    L1r += l1r;
                    L1g += l1g;
                    L1b += l1b;
                }
                                
            }
            
            float4 LV_SampleVolumeOcclusion(uint id, float3 localUVW) {
                    
                // Sample occlusion
                float4 uvwOcclusion = _UdonLightVolumeOcclusionUvw[id];
                    
                [branch] if (uvwOcclusion.x >= 0) {
                    //uint uvwID = id * 3;
                    //float4 uvwPos0 = _UdonLightVolumeUvwScale[uvwID];
                    //float4 uvwPos1 = _UdonLightVolumeUvwScale[uvwID + 1];
                    //float4 uvwPos2 = _UdonLightVolumeUvwScale[uvwID + 2];
                    //float3 uvwScale = float3(uvwPos0.w, uvwPos1.w, uvwPos2.w);
                    //float3 uvwScaled = saturate(localUVW + 0.5) * uvwScale;
                        
                    // Legacy to support older light volumes worlds! Commented code above will be used in future releases! Legacy!
                    uint uvwID = id * 6;
                    float3 uvwScaled = saturate(localUVW + 0.5) * (_UdonLightVolumeUvw[uvwID + 1].xyz - _UdonLightVolumeUvw[uvwID].xyz);
                        
                    return 1.0f - LV_SAMPLE(_UdonLightVolume, uvwOcclusion.xyz + uvwScaled * uvwOcclusion.w);
                } else {
                    return 1;
                }
                    
            }
            
            void LV_PointLightVolumeSH(float3 worldPos, float4 occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b) {
                    
                uint pointCount = min((uint) _UdonPointLightVolumeCount, VRCLV_MAX_LIGHTS_COUNT);
                [branch] if (pointCount == 0) return;
                    
                uint maxOverdraw = min((uint) _UdonLightVolumeAdditiveMaxOverdraw, VRCLV_MAX_LIGHTS_COUNT);
                uint pcount = 0; // Point lights counter
                
                [loop] for (uint pid = 0; pid < pointCount && pcount < maxOverdraw; pid++) {
                    LV_PointLight(pid, worldPos, occlusion, L0, L1r, L1g, L1b, pcount);
                }
                    
            }
            
            void LV_LightVolumeSH(float3 worldPos, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, out float4 occlusion) {
                
                // Initializing output variables
                occlusion = 1;
                float4 mOcclusion = 1; // Multiplicative occlusion. Applies on top of regular occlusion
                    
                // Clamping gloabal iteration counts
                uint volumesCount = min((uint) _UdonLightVolumeCount, VRCLV_MAX_VOLUMES_COUNT);
                    
                //if (_UdonLightVolumeVersion < VRCLV_VERSION || volumesCount == 0 ) { // Fallback to default light probes if Light Volume are not enabled or a version is too old to have a support
                [branch] if (volumesCount == 0) { // Legacy! Fallback to default light probes if Light Volume are not enabled or a version is too old to have a support. Legacy!
                    LV_SampleLightProbe(L0, L1r, L1g, L1b);
                    return;
                }
                    
                uint maxOverdraw = min((uint) _UdonLightVolumeAdditiveMaxOverdraw, VRCLV_MAX_VOLUMES_COUNT);
                uint additiveCount = min((uint) _UdonLightVolumeAdditiveCount, VRCLV_MAX_VOLUMES_COUNT);
                bool lightProbesBlend = _UdonLightVolumeProbesBlend;
                    
                uint volumeID_A = -1; // Main, dominant volume ID
                uint volumeID_B = -1; // Secondary volume ID to blend main with
                
                float3 localUVW   = 0; // Last local UVW to use in disabled Light Probes mode
                float3 localUVW_A = 0; // Main local UVW
                float3 localUVW_B = 0; // Secondary local UVW
                    
                // Are A and B volumes NOT found?
                bool isNoA = true;
                bool isNoB = true;
                    
                // Additive volumes variables
                uint addVolumesCount = 0;
                    
                // Iterating through all light volumes with simplified algorithm requiring Light Volumes to be sorted by weight in descending order
                [loop] for (uint id = 0; id < volumesCount; id++) {
                    localUVW = LV_LocalFromVolume(id, worldPos);
                    [branch] if (LV_PointLocalAABB(localUVW)) { // Intersection test
                        [branch] if (id < additiveCount) { // Sampling additive volumes
                            [branch] if (addVolumesCount < maxOverdraw) {
                                float4 occ; // Multiplicative occlusion
                                LV_SampleVolume(id, localUVW, L0, L1r, L1g, L1b, occ);
                                mOcclusion *= occ;
                                addVolumesCount++;
                            } 
                        } else if (isNoA) { // First, searching for volume A
                            volumeID_A = id;
                            localUVW_A = localUVW;
                            isNoA = false;
                        } else { // Next, searching for volume B if A found
                            volumeID_B = id;
                            localUVW_B = localUVW;
                            isNoB = false;
                            break;
                        }
                    }
                }
                
                // If no volumes found, using Light Probes as fallback
                [branch] if (isNoA && lightProbesBlend) {
                    LV_SampleLightProbe(L0, L1r, L1g, L1b);
                    occlusion *= mOcclusion;
                    return;
                }
                        
                // Fallback to lowest weight light volume if outside of every volume
                localUVW_A = isNoA ? localUVW : localUVW_A;
                volumeID_A = isNoA ? volumesCount - 1 : volumeID_A;
                
                // Volume A SH components, occlusion, and mask to blend volume sides
                float3 L0_A  = 0;
                float3 L1r_A = 0;
                float3 L1g_A = 0;
                float3 L1b_A = 0;
                float4 occlusion_A = 1;
                    
                // Sampling Light Volume A
                LV_SampleVolume(volumeID_A, localUVW_A, L0_A, L1r_A, L1g_A, L1b_A, occlusion_A);
                    
                float mask = LV_BoundsMask(localUVW_A, _UdonLightVolumeInvLocalEdgeSmooth[volumeID_A]);
                [branch] if (mask == 1 || isNoA || (_UdonLightVolumeSharpBounds && isNoB)) { // Returning SH A result if it's the center of mask or out of bounds
                    L0  += L0_A;
                    L1r += L1r_A;
                    L1g += L1g_A;
                    L1b += L1b_A;
                    occlusion = occlusion_A;
                    occlusion *= mOcclusion;
                    return;
                }
                    
                // Volume B SH components and occlusion
                float3 L0_B  = 0;
                float3 L1r_B = 0;
                float3 L1g_B = 0;
                float3 L1b_B = 0;
                float4 occlusion_B = 1;
                
                [branch] if (isNoB && lightProbesBlend) { // No Volume found and light volumes blending enabled
                
                    // Sample Light Probes B
                    LV_SampleLightProbe(L0_B, L1r_B, L1g_B, L1b_B);
                
                } else { // Blending Volume A and Volume B
                            
                    // If no volume b found, use last one found to fallback
                    localUVW_B = isNoB ? localUVW : localUVW_B;
                    volumeID_B = isNoB ? volumesCount - 1 : volumeID_B;
                            
                    // Sampling Light Volume B
                    LV_SampleVolume(volumeID_B, localUVW_B, L0_B, L1r_B, L1g_B, L1b_B, occlusion_B);
                        
                }
                
                // Lerping occlusion
                occlusion = lerp(occlusion_B, occlusion_A, mask);
                occlusion *= mOcclusion;
                
                // Lerping SH components
                L0  += lerp(L0_B,  L0_A,  mask);
                L1r += lerp(L1r_B, L1r_A, mask);
                L1g += lerp(L1g_B, L1g_A, mask);
                L1b += lerp(L1b_B, L1b_A, mask);
                
            }
            
            void LV_LightVolumeAdditiveSH(float3 worldPos, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, out float4 occlusion) {
                
                // Initializing output variables
                occlusion = 1;
                float4 mOcclusion = 1; // Multiplicative occlusion. Applies on top of regular occlusion
                    
                // Clamping gloabal iteration counts
                uint additiveCount = min((uint) _UdonLightVolumeAdditiveCount, VRCLV_MAX_VOLUMES_COUNT);
                //if (_UdonLightVolumeVersion < VRCLV_VERSION || (additiveCount == 0 && pointCount == 0)) return;
                [branch] if (additiveCount == 0 && (uint) _UdonPointLightVolumeCount == 0) return; // Legacy!
                
                uint volumesCount = min((uint) _UdonLightVolumeCount, VRCLV_MAX_VOLUMES_COUNT);
                uint maxOverdraw = min((uint) _UdonLightVolumeAdditiveMaxOverdraw, VRCLV_MAX_VOLUMES_COUNT);
                    
                uint volumeID_A = -1; // Main, dominant volume ID
                uint volumeID_B = -1; // Secondary volume ID to blend main with
                
                float3 localUVW   = 0; // Last local UVW to use in disabled Light Probes mode
                float3 localUVW_A = 0; // Main local UVW for Y Axis and Free rotations
                float3 localUVW_B = 0; // Secondary local UVW
                    
                // Are A and B volumes NOT found?
                bool isNoA = true;
                bool isNoB = true;
                    
                // Additive volumes variables
                uint addVolumesCount = 0;
                
                // Iterating through all light volumes with simplified algorithm requiring Light Volumes to be sorted by weight in descending order
                uint count = min(_UdonLightVolumeOcclusionCount == 0 ? additiveCount : volumesCount, VRCLV_MAX_VOLUMES_COUNT); // Only use all volumes if occlusion volumes are enabled
                [loop] for (uint id = 0; id < count; id++) {
                    localUVW = LV_LocalFromVolume(id, worldPos);
                    [branch] if (LV_PointLocalAABB(localUVW)) { // Intersection test
                        [branch] if (id < additiveCount) { // Sampling additive volumes
                            [branch] if (addVolumesCount < maxOverdraw) {
                                float4 occ; // Multiplicative occlusion
                                LV_SampleVolume(id, localUVW, L0, L1r, L1g, L1b, occ);
                                mOcclusion *= occ;
                                addVolumesCount++;
                            } 
                        } else if (isNoA) { // First, searching for volume A
                            volumeID_A = id;
                            localUVW_A = localUVW;
                            isNoA = false;
                        } else { // Next, searching for volume B if A found
                            volumeID_B = id;
                            localUVW_B = localUVW;
                            isNoB = false;
                            break;
                        }
                    }
                }
                
                // If no volumes found, or we don't need the occlusion data, we are done
                [branch] if (isNoA || _UdonLightVolumeOcclusionCount == 0) {
                    occlusion *= mOcclusion;
                    return;
                }
                    
                // Fallback to lowest weight light volume if outside of every volume
                localUVW_A = isNoA ? localUVW : localUVW_A;
                volumeID_A = isNoA ? volumesCount - 1 : volumeID_A;
                
                // Sampling Light Volume A
                occlusion = LV_SampleVolumeOcclusion(volumeID_A, localUVW_A);
                float mask = LV_BoundsMask(localUVW_A, _UdonLightVolumeInvLocalEdgeSmooth[volumeID_A]);
                    
                [branch] if (mask == 1 || (_UdonLightVolumeSharpBounds && isNoB)) {
                    occlusion *= mOcclusion;
                    return; // Returning A result if it's the center of mask or out of bounds
                }
                
                // Blending Volume A and Volume B
                [branch] if (isNoB) occlusion = lerp(1, occlusion, mask);
                else occlusion = lerp(LV_SampleVolumeOcclusion(volumeID_B, localUVW_B), occlusion, mask);
                
                occlusion *= mOcclusion;
                    
            }
            
            float3 LightVolumeSpecular(float3 f0, float smoothness, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                    
                float3 specColor = max(float3(dot(reflect(-L1r, worldNormal), viewDir), dot(reflect(-L1g, worldNormal), viewDir), dot(reflect(-L1b, worldNormal), viewDir)), 0);
                    
                float3 rDir = normalize(normalize(L1r) + viewDir);
                float3 gDir = normalize(normalize(L1g) + viewDir);
                float3 bDir = normalize(normalize(L1b) + viewDir);
                    
                float rNh = saturate(dot(worldNormal, rDir));
                float gNh = saturate(dot(worldNormal, gDir));
                float bNh = saturate(dot(worldNormal, bDir));
                    
                float roughness = 1 - smoothness * 0.9f;
                float roughExp = roughness * roughness;
                    
                float rSpec = LV_DistributionGGX(rNh, roughExp);
                float gSpec = LV_DistributionGGX(gNh, roughExp);
                float bSpec = LV_DistributionGGX(bNh, roughExp);
                    
                float3 specs = (rSpec + gSpec + bSpec) * f0;
                float3 coloredSpecs = specs * specColor;
                    
                float3 a = coloredSpecs + specs * L0;
                float3 b = coloredSpecs * 3;
                    
                return max(lerp(a, b, smoothness) * 0.5f, 0.0);
                    
            }
            
            float3 LightVolumeSpecular(float3 albedo, float smoothness, float metallic, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                float3 specularf0 = lerp(0.04f, albedo, metallic);
                return LightVolumeSpecular(specularf0, smoothness, worldNormal, viewDir, L0, L1r, L1g, L1b);
            }
            
            float3 LightVolumeSpecularDominant(float3 f0, float smoothness, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                    
                float3 dominantDir = L1r + L1g + L1b;
                float3 dir = normalize(normalize(dominantDir) + viewDir);
                float nh = saturate(dot(worldNormal, dir));
                    
                float roughness = 1 - smoothness * 0.9f;
                float roughExp = roughness * roughness;
                    
                float spec = LV_DistributionGGX(nh, roughExp);
                    
                return max(spec * L0 * f0, 0.0) * 1.5f;
                    
            }
            
            float3 LightVolumeSpecularDominant(float3 albedo, float smoothness, float metallic, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                float3 specularf0 = lerp(0.04f, albedo, metallic);
                return LightVolumeSpecularDominant(specularf0, smoothness, worldNormal, viewDir, L0, L1r, L1g, L1b);
            }
            
            float3 LightVolumeEvaluate(float3 worldNormal, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                return float3(LV_EvaluateSH(L0.r, L1r, worldNormal), LV_EvaluateSH(L0.g, L1g, worldNormal), LV_EvaluateSH(L0.b, L1b, worldNormal));
            }
            
            void LightVolumeSH(float3 worldPos, out float3 L0, out float3 L1r, out float3 L1g, out float3 L1b, float3 worldPosOffset = 0) {
                L0 = 0; L1r = 0; L1g = 0; L1b = 0;
                if (_UdonLightVolumeEnabled == 0) {
                    LV_SampleLightProbeDering(L0, L1r, L1g, L1b);
                } else {
                    float4 occlusion = 1;
                    LV_LightVolumeSH(worldPos + worldPosOffset, L0, L1r, L1g, L1b, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, L1r, L1g, L1b);
                }
            }
            
            void LightVolumeAdditiveSH(float3 worldPos, out float3 L0, out float3 L1r, out float3 L1g, out float3 L1b, float3 worldPosOffset = 0) {
                L0 = 0; L1r = 0; L1g = 0; L1b = 0;
                if (_UdonLightVolumeEnabled != 0) {
                    float4 occlusion = 1;
                    LV_LightVolumeAdditiveSH(worldPos + worldPosOffset, L0, L1r, L1g, L1b, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, L1r, L1g, L1b);
                }
            }
            
            float3 LightVolumeSH_L0(float3 worldPos, float3 worldPosOffset = 0) {
                if (_UdonLightVolumeEnabled == 0) {
                    return float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                } else {
                    float3 L0 = 0; float4 occlusion = 1;
                    float3 unused_L1; // Let's just pray that compiler will strip everything x.x
                    LV_LightVolumeSH(worldPos + worldPosOffset, L0, unused_L1, unused_L1, unused_L1, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, unused_L1, unused_L1, unused_L1);
                    return L0;
                }
            }
            
            float3 LightVolumeAdditiveSH_L0(float3 worldPos, float3 worldPosOffset = 0) {
                if (_UdonLightVolumeEnabled == 0) {
                    return 0;
                } else {
                    float3 L0 = 0; float4 occlusion = 1;
                    float3 unused_L1; // Let's just pray that compiler will strip everything x.x
                    LV_LightVolumeAdditiveSH(worldPos + worldPosOffset, L0, unused_L1, unused_L1, unused_L1, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, unused_L1, unused_L1, unused_L1);
                    return L0;
                }
            }
            
            float LightVolumesEnabled() {
                return _UdonLightVolumeEnabled;
            }
            
            float LightVolumesVersion() {
                return _UdonLightVolumeVersion == 0 ? _UdonLightVolumeEnabled : _UdonLightVolumeVersion;
            }
            
            #endif
            
            #if INCLUDE_LTCGI
            
            void LTCGICallbackDiffuse(inout LTCGIAccumulatorStruct acc, in ltcgi_output output)
            {
                acc.diffuse += output.intensity * output.color;
            }
            
            void LTCGICallbackSpecular(inout LTCGIAccumulatorStruct acc, in ltcgi_output output)
            {
                acc.specular += output.intensity * output.color;
            }    
            
            #define LTCGI_V2_DIFFUSE_CALLBACK LTCGICallbackDiffuse
            #define LTCGI_V2_SPECULAR_CALLBACK LTCGICallbackSpecular
                
            #include "Packages/at.pimaker.ltcgi/Shaders/LTCGI.cginc"
            #endif
            
            // Bakery volume helpers
            #if defined(BAKERY_ENABLED)
            #if defined(BAKERY_VOLUME)
            BakeryVolumeData GetBakeryVolumeTextureData(BakeryVolumeData data)
            {
                #ifdef BAKERY_COMPRESSED_VOLUME
                    data.tex0 = _Volume0.Sample(sampler_Volume0, data.uv);
                    data.tex1 = _Volume1.Sample(sampler_Volume0, data.uv) * 2 - 1;
                    data.tex2 = _Volume2.Sample(sampler_Volume0, data.uv) * 2 - 1;
                    data.tex3 = _Volume3.Sample(sampler_Volume0, data.uv) * 2 - 1;
                    data.L0 = data.tex0.xyz;
                    data.L1x = data.tex1.xyz * data.L0 * 2;
                    data.L1y = data.tex2.xyz * data.L0 * 2;
                    data.L1z = data.tex3.xyz * data.L0 * 2;
                #else
                    data.tex0 = _Volume0.Sample(sampler_Volume0, data.uv);
                    data.tex1 = _Volume1.Sample(sampler_Volume0, data.uv);
                    data.tex2 = _Volume2.Sample(sampler_Volume0, data.uv);
                    data.L0 = data.tex0.xyz;
                    data.L1x = data.tex1.xyz;
                    data.L1y = data.tex2.xyz;
                    data.L1z = float3(data.tex0.w, data.tex1.w, data.tex2.w);
                #endif
                return data;
            }
            
            BakeryVolumeSpecularData GetBakeryVolumeSpecularData(BakeryVolumeData data)
            {
                BakeryVolumeSpecularData ret = (BakeryVolumeSpecularData) 0;
            
                float3 nL1x = data.L1x / data.L0;
                float3 nL1y = data.L1y / data.L0;
                float3 nL1z = data.L1z / data.L0;
                ret.direction = float3(dot(nL1x, lumaConv), dot(nL1y, lumaConv), dot(nL1z, lumaConv));
                ret.color = data.L0 + ret.direction.x * data.L1x + ret.direction.y * data.L1y + ret.direction.z * data.L1z;
                ret.NoV = dot(data.normal, data.viewDir);
                ret.NoV = max(ret.NoV, 0.0001);
                return ret;
            }
            
            #endif
            
            #endif

            // Functions
            void PBRFragment(MeshData d, inout SurfaceData o) {
                // this allows us to handle things like parallax nicely
                #if defined(PARALLAX)
                    GLOBAL_uv = GLOBAL_parallaxUv;
                #else
                    GLOBAL_uv = d.uv0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                #endif
            
                // Do Triplanar
                if (_MappingSpace == 3)
                {
                    // Fast (bad) Triplanar
                    float3 axisProjection = mul(float3(0.0001, 0.0001, 1), d.TBNMatrix);
                    axisProjection = abs(axisProjection);
                    axisProjection = pow(axisProjection, 160);
                    axisProjection /= axisProjection.x + axisProjection.y + axisProjection.z;
                    axisProjection = saturate(invLerp(axisProjection, 0.5, 0.5001));
                    axisProjection.z += saturate(1 - length(axisProjection));
            
                    float3 pos = d.worldSpacePosition * _MainTex_ST.x;
                    GLOBAL_uv = pos.zy;
                    GLOBAL_uv *= axisProjection.x;
                    GLOBAL_uv += pos.xz * axisProjection.y;
                    GLOBAL_uv += pos.xy * axisProjection.z;
            
                }
                else if (_MappingSpace > 0)
                {
                    GLOBAL_uv = (_MappingSpace - 1) ? half2(d.worldSpacePosition[_PlanarAxisX], d.worldSpacePosition[_PlanarAxisY]) : half2(d.localSpacePosition[_PlanarAxisX], d.localSpacePosition[_PlanarAxisY]);
                    GLOBAL_uv *= _MainTex_ST.xy + _MainTex_ST.zw;
                }
                half4 albedo = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, GLOBAL_uv);
                if (_AlbedoChannel > 0)
                {
                    albedo.rgb = albedo[_AlbedoChannel - 1].xxx;
                }
                half4 masks = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, GLOBAL_uv);
                float4 normalTex = SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, GLOBAL_uv);
                if (_FlipBumpY)
                {
                    normalTex.y = 1 - normalTex.y;
                }
                    
                float3 normal = UnpackNormalScale(normalTex, _BumpScale);
            
                half3 emission = SAMPLE_TEXTURE2D(_EmissionMap, sampler_EmissionMap, GLOBAL_uv).rgb;
                if (_EmissionChannel > 0)
                {
                    emission.rgb = emission[_EmissionChannel - 1].xxx;
                }
                int hasMasks = _MaskMap_TexelSize.z > 8;
                half metal = masks[_MetalChannel];
                half smooth = masks[_SmoothChannel];
                if (_RoughnessMode)
                {
                    smooth = 1 - smooth;
                }
                half detailMask = masks[_DetailMaskChannel];
                half occlusion = masks[_AOChannel];
                metal = remap(metal, 0, 1, _MetallicRemap.x, _MetallicRemap.y);
                smooth = remap(smooth, 0, 1, _SmoothnessRemap.x, _SmoothnessRemap.y);
                GLOBAL_maskMap = half4(metal, occlusion, detailMask, smooth);
                o.Metallic = lerp(_Metallic, metal, hasMasks);
                o.Smoothness = lerp(_Smoothness, smooth, hasMasks);
                o.Occlusion = lerp(1, occlusion, _OcclusionStrength);
                o.Normal = normal;
                if (!_DetailAsTintMask)
                {
                    o.Albedo *= albedo.rgb * _Color.rgb;
                }
                else
                {
                    o.Albedo *= lerp(albedo, albedo.rgb * _Color.rgb, detailMask);
                }
                // Fix BC7 compression issues, unity PLS fix
                {
                    uint a = uint(o.Alpha * 255.0);
                    a = a > 254 ? 255 : a;
                    a = a < 5 ? 0 : a;
                    o.Alpha =  a / 255.0;
                }
            
                o.Alpha *= albedo.a * _Color.a;
                #if defined(_EMISSION)
                    o.Emission = emission * pow(_EmissionColor,2.2);
                #endif
            }
            

            #if defined(_PARALLAXSTEPS_EIGHT)
                #define PARALLAX_STEPS 8
            #elif defined(_PARALLAXSTEPS_SIXTEEN)
                #define PARALLAX_STEPS 16
            #elif defined(_PARALLAXSTEPS_THIRTYTWO)
                #define PARALLAX_STEPS 32
            #elif defined(_PARALLAXSTEPS_SIXTYFOUR)
                #define PARALLAX_STEPS 64
            #else
                #define PARALLAX_STEPS 1
            #endif
            
            float2 POM_simple(TEXTURE2D_PARAM(heightMap, heightSampler), float currentHeight, float scale, float2 uv, float3 tangetSpaceViewDir, float refPlane, out float heightOffset)
            {
                heightOffset = 0;
                float2 uvOffset = 0;
                float stepSize = 1.0 / PARALLAX_STEPS;
                float stepHeight = 1;
                tangetSpaceViewDir.xy /= (tangetSpaceViewDir.z + 0.42);
                float2 uvDelta = tangetSpaceViewDir.xy * (stepSize * scale);
            
                float2 derivatives = float2(ddx(uv.x), ddy(uv.y));
            
                [unroll(PARALLAX_STEPS)]
                for (int i = 1; i <= PARALLAX_STEPS && stepHeight > currentHeight; i++)
                {
                    uvOffset -= uvDelta;
                    stepHeight -= stepSize;
                    currentHeight = SAMPLE_TEXTURE2D_GRAD(heightMap, heightSampler, uv + uvOffset, derivatives.x, derivatives.y).r + refPlane;
                }
            
                [unroll(3)]
                for (int k = 0; k < 3; k++)
                {
                    uvDelta *= 0.5;
                    stepSize *= 0.5;
            
                    if (stepHeight < currentHeight)
                    {
                        uvOffset += uvDelta;
                        stepHeight += stepSize;
                    } else {
                        uvOffset -= uvDelta;
                        stepHeight -= stepSize;
                    }
                    currentHeight = SAMPLE_TEXTURE2D_GRAD(heightMap, heightSampler, uv + uvOffset, derivatives.x, derivatives.y).r + refPlane;
                }
            
                heightOffset = currentHeight;
                return uvOffset;
            }
            
            void ParallaxFragment(MeshData d, FragmentData i)
            {
                // this is a bit "magical" but basically we just push to global UVs
                // and then any other module will read from them
                // we use FragmentQueue to push the actual function call above the other modules
                GLOBAL_parallaxUv = d.uv0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                #if defined(PARALLAX) && !defined(PLAT_QUEST)
                {
                    float customHeight = 0;
                    if (_ParallaxScaleBasedOnAngle)
                    {
                        float3 forwardRay = TransformViewToWorldDir(float3(0,0,1));
                        _HeightScale *= pow(saturate(dot(d.worldNormal, forwardRay)), 1.0/1.5);
                    }
                    half startingPoint = SAMPLE_TEXTURE2D(_Height, sampler_Height, GLOBAL_parallaxUv).r;
                    float2 uvOffset = POM_simple(TEXTURE2D_ARGS(_Height, sampler_Height), startingPoint, _HeightScale, GLOBAL_parallaxUv, d.tangentSpaceViewDir, _HeightRefPlane, customHeight);
                    GLOBAL_parallaxUv += uvOffset;
            
                    GLOBAL_height = customHeight;
                    GLOBAL_heightSet = 1;
                }
                #endif
            }
            

            void DetailsFragment(MeshData d, inout SurfaceData o)
            {
                #if !defined(DETAILS_OVERLAY)
                    return;
                #else
                half masks = 0;
            
                // we can grab the mask map from the Base Shader if it was present
                #if defined(_MASKMAP_SAMPLED)
                masks = GLOBAL_maskMap.b;
                #else
                masks = 1;
                #endif
            
                half mask = lerp(masks, 1, _DIgnoreMask);
                float2 uv = d.uv0.xy;
                switch(_DUVChannel)
                {
                    case 1: uv = d.uv1.xy; break;
                    case 2: uv = d.uv2.xy; break;
                    case 3: uv = d.uv3.xy; break;
                    default: uv = d.uv0.xy; break;
                }
                uv = uv * _DDetailsMap_ST.xy + _DDetailsMap_ST.zw;
                if (_DMappingSpace > 0)
                {
                    uv = (_DMappingSpace - 1) ? half2(d.worldSpacePosition[_DPlanarAxisX], d.worldSpacePosition[_DPlanarAxisY]) : half2(d.localSpacePosition[_DPlanarAxisX], d.localSpacePosition[_DPlanarAxisY]);
                    uv = uv * _DDetailsMap_ST.xy + _DDetailsMap_ST.zw;
                }
            
                half4 detailsMap = SAMPLE_TEXTURE2D(_DDetailsMap, sampler_DDetailsMap, uv);
            
                #if defined(DETAILS_MODE_PACKED)
                    
                // 0.5 is the neutral value
                half detailAlbedo = detailsMap.r * 2.0 - 1.0;
                half detailSmooth = detailsMap.b * 2.0 - 1.0;
                half3 detailNormal = 0;
                if (_DNormalFlipY)
                {
                    detailsMap.g = 1 - detailsMap.g;
                }
                detailNormal = UnpackNormalScale(float4(detailsMap.ag, 1, 1), _DNormalScale);
                half detailAlbedoSpeed = saturate(abs(detailAlbedo) * _DAlbedoScale);
                half3 albedoOverlay = lerp(sqrt(o.Albedo), (detailAlbedo < 0.0) ? 0.0.xxx : 1.0.xxx, detailAlbedoSpeed * detailAlbedoSpeed);
                albedoOverlay *= albedoOverlay;
            
                // Packed mode only supports HDRP-style albedo mixing
                o.Albedo = lerp(o.Albedo, saturate(albedoOverlay), mask);
            
                #elif defined(DETAILS_MODE_SEPARATED)        
                half detailSmooth = detailsMap.a * 2.0 - 1.0;
            
                half4 packedNormal = SAMPLE_TEXTURE2D(_DDetailsNormal, sampler_DDetailsNormal, uv);
                if (_DNormalFlipY)
                {
                    packedNormal.g = 1 - packedNormal.g;
                }
                half3 detailNormal = UnpackNormalScale(packedNormal, _DNormalScale);
            
                // Separated mdoe supports BIRP-style 2x albedo mixing
                if (_DAlbedoMixingLegacy) {
                    o.Albedo *= LerpWhiteTo(detailsMap.rgb * unity_ColorSpaceDouble.rgb, mask * _DAlbedoScale);
                } else {
                    half3 detailAlbedo = detailsMap.rgb * 2.0 - 1.0;
                    half3 detailAlbedoSpeed = saturate(abs(detailAlbedo) * _DAlbedoScale);
                    half3 albedoOverlay = lerp(sqrt(o.Albedo), (detailAlbedo < 0.0) ? 0.0.xxx : 1.0.xxx, detailAlbedoSpeed * detailAlbedoSpeed);
                    albedoOverlay *= albedoOverlay;
                    o.Albedo = lerp(o.Albedo, saturate(albedoOverlay), mask);
                }
                #endif
            
                // do the smooth details
                half detailSmoothSpeed = saturate(abs(detailSmooth) * _DSmoothScale);
                half smoothOverlay = lerp(o.Smoothness, (detailSmooth < 0.0) ? 0.0 : 1.0, detailSmoothSpeed * detailSmoothSpeed);
                o.Smoothness = lerp(o.Smoothness, saturate(smoothOverlay), mask);
            
                // do the normal details
                o.Normal = lerp(o.Normal, BlendNormals(o.Normal, detailNormal), mask);
                #endif
            }
            

            bool isVR__local()
            {
            #if UNITY_SINGLE_PASS_STEREO
                return true;
            #else
                return false;
            #endif
            }
            
            void VRCFeaturesVertex(inout VertexData v)
            {
                #if defined(VRC_FEATURES)
                bool isMainView = _VRChatCameraMode == 0 && _VRChatMirrorMode == 0;
                bool isInVRHandCam = _VRChatCameraMode == 1;
                bool isInDesktopHandCam = _VRChatCameraMode == 2;
                bool isInVR = isVR__local();
                bool isInDesktop = !isInVR && !isInDesktopHandCam;
                bool isInVRMirror = _VRChatMirrorMode == 1;
                bool isInDesktopMirror = _VRChatMirrorMode == 2;
            
                if (_VRCHideInVR && isInVR && isMainView)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInDesktop && isInDesktop && isMainView)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInVRCamera && isInVRHandCam)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInDesktopCamera && isInDesktopHandCam)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInVRMirror && isInVRMirror)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInDesktopMirror && isInDesktopMirror)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                #endif
            }
            

            void VRCLightVolumesCustomProbesSetup(MeshData d, inout SurfaceData o)
            {
                #if defined(INTEGRATE_VRCLIGHTVOLUMES) && !defined(ORL_LIGHTING_MODEL_UI)
                {
                    float3 L0, L1r, L1g, L1b;
                    LightVolumeSH(d.worldSpacePosition + d.worldNormal * _VRCLightVolumesSurfacePushoff, L0, L1r, L1g, L1b);
                    o.VRCLV_L0 = L0;
                    o.VRCLV_L1r = L1r;
                    o.VRCLV_L1g = L1g;
                    o.VRCLV_L1b = L1b;
            
                    // Since toon shaders can derive light directions from probes
                    // we need to directly modify these values
                    #if defined(ORL_LIGHTING_MODEL_TOON_V2)
                    unity_SHAr = float4(L1r, L0.r);
                    unity_SHAg = float4(L1g, L0.g);
                    unity_SHAb = float4(L1b, L0.b);
                    #endif
                }
                #endif
            }
            

            void VRCLightVolumesCustomProbes(SurfaceData o, MeshData d, inout half3 indirectDiffuse)
            {
                // Custom Probes
                #if defined(INTEGRATE_VRCLIGHTVOLUMES) && !defined(ORL_LIGHTING_MODEL_UI)
                {
                    #if defined(ORL_LIGHTING_MODEL_TOON_V2)
                    {
                        o.Normal = _IgnoreLightprobeNormal ? float3(0, 0.5, 0) : o.WorldNormal;
                    }
                    #endif
                    indirectDiffuse = LightVolumeEvaluate(o.Normal, o.VRCLV_L0, o.VRCLV_L1r, o.VRCLV_L1g, o.VRCLV_L1b);
                }
                #endif
            }
            

            void VRCLightVolumesCustomProbesBakedSpecular(SurfaceData o, MeshData d, inout half3 indirectSpecular, inout half3 bakedSpecularColor, inout half3 bakedDominantDirection)
            {
                #if defined(INTEGRATE_VRCLIGHTVOLUMES) && !defined(ORL_LIGHTING_MODEL_UI)
                bakedSpecularColor = o.VRCLV_L0;
                bakedDominantDirection = o.VRCLV_L1r.xyz + o.VRCLV_L1g.xyz + o.VRCLV_L1b.xyz;
                #endif
            }
            

            void VRCLightVolumesCustomGI(SurfaceData o, MeshData d, inout half3 indirectDiffuse)
            {
                #if defined(INTEGRATE_VRCLIGHTVOLUMES)
                {
                    #if defined(LIGHTMAP_ON)
                    {
                        float3 L0, L1r, L1g, L1b;
                        LightVolumeAdditiveSH(d.worldSpacePosition + d.worldNormal * _VRCLightVolumesSurfacePushoff, L0, L1r, L1g, L1b);
                        indirectDiffuse += LightVolumeEvaluate(o.Normal, L0, L1r, L1g, L1b);
                    }
                    #endif
                }
                #endif
            }
            

            void VRCLightVolumesColor(MeshData d, bool facing, inout half4 FinalColor)
            {
                #if !defined(UNITY_PASS_FORWARDBASE)
                return;
                #endif
                #if !defined(ORL_LIGHTING_MODEL_UI)
                return;
                #endif
            
                #if defined(INTEGRATE_VRCLIGHTVOLUMES)
                {
                    float3 L0, L1r, L1g, L1b;
                    float3 worldNormal = d.worldNormal;
                    if (!facing) {
                        worldNormal = -worldNormal;
                    }
                    LightVolumeSH(d.worldSpacePosition + worldNormal * _VRCLightVolumesSurfacePushoff, L0, L1r, L1g, L1b);
                    half3 indirectDiffuse = LightVolumeEvaluate(worldNormal, L0, L1r, L1g, L1b);
                    FinalColor.rgb *= indirectDiffuse;
                }
                #endif
            
            }
            

            void PosterDisplayFragment(FragmentData i, inout SurfaceData o)
            {
                fixed4 col = GetPosterColor(
                    i.uv0.xy,
                    _TimeOffset,
                    _DurationStatic,
                    _DurationEase,
                    _GridHorizontal,
                    _GridVertical,
                    _CellMargin,
                    _EaseFunction,
                    _EaseAnimation,
                    _PosterTex, _PosterTex_ST, _PosterTint,
                    _IdleTex, _IdleTex_ST, _IdleTint,
                    _Idling
                );
            
                o.Albedo *= col;
                o.Emission *= col;
            }
            

            
                void ALFragment(MeshData d, inout SurfaceData o)
                {
                    UNITY_BRANCH
                    if (_KillEffects) return;
            
                    UNITY_BRANCH
                    if (!AudioLinkIsAvailable()) return;
            
                    half3 finalEmission = 0;
                    half finalAlpha = 1;
                    float2 uv = 0;
                    switch(_ALUVChannel)
                    {
                        case 0: uv = d.uv0.xy; break;
                        case 1: uv = d.uv1.xy; break;
                        case 2: uv = d.uv2.xy; break;
                        case 3: uv = d.uv3.xy; break;
                    }
                    half4 mask = SAMPLE_TEXTURE2D(_ALMask, sampler_ALMask, uv);
                    
                    #if defined(AL_EFFECT_BAND_SELECTION)
            
                    half uvSource = lerp(uv.x, lerp(uv.y, lerp(1 - uv.x, 1 - uv.y, saturate(_BandScrollAxis - 2)), saturate(_BandScrollAxis - 1)), saturate(_BandScrollAxis));
                    half scaledUv = (uvSource * _BandHistoryRange) % 128.0;
                    half4 bandData = AudioLinkLerp(float2(scaledUv, clamp(_BandFrequency - 1, 0, 3)));
                    finalEmission = bandData.rgb * _ALTint;
                    finalAlpha = bandData.r;
            
                    #elif defined(AL_EFFECT_UV_BASED)
            
                    float2 scaledUv = float2(lerp(uv.x, uv.y, _UVFlipXY) * _UVHistoryRange % 128, floor(lerp(uv.y, uv.x, _UVFlipXY) * 4));
                    half4 bandData = AudioLinkLerp(scaledUv).rrra;
                    if (_UVUseThemeColors)
                    {
                        int band = clamp(floor(scaledUv.y), 0, 3);
                        switch(band)
                        {
                            case 0:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR0);
                                break;
                            case 1:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR1);
                                break;
                            case 2:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR2);
                                break;
                            case 3:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR3);
                                break;
                        }
                    }
                    finalEmission = bandData.rgb * _ALTint;
                    finalAlpha = bandData.r;
            
                    #elif defined(AL_EFFECT_WAVEFORM)
            
                    half noteno = abs(uv.x) * AUDIOLINK_ETOTALBINS;
                    half wvfrm = AudioLinkLerpMultiline(ALPASS_DFT + half2(noteno, 0)).z * _WVFRMScale;
                    half2 gradientUvs = uv;
                    if (_WVFRMFlipUVDirection) {
                        gradientUvs = half2(gradientUvs.y, gradientUvs.x);
                    }
                    half4 bottomColor = SAMPLE_TEXTURE2D(_WVFRMBottomColor, sampler_WVFRMBottomColor, gradientUvs);
                    half4 topColor = SAMPLE_TEXTURE2D(_WVFRMTopColor, sampler_WVFRMBottomColor, gradientUvs);
                    half4 midColor = SAMPLE_TEXTURE2D(_WVFRMMiddleColor, sampler_WVFRMBottomColor, gradientUvs);
                    half4 finalBlend = lerp(lerp(bottomColor, midColor, _WVFRMMiddleLine > 0 && lerp(uv.y, 1 - uv.y, _WVFRMFlip) > (wvfrm + _WVFRMOffset) - _WVFRMMiddleLineWidth), topColor, lerp(uv.y, 1 - uv.y, _WVFRMFlip) > (wvfrm + _WVFRMOffset));
                    finalEmission = finalBlend.rgb;
                    finalEmission *= _ALTint;
                    finalAlpha = finalBlend.a;
            
                    #elif defined(AL_EFFECT_PULSE)
            
                    half pulseData = 0;
                    UNITY_BRANCH
                    if (_PulseSmoothing == 0) {
                        pulseData = AudioLinkData(int2(0, clamp(_PulseBand - 1, 0, 3))).r;
                    } else {
                        pulseData = AudioLinkData(ALPASS_FILTEREDAUDIOLINK + int2(16 - _PulseSmoothing, clamp(_PulseBand - 1, 0, 3))).r;
                    }
                    if (_PulseMode == 0)
                    {
                        if (!_PulseEmissionMode)
                        {
                            finalEmission = o.Emission + pulseData * _ALTint * _PulseStrength;
                        }
                        else
                        {
                            finalEmission = o.Emission * pulseData * _ALTint * _PulseStrength;
                        }
                    }
                    else
                    {
                        finalEmission = pulseData * _PulseStrength * _ALTint;
                        if (_PulseTextureAdjustment == 0)
                        {
                            uv += _PulseTextureDirection.xy * pulseData;
                        }
                        else
                        {
                            float chrono = (AudioLinkDecodeDataAsUInt(ALPASS_CHRONOTENSITY + uint2(1, 0)) % 1000000) / 1000000.0;
                            uv += _PulseTextureDirection.xy * chrono;
                        }
                        finalEmission += SAMPLE_TEXTURE2D(_PulseTexture, sampler_PulseTexture, uv) * _ALTint;
                    }
            
                    #elif defined(AL_EFFECT_BAR)
            
                    float uvSource = lerp(uv.x, lerp(uv.y, lerp(1 - uv.x, 1 - uv.y, saturate(_BarAxis - 2)), saturate(_BarAxis - 1)), saturate(_BarAxis));
                    half3 color = SAMPLE_TEXTURE2D(_BarColor, sampler_BarColor, half2(uvSource, 0)).rgb;
                    half bandData = 0;
                    UNITY_BRANCH
                    if (_BarSmoothing == 0) {
                        bandData = saturate(AudioLinkData(int2(0, clamp(_BarBand - 1, 0, 3))).r * _BarScale);
                    } else {
                        bandData = saturate(AudioLinkData(ALPASS_FILTEREDAUDIOLINK + int2(16 - _BarSmoothing, clamp(_BarBand - 1, 0, 3))).r * _BarScale);
                    }
                    half barData = smoothstep((1 - bandData), (1 - bandData) + 0.01, uvSource);
                    finalEmission = lerp(0, barData.xxx * _ALTint.rgb * color.rgb, bandData);
                    finalAlpha = barData * bandData;
            
                    #endif
            
                    o.Emission = lerp(o.Emission, finalEmission, mask.r);
                    #if defined(AL_CUTOUT)
                    o.Alpha = finalAlpha;
                    #endif
                }
            

            void LTCGICustomGI(MeshData d, SurfaceData o, inout half3 customGISpecular, inout half3 customGIDiffuse)
            {
                #if !defined(ORL_LIGHTING_MODEL_VFX)
                {
                    #if defined(PLAT_QUEST)
                    if (!_LTCGIEnableOnMobile) return;
                    #endif
            
                    #if defined(INTEGRATE_LTCGI)
                        LTCGIAccumulatorStruct ltcgiData = (LTCGIAccumulatorStruct) 0;
            
                        LTCGI_Contribution(
                            ltcgiData,
                            d.worldSpacePosition.xyz,
                            o.Normal.xyz,
                            d.worldSpaceViewDir,
                            saturate((1 - o.Smoothness) + _LTCGIRoughnessModifier),
                            d.uv1.xy
                        );
            
                        if (_LTCGIClampBrightness) {
                            half3 hsv = RGB2HSV(ltcgiData.specular);
                            hsv.z = tanh(hsv.z) * max(0, _LTCGIMaxBrightness);
                            customGISpecular += HSV2RGB(hsv) * _LTCGISpecularIntensity;
                        } else {
                            customGISpecular += ltcgiData.specular * _LTCGISpecularIntensity;
                        }
                        customGIDiffuse += ltcgiData.diffuse * _LTCGIDiffuseIntensity;
                    #endif
                }
                #endif
            }
            

            void LTCGIColor(MeshData d, FragmentData i, inout half4 FinalColor, bool facing)
            {
                #if defined(ORL_LIGHTING_MODEL_VFX)
                {
                    #if defined(PLAT_QUEST)
                    if (!_LTCGIEnableOnMobile) return;
                    #endif
            
                    #if defined(INTEGRATE_LTCGI)
                        LTCGIAccumulatorStruct ltcgiData = (LTCGIAccumulatorStruct) 0;
            
                        float3 viewDir = d.worldSpaceViewDir;
                        if (!facing)
                        {
                            viewDir = -d.worldSpaceViewDir;
                        }
            
                        LTCGI_Contribution(
                            ltcgiData,
                            d.worldSpacePosition.xyz,
                            d.worldNormal.xyz,
                            viewDir,
                            saturate(0.5 + _LTCGIRoughnessModifier),
                            d.uv1.xy
                        );
            
                        if (_LTCGIClampBrightness) {
                            half3 hsv = RGB2HSV(ltcgiData.specular);
                            hsv.z = tanh(hsv.z) * max(0, _LTCGIMaxBrightness);
                            FinalColor.rgb += HSV2RGB(hsv) * _LTCGISpecularIntensity;
                        } else {
                            FinalColor.rgb += ltcgiData.specular * _LTCGISpecularIntensity;
                        }
                        FinalColor.rgb += ltcgiData.diffuse * _LTCGIDiffuseIntensity;
                        if (_LTCGIAlphaPremultiply)
                        {
                            FinalColor.rgb *= FinalColor.a;
                        }
                    #endif
                }
                #endif
            }
            

            void FragmentBase(MeshData d, FragmentData i, SurfaceData o, inout half4 FinalColor)
            {
                #if defined(UNITY_PASS_SHADOWCASTER)
                    return;
                #else
            
                half reflectance = 0.5;
                float oneMinusReflectivity = 1.0 - 0.04 - o.Metallic * (1.0 - 0.04);
                half3 f0 = 0.16 * reflectance * reflectance * oneMinusReflectivity + o.Albedo * o.Metallic;
            
                half3 indirectDiffuse = 0;
                half3 indirectSpecular = 0;
                    
                half occlusion = o.Occlusion;
            
                half perceptualRoughness = 1 - o.Smoothness;
            
                float3 tangentNormal = o.Normal;
            
                #if defined(SHADING_MODE_CLOTH)
                half3 albedoSqrt = sqrt(o.Albedo);
                #endif
                    
                o.Normal = Unity_SafeNormalize(mul(o.Normal, d.TBNMatrix));
            
                #ifndef USING_DIRECTIONAL_LIGHT
                float3 lightDir = Unity_SafeNormalize(UnityWorldSpaceLightDir(d.worldSpacePosition));
                #else
                float3 lightDir = Unity_SafeNormalize(_WorldSpaceLightPos0.xyz);
                #endif
            
                #if defined(GSAA)
                perceptualRoughness = GSAA_Filament(_GSAAIncludeNormalMaps ? o.Normal : d.worldNormal, perceptualRoughness, _GSAAVariance, _GSAAThreshold);
                #endif
            
                UNITY_LIGHT_ATTENUATION(lightAttenuation, i, d.worldSpacePosition);
                half3 lightColor = lightAttenuation * _LightColor0.rgb;
            
                float3 lightHalfVector = Unity_SafeNormalize(lightDir + d.worldSpaceViewDir);
                half lightNoL = saturate(dot(o.Normal, lightDir));
                half lightLoH = saturate(dot(lightDir, lightHalfVector));
            
                half NoV = abs(dot(o.Normal, d.worldSpaceViewDir)) + 1e-5;
            
                // Standard BRDF Setup
                half3 dfguv = half3(NoV, perceptualRoughness, 0);
                float2 dfg = SAMPLE_TEXTURE2D(_DFG, sampler_DFG, dfguv).xy;
                half3 energyCompensation = 1.0 + f0 * (1.0 / dfg.y - 1.0);
            
                float rough = perceptualRoughness * perceptualRoughness;
                half clampedRoughness = max(rough, ORL_MIN_ROUGHNESS);
            
                // Clear Coat BRDF Setup
                #if defined(CLEARCOAT)
                half3 clearcoatdfguv = 0;
                float2 clearcoatdfg = 0;
            
                float clearCoatAttenuation = 1.0;
                float clearCoatRoughness = 1.0 - _ClearCoatSmoothness;
                half clampedClearCoatRoughness = max(clearCoatRoughness * clearCoatRoughness, ORL_MIN_ROUGHNESS);
                half3 clearCoatMainLightSpecular = 0;
                half3 clearCoatIndirectSpecular = 0;
                #endif
            
                half3 mainLightDiffuse = 0;
                half3 mainLightSpecular = 0;
            
                mainLightDiffuse = Fd_Burley(perceptualRoughness, NoV, lightNoL, lightLoH);
            
                #if defined(SHADING_MODE_CLOTH)
                {
                    if (_ClothHasSubsurface)
                    {
                        mainLightDiffuse *= Fd_Wrap(dot(o.Normal, lightDir), 0.5);
                        mainLightDiffuse *= saturate(_ClothSubsurfaceColor.rgb + lightNoL);
                    } else {
                        mainLightDiffuse *= lightNoL;
                    }
                    mainLightDiffuse *= lightColor;
                }
                #else
                mainLightDiffuse *= lightColor * lightNoL;
                #endif
            
            
                // Collect Vertex Light Data and calculate direct diffuse
                #if defined(SHADE_VERTEXLIGHTS) &&defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                float4x4 vLightColors = getVertexLightsColors(d.worldSpacePosition, o.Normal, false);
                float4x4 vLightDirections = getVertexLightsDir(d.worldSpacePosition);
                float4x4 vLightHalfVectors = 0;
                float4 vLightNoLs = 0;
                float4 vLightLoHs = 0;
            
                half3 vertexLightDiffuse = 0;
                half3 vertexLightSpecular = 0;
                half3 clearCoatVertexLightSpecular = 0;
            
                [unroll(4)]
                for (int i = 0; i < 4; i++)
                {
                    vLightHalfVectors[i].rgb = Unity_SafeNormalize(vLightDirections[i] + d.worldSpaceViewDir);
                    vLightLoHs[i] = saturate(dot(vLightDirections[i], vLightHalfVectors[i]));
                    vLightNoLs[i] = saturate(dot(o.Normal, vLightDirections[i]));
            
                    half3 vLightDiffuse = Fd_Burley(perceptualRoughness, NoV, vLightNoLs[i], vLightLoHs[i]);
            
                    #if defined(SHADING_MODE_CLOTH)
                    {
                        if (_ClothHasSubsurface)
                        {
                            vLightColors[i].rgb *= Fd_Wrap(dot(o.Normal, vLightDirections[i]), 0.5);
                            vLightColors[i].rgb *= saturate(_ClothSubsurfaceColor.rgb + vLightNoLs[i]);
                        } else {
                            vLightDiffuse *= vLightNoLs[i];
                        }
                        vLightDiffuse *= vLightColors[i];
                    }
                    #else
                    vLightDiffuse *= vLightColors[i] * vLightNoLs[i];
                    #endif
            
                    vertexLightDiffuse += vLightDiffuse;
                }
                #endif
            
                // https://assetstore.unity.com/packages/tools/level-design/bakery-gpu-lightmapper-122218
                #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME)
                    BakeryVolumeData volumeData = (BakeryVolumeData) 0;
            
                    if (_Udon_GlobalVolumeAdapterEnabled == 1)
                    {
                        _GlobalVolumeMin = _Udon_GlobalVolumeMin;
                        _GlobalVolumeInvSize = _Udon_GlobalVolumeInvSize;
            
                        // Arbitrary rotation (runtime only)
                        #if defined(BAKERY_VOLROTATION)
                        _GlobalVolumeMatrix = _Udon_GlobalVolumeMatrix;
                        #endif
            
                        // Y Rotation (baked)
                        #if defined(BAKERY_VOLROTATIONY)
                        _GlobalVolumeRY = _Udon_GlobalVolumeRY;
                        #endif
                    }
                        
                    bool isGlobalVolume = _VolumeInvSize.x > 1000000; // ~inf
                    volumeData.viewDir = Unity_SafeNormalize(d.worldSpaceViewDir);
                        
                    // Runtime volume rotation
                    // Requires a special adapter to work in VRChat
                    #if defined(BAKERY_VOLROTATION)
                        float4x4 volMatrix = (isGlobalVolume ? _GlobalVolumeMatrix : _VolumeMatrix);
                        float3 volInvSize = (isGlobalVolume ? _GlobalVolumeInvSize : _VolumeInvSize);
                        volumeData.uv = mul(volMatrix, float4(d.worldSpacePosition,1)).xyz * volInvSize + 0.5f;
            
                        volumeData.normal = mul((float3x3)volMatrix, o.Normal);
                        volumeData.normal = Unity_SafeNormalize(volumeData.normal);
                            
                        #if defined(BAKED_SPECULAR)
                            volumeData.viewDir = mul((float3x3)volMatrix, volumeData.viewDir);
                        #endif
                    #else
                        volumeData.uv = d.worldSpacePosition - (isGlobalVolume ? _GlobalVolumeMin : _VolumeMin);
                        #if defined(BAKERY_VOLROTATIONY)
                            float2 sc = (isGlobalVolume ? _GlobalVolumeRY : _VolumeRY);
                            volumeData.uv.xz = mul(float2x2(sc.y, -sc.x, sc.x, sc.y), volumeData.uv.xz);
                        #endif
                        volumeData.uv *= (isGlobalVolume ? _GlobalVolumeInvSize : _VolumeInvSize);
                        volumeData.normal = o.Normal;
                    #endif
            
                    volumeData.occlusion = saturate(dot(_VolumeMask.Sample(sampler_VolumeMask, volumeData.uv), unity_OcclusionMaskSelector));
            
                    lightColor *= volumeData.occlusion;
                    mainLightDiffuse *= volumeData.occlusion;
            
                    #if defined(SHADE_VERTEXLIGHTS) &&defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                    {
                        vertexLightDiffuse *= volumeData.occlusion;
                    }
                    #endif
            
                #endif    
            
                // READ THE LIGHTMAP
                // Can be Baked, Realtime, both or either
                #if (defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)) && defined(UNITY_PASS_FORWARDBASE)
                    half3 lightMap = 0;
                    half4 bakedColorTex = 0;
                    half2 lightmapUV = d.lightmapUv.xy;
            
                    // explicitly checking for lightmap on because we can be in rtgi only mode
                    #if defined(LIGHTMAP_ON)
                        
                    // UNITY LIGHTMAPPING
                    #if !defined(BAKERYLM_ENABLED) || !defined(BAKERY_ENABLED)
                        lightMap = tex2DFastBicubicLightmap(lightmapUV, bakedColorTex);
                    #endif
            
                    // BAKERY RNM MODE
                    #if defined(BAKERY_RNM) && defined(BAKERY_ENABLED)
                        float3 rnm0 = DecodeLightmap(BakeryTex2D(_RNM0, sampler_RNM0, lightmapUV, _RNM0_TexelSize));
                        float3 rnm1 = DecodeLightmap(BakeryTex2D(_RNM1, sampler_RNM0, lightmapUV, _RNM0_TexelSize));
                        float3 rnm2 = DecodeLightmap(BakeryTex2D(_RNM2, sampler_RNM0, lightmapUV, _RNM0_TexelSize));
                            
                        lightMap = saturate(dot(rnmBasis0, tangentNormal)) * rnm0 +
                        saturate(dot(rnmBasis1, tangentNormal)) * rnm1 +
                        saturate(dot(rnmBasis2, tangentNormal)) * rnm2;
                    #endif
            
                    // BAKERY SH MODE (these are also used for the specular)
                    #if defined(BAKERY_SH) && defined(BAKERY_ENABLED)
                        half3 L0 = DecodeLightmap(BakeryTex2D(unity_Lightmap, samplerunity_Lightmap, lightmapUV, _RNM0_TexelSize));
                            
                        half3 nL1x = BakeryTex2D(_RNM0, sampler_RNM0, lightmapUV, _RNM0_TexelSize) * 2.0 - 1.0;
                        half3 nL1y = BakeryTex2D(_RNM1, sampler_RNM0, lightmapUV, _RNM0_TexelSize) * 2.0 - 1.0;
                        half3 nL1z = BakeryTex2D(_RNM2, sampler_RNM0, lightmapUV, _RNM0_TexelSize) * 2.0 - 1.0;
                        half3 L1x = nL1x * L0 * 2.0;
                        half3 L1y = nL1y * L0 * 2.0;
                        half3 L1z = nL1z * L0 * 2.0;
                            
                        // Non-Linear mode
                        #if defined(BAKERY_SHNONLINEAR)
                        half lumaL0 = dot(L0, half(1));
                        half lumaL1x = dot(L1x, half(1));
                        half lumaL1y = dot(L1y, half(1));
                        half lumaL1z = dot(L1z, half(1));
                        half lumaSH = shEvaluateDiffuseL1Geomerics(lumaL0, half3(lumaL1x, lumaL1y, lumaL1z), o.Normal);
                            
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        half regularLumaSH = dot(lightMap, 1.0);
                        lightMap *= lerp(1.0, lumaSH / regularLumaSH, saturate(regularLumaSH * 16.0));
                        #else
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        #endif
                    #endif
            
                    // Load directional lightmap
                    #if defined(DIRLIGHTMAP_COMBINED)
                        half4 lightMapDirection = tex2DFastBicubicSample(TEXTURE2D_ARGS(unity_LightmapInd, samplerunity_Lightmap), lightmapUV);
                        #if !defined(BAKERY_MONOSH)
                            lightMap = DecodeDirectionalLightmap(lightMap, lightMapDirection, o.Normal);
                        #endif
                    #endif
            
                    // Unity+Bakery often results in a full clear of DIRLIGHTMAP_COMBINED keyword
                    // which in turn results in no lightmap being applied when MONOSH is enabled
                    // this is an escape hatch for such a case to improve dev experience
                    #if defined(BAKERY_MONOSH) && defined(BAKERY_ENABLED) && !defined(DIRLIGHTMAP_COMBINED)
                        lightMap = tex2DFastBicubicLightmap(lightmapUV, bakedColorTex);
                    #endif
            
                    // Bakery MonoSH handling
                    #if defined(BAKERY_MONOSH) && defined(BAKERY_ENABLED) && defined(DIRLIGHTMAP_COMBINED)
                        half3 L0 = tex2DFastBicubicLightmap(lightmapUV, bakedColorTex);
                        half3 nL1 = lightMapDirection.xyz * 2.0 - 1.0;
                        half3 L1x = nL1.x * L0 * 2.0;
                        half3 L1y = nL1.y * L0 * 2.0;
                        half3 L1z = nL1.z * L0 * 2.0;
            
                        #if defined(BAKERY_SHNONLINEAR)
                        half lumaL0 = dot(L0, 1);
                        half lumaL1x = dot(L1x, 1);
                        half lumaL1y = dot(L1y, 1);
                        half lumaL1z = dot(L1z, 1);
                        half lumaSH = shEvaluateDiffuseL1Geomerics(lumaL0, half3(lumaL1x, lumaL1y, lumaL1z), o.Normal);
            
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        half regularLumaSH = dot(lightMap, 1);
                        lightMap *= lerp(1, lumaSH / regularLumaSH, saturate(regularLumaSH*16));
                        #else
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        #endif
            
                        lightMap = max(lightMap, 0.0);
                    #endif
            
                    #endif // defined(LIGHTMAP_ON)
            
                    // Handle RTGI specifically
                    #if defined(DYNAMICLIGHTMAP_ON) && !defined(PLAT_QUEST)
                        // only branch on non-meta passes
                        #if !defined(UNITY_PASS_META)
                        {
                            [branch]
                            if (!_IgnoreRealtimeGI) {
                                half3 realtimeLightMap = getRealtimeLightmap(d.lightmapUv.zw, o.Normal, _RealtimeGIDisableBicubic);
                                lightMap += realtimeLightMap;
                            }
                        }
                        #else
                        {
                            half3 realtimeLightMap = getRealtimeLightmap(d.lightmapUv.zw, o.Normal);
                            lightMap += realtimeLightMap;
                        }
                        #endif
                    #endif
            
                    #if defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN)
                        mainLightDiffuse = 0;
                        lightMap = SubtractMainLightWithRealtimeAttenuationFromLightmapMultiply(lightMap, lightAttenuation, bakedColorTex, o.Normal);
                    #endif
            
                    indirectDiffuse = lightMap;
            
                // Lightmapping end
            
                // Bakery Volume Sampling (replaces probes and LPPVs)
                #elif defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME) && defined(UNITY_PASS_FORWARDBASE)
                    // Sample the volume textures
                    volumeData = GetBakeryVolumeTextureData(volumeData);
                    // Sample using Geomerics approach, similar to lightprobes and LPPVs
                    indirectDiffuse = max(0, GetNonLinearSH(
                        volumeData.L0, 
                        float3(volumeData.L1x.r, volumeData.L1y.r, volumeData.L1z.r),
                        float3(volumeData.L1x.g, volumeData.L1y.g, volumeData.L1z.g),
                        float3(volumeData.L1x.b, volumeData.L1y.b, volumeData.L1z.b),
                        volumeData.normal)
                    );
            
                // Lightprobes Sampling
                #elif defined(UNITY_PASS_FORWARDBASE)
                    #if defined(_INTEGRATE_CUSTOMPROBES)
                    {
                        VRCLightVolumesCustomProbesSetup(d, o);
                    }
                    #endif
                    // LPPV support
                    #if UNITY_LIGHT_PROBE_PROXY_VOLUME
                    {
                        UNITY_BRANCH
                        if (unity_ProbeVolumeParams.x == 1)
                        {
                            indirectDiffuse = SHEvalLinearL0L1_SampleProbeVolume(half4(o.Normal, 1), d.worldSpacePosition);
                        }
                        else // Mesh has BlendProbes instead of LPPV
                        {
                            // Enable Integration of Custom Lightprobe solutions
                            #if defined(_INTEGRATE_CUSTOMPROBES)
                            {
                                VRCLightVolumesCustomProbes(o, d, indirectDiffuse);
                            }
                            #else
                            {
                                #if defined(NONLINEAR_SH)
                                {
                                    half3 L0 = half3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                                    half3 L0L2 = half3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0;
                                    L0 = L0+L0L2;
                                    indirectDiffuse = max(0, GetNonLinearSH(L0, unity_SHAr, unity_SHAg, unity_SHAb, o.Normal));
                                    indirectDiffuse += SHEvalLinearL2(float4(o.Normal, 1));
                                }
                                #else
                                {
                                    indirectDiffuse = max(0, ShadeSH9(half4(o.Normal, 1)));   
                                }
                                #endif
                            }
                            #endif
                        }
                    }
                    #else // No LPPVs enabled project-wide
                    {
                        // Enable Integration of Custom Lightprobe solutions
                        #if defined(_INTEGRATE_CUSTOMPROBES)
                        {
                            VRCLightVolumesCustomProbes(o, d, indirectDiffuse);
                        }
                        #else
                        {
                            #if defined(NONLINEAR_SH)
                            {
                                half3 L0 = half3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                                half3 L0L2 = half3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0;
                                L0 = L0+L0L2;
                                indirectDiffuse = max(0, GetNonLinearSH(L0, unity_SHAr, unity_SHAg, unity_SHAb, o.Normal));
                                indirectDiffuse += SHEvalLinearL2(float4(o.Normal, 1));
                            }
                            #else
                            {
                                indirectDiffuse = max(0, ShadeSH9(half4(o.Normal, 1)));   
                            }
                            #endif
                        }
                        #endif
                    }
                    #endif
                #endif // end of #if defined(LIGHTMAP_ON) && !defined(UNITY_PASS_FORWARDADD)
            
                // Attenuate main light diffuse by shadowmask
                float3 forwardShadows = 1;
                #if defined(LIGHTMAP_SHADOW_MIXING) && defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) && defined(LIGHTMAP_ON) && !defined(UNITY_PASS_FORWARDADD)
                {
                    forwardShadows = UnityComputeForwardShadows(d.lightmapUv.xy, d.worldSpacePosition, d.screenPos);
                    mainLightDiffuse *= forwardShadows;
                }
                #endif
            
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                clearcoatdfguv = half3(NoV, clearCoatRoughness, 0);
                clearcoatdfg = SAMPLE_TEXTURE2D(_DFG, sampler_DFG, clearcoatdfguv).xy;
            
                half clearCoatMask = _ClearCoatStrength;
                [branch]
                if (_HasClearCoatMask)
                {
                    clearCoatMask *= SAMPLE_TEXTURE2D(_ClearCoatMask, sampler_MainTex, d.uv0.xy * _ClearCoatMask_ST.xy + _ClearCoatMask_ST.zw)[_ClearCoatMaskChannel];
                }
                #endif
            
                // DIRECT REALTIME SPECULAR
                #if !defined(SPECULAR_HIGHLIGHTS_OFF) && defined(USING_LIGHT_MULTI_COMPILE)
                {
                    // Main Light
                    {
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            mainLightSpecular = GetSpecularHighlights(lightColor, f0, o.Normal, lightHalfVector, lightLoH, lightNoL, NoV, clampedRoughness, energyCompensation);
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            mainLightSpecular = GetSpecularHighlightsCloth(lightColor, o.Normal, lightHalfVector, lightNoL, NoV, clampedRoughness, energyCompensation, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                        }
                        #endif
            
                        mainLightSpecular *= lightNoL;
            
                        #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                        {
                            clearCoatMainLightSpecular = GetSpecularHighlightsClearCoat(lightColor, f0, d.worldNormal, lightHalfVector, lightLoH, clampedClearCoatRoughness, clearCoatMask, clearCoatAttenuation);
                            clearCoatMainLightSpecular *= saturate(dot(d.worldNormal, lightDir));
                        }
                        #endif
                    }
            
                    // Vertex Lights
                    #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                    {
                        [unroll(4)]
                        for (int i = 0; i < 4; i++)
                        {
                            #if defined(SHADING_MODE_DEFAULT)
                            {
                                vertexLightSpecular += vLightNoLs[i] * GetSpecularHighlights(vLightColors[i], f0, o.Normal, vLightHalfVectors[i], vLightLoHs[i], vLightNoLs[i], NoV, clampedRoughness, energyCompensation);
                            }
                            #elif defined(SHADING_MODE_CLOTH)
                            {
                                vertexLightSpecular += vLightNoLs[i] * GetSpecularHighlightsCloth(vLightColors[i], o.Normal, vLightHalfVectors[i], vLightNoLs[i], NoV, clampedRoughness, energyCompensation, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                            }
                            #endif
            
                            // Clear Coat
                            #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                            {
                                clearCoatVertexLightSpecular += GetSpecularHighlightsClearCoat(vLightColors[i], f0, d.worldNormal, vLightHalfVectors[i], vLightLoHs[i], clampedClearCoatRoughness, clearCoatMask, clearCoatAttenuation) * saturate(dot(d.worldNormal, vLightDirections[i]));
                            }
                            #endif
                        }
                    }
                    #endif
                }
                #endif
            
                // Attenuate main light specular by shadowmask
                #if defined(LIGHTMAP_SHADOW_MIXING) && defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) && defined(LIGHTMAP_ON) && !defined(UNITY_PASS_FORWARDADD)
                {
                    mainLightSpecular *= forwardShadows;
                }
                #endif
            
                // BAKED SPECULAR
                half3 bakedDirectSpecular = 0;
                #if defined(BAKED_SPECULAR) && !defined(BAKERYLM_ENABLED) && defined(UNITY_PASS_FORWARDBASE)
                {
                    half3 bakedDominantDirection = 1;
                    half3 bakedSpecularColor = 0;
            
                    // only do it if we have a directional lightmap
                    #if defined(DIRLIGHTMAP_COMBINED) && defined(LIGHTMAP_ON)
                    bakedDominantDirection = (lightMapDirection.xyz) * 2 - 1;
                    half directionality = max(0.001, length(bakedDominantDirection));
                    bakedDominantDirection /= directionality;
                    bakedSpecularColor = indirectDiffuse;
                    #endif
            
                    // if we do not have lightmap - derive the specular from probes
                    #if !defined(LIGHTMAP_ON)
                    bakedSpecularColor = half3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                    bakedDominantDirection = unity_SHAr.xyz + unity_SHAg.xyz + unity_SHAb.xyz;
            
                    // Enable Custom Lightprobes to write to baked specular
                    #if defined(_INTEGRATE_CUSTOMPROBES)
                    {
                        VRCLightVolumesCustomProbesBakedSpecular(o, d, indirectSpecular, bakedSpecularColor, bakedDominantDirection);
                    }
                    #endif
                    #endif
            
                    bakedDominantDirection = normalize(bakedDominantDirection);
                    #if defined(SHADING_MODE_DEFAULT)
                    {
                        bakedDirectSpecular = GetSpecularHighlights(o.Normal, bakedSpecularColor, bakedDominantDirection, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, energyCompensation);
                    }
                    #elif defined(SHADING_MODE_CLOTH)
                    {
                        bakedDirectSpecular = GetSpecularHighlightsCloth(o.Normal, bakedSpecularColor, bakedDominantDirection, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                    }
                    #endif
                }
                #endif
            
                // BAKERY DIRECT SPECULAR
                #if defined(LIGHTMAP_ON) && defined(BAKERY_LMSPEC) && defined(BAKERY_ENABLED) && defined(UNITY_PASS_FORWARDBASE)
                    #if defined(BAKERY_RNM)
                    {
                        float3 viewDirTangent = -Unity_SafeNormalize(d.tangentSpaceViewDir);
                        float3 dominantDirTangent = rnmBasis0 * dot(rnm0, lumaConv) +
                        rnmBasis1 * dot(rnm1, lumaConv) +
                        rnmBasis2 * dot(rnm2, lumaConv);
            
                        float3 dominantDirTangentNormalized = Unity_SafeNormalize(dominantDirTangent);
            
                        half3 specColor = saturate(dot(rnmBasis0, dominantDirTangentNormalized)) * rnm0 +
                        saturate(dot(rnmBasis1, dominantDirTangentNormalized)) * rnm1 +
                        saturate(dot(rnmBasis2, dominantDirTangentNormalized)) * rnm2;
            
                        float3 halfVector = Unity_SafeNormalize(dominantDirTangentNormalized - viewDirTangent);
                        float NoH = saturate(dot(tangentNormal, halfVector));
                        half3 F = 0
                        float D = 0;
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            F =  F_Schlick(NoV, f0);
                            D = D_GGX(NoH, lerp(1, clampedRoughness, _SpecularRoughnessMod)) * energyCompensation;
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            F = _ClothHasCustomSheen ? _ClothSheenColor : albedoSqrt;
                            D = D_Charlie(lerp(1, clampedRoughness, _SpecularRoughnessMod), NoH);
                        }
                        #endif
                        bakedDirectSpecular += D * specColor * F;
                    }
                    #endif
            
                    #if defined(BAKERY_SH)
                    {
                        half3 dominantDir = half3(dot(nL1x, lumaConv), dot(nL1y, lumaConv), dot(L1z, lumaConv));
                        half3 sh = L0 + dominantDir.x * L1x + dominantDir.y * L1y + dominantDir.z * L1z;
                        dominantDir = normalize(dominantDir);
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            bakedDirectSpecular += GetSpecularHighlights(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, energyCompensation);
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            bakedDirectSpecular += GetSpecularHighlightsCloth(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                        }
                        #endif
                    }
                    #endif
            
                    #if defined(BAKERY_MONOSH) && defined(DIRLIGHTMAP_COMBINED)
                    {
                        half3 dominantDir = nL1;
                        half3 sh = L0 + dominantDir.x * L1x + dominantDir.y * L1y + dominantDir.z * L1z;
                        dominantDir = normalize(dominantDir);
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            bakedDirectSpecular += GetSpecularHighlights(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, energyCompensation);
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            bakedDirectSpecular += GetSpecularHighlightsCloth(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                        }
                        #endif
                    }
                    #endif
                #endif // End of #if defined(BAKERY_LMSPEC) && defined(BAKERY_ENABLED) && !defined(UNITY_PASS_FORWARDADD)
            
                // BAKERY VOLUME SPECULAR
                #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME) && defined(BAKERY_LMSPEC) && defined(UNITY_PASS_FORWARDBASE)
                    BakeryVolumeSpecularData volumeSpecularData = GetBakeryVolumeSpecularData(volumeData);
                    #if defined(SHADING_MODE_DEFAULT)
                    {
                        bakedDirectSpecular += GetSpecularHighlights(volumeData.normal, volumeSpecularData.color, volumeSpecularData.direction, f0, volumeData.viewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), volumeSpecularData.NoV, energyCompensation);
                    }
                    #elif defined(SHADING_MODE_CLOTH)
                    {
                        bakedDirectSpecular += GetSpecularHighlightsCloth(volumeData.normal, volumeSpecularData.color, volumeSpecularData.direction, f0, volumeData.viewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), volumeSpecularData.NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                    }
                    #endif
                #endif
            
                // REFLECTIONS
                #if !defined(UNITY_PASS_FORWARDADD)
                float3 reflDir = reflect(-d.worldSpaceViewDir, o.Normal);
            
                // Box projection contact hardening is only available on PC
                #if !defined(PLAT_QUEST)
                {
                    // This is based on David M's improved box projection code https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections
                    // Licensed under MIT license, see https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections/blob/master/LICENSE for details
                    // Only used if probe is set to be box projected
                    if (_BoxProjectionContactHardening && unity_SpecCube0_ProbePosition.w > 0)
                    {
                        indirectSpecular = getEnvReflectionHardened(reflDir, d.worldSpacePosition, perceptualRoughness, _BoxProjectionContactHardeningStrength);
                    } else {
                        indirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, o.Normal, perceptualRoughness, -1);
                    }
                }
                #else
                {
                    indirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, o.Normal, perceptualRoughness, -1);
                }
                #endif
            
                half horizon = min(1 + dot(reflDir, o.Normal), 1);
                indirectSpecular *= horizon * horizon;
            
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                {
                    // Clear Coat uses a different roughness and a mesh normal instead of the normal map
                    reflDir = reflect(-d.worldSpaceViewDir, d.worldNormal);
            
                    // Box projection contact hardening is only available on PC
                    #if !defined(PLAT_QUEST)
                    {
                        // This is based on David M's improved box projection code https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections
                        // Licensed under MIT license, see https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections/blob/master/LICENSE for details
                        // Only used if probe is set to be box projected
                        if (_BoxProjectionContactHardening && unity_SpecCube0_ProbePosition.w > 0)
                        {
                            clearCoatIndirectSpecular = getEnvReflectionHardened(reflDir, d.worldSpacePosition, clearCoatRoughness, _BoxProjectionContactHardeningStrength);
                        } else {
                            clearCoatIndirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, d.worldNormal, clearCoatRoughness, -1);
                        }
                    }
                    #else
                    {
                        clearCoatIndirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, d.worldNormal, clearCoatRoughness, -1);
                    }
                    #endif
            
                    half clearCoatHorizon = min(1 + dot(reflDir, d.worldNormal), 1);
                    clearCoatIndirectSpecular *= clearCoatHorizon * clearCoatHorizon;
                    clearCoatIndirectSpecular *= clearCoatMask;
                }
                #endif
            
                half indirectSpecularOcclusion = saturate(length(indirectDiffuse) * (1.0 / _SpecOcclusion));
            
                // We should only add dfg _after_ we calculated spec occlusion factors
                half3 envBRDF = EnvBRDFMultiscatter(dfg, f0);
                indirectDiffuse *= 1.0 - envBRDF;
                indirectSpecular *= envBRDF;
            
                indirectSpecularOcclusion *= lerp(1, lightAttenuation, _RealtimeShadowSpecOcclusion);
            
                half computedSpecularOcclusion = computeSpecularAO(NoV, o.Occlusion * indirectSpecularOcclusion, clampedRoughness);
                computedSpecularOcclusion *= energyCompensation;
                    
                #if defined(BAKED_SPECULAR)
                {
                    bakedDirectSpecular *= saturate(lerp(1, computedSpecularOcclusion, _BakedSpecularOcclusion));
                }
                #endif
            
                indirectSpecular *= gtaoMultiBounce(computedSpecularOcclusion, f0);
            
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                {
                    half clearcoatNoV = abs(dot(d.worldNormal, d.worldSpaceViewDir)) + 1e-5;
                    computedSpecularOcclusion = computeSpecularAO(clearcoatNoV, o.Occlusion * indirectSpecularOcclusion, clampedRoughness);
                    computedSpecularOcclusion *= energyCompensation;
            
                    half3 envBRDF = EnvBRDFMultiscatter(clearcoatdfg, f0);
                    clearCoatIndirectSpecular *= envBRDF;
                    clearCoatIndirectSpecular *= gtaoMultiBounce(computedSpecularOcclusion, f0);
                }
                #endif
            
                #endif // !defined(UNITY_PASS_FORWARDADD)
            
                // Standard-Like transparent (premult alpha)
                if (_RenderType == 2)
                {
                    o.Albedo.rgb *= o.Alpha;
                    o.Alpha = 1 - (oneMinusReflectivity) + o.Alpha * (oneMinusReflectivity);
                }
            
                #if !defined(_NATIVE_A2C) || (!defined(UNITY_PASS_FORWARDBASE))
                {
                    // Standard-Like cutout
                    if (_RenderType == 1)
                    {
                        clip(o.Alpha - _Cutoff);
                    }
                }
                #endif
            
                FinalColor.rgb = o.Albedo.rgb * (oneMinusReflectivity);
            
                half3 customGIDiffuse = 0;
                half3 customGISpecular = 0;
                // Custom GI
                {
                    #if defined(_INTEGRATE_CUSTOMGI) && !defined(UNITY_PASS_FORWARDADD)
                    IntegrateCustomGI(d, o, indirectSpecular, indirectDiffuse);
                    #endif
            
                    #if defined (_INTEGRATE_CUSTOMGI_FLEX) && !defined(UNITY_PASS_FORWARDADD)
                    VRCLightVolumesCustomGI(o, d, indirectDiffuse);
            
                    LTCGICustomGI(d, o, customGISpecular, customGIDiffuse);
                    #endif
                }
            
                // Diffuse Contributions
                half3 diffuseContributions = 0;
                diffuseContributions += mainLightDiffuse;
                diffuseContributions += indirectDiffuse * occlusion;
                diffuseContributions += customGIDiffuse * occlusion;
            
                // Add vertex Lights
                #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                {
                    diffuseContributions += vertexLightDiffuse;
                }
                #endif
            
                // Specular Contributions
                half3 specularContributions = 0;
                specularContributions += mainLightSpecular;
                specularContributions += bakedDirectSpecular;
                specularContributions += indirectSpecular;
                specularContributions += customGISpecular;
            
                // Add vertex Lights
                #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                {
                    specularContributions += vertexLightSpecular;
                }
                #endif
            
                // Add clear coat layer
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                {
                    specularContributions += clearCoatMainLightSpecular;
                    specularContributions += clearCoatIndirectSpecular;
            
                    // Add vertex Lights
                    #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                    {
                        specularContributions += clearCoatVertexLightSpecular;
                    }
                #endif
                }
                #endif
            
                // Compositing
                FinalColor.rgb *= diffuseContributions;
                FinalColor.rgb += specularContributions;
            
                if (_RenderType > 1)
                {
                    FinalColor.a = o.Alpha;
                }
                    
                #if defined(UNITY_PASS_FORWARDBASE)
                FinalColor.rgb += o.Emission;
                #endif
            
                // Premulty output by alpha for correct `Fade` mode
                #if defined(UNITY_PASS_FORWARDADD)
                if (_RenderType == 3)
                {
                    FinalColor.rgb *= o.Alpha;
                }
                #endif
            
                #endif // shadowcaster check
            }
            

            void FragmentBaseMetaColor(inout SurfaceData o)
            {
                // Boost emissive for Meta (mostly for RTGI)
                #if defined(UNITY_PASS_META)
                o.Emission *= pow(_GIEmissiveBoost, 2.2);
                #endif
            }
            

            void FragmentBaseColorCorr(inout half4 FinalColor) {
                #if defined(APPLY_COLOR_CORRECTION) && defined(PLAT_QUEST)
                    
                #if defined(MOBILE_TONEMAP_ACES)
                FinalColor.rgb = Tonemap_ACES(FinalColor.rgb);
                #elif defined(MOBILE_TONEMAP_UNREAL)
                FinalColor.rgb = pow(Tonemap_Unreal(FinalColor.rgb), 2.2);
                #elif defined(MOBILE_TONEMAP_UNCHARTED)
                FinalColor.rgb = pow(Tonemap_Uncharted2(FinalColor.rgb),2.2);
                #endif
            
                FinalColor.rgb = applyLiftGammaGainEffect(FinalColor.rgb, _ColorCorrLift, _ColorCorrGamma, _ColorCorrGain);
                #endif
            }
            

            void PBRBaseShadow(SurfaceData o) {
                if (_RenderType == 1)
                {
                    clip(o.Alpha - _Cutoff);
                }
            }
            

            void VertexBase(inout VertexData v, inout FragmentData o)
            {
            
                #if defined(UNITY_PASS_META) && !defined(UNITY_PASS_BAKERY_META)
                o.pos = UnityMetaVertexPosition(v.vertex, v.uv1.xy, v.uv2.xy, unity_LightmapST, unity_DynamicLightmapST);
                #else
                o.pos = TransformObjectToHClip(v.vertex);
                #endif
                o.normal = v.normal;
                o.uv0 = v.uv0;
                o.uv1 = v.uv1;
                o.uv2 = v.uv2;
                o.uv3 = v.uv3;
                #if defined(NEED_UV4)
                o.uv4 = v.uv4;
                #endif
                #if defined(NEED_UV5)
                o.uv5 = v.uv5;
                #endif
                #if defined(NEED_UV6)
                o.uv6 = v.uv6;
                #endif
                #if defined(NEED_UV7)
                o.uv7 = v.uv7;
                #endif
                o.worldPos = mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1));
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldTangent.xyz = UnityObjectToWorldDir(v.tangent.xyz);
                o.worldTangent.w = v.tangent.w * unity_WorldTransformParams.w;
                o.vertexColor = v.color;
            
                #if defined(EDITOR_VISUALIZATION)
                o.vizUV = 0;
                o.lightCoord = 0;
                if (unity_VisualizationMode == EDITORVIZ_TEXTURE)
                {
                    o.vizUV = UnityMetaVizUV(unity_EditorViz_UVIndex, v.uv0.xy, v.uv1.xy, v.uv2.xy, unity_EditorViz_Texture_ST);
                }
                else if (unity_VisualizationMode == EDITORVIZ_SHOWLIGHTMASK)
                {
                    o.vizUV = v.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.lightCoord = mul(unity_EditorViz_WorldToLight, mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1)));
                }
                #endif
            
                #if defined(NEED_SCREEN_POS)
                o.screenPos = GetScreenPosition(o.pos);
                o.screenPos.z = -TransformWorldToView(TransformObjectToWorld(v.vertex)).z;
                #endif
            
                #if !defined(UNITY_PASS_META)
                    #if defined(LIGHTMAP_ON)
                    o.lightmapUv.xy = v.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    #endif
                    #if defined(DYNAMICLIGHTMAP_ON)
                    o.lightmapUv.zw = v.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                    #endif
            
                    UNITY_TRANSFER_LIGHTING(o, v.uv1.xy);
            
                    o.fogData.x = o.pos.z;
                    #if defined(FOG_EXP2)
                    o.fogData.y = 1;
                    #else
                    o.fogData.y = 0;
                    #endif
                #endif
            }
            

            // FreeFunctions

            // ForwardAdd Vertex
            #if !defined(TESS_ENABLED)
            FragmentData Vertex(VertexData v)
            {
                UNITY_SETUP_INSTANCE_ID(v);
                FragmentData o;
                UNITY_INITIALIZE_OUTPUT(FragmentData, o);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                // ForwardAdd Vertex Chain
                VRCFeaturesVertex(v);

                // ForwardAdd VertexBase
                VertexBase(v, o);

                // ForwardAdd PostVertex Chain

                return o;
            }
            #endif

            // ForwardAdd Fragment
            half4 Fragment(FragmentData i, bool facing: SV_IsFrontFace
                #if defined(NEED_SV_DEPTH)
                , out float depth: SV_Depth
                #endif
                #if defined(NEED_SV_DEPTH_LEQUAL)
                , out float depth: SV_DepthLessEqual
                #endif
            ) : SV_TARGET
            {
                #if !defined(NEED_SV_DEPTH) && !defined(NEED_SV_DEPTH_LEQUAL)
                float depth = 0;
                #endif
                UNITY_SETUP_INSTANCE_ID(i);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

                SurfaceData o = CreateSurfaceData();
                MeshData d = CreateMeshData(i, facing);
                half4 FinalColor = 1;

                // ForwardAdd Fragment Chain
                ParallaxFragment(d, i);

                PBRFragment(d, o);

                DetailsFragment(d, o);

                PosterDisplayFragment(i, o);

                ALFragment(d, o);

                // ForwardAdd FragmentBase
                FragmentBase(d, i, o, FinalColor);

                // ForwardAdd Color Chain
                VRCLightVolumesColor(d, facing, FinalColor);

                LTCGIColor(d, i, FinalColor, facing);

                FragmentBaseMetaColor(o);

                FragmentBaseColorCorr(FinalColor);

                ApplyUnityFog(i.fogData, FinalColor);

                return FinalColor;
            }

            ENDCG
            // ForwardAdd Pass End
        }

        Pass
        {
            Name "META"
            Tags { "LightMode" = "Meta"  }
            Cull Off

            // Meta Pass Start
            CGPROGRAM
            #pragma target 4.5
            #pragma multi_compile_instancing
            #pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma shader_feature EDITOR_VISUALISATION
            #pragma vertex Vertex
            #pragma fragment Fragment
            #pragma shader_feature_local_fragment _EMISSION
            
            #pragma shader_feature_local_fragment PARALLAX
            #pragma shader_feature_local_fragment _PARALLAXSTEPS_EIGHT _PARALLAXSTEPS_SIXTEEN _PARALLAXSTEPS_THIRTYTWO _PARALLAXSTEPS_SIXTYFOUR
            
            #pragma shader_feature_local_fragment DETAILS_OVERLAY
            #pragma shader_feature_local_fragment _ DETAILS_MODE_PACKED DETAILS_MODE_SEPARATED
            
            #pragma shader_feature_local_vertex VRC_FEATURES
            
               
             #pragma shader_feature_local_fragment VRCLIGHTVOLUMES
            
             // Global keyword to enable in the project
             #pragma shader_feature_fragment DISABLE_VRCLIGHTVOLUMES
            
            #pragma shader_feature_local_fragment _ AL_EFFECT_BAND_SELECTION AL_EFFECT_UV_BASED AL_EFFECT_WAVEFORM AL_EFFECT_PULSE AL_EFFECT_BAR
            
            #pragma shader_feature_local_fragment INTEGRATE_LTCGI
            
            #pragma shader_feature_local_fragment BAKERY_ENABLED
            #pragma shader_feature_local_fragment _ BAKERY_RNM BAKERY_SH BAKERY_MONOSH
            #pragma shader_feature_local_fragment BAKERY_SHNONLINEAR
            #pragma shader_feature_local_fragment BAKERY_VOLUME
            #pragma shader_feature_local_fragment BAKERY_COMPRESSED_VOLUME
            #pragma shader_feature_local_fragment BAKERY_VOLROTATIONY
            
            #pragma shader_feature_local_fragment BAKED_SPECULAR
            #pragma shader_feature_local_fragment GSAA
            #pragma shader_feature_local_fragment NONLINEAR_SH
            #pragma shader_feature_local_fragment SHADE_VERTEXLIGHTS
            #pragma shader_feature_local_fragment SHADING_MODE_DEFAULT SHADING_MODE_CLOTH
            #pragma shader_feature_local_fragment CLEARCOAT
                
            // PC Only Features
            #if !defined(UNITY_PBS_USE_BRDF2) && !defined(SHADER_API_MOBILE)
                #pragma shader_feature_local_fragment BICUBIC_LIGHTMAP
            #endif
            
            // Mobile Only Features
            #if defined(UNITY_PBS_USE_BRDF2) || defined(SHADER_API_MOBILE)
                #pragma shader_feature_local_fragment FORCE_BOX_PROJECTION
                #pragma shader_feature_local_fragment APPLY_COLOR_CORRECTION
                #pragma shader_feature_local_fragment MOBILE_TONEMAP_ACES MOBILE_TONEMAP_UNREAL MOBILE_TONEMAP_UNCHARTED
            #endif
            
            #if defined(SHADE_VERTEXLIGHTS)
                #pragma multi_compile_fragment _ VERTEXLIGHT_ON
            #endif
            
            #if !defined(MOBILE_TONEMAP_ACES) && !defined(MOBILE_TONEMAP_UNREAL) && !defined(MOBILE_TONEMAP_UNCHARTED)
                #define MOBILE_TONEMAP_ACES
            #endif

            #define UNITY_INSTANCED_LOD_FADE
            #define UNITY_INSTANCED_SH
            #define UNITY_INSTANCED_LIGHTMAPSTS

            #ifndef UNITY_PASS_META
                #define UNITY_PASS_META
            #endif

            #include "UnityPBSLighting.cginc"
            #include "UnityMetaPass.cginc"

            // ShaderDefines
            #define _MASKMAP_SAMPLED
            
            #if !defined(DETAILS_MODE_PACKED) && !defined(DETAILS_MODE_SEPARATED)
              #define DETAILS_MODE_PACKED
            #endif
            
            #define VRCLV_VERSION 2
            #define VRCLV_MAX_VOLUMES_COUNT 32
            #define VRCLV_MAX_LIGHTS_COUNT 128
            
            #if !defined(DISABLE_VRCLIGHTVOLUMES) && defined(VRCLIGHTVOLUMES)
                #define INTEGRATE_VRCLIGHTVOLUMES
            
                #define LV_PI 3.141592653589793f
                #define LV_PI2 6.283185307179586f
            
                #define _INTEGRATE_CUSTOMPROBES
                #define _INTEGRATE_CUSTOMGI_FLEX
            #endif
            
            #if !defined(AL_EFFECT_BAND_SELECTION) && !defined(AL_EFFECT_UV_BASED) && !defined(AL_EFFECT_WAVEFORM) && !defined(AL_EFFECT_PULSE) && !defined(AL_EFFECT_BAR)
            #define AL_EFFECT_NONE
            #endif
            
            #if defined(INTEGRATE_LTCGI)
                #define _INTEGRATE_CUSTOMGI_FLEX
            #endif
            
            #define INCLUDE_LTCGI defined(INTEGRATE_LTCGI)
            
            #if INCLUDE_LTCGI
                #include "Packages/at.pimaker.ltcgi/Shaders/LTCGI_structs.cginc"
            #endif
            
            #if !defined(LIGHTMAP_ON) || !defined(UNITY_PASS_FORWARDBASE)
              #undef BAKERY_SH
              #undef BAKERY_RNM
            #endif
            
            #ifdef LIGHTMAP_ON
              #undef BAKERY_VOLUME
            #endif
            
            #ifdef LIGHTMAP_ON
                #if defined(BAKERY_ENABLED)
                    #if defined(BAKERY_RNM) || defined(BAKERY_SH) || defined(BAKERY_VERTEXLM) || defined(BAKERY_MONOSH)
                        #define BAKERYLM_ENABLED
                        #if !defined(BAKERY_MONOSH)
                            #undef DIRLIGHTMAP_COMBINED
                        #endif
                    #endif
                #endif
            #endif
            
            #if defined(BAKERY_SH) || defined(BAKERY_RNM) || defined(BAKERY_VOLUME) || defined(BAKERY_MONOSH)
              #ifdef BAKED_SPECULAR
                #define _BAKERY_LMSPEC
                #define BAKERY_LMSPEC
              #endif
            #endif
            
            #define ORL_LIGHTING_MODEL_PBR
                
            #if defined(UNITY_PBS_USE_BRDF2) || defined(SHADER_API_MOBILE)
                #define PLAT_QUEST
            #else
                #ifdef PLAT_QUEST
                    #undef PLAT_QUEST
                #endif
            #endif
            
            #define ORL_MIN_ROUGHNESS 0.002025
            #if defined(PLAT_QUEST)
                #define ORL_MIN_ROUGHNESS 0.007921
            #endif
            
            #if !defined(SHADING_MODE_DEFAULT) && !defined(SHADING_MODE_CLOTH)
                #define SHADING_MODE_DEFAULT
            #endif
            
            #define NEED_SCREEN_POS
            #if !defined(NEED_FRAGMENT_IN_SHADOW)
                #define NEED_FRAGMENT_IN_SHADOW
            #endif
            #include "Assets/Xuan25/PosterDisplay/Shader/Inc/PosterDisplay.cginc"

            // DataStructs
            struct VertexData
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float4 color : COLOR;
                float4 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 uv2 : TEXCOORD2;
                float4 uv3 : TEXCOORD3;
                #if defined(NEED_UV4)
                float4 uv4 : TEXCOORD4;
                #endif
                #if defined(NEED_UV5)
                float4 uv5 : TEXCOORD5;
                #endif
                #if defined(NEED_UV6)
                float4 uv6 : TEXCOORD6;
                #endif
                #if defined(NEED_UV7)
                float4 uv7 : TEXCOORD7;
                #endif
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            
            struct FragmentData
            {
                #if defined(UNITY_PASS_SHADOWCASTER)
                V2F_SHADOW_CASTER;
                #else
                float4 pos : SV_POSITION;
                #endif
            
                float3 normal : RAW_NORMAL;
            
                #if !defined(NEED_FLOAT4_UV)
                // by default all UVs are float 2s
                float2 uv0 : TEXCOORD1;
                float2 uv1 : TEXCOORD2;
                float2 uv2 : TEXCOORD3;
                float2 uv3 : TEXCOORD4;
                #if defined(NEED_UV4)
                float2 uv4 : TEXCOORD5;
                #endif
                #if defined(NEED_UV5)
                float2 uv5 : TEXCOORD6;
                #endif
                #if defined(NEED_UV6)
                float2 uv6 : TEXCOORD7;
                #endif
                #if defined(NEED_UV7)
                float2 uv7 : TEXCOORD8;
                #endif
            
                #else // #if !defined(NEED_FLOAT4_UV)
            
                // Shaders can request to get float4 UVs using
                // #define NEED_FLOAT4_UV
                float4 uv0 : TEXCOORD1;
                float4 uv1 : TEXCOORD2;
                float4 uv2 : TEXCOORD3;
                float4 uv3 : TEXCOORD4;
                #if defined(NEED_UV4)
                float4 uv4 : TEXCOORD5;
                #endif
                #if defined(NEED_UV5)
                float4 uv5 : TEXCOORD6;
                #endif
                #if defined(NEED_UV6)
                float4 uv6 : TEXCOORD7;
                #endif
                #if defined(NEED_UV7)
                float4 uv7 : TEXCOORD8;
                #endif
            
                #endif // #if !defined(NEED_FLOAT4_UV)
            
                float3 worldPos : WORLD_POS;
                float3 worldNormal : WORLD_NORMAL;
                float4 worldTangent : WORLD_TANGENT;
            
                #if !defined(UNITY_PASS_SHADOWCASTER)
                float4 lightmapUv : LM_UV;
                #endif
            
                centroid float4 vertexColor : VERTEX_COLOR;
            
                #if !defined(UNITY_PASS_META)
                UNITY_LIGHTING_COORDS(9, 10)
                float2 fogData : FOG_DATA;
                #endif
            
                #if defined(EDITOR_VISUALIZATION)
                float2 vizUV : VIZ_UV;
                float4 lightCoord : LIGHT_COORD;
                #endif
            
                #if defined(NEED_SCREEN_POS)
                float4 screenPos: SCREENPOS;
                #endif
            
                #if defined(EXTRA_V2F_0)
                float4 extraV2F0 : EXTRA_V2F_BLOCK0;
                #endif
                #if defined(EXTRA_V2F_1)
                float4 extraV2F1 : EXTRA_V2F_BLOCK1;
                #endif
                #if defined(EXTRA_V2F_2)
                float4 extraV2F2 : EXTRA_V2F_BLOCK2;
                #endif
                #if defined(EXTRA_V2F_3)
                float4 extraV2F3 : EXTRA_V2F_BLOCK3;
                #endif
            
                // Additional Fragment Data
                
                // Additional Fragment Data End
            
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };
            
            struct LTCGIAccumulatorStruct {
                float3 diffuse;
                float3 specular;
            };
            
            #define LTCGI_V2_CUSTOM_INPUT LTCGIAccumulatorStruct
            
            struct SurfaceData
            {
                half3 Albedo;
                half3 Emission;
                half Metallic;
                half Smoothness;
                half Occlusion;
                float3 Normal;
                half Alpha;
            
                // Additional Surface Data
                #if defined(INTEGRATE_VRCLIGHTVOLUMES)
                float3 VRCLV_L0;
                float3 VRCLV_L1r;
                float3 VRCLV_L1g;
                float3 VRCLV_L1b;
                #endif
                // Additional Surface Data End
            };
            
            SurfaceData CreateSurfaceData()
            {
                SurfaceData o = (SurfaceData) 0;
                o.Albedo = 1;
                o.Occlusion = 1;
                o.Normal = float3(0, 0, 1);
                o.Smoothness = 0.5;
                o.Alpha = 1;
                return o;
            }
            
            struct MeshData
            {
                #if !defined(NEED_FLOAT4_UV)
                // by default all UVs are float 2s
                float2 uv0;
                float2 uv1;
                float2 uv2;
                float2 uv3;
                #if defined(NEED_UV4)
                float2 uv4;
                #endif
                #if defined(NEED_UV5)
                float2 uv5;
                #endif
                #if defined(NEED_UV6)
                float2 uv6;
                #endif
                #if defined(NEED_UV7)
                float2 uv7;
                #endif
            
                #else // #if !defined(NEED_FLOAT4_UV)
            
                // Shaders can request to get float4 UVs using
                // #define NEED_FLOAT4_UV
                float4 uv0;
                float4 uv1;
                float4 uv2;
                float4 uv3;
                #if defined(NEED_UV4)
                float4 uv4;
                #endif
                #if defined(NEED_UV5)
                float4 uv5;
                #endif
                #if defined(NEED_UV6)
                float4 uv6;
                #endif
                #if defined(NEED_UV7)
                float4 uv7;
                #endif
            
                #endif // #if !defined(NEED_FLOAT4_UV)
            
                #if !defined(UNITY_PASS_SHADOWCASTER)
                half4 lightmapUv;
                #endif
                half4 vertexColor;
                half3 normal;
                half3 worldNormal;
                half3 localSpacePosition;
                half3 worldSpacePosition;
                half3 worldSpaceViewDir;
                half3 tangentSpaceViewDir;
                float3x3 TBNMatrix;
                float4 extraV2F0;
                float4 extraV2F1;
                float4 extraV2F2;
                float4 extraV2F3;
                float4 screenPos;
            
                // Additional Mesh Data
                
                // Additional Mesh Data End
            };
            
            MeshData CreateMeshData(FragmentData i, bool facing)
            {
                MeshData d = (MeshData) 0;
                d.uv0 = i.uv0;
                d.uv1 = i.uv1;
                d.uv2 = i.uv2;
                d.uv3 = i.uv3;
                #if defined(NEED_UV4)
                d.uv4 = i.uv4;
                #endif
                #if defined(NEED_UV5)
                d.uv5 = i.uv5;
                #endif
                #if defined(NEED_UV6)
                d.uv6 = i.uv6;
                #endif
                #if defined(NEED_UV7)
                d.uv7 = i.uv7;
                #endif
                #if !defined(UNITY_PASS_SHADOWCASTER)
                d.lightmapUv = i.lightmapUv;
                #endif
                d.worldNormal = normalize(i.worldNormal);
                d.localSpacePosition = mul(unity_WorldToObject, float4(i.worldPos, 1)).xyz;
                d.worldSpacePosition = i.worldPos;
                d.worldSpaceViewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
            
                d.normal = i.normal;
                d.vertexColor = i.vertexColor;
            
                #if !defined(UNITY_PASS_SHADOWCASTER)
                float3 bitangent = cross(d.worldNormal, i.worldTangent.xyz) * (i.worldTangent.w > 0.0 ? 1.0 : - 1.0);
                d.TBNMatrix = float3x3(normalize(i.worldTangent.xyz), bitangent, d.worldNormal);
                d.TBNMatrix[2].xyz *= facing ? 1 : -1;
                d.tangentSpaceViewDir = mul(d.TBNMatrix, d.worldSpaceViewDir);
                #endif
            
                #if defined(EXTRA_V2F_0)
                d.extraV2F0 = i.extraV2F0;
                #endif
                #if defined(EXTRA_V2F_1)
                d.extraV2F1 = i.extraV2F1;
                #endif
                #if defined(EXTRA_V2F_2)
                d.extraV2F2 = i.extraV2F2;
                #endif
                #if defined(EXTRA_V2F_3)
                d.extraV2F3 = i.extraV2F3;
                #endif
                #if defined(NEED_SCREEN_POS)
                d.screenPos = i.screenPos;
                #endif
            
                // Additional Mesh Data Creator
                
                // Additional Mesh Data Creator End
            
                return d;
            }
            // GlobalVariables



            // Variables
            half4 _Color;
            half4 _MainTex_ST;
            int _AlbedoChannel;
            int _MappingSpace;
            int _PlanarAxisX;
            int _PlanarAxisY;
            int _MetalChannel;
            int _AOChannel;
            int _DetailMaskChannel;
            int _SmoothChannel;
            int _RoughnessMode;
            half _Smoothness;
            half _Metallic;
            half4 _MetallicRemap;
            half4 _SmoothnessRemap;
            half4 _MaskMap_TexelSize;
            half _OcclusionStrength;
            int _DetailAsTintMask;
            half _BumpScale;
            int _FlipBumpY;
            half4 _EmissionColor;
            int _EmissionChannel;
            float2 GLOBAL_uv;
            half4 GLOBAL_maskMap;
            #if defined(PARALLAX)
            half _HeightScale;
            half _HeightRefPlane;
            int _ParallaxScaleBasedOnAngle;
            #endif
            float2 GLOBAL_parallaxUv;
            half GLOBAL_heightMask;
            half GLOBAL_heightMaskSmoothing;
            int GLOBAL_heightSet;
            half GLOBAL_height; 
            #if defined(DETAILS_OVERLAY)
            int _DIgnoreMask;
            half4 _DDetailsMap_ST;
            int _DMappingSpace;
            int _DUVChannel;
            int _DPlanarAxisX;
            int _DPlanarAxisY;
            half _DAlbedoScale;
            half _DNormalScale;
            int _DNormalFlipY;
            half _DSmoothScale;
            int _DAlbedoMixingLegacy;
            #endif
            int _VRCHideInVR;
            int _VRCHideInDesktop;
            int _VRCHideInVRCamera;
            int _VRCHideInDesktopCamera;
            int _VRCHideInVRMirror;
            int _VRCHideInDesktopMirror;
            float _VRChatCameraMode;
            float _VRChatMirrorMode;
            #if defined(INTEGRATE_VRCLIGHTVOLUMES)
            float _VRCLightVolumesSurfacePushoff;
            cbuffer LightVolumeUniforms {
                float _UdonLightVolumeEnabled;
                float _UdonLightVolumeVersion;
                float _UdonLightVolumeCount;
                float _UdonLightVolumeAdditiveMaxOverdraw;
                float _UdonLightVolumeAdditiveCount;
                float _UdonLightVolumeProbesBlend;
                float _UdonLightVolumeSharpBounds;
                float4x4 _UdonLightVolumeInvWorldMatrix[VRCLV_MAX_VOLUMES_COUNT];
                float4 _UdonLightVolumeRotation[VRCLV_MAX_VOLUMES_COUNT * 2];
                float3 _UdonLightVolumeInvLocalEdgeSmooth[VRCLV_MAX_VOLUMES_COUNT];
                float3 _UdonLightVolumeUvw[VRCLV_MAX_VOLUMES_COUNT * 6];
                float4 _UdonLightVolumeOcclusionUvw[VRCLV_MAX_VOLUMES_COUNT];
                float4 _UdonLightVolumeColor[VRCLV_MAX_VOLUMES_COUNT];
                float _UdonPointLightVolumeCount;
                float _UdonPointLightVolumeCubeCount;
                float4 _UdonPointLightVolumePosition[VRCLV_MAX_LIGHTS_COUNT];
                float4 _UdonPointLightVolumeColor[VRCLV_MAX_LIGHTS_COUNT];
                float4 _UdonPointLightVolumeDirection[VRCLV_MAX_LIGHTS_COUNT];
                float3 _UdonPointLightVolumeCustomID[VRCLV_MAX_LIGHTS_COUNT];
                float _UdonLightBrightnessCutoff;
                float _UdonLightVolumeOcclusionCount;
            }
            #endif
            sampler2D _PosterTex;
            float4 _PosterTex_ST;
            float4 _PosterTint;
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
            int _ALUVChannel;
            int _BandFrequency;
            int _BandScrollAxis;
            half _BandHistoryRange;
            half _UVHistoryRange;
            int _UVFlipXY;
            int _UVUseThemeColors;
            int _WVFRMMiddleLine;
            half _WVFRMMiddleLineWidth;
            int _WVFRMFlip;
            half _WVFRMOffset;
            half _WVFRMScale;
            int _WVFRMFlipUVDirection;
            int _PulseBand;
            int _PulseSmoothing;
            int _PulseMode;
            half _PulseStrength;
            int _PulseEmissionMode;
            int _PulseTextureAdjustment;
            half4 _PulseTextureDirection;
            int _BarBand;
            int _BarSmoothing;
            int _BarAxis;
            half _BarScale;
            int _KillEffects;
            half4 _ALTint;
            int _LTCGIEnableOnMobile;
            int _LTCGIClampBrightness;
            half _LTCGIMaxBrightness;
            half _LTCGIDiffuseIntensity;
            half _LTCGISpecularIntensity;
            half _LTCGIRoughnessModifier;
            int _LTCGIAlphaPremultiply;
            #if defined(BAKERY_ENABLED)
                #if defined(BAKERY_RNM) || defined(BAKERY_SH)
            float4 _RNM0_TexelSize;
                #endif
            #endif
            #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME)
            half3 _VolumeMin;
            half3 _VolumeInvSize;
            half3 _GlobalVolumeMin;
            int _Udon_GlobalVolumeAdapterEnabled;
            half3 _Udon_GlobalVolumeMin;
            half3 _GlobalVolumeInvSize;
            half3 _Udon_GlobalVolumeInvSize;
            #if defined(BAKERY_VOLROTATION)
            float4x4 _GlobalVolumeMatrix;
            float4x4 _Udon_GlobalVolumeMatrix;
            float4x4 _VolumeMatrix;
            #endif
            #if defined(BAKERY_VOLROTATIONY)
            float2 _GlobalVolumeRY;
            float2 _Udon_GlobalVolumeRY;
            float2 _VolumeRY;
            #endif
            #endif
            #if defined(GSAA)
            half _GSAAVariance;
            half _GSAAThreshold;
            int _GSAAIncludeNormalMaps;
            #endif
            #if defined(APPLY_COLOR_CORRECTION)
            half _ColorCorrLift;
            half _ColorCorrGamma;
            half _ColorCorrGain;
            #endif
            #if defined(CLEARCOAT)
            half _ClearCoatStrength;
            float _ClearCoatSmoothness;
            half4 _ClearCoatMask_ST;
            int _ClearCoatMaskChannel;
            int _HasClearCoatMask;
            #endif
            #if defined(SHADING_MODE_CLOTH)
            int _ClothHasCustomSheen;
            half4 _ClothSheenColor;
            int _ClothHasSubsurface;
            half4 _ClothSubsurfaceColor;
            #endif
            half _SpecOcclusion;
            half _RealtimeShadowSpecOcclusion;
            float _BakedSpecularOcclusion;
            half _SpecularRoughnessMod;
            int _BoxProjectionContactHardening;
            half _BoxProjectionContactHardeningStrength;
            half _GIEmissiveBoost;
            int _IgnoreRealtimeGI;
            int _RealtimeGIDisableBicubic;
            int _RenderType;
            half _Cutoff;

            // Textures
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            TEXTURE2D(_MaskMap);
            SAMPLER(sampler_MaskMap);
            TEXTURE2D(_BumpMap);
            SAMPLER(sampler_BumpMap);
            TEXTURE2D(_EmissionMap);
            SAMPLER(sampler_EmissionMap);
            #if defined(PARALLAX)
            TEXTURE2D(_Height);
            SAMPLER(sampler_Height);
            #endif
            #if defined(DETAILS_OVERLAY)
            TEXTURE2D(_DDetailsMap);
            SAMPLER(sampler_DDetailsMap);
            TEXTURE2D(_DDetailsNormal);
            SAMPLER(sampler_DDetailsNormal);
            #endif
            #if defined(INTEGRATE_VRCLIGHTVOLUMES)
            TEXTURE3D(_UdonLightVolume);
            TEXTURE2D_ARRAY(_UdonPointLightVolumeTexture);
            SAMPLER(sampler_UdonLightVolume);
            #define LV_SAMPLE(tex, uvw) tex.SampleLevel(sampler_UdonLightVolume, uvw, 0)
            #endif
            TEXTURE2D(_ALMask);
            SAMPLER(sampler_ALMask);
            TEXTURE2D(_WVFRMBottomColor);
            TEXTURE2D(_WVFRMTopColor);
            TEXTURE2D(_WVFRMMiddleColor);
            SAMPLER(sampler_WVFRMBottomColor);
            TEXTURE2D(_PulseTexture);
            SAMPLER(sampler_PulseTexture);
            TEXTURE2D(_BarColor);
            SAMPLER(sampler_BarColor);
            #if defined(BAKERY_ENABLED)
                #if defined(BAKERY_RNM) || defined(BAKERY_SH)
            TEXTURE2D(_RNM0);
            TEXTURE2D(_RNM1);
            TEXTURE2D(_RNM2);
            SAMPLER(sampler_RNM0);
                #endif
            #endif
            #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME)
            TEXTURE3D(_Volume0);
            TEXTURE3D(_Volume1);
            TEXTURE3D(_Volume2);
            TEXTURE3D(_VolumeMask);
                #if defined(BAKERY_COMPRESSED_VOLUME)
            TEXTURE3D(_Volume3);
                #endif
            SAMPLER(sampler_Volume0);
            SAMPLER(sampler_VolumeMask);
            #endif
            TEXTURE2D(_DFG);
            SAMPLER(sampler_DFG);
            TEXTURE2D(_ClearCoatMask);

            // PassFunctions
            #if defined(INTEGRATE_VRCLIGHTVOLUMES)
            
            float LV_Smoothstep01(float x) {
                return x * x * (3 - 2 * x);
            }
            
            float3 LV_MultiplyVectorByQuaternion(float3 v, float4 q) {
                float3 t = 2.0 * cross(q.xyz, v);
                return v + q.w * t + cross(q.xyz, t);
            }
            
            float3 LV_MultiplyVectorByMatrix2x3(float3 v, float3 r0, float3 r1) {
                float3 r2 = cross(r0, r1);
                return float3(dot(v, r0), dot(v, r1), dot(v, r2));
            }
            
            float LV_FastAcos(float x) {
                float absX = abs(x); 
                float res = -0.156583f * absX + LV_PI * 0.5f;
                res *= sqrt(1.0f - absX); 
                return (x >= 0) ? res : (LV_PI - res);
            }
            
            float LV_DistributionGGX(float NoH, float roughness) {
                float f = (roughness - 1) * ((roughness + 1) * (NoH * NoH)) + 1;
                return (roughness * roughness) / ((float) LV_PI * f * f);
            }
            
            bool LV_PointLocalAABB(float3 localUVW) {
                return all(abs(localUVW) <= 0.5);
            }
            
            float3 LV_LocalFromVolume(uint volumeID, float3 worldPos) {
                return mul(_UdonLightVolumeInvWorldMatrix[volumeID], float4(worldPos, 1.0)).xyz;
            }
            
            float LV_EvaluateSH(float L0, float3 L1, float3 n) {
                return L0 + dot(L1, n);
            }
            
            float4 LV_SampleCubemapArray(uint id, float3 dir) {
                float3 absDir = abs(dir);
                float2 uv;
                uint face;
                if (absDir.x >= absDir.y && absDir.x >= absDir.z) {
                    face = dir.x > 0 ? 0 : 1;
                    uv = float2((dir.x > 0 ? -dir.z : dir.z), -dir.y) * rcp(absDir.x);
                } else if (absDir.y >= absDir.z) {
                    face = dir.y > 0 ? 2 : 3;
                    uv = float2(dir.x, (dir.y > 0 ? dir.z : -dir.z)) * rcp(absDir.y);
                } else {
                    face = dir.z > 0 ? 4 : 5;
                    uv = float2((dir.z > 0 ? dir.x : -dir.x), -dir.y) * rcp(absDir.z);
                }
                float3 uvid = float3(uv * 0.5 + 0.5, id * 6 + face);
                return LV_SAMPLE(_UdonPointLightVolumeTexture, uvid);
            }
            
            float4 LV_ProjectQuadLightIrradianceSH(float3 shadingPosition, float3 lightVertices[4]) {
                // Transform the vertices into local space centered on the shading position,
                // project, the polygon onto the unit sphere.
                [unroll] for (uint edge0 = 0; edge0 < 4; edge0++) {
                    lightVertices[edge0] = normalize(lightVertices[edge0] - shadingPosition);
                }
                
                // Precomputed directions of rotated zonal harmonics,
                // and associated weights for each basis function.
                // I.E. \omega_{l,d} and \alpha_{l,d}^m in the paper respectively.
                const float3 zhDir0 = float3(0.866025, -0.500001, -0.000004);
                const float3 zhDir1 = float3(-0.759553, 0.438522, -0.480394);
                const float3 zhDir2 = float3(-0.000002, 0.638694,  0.769461);
                const float3 zhWeightL1y = float3(2.1995339f, 2.50785367f, 1.56572711f);
                const float3 zhWeightL1z = float3(-1.82572523f, -2.08165037f, 0.00000000f);
                const float3 zhWeightL1x = float3(2.42459869f, 1.44790525f, 0.90397552f);
                
                float solidAngle = 0.0;
                float3 surfaceIntegral = 0.0;
                [loop] for (uint edge1 = 0; edge1 < 4; edge1++) {
                    uint next = (edge1 + 1) % 4;
                    uint prev = (edge1 + 4 - 1) % 4;
                    float3 prevVert = lightVertices[prev];
                    float3 thisVert = lightVertices[edge1];
                    float3 nextVert = lightVertices[next];
                
                    // Compute the solid angle subtended by the polygon at the shading position,
                    // using Arvo's formula (5.1) https://dl.acm.org/doi/pdf/10.1145/218380.218467.
                    // The L0 term is directly proportional to the solid angle.
                    float3 a = cross(thisVert, prevVert);
                    float3 b = cross(thisVert, nextVert);
                    float lenA = length(a);
                    float lenB = length(b);
                    solidAngle += LV_FastAcos(clamp(dot(a, b) / (lenA * lenB), -1, 1));
                
                    // Compute the integral of the legendre polynomials over the surface of the
                    // projected polygon for each zonal harmonic direction (S_l in the paper).
                    // Computed as a sum of line integrals over the edges of the polygon.
                    float3 mu = b * rcp(lenB);
                    float cosGamma = dot(thisVert, nextVert);
                    float gamma = LV_FastAcos(clamp(cosGamma, -1, 1));
                    surfaceIntegral.x += gamma * dot(zhDir0, mu);
                    surfaceIntegral.y += gamma * dot(zhDir1, mu);
                    surfaceIntegral.z += gamma * dot(zhDir2, mu);
                }
                solidAngle = solidAngle - LV_PI2;
                surfaceIntegral *= 0.5;
                
                // The L0 term is just the projection of the solid angle onto the L0 basis function.
                const float normalizationL0 = 0.5f * sqrt(1.0f / LV_PI);
                float l0 = normalizationL0 * solidAngle;
                    
                // Combine each surface (sub)integral with the associated weights to get
                // full surface integral for each L1 SH basis function.
                float l1y = dot(zhWeightL1y, surfaceIntegral);
                float l1z = dot(zhWeightL1z, surfaceIntegral);
                float l1x = dot(zhWeightL1x, surfaceIntegral);
                
                // The l0, l1y, l1z, l1x are raw SH coefficients for radiance from the polygon.
                // We need to apply some more transformations before we are done:
                // (1) We want the coefficients for irradiance, so we need to convolve with the
                //     clamped cosine kernel, as detailed in https://cseweb.ucsd.edu/~ravir/papers/envmap/envmap.pdf.
                //     The kernel has coefficients PI and 2/3*PI for L0 and L1 respectively.
                // (2) Unity's area lights underestimate the irradiance by a factor of PI for historical reasons.
                //     We need to divide by PI to match this 'incorrect' behavior.
                // (3) Unity stores SH coefficients (unity_SHAr..unity_SHC) pre-multiplied with the constant
                //     part of each SH basis function, so we need to multiply by constant part to match it.
                const float cosineKernelL0 = LV_PI; // (1)
                const float cosineKernelL1 = LV_PI2 / 3.0f; // (1)
                const float oneOverPi = 1.0f / LV_PI; // (2)
                const float normalizationL1 = 0.5f * sqrt(3.0f / LV_PI); // (3)
                const float weightL0 = cosineKernelL0 * normalizationL0 * oneOverPi; // (1), (2), (3)
                const float weightL1 = cosineKernelL1 * normalizationL1 * oneOverPi; // (1), (2), (3)
                l0  *= weightL0;
                l1y *= weightL1;
                l1z *= weightL1;
                l1x *= weightL1;
                    
                return float4(l1x, l1y, l1z, l0);
            }
            
            void LV_QuadLight(float3 worldPos, float3 centroidPos, float4 rotationQuat, float2 size, float3 color, float sqMaxDist, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float3 lightToWorldPos = worldPos - centroidPos;
                    
                // Normal culling
                float3 normal = LV_MultiplyVectorByQuaternion(float3(0, 0, 1), rotationQuat);
                [branch] if (dot(normal, lightToWorldPos) < 0.0) return;
                    
                // Attenuate the light based on distance to the bounding sphere, so we don't get hard seam at the edge.
                float sqCutoffDist = sqMaxDist - dot(lightToWorldPos, lightToWorldPos);
                color.rgb *= saturate(sqCutoffDist / sqMaxDist) * LV_PI * occlusion;
                        
                // Compute the vertices of the quad
                float2 halfSize = size * 0.5f;
                float3 xAxis = LV_MultiplyVectorByQuaternion(float3(1, 0, 0), rotationQuat);
                float3 yAxis = cross(normal, xAxis);
                float3 verts[4];
                verts[0] = centroidPos + (-halfSize.x * xAxis) + ( halfSize.y * yAxis);
                verts[1] = centroidPos + ( halfSize.x * xAxis) + ( halfSize.y * yAxis);
                verts[2] = centroidPos + ( halfSize.x * xAxis) + (-halfSize.y * yAxis);
                verts[3] = centroidPos + (-halfSize.x * xAxis) + (-halfSize.y * yAxis);
                
                // Project irradiance from the area light
                float4 areaLightSH = LV_ProjectQuadLightIrradianceSH(worldPos, verts);
                
                // If the magnitude of L1 is greater than L0, we may get negative values
                // when reconstructing. To avoid, normalize L1. This is effectively de-ringing.
                float lenL1 = length(areaLightSH.xyz);
                if (lenL1 > areaLightSH.w) areaLightSH.xyz *= areaLightSH.w / lenL1;
                    
                L0  += areaLightSH.w * color.rgb;
                L1r += areaLightSH.xyz * color.r;
                L1g += areaLightSH.xyz * color.g;
                L1b += areaLightSH.xyz * color.b;
                    
                count++;
            }
            
            float3 LV_PointLightAttenuation(float sqdist, float sqlightSize, float3 color, float brightnessCutoff, float sqMaxDist) {
                float mask = saturate(1 - sqdist / sqMaxDist);
                return mask * mask * color * sqlightSize / (sqdist + sqlightSize);
            }
            
            float LV_PointLightSolidAngle(float sqdist, float sqlightSize) {
                return saturate(sqrt(sqdist / (sqlightSize + sqdist)));
            }
            
            void LV_SphereLight(float sqdist, float3 dirN, float sqlightSize, float3 color, float occlusion, float sqMaxDist, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float3 att = LV_PointLightAttenuation(sqdist, sqlightSize, color, _UdonLightBrightnessCutoff, sqMaxDist);
                
                float3 l0 = att * occlusion;
                float3 l1 = dirN * LV_PointLightSolidAngle(sqdist, sqlightSize);
                    
                L0 += l0;
                L1r += l0.r * l1;
                L1g += l0.g * l1;
                L1b += l0.b * l1;
                count++;
                    
            }
            
            void LV_SphereSpotLight(float sqdist, float3 dirN, float sqlightSize, float3 att, float spotMask, float cosAngle, float coneFalloff, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float smoothedCone = LV_Smoothstep01(saturate(spotMask * coneFalloff));
                float3 l0 = att * (occlusion * smoothedCone);
                float3 l1 = dirN * LV_PointLightSolidAngle(sqdist, sqlightSize * saturate(1 - cosAngle));
                    
                L0 += l0;
                L1r += l0.r * l1;
                L1g += l0.g * l1;
                L1b += l0.b * l1;
                count++;
                    
            }
            
            void LV_SphereSpotLightCookie(float sqdist, float3 dirN, float sqlightSize, float3 att, float4 lightRot, float tanAngle, uint customId, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float3 localDir = LV_MultiplyVectorByQuaternion(-dirN, lightRot);
                float2 uv = localDir.xy * rcp(localDir.z * tanAngle);
                [branch] if (
                    localDir.z <= 0.0 || // Culling by direction
                    abs(uv.x) > 1.0 || abs(uv.y) > 1.0 // Culling by UV
                ) return;
                        
                uint id = (uint) _UdonPointLightVolumeCubeCount * 5 - customId - 1;
                float3 uvid = float3(uv * 0.5 + 0.5, id);        
                float angleSize = saturate(rsqrt(1 + tanAngle * tanAngle));
                float4 cookie = LV_SAMPLE(_UdonPointLightVolumeTexture, uvid);
                        
                float3 l0 = att * cookie.rgb * (cookie.a * occlusion);
                float3 l1 = dirN * LV_PointLightSolidAngle(sqdist, sqlightSize * (1 - angleSize));
                    
                L0 += l0;
                L1r += l0.r * l1;
                L1g += l0.g * l1;
                L1b += l0.b * l1;
                count++;
                    
            }
            
            void LV_SphereSpotLightAttenuationLUT(float sqdist, float3 dirN, float sqlightSize, float3 color, float spotMask, float cosAngle, uint customId, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float dirRadius = sqdist * abs(sqlightSize);
                float spot = 1 - saturate(spotMask * rcp(1 - cosAngle));
                uint id = (uint) _UdonPointLightVolumeCubeCount * 5 + customId - 1;
                float3 uvid = float3(sqrt(float2(spot, dirRadius)), id);
                float3 att = color.rgb * LV_SAMPLE(_UdonPointLightVolumeTexture, uvid).xyz * occlusion;
                    
                L0 += att;
                L1r += dirN * att.r;
                L1g += dirN * att.g;
                L1b += dirN * att.b;
                    
                count++;
                    
            }
            
            void LV_PointLight(uint id, float3 worldPos, float4 occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                // IDs and range data
                float3 customID_data = _UdonPointLightVolumeCustomID[id];
                int shadowId = (int) customID_data.y; // Shadowmask id
                int customId = (int) customID_data.x; // Custom Texture ID
                float sqrRange = customID_data.z; // Squared culling distance
                    
                float4 pos = _UdonPointLightVolumePosition[id]; // Light position and inversed squared range 
                float3 dir = pos.xyz - worldPos;
                float sqlen = max(dot(dir, dir), 1e-6);
                [branch] if (sqlen > sqrRange) return; // Early distance based culling
                float3 dirN = dir * rsqrt(sqlen);
                    
                // Processing lights occlusion
                float lightOcclusion = 1;
                if (_UdonLightVolumeOcclusionCount != 0 && shadowId >= 0) {
                    lightOcclusion = dot(occlusion, float4(shadowId == 0, shadowId == 1, shadowId == 2, shadowId == 3));
                }
                    
                float4 color = _UdonPointLightVolumeColor[id]; // Color, angle
                float4 ldir = _UdonPointLightVolumeDirection[id]; // Dir + falloff or Rotation
                    
                [branch] if (pos.w < 0) { // It is a spot light
                
                    float angle = color.w;
                    float spotMask = dot(ldir.xyz, -dirN) - angle;
                    [branch] if(customId >= 0 && spotMask < 0) return; // Spot cone based culling
                        
                    [branch] if (customId > 0) {  // If it uses Attenuation LUT
                            
                        LV_SphereSpotLightAttenuationLUT(sqlen, dirN, -pos.w, color.rgb, spotMask, angle, customId, lightOcclusion, L0, L1r, L1g, L1b, count);
                            
                    } else { // If it uses default parametric attenuation
                
                        float3 att = LV_PointLightAttenuation(sqlen, -pos.w, color.rgb, _UdonLightBrightnessCutoff, sqrRange);
                
                        [branch] if (customId < 0) { // If uses cookie
                                
                            LV_SphereSpotLightCookie(sqlen, dirN, -pos.w, att, ldir, angle, customId, lightOcclusion, L0, L1r, L1g, L1b, count);
                                
                        } else { // If it uses default parametric attenuation
                                
                            LV_SphereSpotLight(sqlen, dirN, -pos.w, att, spotMask, angle, ldir.w, lightOcclusion, L0, L1r, L1g, L1b, count);
                                
                        }
                            
                    }
                        
                } else if (color.w <= 1.5f) { // It is a point light
                        
                    [branch] if (customId > 0) { // Using LUT
                            
                        float invSqRange = abs(pos.w); // Sign of range defines if it's point light (positive) or a spot light (negative)
                        float dirRadius = sqlen * invSqRange;
                        uint id = (uint) _UdonPointLightVolumeCubeCount * 5 + customId;
                        float3 uvid = float3(sqrt(float2(0, dirRadius)), id);
                        float3 att = color.rgb * LV_SAMPLE(_UdonPointLightVolumeTexture, uvid).xyz * lightOcclusion;
                            
                        L0 += att;
                        L1r += dirN * att.r;
                        L1g += dirN * att.g;
                        L1b += dirN * att.b;
                            
                        count++;
                            
                    } else { // If it uses default parametric attenuation
                            
                        float3 l0 = 0, l1r = 0, l1g = 0, l1b = 0;
                        LV_SphereLight(sqlen, dirN, pos.w, color.rgb, lightOcclusion, sqrRange, l0, l1r, l1g, l1b, count);
                
                        float3 cubeColor = 1;
                        [branch] if (customId < 0) { // If it uses a cubemap
                            uint id = -customId - 1; // Cubemap ID starts from zero and should not take in count texture array slices count.
                            cubeColor = LV_SampleCubemapArray(id, LV_MultiplyVectorByQuaternion(dirN, ldir)).xyz;
                        }
                
                        L0 += l0 * cubeColor;
                        L1r += l1r * cubeColor.r;
                        L1g += l1g * cubeColor.g;
                        L1b += l1b * cubeColor.b;
                    }
                        
                } else { // It is an area light
                        
                    LV_QuadLight(worldPos, pos.xyz, ldir, float2(pos.w, color.w - 2.0f), color.rgb, sqrRange, lightOcclusion, L0, L1r, L1g, L1b, count);
                        
                }
                
            }
            
            void LV_SampleLightVolumeTex(float3 uvw0, float3 uvw1, float3 uvw2, out float3 L0, out float3 L1r, out float3 L1g, out float3 L1b) {
                // Sampling 3D Atlas
                float4 tex0 = LV_SAMPLE(_UdonLightVolume, uvw0);
                float4 tex1 = LV_SAMPLE(_UdonLightVolume, uvw1);
                float4 tex2 = LV_SAMPLE(_UdonLightVolume, uvw2);
                // Packing final data
                L0 = tex0.rgb;
                L1r = float3(tex1.r, tex2.r, tex0.a);
                L1g = float3(tex1.g, tex2.g, tex1.a);
                L1b = float3(tex1.b, tex2.b, tex2.a);
            }
            
            float LV_BoundsMask(float3 localUVW, float3 invLocalEdgeSmooth) {
                float3 distToMin = (localUVW + 0.5) * invLocalEdgeSmooth;
                float3 distToMax = (0.5 - localUVW) * invLocalEdgeSmooth;
                float3 fade = saturate(min(distToMin, distToMax));
                return fade.x * fade.y * fade.z;
            }
            
            void LV_SampleLightProbe(inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b) {
                L0 += float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                L1r += unity_SHAr.xyz;
                L1g += unity_SHAg.xyz;
                L1b += unity_SHAb.xyz;
            }
            
            void LV_SampleLightProbeDering(inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b) {
                L0 += float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                L1r += unity_SHAr.xyz * 0.565f;
                L1g += unity_SHAg.xyz * 0.565f;
                L1b += unity_SHAb.xyz * 0.565f;
            }
            
            void LV_SampleVolume(uint id, float3 localUVW, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, out float4 occlusion) {
                    
                // Additive UVW
                //uint uvwID = id * 3;
                //float4 uvwPos0 = _UdonLightVolumeUvwScale[uvwID];
                //float4 uvwPos1 = _UdonLightVolumeUvwScale[uvwID + 1];
                //float4 uvwPos2 = _UdonLightVolumeUvwScale[uvwID + 2];
                //float3 uvwScale = float3(uvwPos0.w, uvwPos1.w, uvwPos2.w);
                    
                //float3 uvwScaled = saturate(localUVW + 0.5) * uvwScale;
                //float3 uvw0 = uvwPos0.xyz + uvwScaled;
                //float3 uvw1 = uvwPos1.xyz + uvwScaled;
                //float3 uvw2 = uvwPos2.xyz + uvwScaled;
                    
                // Legacy! Commented code above will be used in future releases! Legacy!
                uint uvwID = id * 6;
                float3 uvwScaled = saturate(localUVW + 0.5) * (_UdonLightVolumeUvw[uvwID + 1].xyz - _UdonLightVolumeUvw[uvwID].xyz);
                float3 uvw0 = uvwScaled + _UdonLightVolumeUvw[uvwID].xyz;
                float3 uvw1 = uvwScaled + _UdonLightVolumeUvw[uvwID + 2].xyz;
                float3 uvw2 = uvwScaled + _UdonLightVolumeUvw[uvwID + 4].xyz;
                    
                // Sample additive
                float3 l0, l1r, l1g, l1b;
                LV_SampleLightVolumeTex(uvw0, uvw1, uvw2, l0, l1r, l1g, l1b);
                
                // Sample occlusion
                float4 uvwOcclusion = _UdonLightVolumeOcclusionUvw[id];
                [branch] if (uvwOcclusion.x >= 0) {
                    occlusion = 1.0f - LV_SAMPLE(_UdonLightVolume, uvwOcclusion.xyz + uvwScaled * uvwOcclusion.w);
                } else {
                    occlusion = 1;
                }
                    
                // Color correction
                float4 color = _UdonLightVolumeColor[id];
                L0 += l0 * color.rgb;
                l1r *= color.r;
                l1g *= color.g;
                l1b *= color.b;
                    
                // Rotate if needed
                if (color.a != 0) {
                    //float4 r = _UdonLightVolumeRotationQuaternion[id];
                    //L1r = LV_MultiplyVectorByQuaternion(L1r, r);
                    //L1g = LV_MultiplyVectorByQuaternion(L1g, r);
                    //L1b = LV_MultiplyVectorByQuaternion(L1b, r);
                        
                    // Legacy to support older light volumes worlds! Commented code above will be used in future releases! Legacy!
                    float3 r0 = _UdonLightVolumeRotation[id * 2].xyz;
                    float3 r1 = _UdonLightVolumeRotation[id * 2 + 1].xyz;
                    L1r += LV_MultiplyVectorByMatrix2x3(l1r, r0, r1);
                    L1g += LV_MultiplyVectorByMatrix2x3(l1g, r0, r1);
                    L1b += LV_MultiplyVectorByMatrix2x3(l1b, r0, r1);
                } else {
                    L1r += l1r;
                    L1g += l1g;
                    L1b += l1b;
                }
                                
            }
            
            float4 LV_SampleVolumeOcclusion(uint id, float3 localUVW) {
                    
                // Sample occlusion
                float4 uvwOcclusion = _UdonLightVolumeOcclusionUvw[id];
                    
                [branch] if (uvwOcclusion.x >= 0) {
                    //uint uvwID = id * 3;
                    //float4 uvwPos0 = _UdonLightVolumeUvwScale[uvwID];
                    //float4 uvwPos1 = _UdonLightVolumeUvwScale[uvwID + 1];
                    //float4 uvwPos2 = _UdonLightVolumeUvwScale[uvwID + 2];
                    //float3 uvwScale = float3(uvwPos0.w, uvwPos1.w, uvwPos2.w);
                    //float3 uvwScaled = saturate(localUVW + 0.5) * uvwScale;
                        
                    // Legacy to support older light volumes worlds! Commented code above will be used in future releases! Legacy!
                    uint uvwID = id * 6;
                    float3 uvwScaled = saturate(localUVW + 0.5) * (_UdonLightVolumeUvw[uvwID + 1].xyz - _UdonLightVolumeUvw[uvwID].xyz);
                        
                    return 1.0f - LV_SAMPLE(_UdonLightVolume, uvwOcclusion.xyz + uvwScaled * uvwOcclusion.w);
                } else {
                    return 1;
                }
                    
            }
            
            void LV_PointLightVolumeSH(float3 worldPos, float4 occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b) {
                    
                uint pointCount = min((uint) _UdonPointLightVolumeCount, VRCLV_MAX_LIGHTS_COUNT);
                [branch] if (pointCount == 0) return;
                    
                uint maxOverdraw = min((uint) _UdonLightVolumeAdditiveMaxOverdraw, VRCLV_MAX_LIGHTS_COUNT);
                uint pcount = 0; // Point lights counter
                
                [loop] for (uint pid = 0; pid < pointCount && pcount < maxOverdraw; pid++) {
                    LV_PointLight(pid, worldPos, occlusion, L0, L1r, L1g, L1b, pcount);
                }
                    
            }
            
            void LV_LightVolumeSH(float3 worldPos, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, out float4 occlusion) {
                
                // Initializing output variables
                occlusion = 1;
                float4 mOcclusion = 1; // Multiplicative occlusion. Applies on top of regular occlusion
                    
                // Clamping gloabal iteration counts
                uint volumesCount = min((uint) _UdonLightVolumeCount, VRCLV_MAX_VOLUMES_COUNT);
                    
                //if (_UdonLightVolumeVersion < VRCLV_VERSION || volumesCount == 0 ) { // Fallback to default light probes if Light Volume are not enabled or a version is too old to have a support
                [branch] if (volumesCount == 0) { // Legacy! Fallback to default light probes if Light Volume are not enabled or a version is too old to have a support. Legacy!
                    LV_SampleLightProbe(L0, L1r, L1g, L1b);
                    return;
                }
                    
                uint maxOverdraw = min((uint) _UdonLightVolumeAdditiveMaxOverdraw, VRCLV_MAX_VOLUMES_COUNT);
                uint additiveCount = min((uint) _UdonLightVolumeAdditiveCount, VRCLV_MAX_VOLUMES_COUNT);
                bool lightProbesBlend = _UdonLightVolumeProbesBlend;
                    
                uint volumeID_A = -1; // Main, dominant volume ID
                uint volumeID_B = -1; // Secondary volume ID to blend main with
                
                float3 localUVW   = 0; // Last local UVW to use in disabled Light Probes mode
                float3 localUVW_A = 0; // Main local UVW
                float3 localUVW_B = 0; // Secondary local UVW
                    
                // Are A and B volumes NOT found?
                bool isNoA = true;
                bool isNoB = true;
                    
                // Additive volumes variables
                uint addVolumesCount = 0;
                    
                // Iterating through all light volumes with simplified algorithm requiring Light Volumes to be sorted by weight in descending order
                [loop] for (uint id = 0; id < volumesCount; id++) {
                    localUVW = LV_LocalFromVolume(id, worldPos);
                    [branch] if (LV_PointLocalAABB(localUVW)) { // Intersection test
                        [branch] if (id < additiveCount) { // Sampling additive volumes
                            [branch] if (addVolumesCount < maxOverdraw) {
                                float4 occ; // Multiplicative occlusion
                                LV_SampleVolume(id, localUVW, L0, L1r, L1g, L1b, occ);
                                mOcclusion *= occ;
                                addVolumesCount++;
                            } 
                        } else if (isNoA) { // First, searching for volume A
                            volumeID_A = id;
                            localUVW_A = localUVW;
                            isNoA = false;
                        } else { // Next, searching for volume B if A found
                            volumeID_B = id;
                            localUVW_B = localUVW;
                            isNoB = false;
                            break;
                        }
                    }
                }
                
                // If no volumes found, using Light Probes as fallback
                [branch] if (isNoA && lightProbesBlend) {
                    LV_SampleLightProbe(L0, L1r, L1g, L1b);
                    occlusion *= mOcclusion;
                    return;
                }
                        
                // Fallback to lowest weight light volume if outside of every volume
                localUVW_A = isNoA ? localUVW : localUVW_A;
                volumeID_A = isNoA ? volumesCount - 1 : volumeID_A;
                
                // Volume A SH components, occlusion, and mask to blend volume sides
                float3 L0_A  = 0;
                float3 L1r_A = 0;
                float3 L1g_A = 0;
                float3 L1b_A = 0;
                float4 occlusion_A = 1;
                    
                // Sampling Light Volume A
                LV_SampleVolume(volumeID_A, localUVW_A, L0_A, L1r_A, L1g_A, L1b_A, occlusion_A);
                    
                float mask = LV_BoundsMask(localUVW_A, _UdonLightVolumeInvLocalEdgeSmooth[volumeID_A]);
                [branch] if (mask == 1 || isNoA || (_UdonLightVolumeSharpBounds && isNoB)) { // Returning SH A result if it's the center of mask or out of bounds
                    L0  += L0_A;
                    L1r += L1r_A;
                    L1g += L1g_A;
                    L1b += L1b_A;
                    occlusion = occlusion_A;
                    occlusion *= mOcclusion;
                    return;
                }
                    
                // Volume B SH components and occlusion
                float3 L0_B  = 0;
                float3 L1r_B = 0;
                float3 L1g_B = 0;
                float3 L1b_B = 0;
                float4 occlusion_B = 1;
                
                [branch] if (isNoB && lightProbesBlend) { // No Volume found and light volumes blending enabled
                
                    // Sample Light Probes B
                    LV_SampleLightProbe(L0_B, L1r_B, L1g_B, L1b_B);
                
                } else { // Blending Volume A and Volume B
                            
                    // If no volume b found, use last one found to fallback
                    localUVW_B = isNoB ? localUVW : localUVW_B;
                    volumeID_B = isNoB ? volumesCount - 1 : volumeID_B;
                            
                    // Sampling Light Volume B
                    LV_SampleVolume(volumeID_B, localUVW_B, L0_B, L1r_B, L1g_B, L1b_B, occlusion_B);
                        
                }
                
                // Lerping occlusion
                occlusion = lerp(occlusion_B, occlusion_A, mask);
                occlusion *= mOcclusion;
                
                // Lerping SH components
                L0  += lerp(L0_B,  L0_A,  mask);
                L1r += lerp(L1r_B, L1r_A, mask);
                L1g += lerp(L1g_B, L1g_A, mask);
                L1b += lerp(L1b_B, L1b_A, mask);
                
            }
            
            void LV_LightVolumeAdditiveSH(float3 worldPos, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, out float4 occlusion) {
                
                // Initializing output variables
                occlusion = 1;
                float4 mOcclusion = 1; // Multiplicative occlusion. Applies on top of regular occlusion
                    
                // Clamping gloabal iteration counts
                uint additiveCount = min((uint) _UdonLightVolumeAdditiveCount, VRCLV_MAX_VOLUMES_COUNT);
                //if (_UdonLightVolumeVersion < VRCLV_VERSION || (additiveCount == 0 && pointCount == 0)) return;
                [branch] if (additiveCount == 0 && (uint) _UdonPointLightVolumeCount == 0) return; // Legacy!
                
                uint volumesCount = min((uint) _UdonLightVolumeCount, VRCLV_MAX_VOLUMES_COUNT);
                uint maxOverdraw = min((uint) _UdonLightVolumeAdditiveMaxOverdraw, VRCLV_MAX_VOLUMES_COUNT);
                    
                uint volumeID_A = -1; // Main, dominant volume ID
                uint volumeID_B = -1; // Secondary volume ID to blend main with
                
                float3 localUVW   = 0; // Last local UVW to use in disabled Light Probes mode
                float3 localUVW_A = 0; // Main local UVW for Y Axis and Free rotations
                float3 localUVW_B = 0; // Secondary local UVW
                    
                // Are A and B volumes NOT found?
                bool isNoA = true;
                bool isNoB = true;
                    
                // Additive volumes variables
                uint addVolumesCount = 0;
                
                // Iterating through all light volumes with simplified algorithm requiring Light Volumes to be sorted by weight in descending order
                uint count = min(_UdonLightVolumeOcclusionCount == 0 ? additiveCount : volumesCount, VRCLV_MAX_VOLUMES_COUNT); // Only use all volumes if occlusion volumes are enabled
                [loop] for (uint id = 0; id < count; id++) {
                    localUVW = LV_LocalFromVolume(id, worldPos);
                    [branch] if (LV_PointLocalAABB(localUVW)) { // Intersection test
                        [branch] if (id < additiveCount) { // Sampling additive volumes
                            [branch] if (addVolumesCount < maxOverdraw) {
                                float4 occ; // Multiplicative occlusion
                                LV_SampleVolume(id, localUVW, L0, L1r, L1g, L1b, occ);
                                mOcclusion *= occ;
                                addVolumesCount++;
                            } 
                        } else if (isNoA) { // First, searching for volume A
                            volumeID_A = id;
                            localUVW_A = localUVW;
                            isNoA = false;
                        } else { // Next, searching for volume B if A found
                            volumeID_B = id;
                            localUVW_B = localUVW;
                            isNoB = false;
                            break;
                        }
                    }
                }
                
                // If no volumes found, or we don't need the occlusion data, we are done
                [branch] if (isNoA || _UdonLightVolumeOcclusionCount == 0) {
                    occlusion *= mOcclusion;
                    return;
                }
                    
                // Fallback to lowest weight light volume if outside of every volume
                localUVW_A = isNoA ? localUVW : localUVW_A;
                volumeID_A = isNoA ? volumesCount - 1 : volumeID_A;
                
                // Sampling Light Volume A
                occlusion = LV_SampleVolumeOcclusion(volumeID_A, localUVW_A);
                float mask = LV_BoundsMask(localUVW_A, _UdonLightVolumeInvLocalEdgeSmooth[volumeID_A]);
                    
                [branch] if (mask == 1 || (_UdonLightVolumeSharpBounds && isNoB)) {
                    occlusion *= mOcclusion;
                    return; // Returning A result if it's the center of mask or out of bounds
                }
                
                // Blending Volume A and Volume B
                [branch] if (isNoB) occlusion = lerp(1, occlusion, mask);
                else occlusion = lerp(LV_SampleVolumeOcclusion(volumeID_B, localUVW_B), occlusion, mask);
                
                occlusion *= mOcclusion;
                    
            }
            
            float3 LightVolumeSpecular(float3 f0, float smoothness, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                    
                float3 specColor = max(float3(dot(reflect(-L1r, worldNormal), viewDir), dot(reflect(-L1g, worldNormal), viewDir), dot(reflect(-L1b, worldNormal), viewDir)), 0);
                    
                float3 rDir = normalize(normalize(L1r) + viewDir);
                float3 gDir = normalize(normalize(L1g) + viewDir);
                float3 bDir = normalize(normalize(L1b) + viewDir);
                    
                float rNh = saturate(dot(worldNormal, rDir));
                float gNh = saturate(dot(worldNormal, gDir));
                float bNh = saturate(dot(worldNormal, bDir));
                    
                float roughness = 1 - smoothness * 0.9f;
                float roughExp = roughness * roughness;
                    
                float rSpec = LV_DistributionGGX(rNh, roughExp);
                float gSpec = LV_DistributionGGX(gNh, roughExp);
                float bSpec = LV_DistributionGGX(bNh, roughExp);
                    
                float3 specs = (rSpec + gSpec + bSpec) * f0;
                float3 coloredSpecs = specs * specColor;
                    
                float3 a = coloredSpecs + specs * L0;
                float3 b = coloredSpecs * 3;
                    
                return max(lerp(a, b, smoothness) * 0.5f, 0.0);
                    
            }
            
            float3 LightVolumeSpecular(float3 albedo, float smoothness, float metallic, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                float3 specularf0 = lerp(0.04f, albedo, metallic);
                return LightVolumeSpecular(specularf0, smoothness, worldNormal, viewDir, L0, L1r, L1g, L1b);
            }
            
            float3 LightVolumeSpecularDominant(float3 f0, float smoothness, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                    
                float3 dominantDir = L1r + L1g + L1b;
                float3 dir = normalize(normalize(dominantDir) + viewDir);
                float nh = saturate(dot(worldNormal, dir));
                    
                float roughness = 1 - smoothness * 0.9f;
                float roughExp = roughness * roughness;
                    
                float spec = LV_DistributionGGX(nh, roughExp);
                    
                return max(spec * L0 * f0, 0.0) * 1.5f;
                    
            }
            
            float3 LightVolumeSpecularDominant(float3 albedo, float smoothness, float metallic, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                float3 specularf0 = lerp(0.04f, albedo, metallic);
                return LightVolumeSpecularDominant(specularf0, smoothness, worldNormal, viewDir, L0, L1r, L1g, L1b);
            }
            
            float3 LightVolumeEvaluate(float3 worldNormal, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                return float3(LV_EvaluateSH(L0.r, L1r, worldNormal), LV_EvaluateSH(L0.g, L1g, worldNormal), LV_EvaluateSH(L0.b, L1b, worldNormal));
            }
            
            void LightVolumeSH(float3 worldPos, out float3 L0, out float3 L1r, out float3 L1g, out float3 L1b, float3 worldPosOffset = 0) {
                L0 = 0; L1r = 0; L1g = 0; L1b = 0;
                if (_UdonLightVolumeEnabled == 0) {
                    LV_SampleLightProbeDering(L0, L1r, L1g, L1b);
                } else {
                    float4 occlusion = 1;
                    LV_LightVolumeSH(worldPos + worldPosOffset, L0, L1r, L1g, L1b, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, L1r, L1g, L1b);
                }
            }
            
            void LightVolumeAdditiveSH(float3 worldPos, out float3 L0, out float3 L1r, out float3 L1g, out float3 L1b, float3 worldPosOffset = 0) {
                L0 = 0; L1r = 0; L1g = 0; L1b = 0;
                if (_UdonLightVolumeEnabled != 0) {
                    float4 occlusion = 1;
                    LV_LightVolumeAdditiveSH(worldPos + worldPosOffset, L0, L1r, L1g, L1b, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, L1r, L1g, L1b);
                }
            }
            
            float3 LightVolumeSH_L0(float3 worldPos, float3 worldPosOffset = 0) {
                if (_UdonLightVolumeEnabled == 0) {
                    return float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                } else {
                    float3 L0 = 0; float4 occlusion = 1;
                    float3 unused_L1; // Let's just pray that compiler will strip everything x.x
                    LV_LightVolumeSH(worldPos + worldPosOffset, L0, unused_L1, unused_L1, unused_L1, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, unused_L1, unused_L1, unused_L1);
                    return L0;
                }
            }
            
            float3 LightVolumeAdditiveSH_L0(float3 worldPos, float3 worldPosOffset = 0) {
                if (_UdonLightVolumeEnabled == 0) {
                    return 0;
                } else {
                    float3 L0 = 0; float4 occlusion = 1;
                    float3 unused_L1; // Let's just pray that compiler will strip everything x.x
                    LV_LightVolumeAdditiveSH(worldPos + worldPosOffset, L0, unused_L1, unused_L1, unused_L1, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, unused_L1, unused_L1, unused_L1);
                    return L0;
                }
            }
            
            float LightVolumesEnabled() {
                return _UdonLightVolumeEnabled;
            }
            
            float LightVolumesVersion() {
                return _UdonLightVolumeVersion == 0 ? _UdonLightVolumeEnabled : _UdonLightVolumeVersion;
            }
            
            #endif
            
            #if INCLUDE_LTCGI
            
            void LTCGICallbackDiffuse(inout LTCGIAccumulatorStruct acc, in ltcgi_output output)
            {
                acc.diffuse += output.intensity * output.color;
            }
            
            void LTCGICallbackSpecular(inout LTCGIAccumulatorStruct acc, in ltcgi_output output)
            {
                acc.specular += output.intensity * output.color;
            }    
            
            #define LTCGI_V2_DIFFUSE_CALLBACK LTCGICallbackDiffuse
            #define LTCGI_V2_SPECULAR_CALLBACK LTCGICallbackSpecular
                
            #include "Packages/at.pimaker.ltcgi/Shaders/LTCGI.cginc"
            #endif
            
            // Bakery volume helpers
            #if defined(BAKERY_ENABLED)
            #if defined(BAKERY_VOLUME)
            BakeryVolumeData GetBakeryVolumeTextureData(BakeryVolumeData data)
            {
                #ifdef BAKERY_COMPRESSED_VOLUME
                    data.tex0 = _Volume0.Sample(sampler_Volume0, data.uv);
                    data.tex1 = _Volume1.Sample(sampler_Volume0, data.uv) * 2 - 1;
                    data.tex2 = _Volume2.Sample(sampler_Volume0, data.uv) * 2 - 1;
                    data.tex3 = _Volume3.Sample(sampler_Volume0, data.uv) * 2 - 1;
                    data.L0 = data.tex0.xyz;
                    data.L1x = data.tex1.xyz * data.L0 * 2;
                    data.L1y = data.tex2.xyz * data.L0 * 2;
                    data.L1z = data.tex3.xyz * data.L0 * 2;
                #else
                    data.tex0 = _Volume0.Sample(sampler_Volume0, data.uv);
                    data.tex1 = _Volume1.Sample(sampler_Volume0, data.uv);
                    data.tex2 = _Volume2.Sample(sampler_Volume0, data.uv);
                    data.L0 = data.tex0.xyz;
                    data.L1x = data.tex1.xyz;
                    data.L1y = data.tex2.xyz;
                    data.L1z = float3(data.tex0.w, data.tex1.w, data.tex2.w);
                #endif
                return data;
            }
            
            BakeryVolumeSpecularData GetBakeryVolumeSpecularData(BakeryVolumeData data)
            {
                BakeryVolumeSpecularData ret = (BakeryVolumeSpecularData) 0;
            
                float3 nL1x = data.L1x / data.L0;
                float3 nL1y = data.L1y / data.L0;
                float3 nL1z = data.L1z / data.L0;
                ret.direction = float3(dot(nL1x, lumaConv), dot(nL1y, lumaConv), dot(nL1z, lumaConv));
                ret.color = data.L0 + ret.direction.x * data.L1x + ret.direction.y * data.L1y + ret.direction.z * data.L1z;
                ret.NoV = dot(data.normal, data.viewDir);
                ret.NoV = max(ret.NoV, 0.0001);
                return ret;
            }
            
            #endif
            
            #endif

            // Functions
            void PBRFragment(MeshData d, inout SurfaceData o) {
                // this allows us to handle things like parallax nicely
                #if defined(PARALLAX)
                    GLOBAL_uv = GLOBAL_parallaxUv;
                #else
                    GLOBAL_uv = d.uv0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                #endif
            
                // Do Triplanar
                if (_MappingSpace == 3)
                {
                    // Fast (bad) Triplanar
                    float3 axisProjection = mul(float3(0.0001, 0.0001, 1), d.TBNMatrix);
                    axisProjection = abs(axisProjection);
                    axisProjection = pow(axisProjection, 160);
                    axisProjection /= axisProjection.x + axisProjection.y + axisProjection.z;
                    axisProjection = saturate(invLerp(axisProjection, 0.5, 0.5001));
                    axisProjection.z += saturate(1 - length(axisProjection));
            
                    float3 pos = d.worldSpacePosition * _MainTex_ST.x;
                    GLOBAL_uv = pos.zy;
                    GLOBAL_uv *= axisProjection.x;
                    GLOBAL_uv += pos.xz * axisProjection.y;
                    GLOBAL_uv += pos.xy * axisProjection.z;
            
                }
                else if (_MappingSpace > 0)
                {
                    GLOBAL_uv = (_MappingSpace - 1) ? half2(d.worldSpacePosition[_PlanarAxisX], d.worldSpacePosition[_PlanarAxisY]) : half2(d.localSpacePosition[_PlanarAxisX], d.localSpacePosition[_PlanarAxisY]);
                    GLOBAL_uv *= _MainTex_ST.xy + _MainTex_ST.zw;
                }
                half4 albedo = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, GLOBAL_uv);
                if (_AlbedoChannel > 0)
                {
                    albedo.rgb = albedo[_AlbedoChannel - 1].xxx;
                }
                half4 masks = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, GLOBAL_uv);
                float4 normalTex = SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, GLOBAL_uv);
                if (_FlipBumpY)
                {
                    normalTex.y = 1 - normalTex.y;
                }
                    
                float3 normal = UnpackNormalScale(normalTex, _BumpScale);
            
                half3 emission = SAMPLE_TEXTURE2D(_EmissionMap, sampler_EmissionMap, GLOBAL_uv).rgb;
                if (_EmissionChannel > 0)
                {
                    emission.rgb = emission[_EmissionChannel - 1].xxx;
                }
                int hasMasks = _MaskMap_TexelSize.z > 8;
                half metal = masks[_MetalChannel];
                half smooth = masks[_SmoothChannel];
                if (_RoughnessMode)
                {
                    smooth = 1 - smooth;
                }
                half detailMask = masks[_DetailMaskChannel];
                half occlusion = masks[_AOChannel];
                metal = remap(metal, 0, 1, _MetallicRemap.x, _MetallicRemap.y);
                smooth = remap(smooth, 0, 1, _SmoothnessRemap.x, _SmoothnessRemap.y);
                GLOBAL_maskMap = half4(metal, occlusion, detailMask, smooth);
                o.Metallic = lerp(_Metallic, metal, hasMasks);
                o.Smoothness = lerp(_Smoothness, smooth, hasMasks);
                o.Occlusion = lerp(1, occlusion, _OcclusionStrength);
                o.Normal = normal;
                if (!_DetailAsTintMask)
                {
                    o.Albedo *= albedo.rgb * _Color.rgb;
                }
                else
                {
                    o.Albedo *= lerp(albedo, albedo.rgb * _Color.rgb, detailMask);
                }
                // Fix BC7 compression issues, unity PLS fix
                {
                    uint a = uint(o.Alpha * 255.0);
                    a = a > 254 ? 255 : a;
                    a = a < 5 ? 0 : a;
                    o.Alpha =  a / 255.0;
                }
            
                o.Alpha *= albedo.a * _Color.a;
                #if defined(_EMISSION)
                    o.Emission = emission * pow(_EmissionColor,2.2);
                #endif
            }
            

            #if defined(_PARALLAXSTEPS_EIGHT)
                #define PARALLAX_STEPS 8
            #elif defined(_PARALLAXSTEPS_SIXTEEN)
                #define PARALLAX_STEPS 16
            #elif defined(_PARALLAXSTEPS_THIRTYTWO)
                #define PARALLAX_STEPS 32
            #elif defined(_PARALLAXSTEPS_SIXTYFOUR)
                #define PARALLAX_STEPS 64
            #else
                #define PARALLAX_STEPS 1
            #endif
            
            float2 POM_simple(TEXTURE2D_PARAM(heightMap, heightSampler), float currentHeight, float scale, float2 uv, float3 tangetSpaceViewDir, float refPlane, out float heightOffset)
            {
                heightOffset = 0;
                float2 uvOffset = 0;
                float stepSize = 1.0 / PARALLAX_STEPS;
                float stepHeight = 1;
                tangetSpaceViewDir.xy /= (tangetSpaceViewDir.z + 0.42);
                float2 uvDelta = tangetSpaceViewDir.xy * (stepSize * scale);
            
                float2 derivatives = float2(ddx(uv.x), ddy(uv.y));
            
                [unroll(PARALLAX_STEPS)]
                for (int i = 1; i <= PARALLAX_STEPS && stepHeight > currentHeight; i++)
                {
                    uvOffset -= uvDelta;
                    stepHeight -= stepSize;
                    currentHeight = SAMPLE_TEXTURE2D_GRAD(heightMap, heightSampler, uv + uvOffset, derivatives.x, derivatives.y).r + refPlane;
                }
            
                [unroll(3)]
                for (int k = 0; k < 3; k++)
                {
                    uvDelta *= 0.5;
                    stepSize *= 0.5;
            
                    if (stepHeight < currentHeight)
                    {
                        uvOffset += uvDelta;
                        stepHeight += stepSize;
                    } else {
                        uvOffset -= uvDelta;
                        stepHeight -= stepSize;
                    }
                    currentHeight = SAMPLE_TEXTURE2D_GRAD(heightMap, heightSampler, uv + uvOffset, derivatives.x, derivatives.y).r + refPlane;
                }
            
                heightOffset = currentHeight;
                return uvOffset;
            }
            
            void ParallaxFragment(MeshData d, FragmentData i)
            {
                // this is a bit "magical" but basically we just push to global UVs
                // and then any other module will read from them
                // we use FragmentQueue to push the actual function call above the other modules
                GLOBAL_parallaxUv = d.uv0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                #if defined(PARALLAX) && !defined(PLAT_QUEST)
                {
                    float customHeight = 0;
                    if (_ParallaxScaleBasedOnAngle)
                    {
                        float3 forwardRay = TransformViewToWorldDir(float3(0,0,1));
                        _HeightScale *= pow(saturate(dot(d.worldNormal, forwardRay)), 1.0/1.5);
                    }
                    half startingPoint = SAMPLE_TEXTURE2D(_Height, sampler_Height, GLOBAL_parallaxUv).r;
                    float2 uvOffset = POM_simple(TEXTURE2D_ARGS(_Height, sampler_Height), startingPoint, _HeightScale, GLOBAL_parallaxUv, d.tangentSpaceViewDir, _HeightRefPlane, customHeight);
                    GLOBAL_parallaxUv += uvOffset;
            
                    GLOBAL_height = customHeight;
                    GLOBAL_heightSet = 1;
                }
                #endif
            }
            

            void DetailsFragment(MeshData d, inout SurfaceData o)
            {
                #if !defined(DETAILS_OVERLAY)
                    return;
                #else
                half masks = 0;
            
                // we can grab the mask map from the Base Shader if it was present
                #if defined(_MASKMAP_SAMPLED)
                masks = GLOBAL_maskMap.b;
                #else
                masks = 1;
                #endif
            
                half mask = lerp(masks, 1, _DIgnoreMask);
                float2 uv = d.uv0.xy;
                switch(_DUVChannel)
                {
                    case 1: uv = d.uv1.xy; break;
                    case 2: uv = d.uv2.xy; break;
                    case 3: uv = d.uv3.xy; break;
                    default: uv = d.uv0.xy; break;
                }
                uv = uv * _DDetailsMap_ST.xy + _DDetailsMap_ST.zw;
                if (_DMappingSpace > 0)
                {
                    uv = (_DMappingSpace - 1) ? half2(d.worldSpacePosition[_DPlanarAxisX], d.worldSpacePosition[_DPlanarAxisY]) : half2(d.localSpacePosition[_DPlanarAxisX], d.localSpacePosition[_DPlanarAxisY]);
                    uv = uv * _DDetailsMap_ST.xy + _DDetailsMap_ST.zw;
                }
            
                half4 detailsMap = SAMPLE_TEXTURE2D(_DDetailsMap, sampler_DDetailsMap, uv);
            
                #if defined(DETAILS_MODE_PACKED)
                    
                // 0.5 is the neutral value
                half detailAlbedo = detailsMap.r * 2.0 - 1.0;
                half detailSmooth = detailsMap.b * 2.0 - 1.0;
                half3 detailNormal = 0;
                if (_DNormalFlipY)
                {
                    detailsMap.g = 1 - detailsMap.g;
                }
                detailNormal = UnpackNormalScale(float4(detailsMap.ag, 1, 1), _DNormalScale);
                half detailAlbedoSpeed = saturate(abs(detailAlbedo) * _DAlbedoScale);
                half3 albedoOverlay = lerp(sqrt(o.Albedo), (detailAlbedo < 0.0) ? 0.0.xxx : 1.0.xxx, detailAlbedoSpeed * detailAlbedoSpeed);
                albedoOverlay *= albedoOverlay;
            
                // Packed mode only supports HDRP-style albedo mixing
                o.Albedo = lerp(o.Albedo, saturate(albedoOverlay), mask);
            
                #elif defined(DETAILS_MODE_SEPARATED)        
                half detailSmooth = detailsMap.a * 2.0 - 1.0;
            
                half4 packedNormal = SAMPLE_TEXTURE2D(_DDetailsNormal, sampler_DDetailsNormal, uv);
                if (_DNormalFlipY)
                {
                    packedNormal.g = 1 - packedNormal.g;
                }
                half3 detailNormal = UnpackNormalScale(packedNormal, _DNormalScale);
            
                // Separated mdoe supports BIRP-style 2x albedo mixing
                if (_DAlbedoMixingLegacy) {
                    o.Albedo *= LerpWhiteTo(detailsMap.rgb * unity_ColorSpaceDouble.rgb, mask * _DAlbedoScale);
                } else {
                    half3 detailAlbedo = detailsMap.rgb * 2.0 - 1.0;
                    half3 detailAlbedoSpeed = saturate(abs(detailAlbedo) * _DAlbedoScale);
                    half3 albedoOverlay = lerp(sqrt(o.Albedo), (detailAlbedo < 0.0) ? 0.0.xxx : 1.0.xxx, detailAlbedoSpeed * detailAlbedoSpeed);
                    albedoOverlay *= albedoOverlay;
                    o.Albedo = lerp(o.Albedo, saturate(albedoOverlay), mask);
                }
                #endif
            
                // do the smooth details
                half detailSmoothSpeed = saturate(abs(detailSmooth) * _DSmoothScale);
                half smoothOverlay = lerp(o.Smoothness, (detailSmooth < 0.0) ? 0.0 : 1.0, detailSmoothSpeed * detailSmoothSpeed);
                o.Smoothness = lerp(o.Smoothness, saturate(smoothOverlay), mask);
            
                // do the normal details
                o.Normal = lerp(o.Normal, BlendNormals(o.Normal, detailNormal), mask);
                #endif
            }
            

            bool isVR__local()
            {
            #if UNITY_SINGLE_PASS_STEREO
                return true;
            #else
                return false;
            #endif
            }
            
            void VRCFeaturesVertex(inout VertexData v)
            {
                #if defined(VRC_FEATURES)
                bool isMainView = _VRChatCameraMode == 0 && _VRChatMirrorMode == 0;
                bool isInVRHandCam = _VRChatCameraMode == 1;
                bool isInDesktopHandCam = _VRChatCameraMode == 2;
                bool isInVR = isVR__local();
                bool isInDesktop = !isInVR && !isInDesktopHandCam;
                bool isInVRMirror = _VRChatMirrorMode == 1;
                bool isInDesktopMirror = _VRChatMirrorMode == 2;
            
                if (_VRCHideInVR && isInVR && isMainView)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInDesktop && isInDesktop && isMainView)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInVRCamera && isInVRHandCam)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInDesktopCamera && isInDesktopHandCam)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInVRMirror && isInVRMirror)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInDesktopMirror && isInDesktopMirror)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                #endif
            }
            

            void VRCLightVolumesCustomProbesSetup(MeshData d, inout SurfaceData o)
            {
                #if defined(INTEGRATE_VRCLIGHTVOLUMES) && !defined(ORL_LIGHTING_MODEL_UI)
                {
                    float3 L0, L1r, L1g, L1b;
                    LightVolumeSH(d.worldSpacePosition + d.worldNormal * _VRCLightVolumesSurfacePushoff, L0, L1r, L1g, L1b);
                    o.VRCLV_L0 = L0;
                    o.VRCLV_L1r = L1r;
                    o.VRCLV_L1g = L1g;
                    o.VRCLV_L1b = L1b;
            
                    // Since toon shaders can derive light directions from probes
                    // we need to directly modify these values
                    #if defined(ORL_LIGHTING_MODEL_TOON_V2)
                    unity_SHAr = float4(L1r, L0.r);
                    unity_SHAg = float4(L1g, L0.g);
                    unity_SHAb = float4(L1b, L0.b);
                    #endif
                }
                #endif
            }
            

            void VRCLightVolumesCustomProbes(SurfaceData o, MeshData d, inout half3 indirectDiffuse)
            {
                // Custom Probes
                #if defined(INTEGRATE_VRCLIGHTVOLUMES) && !defined(ORL_LIGHTING_MODEL_UI)
                {
                    #if defined(ORL_LIGHTING_MODEL_TOON_V2)
                    {
                        o.Normal = _IgnoreLightprobeNormal ? float3(0, 0.5, 0) : o.WorldNormal;
                    }
                    #endif
                    indirectDiffuse = LightVolumeEvaluate(o.Normal, o.VRCLV_L0, o.VRCLV_L1r, o.VRCLV_L1g, o.VRCLV_L1b);
                }
                #endif
            }
            

            void VRCLightVolumesCustomProbesBakedSpecular(SurfaceData o, MeshData d, inout half3 indirectSpecular, inout half3 bakedSpecularColor, inout half3 bakedDominantDirection)
            {
                #if defined(INTEGRATE_VRCLIGHTVOLUMES) && !defined(ORL_LIGHTING_MODEL_UI)
                bakedSpecularColor = o.VRCLV_L0;
                bakedDominantDirection = o.VRCLV_L1r.xyz + o.VRCLV_L1g.xyz + o.VRCLV_L1b.xyz;
                #endif
            }
            

            void VRCLightVolumesCustomGI(SurfaceData o, MeshData d, inout half3 indirectDiffuse)
            {
                #if defined(INTEGRATE_VRCLIGHTVOLUMES)
                {
                    #if defined(LIGHTMAP_ON)
                    {
                        float3 L0, L1r, L1g, L1b;
                        LightVolumeAdditiveSH(d.worldSpacePosition + d.worldNormal * _VRCLightVolumesSurfacePushoff, L0, L1r, L1g, L1b);
                        indirectDiffuse += LightVolumeEvaluate(o.Normal, L0, L1r, L1g, L1b);
                    }
                    #endif
                }
                #endif
            }
            

            void VRCLightVolumesColor(MeshData d, bool facing, inout half4 FinalColor)
            {
                #if !defined(UNITY_PASS_FORWARDBASE)
                return;
                #endif
                #if !defined(ORL_LIGHTING_MODEL_UI)
                return;
                #endif
            
                #if defined(INTEGRATE_VRCLIGHTVOLUMES)
                {
                    float3 L0, L1r, L1g, L1b;
                    float3 worldNormal = d.worldNormal;
                    if (!facing) {
                        worldNormal = -worldNormal;
                    }
                    LightVolumeSH(d.worldSpacePosition + worldNormal * _VRCLightVolumesSurfacePushoff, L0, L1r, L1g, L1b);
                    half3 indirectDiffuse = LightVolumeEvaluate(worldNormal, L0, L1r, L1g, L1b);
                    FinalColor.rgb *= indirectDiffuse;
                }
                #endif
            
            }
            

            void PosterDisplayFragment(FragmentData i, inout SurfaceData o)
            {
                fixed4 col = GetPosterColor(
                    i.uv0.xy,
                    _TimeOffset,
                    _DurationStatic,
                    _DurationEase,
                    _GridHorizontal,
                    _GridVertical,
                    _CellMargin,
                    _EaseFunction,
                    _EaseAnimation,
                    _PosterTex, _PosterTex_ST, _PosterTint,
                    _IdleTex, _IdleTex_ST, _IdleTint,
                    _Idling
                );
            
                o.Albedo *= col;
                o.Emission *= col;
            }
            

            
                void ALFragment(MeshData d, inout SurfaceData o)
                {
                    UNITY_BRANCH
                    if (_KillEffects) return;
            
                    UNITY_BRANCH
                    if (!AudioLinkIsAvailable()) return;
            
                    half3 finalEmission = 0;
                    half finalAlpha = 1;
                    float2 uv = 0;
                    switch(_ALUVChannel)
                    {
                        case 0: uv = d.uv0.xy; break;
                        case 1: uv = d.uv1.xy; break;
                        case 2: uv = d.uv2.xy; break;
                        case 3: uv = d.uv3.xy; break;
                    }
                    half4 mask = SAMPLE_TEXTURE2D(_ALMask, sampler_ALMask, uv);
                    
                    #if defined(AL_EFFECT_BAND_SELECTION)
            
                    half uvSource = lerp(uv.x, lerp(uv.y, lerp(1 - uv.x, 1 - uv.y, saturate(_BandScrollAxis - 2)), saturate(_BandScrollAxis - 1)), saturate(_BandScrollAxis));
                    half scaledUv = (uvSource * _BandHistoryRange) % 128.0;
                    half4 bandData = AudioLinkLerp(float2(scaledUv, clamp(_BandFrequency - 1, 0, 3)));
                    finalEmission = bandData.rgb * _ALTint;
                    finalAlpha = bandData.r;
            
                    #elif defined(AL_EFFECT_UV_BASED)
            
                    float2 scaledUv = float2(lerp(uv.x, uv.y, _UVFlipXY) * _UVHistoryRange % 128, floor(lerp(uv.y, uv.x, _UVFlipXY) * 4));
                    half4 bandData = AudioLinkLerp(scaledUv).rrra;
                    if (_UVUseThemeColors)
                    {
                        int band = clamp(floor(scaledUv.y), 0, 3);
                        switch(band)
                        {
                            case 0:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR0);
                                break;
                            case 1:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR1);
                                break;
                            case 2:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR2);
                                break;
                            case 3:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR3);
                                break;
                        }
                    }
                    finalEmission = bandData.rgb * _ALTint;
                    finalAlpha = bandData.r;
            
                    #elif defined(AL_EFFECT_WAVEFORM)
            
                    half noteno = abs(uv.x) * AUDIOLINK_ETOTALBINS;
                    half wvfrm = AudioLinkLerpMultiline(ALPASS_DFT + half2(noteno, 0)).z * _WVFRMScale;
                    half2 gradientUvs = uv;
                    if (_WVFRMFlipUVDirection) {
                        gradientUvs = half2(gradientUvs.y, gradientUvs.x);
                    }
                    half4 bottomColor = SAMPLE_TEXTURE2D(_WVFRMBottomColor, sampler_WVFRMBottomColor, gradientUvs);
                    half4 topColor = SAMPLE_TEXTURE2D(_WVFRMTopColor, sampler_WVFRMBottomColor, gradientUvs);
                    half4 midColor = SAMPLE_TEXTURE2D(_WVFRMMiddleColor, sampler_WVFRMBottomColor, gradientUvs);
                    half4 finalBlend = lerp(lerp(bottomColor, midColor, _WVFRMMiddleLine > 0 && lerp(uv.y, 1 - uv.y, _WVFRMFlip) > (wvfrm + _WVFRMOffset) - _WVFRMMiddleLineWidth), topColor, lerp(uv.y, 1 - uv.y, _WVFRMFlip) > (wvfrm + _WVFRMOffset));
                    finalEmission = finalBlend.rgb;
                    finalEmission *= _ALTint;
                    finalAlpha = finalBlend.a;
            
                    #elif defined(AL_EFFECT_PULSE)
            
                    half pulseData = 0;
                    UNITY_BRANCH
                    if (_PulseSmoothing == 0) {
                        pulseData = AudioLinkData(int2(0, clamp(_PulseBand - 1, 0, 3))).r;
                    } else {
                        pulseData = AudioLinkData(ALPASS_FILTEREDAUDIOLINK + int2(16 - _PulseSmoothing, clamp(_PulseBand - 1, 0, 3))).r;
                    }
                    if (_PulseMode == 0)
                    {
                        if (!_PulseEmissionMode)
                        {
                            finalEmission = o.Emission + pulseData * _ALTint * _PulseStrength;
                        }
                        else
                        {
                            finalEmission = o.Emission * pulseData * _ALTint * _PulseStrength;
                        }
                    }
                    else
                    {
                        finalEmission = pulseData * _PulseStrength * _ALTint;
                        if (_PulseTextureAdjustment == 0)
                        {
                            uv += _PulseTextureDirection.xy * pulseData;
                        }
                        else
                        {
                            float chrono = (AudioLinkDecodeDataAsUInt(ALPASS_CHRONOTENSITY + uint2(1, 0)) % 1000000) / 1000000.0;
                            uv += _PulseTextureDirection.xy * chrono;
                        }
                        finalEmission += SAMPLE_TEXTURE2D(_PulseTexture, sampler_PulseTexture, uv) * _ALTint;
                    }
            
                    #elif defined(AL_EFFECT_BAR)
            
                    float uvSource = lerp(uv.x, lerp(uv.y, lerp(1 - uv.x, 1 - uv.y, saturate(_BarAxis - 2)), saturate(_BarAxis - 1)), saturate(_BarAxis));
                    half3 color = SAMPLE_TEXTURE2D(_BarColor, sampler_BarColor, half2(uvSource, 0)).rgb;
                    half bandData = 0;
                    UNITY_BRANCH
                    if (_BarSmoothing == 0) {
                        bandData = saturate(AudioLinkData(int2(0, clamp(_BarBand - 1, 0, 3))).r * _BarScale);
                    } else {
                        bandData = saturate(AudioLinkData(ALPASS_FILTEREDAUDIOLINK + int2(16 - _BarSmoothing, clamp(_BarBand - 1, 0, 3))).r * _BarScale);
                    }
                    half barData = smoothstep((1 - bandData), (1 - bandData) + 0.01, uvSource);
                    finalEmission = lerp(0, barData.xxx * _ALTint.rgb * color.rgb, bandData);
                    finalAlpha = barData * bandData;
            
                    #endif
            
                    o.Emission = lerp(o.Emission, finalEmission, mask.r);
                    #if defined(AL_CUTOUT)
                    o.Alpha = finalAlpha;
                    #endif
                }
            

            void LTCGICustomGI(MeshData d, SurfaceData o, inout half3 customGISpecular, inout half3 customGIDiffuse)
            {
                #if !defined(ORL_LIGHTING_MODEL_VFX)
                {
                    #if defined(PLAT_QUEST)
                    if (!_LTCGIEnableOnMobile) return;
                    #endif
            
                    #if defined(INTEGRATE_LTCGI)
                        LTCGIAccumulatorStruct ltcgiData = (LTCGIAccumulatorStruct) 0;
            
                        LTCGI_Contribution(
                            ltcgiData,
                            d.worldSpacePosition.xyz,
                            o.Normal.xyz,
                            d.worldSpaceViewDir,
                            saturate((1 - o.Smoothness) + _LTCGIRoughnessModifier),
                            d.uv1.xy
                        );
            
                        if (_LTCGIClampBrightness) {
                            half3 hsv = RGB2HSV(ltcgiData.specular);
                            hsv.z = tanh(hsv.z) * max(0, _LTCGIMaxBrightness);
                            customGISpecular += HSV2RGB(hsv) * _LTCGISpecularIntensity;
                        } else {
                            customGISpecular += ltcgiData.specular * _LTCGISpecularIntensity;
                        }
                        customGIDiffuse += ltcgiData.diffuse * _LTCGIDiffuseIntensity;
                    #endif
                }
                #endif
            }
            

            void LTCGIColor(MeshData d, FragmentData i, inout half4 FinalColor, bool facing)
            {
                #if defined(ORL_LIGHTING_MODEL_VFX)
                {
                    #if defined(PLAT_QUEST)
                    if (!_LTCGIEnableOnMobile) return;
                    #endif
            
                    #if defined(INTEGRATE_LTCGI)
                        LTCGIAccumulatorStruct ltcgiData = (LTCGIAccumulatorStruct) 0;
            
                        float3 viewDir = d.worldSpaceViewDir;
                        if (!facing)
                        {
                            viewDir = -d.worldSpaceViewDir;
                        }
            
                        LTCGI_Contribution(
                            ltcgiData,
                            d.worldSpacePosition.xyz,
                            d.worldNormal.xyz,
                            viewDir,
                            saturate(0.5 + _LTCGIRoughnessModifier),
                            d.uv1.xy
                        );
            
                        if (_LTCGIClampBrightness) {
                            half3 hsv = RGB2HSV(ltcgiData.specular);
                            hsv.z = tanh(hsv.z) * max(0, _LTCGIMaxBrightness);
                            FinalColor.rgb += HSV2RGB(hsv) * _LTCGISpecularIntensity;
                        } else {
                            FinalColor.rgb += ltcgiData.specular * _LTCGISpecularIntensity;
                        }
                        FinalColor.rgb += ltcgiData.diffuse * _LTCGIDiffuseIntensity;
                        if (_LTCGIAlphaPremultiply)
                        {
                            FinalColor.rgb *= FinalColor.a;
                        }
                    #endif
                }
                #endif
            }
            

            void FragmentBase(MeshData d, FragmentData i, SurfaceData o, inout half4 FinalColor)
            {
                #if defined(UNITY_PASS_SHADOWCASTER)
                    return;
                #else
            
                half reflectance = 0.5;
                float oneMinusReflectivity = 1.0 - 0.04 - o.Metallic * (1.0 - 0.04);
                half3 f0 = 0.16 * reflectance * reflectance * oneMinusReflectivity + o.Albedo * o.Metallic;
            
                half3 indirectDiffuse = 0;
                half3 indirectSpecular = 0;
                    
                half occlusion = o.Occlusion;
            
                half perceptualRoughness = 1 - o.Smoothness;
            
                float3 tangentNormal = o.Normal;
            
                #if defined(SHADING_MODE_CLOTH)
                half3 albedoSqrt = sqrt(o.Albedo);
                #endif
                    
                o.Normal = Unity_SafeNormalize(mul(o.Normal, d.TBNMatrix));
            
                #ifndef USING_DIRECTIONAL_LIGHT
                float3 lightDir = Unity_SafeNormalize(UnityWorldSpaceLightDir(d.worldSpacePosition));
                #else
                float3 lightDir = Unity_SafeNormalize(_WorldSpaceLightPos0.xyz);
                #endif
            
                #if defined(GSAA)
                perceptualRoughness = GSAA_Filament(_GSAAIncludeNormalMaps ? o.Normal : d.worldNormal, perceptualRoughness, _GSAAVariance, _GSAAThreshold);
                #endif
            
                UNITY_LIGHT_ATTENUATION(lightAttenuation, i, d.worldSpacePosition);
                half3 lightColor = lightAttenuation * _LightColor0.rgb;
            
                float3 lightHalfVector = Unity_SafeNormalize(lightDir + d.worldSpaceViewDir);
                half lightNoL = saturate(dot(o.Normal, lightDir));
                half lightLoH = saturate(dot(lightDir, lightHalfVector));
            
                half NoV = abs(dot(o.Normal, d.worldSpaceViewDir)) + 1e-5;
            
                // Standard BRDF Setup
                half3 dfguv = half3(NoV, perceptualRoughness, 0);
                float2 dfg = SAMPLE_TEXTURE2D(_DFG, sampler_DFG, dfguv).xy;
                half3 energyCompensation = 1.0 + f0 * (1.0 / dfg.y - 1.0);
            
                float rough = perceptualRoughness * perceptualRoughness;
                half clampedRoughness = max(rough, ORL_MIN_ROUGHNESS);
            
                // Clear Coat BRDF Setup
                #if defined(CLEARCOAT)
                half3 clearcoatdfguv = 0;
                float2 clearcoatdfg = 0;
            
                float clearCoatAttenuation = 1.0;
                float clearCoatRoughness = 1.0 - _ClearCoatSmoothness;
                half clampedClearCoatRoughness = max(clearCoatRoughness * clearCoatRoughness, ORL_MIN_ROUGHNESS);
                half3 clearCoatMainLightSpecular = 0;
                half3 clearCoatIndirectSpecular = 0;
                #endif
            
                half3 mainLightDiffuse = 0;
                half3 mainLightSpecular = 0;
            
                mainLightDiffuse = Fd_Burley(perceptualRoughness, NoV, lightNoL, lightLoH);
            
                #if defined(SHADING_MODE_CLOTH)
                {
                    if (_ClothHasSubsurface)
                    {
                        mainLightDiffuse *= Fd_Wrap(dot(o.Normal, lightDir), 0.5);
                        mainLightDiffuse *= saturate(_ClothSubsurfaceColor.rgb + lightNoL);
                    } else {
                        mainLightDiffuse *= lightNoL;
                    }
                    mainLightDiffuse *= lightColor;
                }
                #else
                mainLightDiffuse *= lightColor * lightNoL;
                #endif
            
            
                // Collect Vertex Light Data and calculate direct diffuse
                #if defined(SHADE_VERTEXLIGHTS) &&defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                float4x4 vLightColors = getVertexLightsColors(d.worldSpacePosition, o.Normal, false);
                float4x4 vLightDirections = getVertexLightsDir(d.worldSpacePosition);
                float4x4 vLightHalfVectors = 0;
                float4 vLightNoLs = 0;
                float4 vLightLoHs = 0;
            
                half3 vertexLightDiffuse = 0;
                half3 vertexLightSpecular = 0;
                half3 clearCoatVertexLightSpecular = 0;
            
                [unroll(4)]
                for (int i = 0; i < 4; i++)
                {
                    vLightHalfVectors[i].rgb = Unity_SafeNormalize(vLightDirections[i] + d.worldSpaceViewDir);
                    vLightLoHs[i] = saturate(dot(vLightDirections[i], vLightHalfVectors[i]));
                    vLightNoLs[i] = saturate(dot(o.Normal, vLightDirections[i]));
            
                    half3 vLightDiffuse = Fd_Burley(perceptualRoughness, NoV, vLightNoLs[i], vLightLoHs[i]);
            
                    #if defined(SHADING_MODE_CLOTH)
                    {
                        if (_ClothHasSubsurface)
                        {
                            vLightColors[i].rgb *= Fd_Wrap(dot(o.Normal, vLightDirections[i]), 0.5);
                            vLightColors[i].rgb *= saturate(_ClothSubsurfaceColor.rgb + vLightNoLs[i]);
                        } else {
                            vLightDiffuse *= vLightNoLs[i];
                        }
                        vLightDiffuse *= vLightColors[i];
                    }
                    #else
                    vLightDiffuse *= vLightColors[i] * vLightNoLs[i];
                    #endif
            
                    vertexLightDiffuse += vLightDiffuse;
                }
                #endif
            
                // https://assetstore.unity.com/packages/tools/level-design/bakery-gpu-lightmapper-122218
                #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME)
                    BakeryVolumeData volumeData = (BakeryVolumeData) 0;
            
                    if (_Udon_GlobalVolumeAdapterEnabled == 1)
                    {
                        _GlobalVolumeMin = _Udon_GlobalVolumeMin;
                        _GlobalVolumeInvSize = _Udon_GlobalVolumeInvSize;
            
                        // Arbitrary rotation (runtime only)
                        #if defined(BAKERY_VOLROTATION)
                        _GlobalVolumeMatrix = _Udon_GlobalVolumeMatrix;
                        #endif
            
                        // Y Rotation (baked)
                        #if defined(BAKERY_VOLROTATIONY)
                        _GlobalVolumeRY = _Udon_GlobalVolumeRY;
                        #endif
                    }
                        
                    bool isGlobalVolume = _VolumeInvSize.x > 1000000; // ~inf
                    volumeData.viewDir = Unity_SafeNormalize(d.worldSpaceViewDir);
                        
                    // Runtime volume rotation
                    // Requires a special adapter to work in VRChat
                    #if defined(BAKERY_VOLROTATION)
                        float4x4 volMatrix = (isGlobalVolume ? _GlobalVolumeMatrix : _VolumeMatrix);
                        float3 volInvSize = (isGlobalVolume ? _GlobalVolumeInvSize : _VolumeInvSize);
                        volumeData.uv = mul(volMatrix, float4(d.worldSpacePosition,1)).xyz * volInvSize + 0.5f;
            
                        volumeData.normal = mul((float3x3)volMatrix, o.Normal);
                        volumeData.normal = Unity_SafeNormalize(volumeData.normal);
                            
                        #if defined(BAKED_SPECULAR)
                            volumeData.viewDir = mul((float3x3)volMatrix, volumeData.viewDir);
                        #endif
                    #else
                        volumeData.uv = d.worldSpacePosition - (isGlobalVolume ? _GlobalVolumeMin : _VolumeMin);
                        #if defined(BAKERY_VOLROTATIONY)
                            float2 sc = (isGlobalVolume ? _GlobalVolumeRY : _VolumeRY);
                            volumeData.uv.xz = mul(float2x2(sc.y, -sc.x, sc.x, sc.y), volumeData.uv.xz);
                        #endif
                        volumeData.uv *= (isGlobalVolume ? _GlobalVolumeInvSize : _VolumeInvSize);
                        volumeData.normal = o.Normal;
                    #endif
            
                    volumeData.occlusion = saturate(dot(_VolumeMask.Sample(sampler_VolumeMask, volumeData.uv), unity_OcclusionMaskSelector));
            
                    lightColor *= volumeData.occlusion;
                    mainLightDiffuse *= volumeData.occlusion;
            
                    #if defined(SHADE_VERTEXLIGHTS) &&defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                    {
                        vertexLightDiffuse *= volumeData.occlusion;
                    }
                    #endif
            
                #endif    
            
                // READ THE LIGHTMAP
                // Can be Baked, Realtime, both or either
                #if (defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)) && defined(UNITY_PASS_FORWARDBASE)
                    half3 lightMap = 0;
                    half4 bakedColorTex = 0;
                    half2 lightmapUV = d.lightmapUv.xy;
            
                    // explicitly checking for lightmap on because we can be in rtgi only mode
                    #if defined(LIGHTMAP_ON)
                        
                    // UNITY LIGHTMAPPING
                    #if !defined(BAKERYLM_ENABLED) || !defined(BAKERY_ENABLED)
                        lightMap = tex2DFastBicubicLightmap(lightmapUV, bakedColorTex);
                    #endif
            
                    // BAKERY RNM MODE
                    #if defined(BAKERY_RNM) && defined(BAKERY_ENABLED)
                        float3 rnm0 = DecodeLightmap(BakeryTex2D(_RNM0, sampler_RNM0, lightmapUV, _RNM0_TexelSize));
                        float3 rnm1 = DecodeLightmap(BakeryTex2D(_RNM1, sampler_RNM0, lightmapUV, _RNM0_TexelSize));
                        float3 rnm2 = DecodeLightmap(BakeryTex2D(_RNM2, sampler_RNM0, lightmapUV, _RNM0_TexelSize));
                            
                        lightMap = saturate(dot(rnmBasis0, tangentNormal)) * rnm0 +
                        saturate(dot(rnmBasis1, tangentNormal)) * rnm1 +
                        saturate(dot(rnmBasis2, tangentNormal)) * rnm2;
                    #endif
            
                    // BAKERY SH MODE (these are also used for the specular)
                    #if defined(BAKERY_SH) && defined(BAKERY_ENABLED)
                        half3 L0 = DecodeLightmap(BakeryTex2D(unity_Lightmap, samplerunity_Lightmap, lightmapUV, _RNM0_TexelSize));
                            
                        half3 nL1x = BakeryTex2D(_RNM0, sampler_RNM0, lightmapUV, _RNM0_TexelSize) * 2.0 - 1.0;
                        half3 nL1y = BakeryTex2D(_RNM1, sampler_RNM0, lightmapUV, _RNM0_TexelSize) * 2.0 - 1.0;
                        half3 nL1z = BakeryTex2D(_RNM2, sampler_RNM0, lightmapUV, _RNM0_TexelSize) * 2.0 - 1.0;
                        half3 L1x = nL1x * L0 * 2.0;
                        half3 L1y = nL1y * L0 * 2.0;
                        half3 L1z = nL1z * L0 * 2.0;
                            
                        // Non-Linear mode
                        #if defined(BAKERY_SHNONLINEAR)
                        half lumaL0 = dot(L0, half(1));
                        half lumaL1x = dot(L1x, half(1));
                        half lumaL1y = dot(L1y, half(1));
                        half lumaL1z = dot(L1z, half(1));
                        half lumaSH = shEvaluateDiffuseL1Geomerics(lumaL0, half3(lumaL1x, lumaL1y, lumaL1z), o.Normal);
                            
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        half regularLumaSH = dot(lightMap, 1.0);
                        lightMap *= lerp(1.0, lumaSH / regularLumaSH, saturate(regularLumaSH * 16.0));
                        #else
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        #endif
                    #endif
            
                    // Load directional lightmap
                    #if defined(DIRLIGHTMAP_COMBINED)
                        half4 lightMapDirection = tex2DFastBicubicSample(TEXTURE2D_ARGS(unity_LightmapInd, samplerunity_Lightmap), lightmapUV);
                        #if !defined(BAKERY_MONOSH)
                            lightMap = DecodeDirectionalLightmap(lightMap, lightMapDirection, o.Normal);
                        #endif
                    #endif
            
                    // Unity+Bakery often results in a full clear of DIRLIGHTMAP_COMBINED keyword
                    // which in turn results in no lightmap being applied when MONOSH is enabled
                    // this is an escape hatch for such a case to improve dev experience
                    #if defined(BAKERY_MONOSH) && defined(BAKERY_ENABLED) && !defined(DIRLIGHTMAP_COMBINED)
                        lightMap = tex2DFastBicubicLightmap(lightmapUV, bakedColorTex);
                    #endif
            
                    // Bakery MonoSH handling
                    #if defined(BAKERY_MONOSH) && defined(BAKERY_ENABLED) && defined(DIRLIGHTMAP_COMBINED)
                        half3 L0 = tex2DFastBicubicLightmap(lightmapUV, bakedColorTex);
                        half3 nL1 = lightMapDirection.xyz * 2.0 - 1.0;
                        half3 L1x = nL1.x * L0 * 2.0;
                        half3 L1y = nL1.y * L0 * 2.0;
                        half3 L1z = nL1.z * L0 * 2.0;
            
                        #if defined(BAKERY_SHNONLINEAR)
                        half lumaL0 = dot(L0, 1);
                        half lumaL1x = dot(L1x, 1);
                        half lumaL1y = dot(L1y, 1);
                        half lumaL1z = dot(L1z, 1);
                        half lumaSH = shEvaluateDiffuseL1Geomerics(lumaL0, half3(lumaL1x, lumaL1y, lumaL1z), o.Normal);
            
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        half regularLumaSH = dot(lightMap, 1);
                        lightMap *= lerp(1, lumaSH / regularLumaSH, saturate(regularLumaSH*16));
                        #else
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        #endif
            
                        lightMap = max(lightMap, 0.0);
                    #endif
            
                    #endif // defined(LIGHTMAP_ON)
            
                    // Handle RTGI specifically
                    #if defined(DYNAMICLIGHTMAP_ON) && !defined(PLAT_QUEST)
                        // only branch on non-meta passes
                        #if !defined(UNITY_PASS_META)
                        {
                            [branch]
                            if (!_IgnoreRealtimeGI) {
                                half3 realtimeLightMap = getRealtimeLightmap(d.lightmapUv.zw, o.Normal, _RealtimeGIDisableBicubic);
                                lightMap += realtimeLightMap;
                            }
                        }
                        #else
                        {
                            half3 realtimeLightMap = getRealtimeLightmap(d.lightmapUv.zw, o.Normal);
                            lightMap += realtimeLightMap;
                        }
                        #endif
                    #endif
            
                    #if defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN)
                        mainLightDiffuse = 0;
                        lightMap = SubtractMainLightWithRealtimeAttenuationFromLightmapMultiply(lightMap, lightAttenuation, bakedColorTex, o.Normal);
                    #endif
            
                    indirectDiffuse = lightMap;
            
                // Lightmapping end
            
                // Bakery Volume Sampling (replaces probes and LPPVs)
                #elif defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME) && defined(UNITY_PASS_FORWARDBASE)
                    // Sample the volume textures
                    volumeData = GetBakeryVolumeTextureData(volumeData);
                    // Sample using Geomerics approach, similar to lightprobes and LPPVs
                    indirectDiffuse = max(0, GetNonLinearSH(
                        volumeData.L0, 
                        float3(volumeData.L1x.r, volumeData.L1y.r, volumeData.L1z.r),
                        float3(volumeData.L1x.g, volumeData.L1y.g, volumeData.L1z.g),
                        float3(volumeData.L1x.b, volumeData.L1y.b, volumeData.L1z.b),
                        volumeData.normal)
                    );
            
                // Lightprobes Sampling
                #elif defined(UNITY_PASS_FORWARDBASE)
                    #if defined(_INTEGRATE_CUSTOMPROBES)
                    {
                        VRCLightVolumesCustomProbesSetup(d, o);
                    }
                    #endif
                    // LPPV support
                    #if UNITY_LIGHT_PROBE_PROXY_VOLUME
                    {
                        UNITY_BRANCH
                        if (unity_ProbeVolumeParams.x == 1)
                        {
                            indirectDiffuse = SHEvalLinearL0L1_SampleProbeVolume(half4(o.Normal, 1), d.worldSpacePosition);
                        }
                        else // Mesh has BlendProbes instead of LPPV
                        {
                            // Enable Integration of Custom Lightprobe solutions
                            #if defined(_INTEGRATE_CUSTOMPROBES)
                            {
                                VRCLightVolumesCustomProbes(o, d, indirectDiffuse);
                            }
                            #else
                            {
                                #if defined(NONLINEAR_SH)
                                {
                                    half3 L0 = half3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                                    half3 L0L2 = half3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0;
                                    L0 = L0+L0L2;
                                    indirectDiffuse = max(0, GetNonLinearSH(L0, unity_SHAr, unity_SHAg, unity_SHAb, o.Normal));
                                    indirectDiffuse += SHEvalLinearL2(float4(o.Normal, 1));
                                }
                                #else
                                {
                                    indirectDiffuse = max(0, ShadeSH9(half4(o.Normal, 1)));   
                                }
                                #endif
                            }
                            #endif
                        }
                    }
                    #else // No LPPVs enabled project-wide
                    {
                        // Enable Integration of Custom Lightprobe solutions
                        #if defined(_INTEGRATE_CUSTOMPROBES)
                        {
                            VRCLightVolumesCustomProbes(o, d, indirectDiffuse);
                        }
                        #else
                        {
                            #if defined(NONLINEAR_SH)
                            {
                                half3 L0 = half3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                                half3 L0L2 = half3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0;
                                L0 = L0+L0L2;
                                indirectDiffuse = max(0, GetNonLinearSH(L0, unity_SHAr, unity_SHAg, unity_SHAb, o.Normal));
                                indirectDiffuse += SHEvalLinearL2(float4(o.Normal, 1));
                            }
                            #else
                            {
                                indirectDiffuse = max(0, ShadeSH9(half4(o.Normal, 1)));   
                            }
                            #endif
                        }
                        #endif
                    }
                    #endif
                #endif // end of #if defined(LIGHTMAP_ON) && !defined(UNITY_PASS_FORWARDADD)
            
                // Attenuate main light diffuse by shadowmask
                float3 forwardShadows = 1;
                #if defined(LIGHTMAP_SHADOW_MIXING) && defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) && defined(LIGHTMAP_ON) && !defined(UNITY_PASS_FORWARDADD)
                {
                    forwardShadows = UnityComputeForwardShadows(d.lightmapUv.xy, d.worldSpacePosition, d.screenPos);
                    mainLightDiffuse *= forwardShadows;
                }
                #endif
            
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                clearcoatdfguv = half3(NoV, clearCoatRoughness, 0);
                clearcoatdfg = SAMPLE_TEXTURE2D(_DFG, sampler_DFG, clearcoatdfguv).xy;
            
                half clearCoatMask = _ClearCoatStrength;
                [branch]
                if (_HasClearCoatMask)
                {
                    clearCoatMask *= SAMPLE_TEXTURE2D(_ClearCoatMask, sampler_MainTex, d.uv0.xy * _ClearCoatMask_ST.xy + _ClearCoatMask_ST.zw)[_ClearCoatMaskChannel];
                }
                #endif
            
                // DIRECT REALTIME SPECULAR
                #if !defined(SPECULAR_HIGHLIGHTS_OFF) && defined(USING_LIGHT_MULTI_COMPILE)
                {
                    // Main Light
                    {
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            mainLightSpecular = GetSpecularHighlights(lightColor, f0, o.Normal, lightHalfVector, lightLoH, lightNoL, NoV, clampedRoughness, energyCompensation);
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            mainLightSpecular = GetSpecularHighlightsCloth(lightColor, o.Normal, lightHalfVector, lightNoL, NoV, clampedRoughness, energyCompensation, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                        }
                        #endif
            
                        mainLightSpecular *= lightNoL;
            
                        #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                        {
                            clearCoatMainLightSpecular = GetSpecularHighlightsClearCoat(lightColor, f0, d.worldNormal, lightHalfVector, lightLoH, clampedClearCoatRoughness, clearCoatMask, clearCoatAttenuation);
                            clearCoatMainLightSpecular *= saturate(dot(d.worldNormal, lightDir));
                        }
                        #endif
                    }
            
                    // Vertex Lights
                    #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                    {
                        [unroll(4)]
                        for (int i = 0; i < 4; i++)
                        {
                            #if defined(SHADING_MODE_DEFAULT)
                            {
                                vertexLightSpecular += vLightNoLs[i] * GetSpecularHighlights(vLightColors[i], f0, o.Normal, vLightHalfVectors[i], vLightLoHs[i], vLightNoLs[i], NoV, clampedRoughness, energyCompensation);
                            }
                            #elif defined(SHADING_MODE_CLOTH)
                            {
                                vertexLightSpecular += vLightNoLs[i] * GetSpecularHighlightsCloth(vLightColors[i], o.Normal, vLightHalfVectors[i], vLightNoLs[i], NoV, clampedRoughness, energyCompensation, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                            }
                            #endif
            
                            // Clear Coat
                            #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                            {
                                clearCoatVertexLightSpecular += GetSpecularHighlightsClearCoat(vLightColors[i], f0, d.worldNormal, vLightHalfVectors[i], vLightLoHs[i], clampedClearCoatRoughness, clearCoatMask, clearCoatAttenuation) * saturate(dot(d.worldNormal, vLightDirections[i]));
                            }
                            #endif
                        }
                    }
                    #endif
                }
                #endif
            
                // Attenuate main light specular by shadowmask
                #if defined(LIGHTMAP_SHADOW_MIXING) && defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) && defined(LIGHTMAP_ON) && !defined(UNITY_PASS_FORWARDADD)
                {
                    mainLightSpecular *= forwardShadows;
                }
                #endif
            
                // BAKED SPECULAR
                half3 bakedDirectSpecular = 0;
                #if defined(BAKED_SPECULAR) && !defined(BAKERYLM_ENABLED) && defined(UNITY_PASS_FORWARDBASE)
                {
                    half3 bakedDominantDirection = 1;
                    half3 bakedSpecularColor = 0;
            
                    // only do it if we have a directional lightmap
                    #if defined(DIRLIGHTMAP_COMBINED) && defined(LIGHTMAP_ON)
                    bakedDominantDirection = (lightMapDirection.xyz) * 2 - 1;
                    half directionality = max(0.001, length(bakedDominantDirection));
                    bakedDominantDirection /= directionality;
                    bakedSpecularColor = indirectDiffuse;
                    #endif
            
                    // if we do not have lightmap - derive the specular from probes
                    #if !defined(LIGHTMAP_ON)
                    bakedSpecularColor = half3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                    bakedDominantDirection = unity_SHAr.xyz + unity_SHAg.xyz + unity_SHAb.xyz;
            
                    // Enable Custom Lightprobes to write to baked specular
                    #if defined(_INTEGRATE_CUSTOMPROBES)
                    {
                        VRCLightVolumesCustomProbesBakedSpecular(o, d, indirectSpecular, bakedSpecularColor, bakedDominantDirection);
                    }
                    #endif
                    #endif
            
                    bakedDominantDirection = normalize(bakedDominantDirection);
                    #if defined(SHADING_MODE_DEFAULT)
                    {
                        bakedDirectSpecular = GetSpecularHighlights(o.Normal, bakedSpecularColor, bakedDominantDirection, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, energyCompensation);
                    }
                    #elif defined(SHADING_MODE_CLOTH)
                    {
                        bakedDirectSpecular = GetSpecularHighlightsCloth(o.Normal, bakedSpecularColor, bakedDominantDirection, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                    }
                    #endif
                }
                #endif
            
                // BAKERY DIRECT SPECULAR
                #if defined(LIGHTMAP_ON) && defined(BAKERY_LMSPEC) && defined(BAKERY_ENABLED) && defined(UNITY_PASS_FORWARDBASE)
                    #if defined(BAKERY_RNM)
                    {
                        float3 viewDirTangent = -Unity_SafeNormalize(d.tangentSpaceViewDir);
                        float3 dominantDirTangent = rnmBasis0 * dot(rnm0, lumaConv) +
                        rnmBasis1 * dot(rnm1, lumaConv) +
                        rnmBasis2 * dot(rnm2, lumaConv);
            
                        float3 dominantDirTangentNormalized = Unity_SafeNormalize(dominantDirTangent);
            
                        half3 specColor = saturate(dot(rnmBasis0, dominantDirTangentNormalized)) * rnm0 +
                        saturate(dot(rnmBasis1, dominantDirTangentNormalized)) * rnm1 +
                        saturate(dot(rnmBasis2, dominantDirTangentNormalized)) * rnm2;
            
                        float3 halfVector = Unity_SafeNormalize(dominantDirTangentNormalized - viewDirTangent);
                        float NoH = saturate(dot(tangentNormal, halfVector));
                        half3 F = 0
                        float D = 0;
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            F =  F_Schlick(NoV, f0);
                            D = D_GGX(NoH, lerp(1, clampedRoughness, _SpecularRoughnessMod)) * energyCompensation;
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            F = _ClothHasCustomSheen ? _ClothSheenColor : albedoSqrt;
                            D = D_Charlie(lerp(1, clampedRoughness, _SpecularRoughnessMod), NoH);
                        }
                        #endif
                        bakedDirectSpecular += D * specColor * F;
                    }
                    #endif
            
                    #if defined(BAKERY_SH)
                    {
                        half3 dominantDir = half3(dot(nL1x, lumaConv), dot(nL1y, lumaConv), dot(L1z, lumaConv));
                        half3 sh = L0 + dominantDir.x * L1x + dominantDir.y * L1y + dominantDir.z * L1z;
                        dominantDir = normalize(dominantDir);
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            bakedDirectSpecular += GetSpecularHighlights(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, energyCompensation);
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            bakedDirectSpecular += GetSpecularHighlightsCloth(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                        }
                        #endif
                    }
                    #endif
            
                    #if defined(BAKERY_MONOSH) && defined(DIRLIGHTMAP_COMBINED)
                    {
                        half3 dominantDir = nL1;
                        half3 sh = L0 + dominantDir.x * L1x + dominantDir.y * L1y + dominantDir.z * L1z;
                        dominantDir = normalize(dominantDir);
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            bakedDirectSpecular += GetSpecularHighlights(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, energyCompensation);
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            bakedDirectSpecular += GetSpecularHighlightsCloth(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                        }
                        #endif
                    }
                    #endif
                #endif // End of #if defined(BAKERY_LMSPEC) && defined(BAKERY_ENABLED) && !defined(UNITY_PASS_FORWARDADD)
            
                // BAKERY VOLUME SPECULAR
                #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME) && defined(BAKERY_LMSPEC) && defined(UNITY_PASS_FORWARDBASE)
                    BakeryVolumeSpecularData volumeSpecularData = GetBakeryVolumeSpecularData(volumeData);
                    #if defined(SHADING_MODE_DEFAULT)
                    {
                        bakedDirectSpecular += GetSpecularHighlights(volumeData.normal, volumeSpecularData.color, volumeSpecularData.direction, f0, volumeData.viewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), volumeSpecularData.NoV, energyCompensation);
                    }
                    #elif defined(SHADING_MODE_CLOTH)
                    {
                        bakedDirectSpecular += GetSpecularHighlightsCloth(volumeData.normal, volumeSpecularData.color, volumeSpecularData.direction, f0, volumeData.viewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), volumeSpecularData.NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                    }
                    #endif
                #endif
            
                // REFLECTIONS
                #if !defined(UNITY_PASS_FORWARDADD)
                float3 reflDir = reflect(-d.worldSpaceViewDir, o.Normal);
            
                // Box projection contact hardening is only available on PC
                #if !defined(PLAT_QUEST)
                {
                    // This is based on David M's improved box projection code https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections
                    // Licensed under MIT license, see https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections/blob/master/LICENSE for details
                    // Only used if probe is set to be box projected
                    if (_BoxProjectionContactHardening && unity_SpecCube0_ProbePosition.w > 0)
                    {
                        indirectSpecular = getEnvReflectionHardened(reflDir, d.worldSpacePosition, perceptualRoughness, _BoxProjectionContactHardeningStrength);
                    } else {
                        indirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, o.Normal, perceptualRoughness, -1);
                    }
                }
                #else
                {
                    indirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, o.Normal, perceptualRoughness, -1);
                }
                #endif
            
                half horizon = min(1 + dot(reflDir, o.Normal), 1);
                indirectSpecular *= horizon * horizon;
            
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                {
                    // Clear Coat uses a different roughness and a mesh normal instead of the normal map
                    reflDir = reflect(-d.worldSpaceViewDir, d.worldNormal);
            
                    // Box projection contact hardening is only available on PC
                    #if !defined(PLAT_QUEST)
                    {
                        // This is based on David M's improved box projection code https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections
                        // Licensed under MIT license, see https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections/blob/master/LICENSE for details
                        // Only used if probe is set to be box projected
                        if (_BoxProjectionContactHardening && unity_SpecCube0_ProbePosition.w > 0)
                        {
                            clearCoatIndirectSpecular = getEnvReflectionHardened(reflDir, d.worldSpacePosition, clearCoatRoughness, _BoxProjectionContactHardeningStrength);
                        } else {
                            clearCoatIndirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, d.worldNormal, clearCoatRoughness, -1);
                        }
                    }
                    #else
                    {
                        clearCoatIndirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, d.worldNormal, clearCoatRoughness, -1);
                    }
                    #endif
            
                    half clearCoatHorizon = min(1 + dot(reflDir, d.worldNormal), 1);
                    clearCoatIndirectSpecular *= clearCoatHorizon * clearCoatHorizon;
                    clearCoatIndirectSpecular *= clearCoatMask;
                }
                #endif
            
                half indirectSpecularOcclusion = saturate(length(indirectDiffuse) * (1.0 / _SpecOcclusion));
            
                // We should only add dfg _after_ we calculated spec occlusion factors
                half3 envBRDF = EnvBRDFMultiscatter(dfg, f0);
                indirectDiffuse *= 1.0 - envBRDF;
                indirectSpecular *= envBRDF;
            
                indirectSpecularOcclusion *= lerp(1, lightAttenuation, _RealtimeShadowSpecOcclusion);
            
                half computedSpecularOcclusion = computeSpecularAO(NoV, o.Occlusion * indirectSpecularOcclusion, clampedRoughness);
                computedSpecularOcclusion *= energyCompensation;
                    
                #if defined(BAKED_SPECULAR)
                {
                    bakedDirectSpecular *= saturate(lerp(1, computedSpecularOcclusion, _BakedSpecularOcclusion));
                }
                #endif
            
                indirectSpecular *= gtaoMultiBounce(computedSpecularOcclusion, f0);
            
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                {
                    half clearcoatNoV = abs(dot(d.worldNormal, d.worldSpaceViewDir)) + 1e-5;
                    computedSpecularOcclusion = computeSpecularAO(clearcoatNoV, o.Occlusion * indirectSpecularOcclusion, clampedRoughness);
                    computedSpecularOcclusion *= energyCompensation;
            
                    half3 envBRDF = EnvBRDFMultiscatter(clearcoatdfg, f0);
                    clearCoatIndirectSpecular *= envBRDF;
                    clearCoatIndirectSpecular *= gtaoMultiBounce(computedSpecularOcclusion, f0);
                }
                #endif
            
                #endif // !defined(UNITY_PASS_FORWARDADD)
            
                // Standard-Like transparent (premult alpha)
                if (_RenderType == 2)
                {
                    o.Albedo.rgb *= o.Alpha;
                    o.Alpha = 1 - (oneMinusReflectivity) + o.Alpha * (oneMinusReflectivity);
                }
            
                #if !defined(_NATIVE_A2C) || (!defined(UNITY_PASS_FORWARDBASE))
                {
                    // Standard-Like cutout
                    if (_RenderType == 1)
                    {
                        clip(o.Alpha - _Cutoff);
                    }
                }
                #endif
            
                FinalColor.rgb = o.Albedo.rgb * (oneMinusReflectivity);
            
                half3 customGIDiffuse = 0;
                half3 customGISpecular = 0;
                // Custom GI
                {
                    #if defined(_INTEGRATE_CUSTOMGI) && !defined(UNITY_PASS_FORWARDADD)
                    IntegrateCustomGI(d, o, indirectSpecular, indirectDiffuse);
                    #endif
            
                    #if defined (_INTEGRATE_CUSTOMGI_FLEX) && !defined(UNITY_PASS_FORWARDADD)
                    VRCLightVolumesCustomGI(o, d, indirectDiffuse);
            
                    LTCGICustomGI(d, o, customGISpecular, customGIDiffuse);
                    #endif
                }
            
                // Diffuse Contributions
                half3 diffuseContributions = 0;
                diffuseContributions += mainLightDiffuse;
                diffuseContributions += indirectDiffuse * occlusion;
                diffuseContributions += customGIDiffuse * occlusion;
            
                // Add vertex Lights
                #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                {
                    diffuseContributions += vertexLightDiffuse;
                }
                #endif
            
                // Specular Contributions
                half3 specularContributions = 0;
                specularContributions += mainLightSpecular;
                specularContributions += bakedDirectSpecular;
                specularContributions += indirectSpecular;
                specularContributions += customGISpecular;
            
                // Add vertex Lights
                #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                {
                    specularContributions += vertexLightSpecular;
                }
                #endif
            
                // Add clear coat layer
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                {
                    specularContributions += clearCoatMainLightSpecular;
                    specularContributions += clearCoatIndirectSpecular;
            
                    // Add vertex Lights
                    #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                    {
                        specularContributions += clearCoatVertexLightSpecular;
                    }
                #endif
                }
                #endif
            
                // Compositing
                FinalColor.rgb *= diffuseContributions;
                FinalColor.rgb += specularContributions;
            
                if (_RenderType > 1)
                {
                    FinalColor.a = o.Alpha;
                }
                    
                #if defined(UNITY_PASS_FORWARDBASE)
                FinalColor.rgb += o.Emission;
                #endif
            
                // Premulty output by alpha for correct `Fade` mode
                #if defined(UNITY_PASS_FORWARDADD)
                if (_RenderType == 3)
                {
                    FinalColor.rgb *= o.Alpha;
                }
                #endif
            
                #endif // shadowcaster check
            }
            

            void FragmentBaseMetaColor(inout SurfaceData o)
            {
                // Boost emissive for Meta (mostly for RTGI)
                #if defined(UNITY_PASS_META)
                o.Emission *= pow(_GIEmissiveBoost, 2.2);
                #endif
            }
            

            void FragmentBaseColorCorr(inout half4 FinalColor) {
                #if defined(APPLY_COLOR_CORRECTION) && defined(PLAT_QUEST)
                    
                #if defined(MOBILE_TONEMAP_ACES)
                FinalColor.rgb = Tonemap_ACES(FinalColor.rgb);
                #elif defined(MOBILE_TONEMAP_UNREAL)
                FinalColor.rgb = pow(Tonemap_Unreal(FinalColor.rgb), 2.2);
                #elif defined(MOBILE_TONEMAP_UNCHARTED)
                FinalColor.rgb = pow(Tonemap_Uncharted2(FinalColor.rgb),2.2);
                #endif
            
                FinalColor.rgb = applyLiftGammaGainEffect(FinalColor.rgb, _ColorCorrLift, _ColorCorrGamma, _ColorCorrGain);
                #endif
            }
            

            void PBRBaseShadow(SurfaceData o) {
                if (_RenderType == 1)
                {
                    clip(o.Alpha - _Cutoff);
                }
            }
            

            void VertexBase(inout VertexData v, inout FragmentData o)
            {
            
                #if defined(UNITY_PASS_META) && !defined(UNITY_PASS_BAKERY_META)
                o.pos = UnityMetaVertexPosition(v.vertex, v.uv1.xy, v.uv2.xy, unity_LightmapST, unity_DynamicLightmapST);
                #else
                o.pos = TransformObjectToHClip(v.vertex);
                #endif
                o.normal = v.normal;
                o.uv0 = v.uv0;
                o.uv1 = v.uv1;
                o.uv2 = v.uv2;
                o.uv3 = v.uv3;
                #if defined(NEED_UV4)
                o.uv4 = v.uv4;
                #endif
                #if defined(NEED_UV5)
                o.uv5 = v.uv5;
                #endif
                #if defined(NEED_UV6)
                o.uv6 = v.uv6;
                #endif
                #if defined(NEED_UV7)
                o.uv7 = v.uv7;
                #endif
                o.worldPos = mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1));
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldTangent.xyz = UnityObjectToWorldDir(v.tangent.xyz);
                o.worldTangent.w = v.tangent.w * unity_WorldTransformParams.w;
                o.vertexColor = v.color;
            
                #if defined(EDITOR_VISUALIZATION)
                o.vizUV = 0;
                o.lightCoord = 0;
                if (unity_VisualizationMode == EDITORVIZ_TEXTURE)
                {
                    o.vizUV = UnityMetaVizUV(unity_EditorViz_UVIndex, v.uv0.xy, v.uv1.xy, v.uv2.xy, unity_EditorViz_Texture_ST);
                }
                else if (unity_VisualizationMode == EDITORVIZ_SHOWLIGHTMASK)
                {
                    o.vizUV = v.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.lightCoord = mul(unity_EditorViz_WorldToLight, mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1)));
                }
                #endif
            
                #if defined(NEED_SCREEN_POS)
                o.screenPos = GetScreenPosition(o.pos);
                o.screenPos.z = -TransformWorldToView(TransformObjectToWorld(v.vertex)).z;
                #endif
            
                #if !defined(UNITY_PASS_META)
                    #if defined(LIGHTMAP_ON)
                    o.lightmapUv.xy = v.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    #endif
                    #if defined(DYNAMICLIGHTMAP_ON)
                    o.lightmapUv.zw = v.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                    #endif
            
                    UNITY_TRANSFER_LIGHTING(o, v.uv1.xy);
            
                    o.fogData.x = o.pos.z;
                    #if defined(FOG_EXP2)
                    o.fogData.y = 1;
                    #else
                    o.fogData.y = 0;
                    #endif
                #endif
            }
            

            // FreeFunctions

            // ForwardBase Vertex
            #if !defined(TESS_ENABLED)
            FragmentData Vertex(VertexData v)
            {
                UNITY_SETUP_INSTANCE_ID(v);
                FragmentData o;
                UNITY_INITIALIZE_OUTPUT(FragmentData, o);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                // Meta Vertex Chain
                VRCFeaturesVertex(v);

                // Meta VertexBase
                VertexBase(v, o);

                // Meta PostVertex Chain

                return o;
            }
            #endif

            // Meta Fragment
            half4 Fragment(FragmentData i, bool facing: SV_IsFrontFace
                #if defined(NEED_SV_DEPTH)
                , out float depth: SV_Depth
                #endif
                #if defined(NEED_SV_DEPTH_LEQUAL)
                , out float depth: SV_DepthLessEqual
                #endif
            ) : SV_TARGET
            {
                // Stub depth in case its not used
                #if !defined(NEED_SV_DEPTH) && !defined(NEED_SV_DEPTH_LEQUAL)
                float depth = 0;
                #endif
                UNITY_SETUP_INSTANCE_ID(i);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

                SurfaceData o = CreateSurfaceData();
                MeshData d = CreateMeshData(i, facing);
                // Meta pass only takes Albedo, Alpha and Emission
                half4 FinalColor = 1;

                // Meta Fragment Chain
                ParallaxFragment(d, i);

                PBRFragment(d, o);

                DetailsFragment(d, o);

                PosterDisplayFragment(i, o);

                ALFragment(d, o);

                FinalColor = half4(o.Albedo, o.Alpha);

                // Meta Color Chain
                VRCLightVolumesColor(d, facing, FinalColor);

                LTCGIColor(d, i, FinalColor, facing);

                FragmentBaseMetaColor(o);

                FragmentBaseColorCorr(FinalColor);

                UnityMetaInput metaIN;
                UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);

                metaIN.Albedo = FinalColor.rgb;
				metaIN.Emission = o.Emission;

                #if defined(EDITOR_VISUALISATION)
                metaIN.VizUV = i.vizUV;
                metaIN.LightCoord = i.lightCoord;
                #endif

                return UnityMetaFragment(metaIN);
            }

            ENDCG
            // Meta Pass End
        }

        Pass
        {
            Tags { "LightMode" = "ShadowCaster"  }

            // ShadowCaster Pass Start
            CGPROGRAM
            #pragma target 4.5
            #pragma multi_compile_instancing
            #pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_shadowcaster
            #pragma vertex Vertex
            #pragma fragment Fragment
            #pragma shader_feature_local_fragment _EMISSION
            
            #pragma shader_feature_local_fragment PARALLAX
            #pragma shader_feature_local_fragment _PARALLAXSTEPS_EIGHT _PARALLAXSTEPS_SIXTEEN _PARALLAXSTEPS_THIRTYTWO _PARALLAXSTEPS_SIXTYFOUR
            
            #pragma shader_feature_local_fragment DETAILS_OVERLAY
            #pragma shader_feature_local_fragment _ DETAILS_MODE_PACKED DETAILS_MODE_SEPARATED
            
            #pragma shader_feature_local_vertex VRC_FEATURES
            
               
             #pragma shader_feature_local_fragment VRCLIGHTVOLUMES
            
             // Global keyword to enable in the project
             #pragma shader_feature_fragment DISABLE_VRCLIGHTVOLUMES
            
            #pragma shader_feature_local_fragment _ AL_EFFECT_BAND_SELECTION AL_EFFECT_UV_BASED AL_EFFECT_WAVEFORM AL_EFFECT_PULSE AL_EFFECT_BAR
            
            #pragma shader_feature_local_fragment INTEGRATE_LTCGI
            
            #pragma shader_feature_local_fragment BAKERY_ENABLED
            #pragma shader_feature_local_fragment _ BAKERY_RNM BAKERY_SH BAKERY_MONOSH
            #pragma shader_feature_local_fragment BAKERY_SHNONLINEAR
            #pragma shader_feature_local_fragment BAKERY_VOLUME
            #pragma shader_feature_local_fragment BAKERY_COMPRESSED_VOLUME
            #pragma shader_feature_local_fragment BAKERY_VOLROTATIONY
            
            #pragma shader_feature_local_fragment BAKED_SPECULAR
            #pragma shader_feature_local_fragment GSAA
            #pragma shader_feature_local_fragment NONLINEAR_SH
            #pragma shader_feature_local_fragment SHADE_VERTEXLIGHTS
            #pragma shader_feature_local_fragment SHADING_MODE_DEFAULT SHADING_MODE_CLOTH
            #pragma shader_feature_local_fragment CLEARCOAT
                
            // PC Only Features
            #if !defined(UNITY_PBS_USE_BRDF2) && !defined(SHADER_API_MOBILE)
                #pragma shader_feature_local_fragment BICUBIC_LIGHTMAP
            #endif
            
            // Mobile Only Features
            #if defined(UNITY_PBS_USE_BRDF2) || defined(SHADER_API_MOBILE)
                #pragma shader_feature_local_fragment FORCE_BOX_PROJECTION
                #pragma shader_feature_local_fragment APPLY_COLOR_CORRECTION
                #pragma shader_feature_local_fragment MOBILE_TONEMAP_ACES MOBILE_TONEMAP_UNREAL MOBILE_TONEMAP_UNCHARTED
            #endif
            
            #if defined(SHADE_VERTEXLIGHTS)
                #pragma multi_compile_fragment _ VERTEXLIGHT_ON
            #endif
            
            #if !defined(MOBILE_TONEMAP_ACES) && !defined(MOBILE_TONEMAP_UNREAL) && !defined(MOBILE_TONEMAP_UNCHARTED)
                #define MOBILE_TONEMAP_ACES
            #endif

            #define UNITY_INSTANCED_LOD_FADE
            #define UNITY_INSTANCED_SH
            #define UNITY_INSTANCED_LIGHTMAPSTS

            #ifndef UNITY_PASS_SHADOWCASTER
                #define UNITY_PASS_SHADOWCASTER
            #endif

            #include "UnityPBSLighting.cginc"

            // ShaderDefines
            #define _MASKMAP_SAMPLED
            
            #if !defined(DETAILS_MODE_PACKED) && !defined(DETAILS_MODE_SEPARATED)
              #define DETAILS_MODE_PACKED
            #endif
            
            #define VRCLV_VERSION 2
            #define VRCLV_MAX_VOLUMES_COUNT 32
            #define VRCLV_MAX_LIGHTS_COUNT 128
            
            #if !defined(DISABLE_VRCLIGHTVOLUMES) && defined(VRCLIGHTVOLUMES)
                #define INTEGRATE_VRCLIGHTVOLUMES
            
                #define LV_PI 3.141592653589793f
                #define LV_PI2 6.283185307179586f
            
                #define _INTEGRATE_CUSTOMPROBES
                #define _INTEGRATE_CUSTOMGI_FLEX
            #endif
            
            #if !defined(AL_EFFECT_BAND_SELECTION) && !defined(AL_EFFECT_UV_BASED) && !defined(AL_EFFECT_WAVEFORM) && !defined(AL_EFFECT_PULSE) && !defined(AL_EFFECT_BAR)
            #define AL_EFFECT_NONE
            #endif
            
            #if defined(INTEGRATE_LTCGI)
                #define _INTEGRATE_CUSTOMGI_FLEX
            #endif
            
            #define INCLUDE_LTCGI defined(INTEGRATE_LTCGI)
            
            #if INCLUDE_LTCGI
                #include "Packages/at.pimaker.ltcgi/Shaders/LTCGI_structs.cginc"
            #endif
            
            #if !defined(LIGHTMAP_ON) || !defined(UNITY_PASS_FORWARDBASE)
              #undef BAKERY_SH
              #undef BAKERY_RNM
            #endif
            
            #ifdef LIGHTMAP_ON
              #undef BAKERY_VOLUME
            #endif
            
            #ifdef LIGHTMAP_ON
                #if defined(BAKERY_ENABLED)
                    #if defined(BAKERY_RNM) || defined(BAKERY_SH) || defined(BAKERY_VERTEXLM) || defined(BAKERY_MONOSH)
                        #define BAKERYLM_ENABLED
                        #if !defined(BAKERY_MONOSH)
                            #undef DIRLIGHTMAP_COMBINED
                        #endif
                    #endif
                #endif
            #endif
            
            #if defined(BAKERY_SH) || defined(BAKERY_RNM) || defined(BAKERY_VOLUME) || defined(BAKERY_MONOSH)
              #ifdef BAKED_SPECULAR
                #define _BAKERY_LMSPEC
                #define BAKERY_LMSPEC
              #endif
            #endif
            
            #define ORL_LIGHTING_MODEL_PBR
                
            #if defined(UNITY_PBS_USE_BRDF2) || defined(SHADER_API_MOBILE)
                #define PLAT_QUEST
            #else
                #ifdef PLAT_QUEST
                    #undef PLAT_QUEST
                #endif
            #endif
            
            #define ORL_MIN_ROUGHNESS 0.002025
            #if defined(PLAT_QUEST)
                #define ORL_MIN_ROUGHNESS 0.007921
            #endif
            
            #if !defined(SHADING_MODE_DEFAULT) && !defined(SHADING_MODE_CLOTH)
                #define SHADING_MODE_DEFAULT
            #endif
            
            #define NEED_SCREEN_POS
            #if !defined(NEED_FRAGMENT_IN_SHADOW)
                #define NEED_FRAGMENT_IN_SHADOW
            #endif
            #include "Assets/Xuan25/PosterDisplay/Shader/Inc/PosterDisplay.cginc"

            // DataStructs
            struct VertexData
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float4 color : COLOR;
                float4 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 uv2 : TEXCOORD2;
                float4 uv3 : TEXCOORD3;
                #if defined(NEED_UV4)
                float4 uv4 : TEXCOORD4;
                #endif
                #if defined(NEED_UV5)
                float4 uv5 : TEXCOORD5;
                #endif
                #if defined(NEED_UV6)
                float4 uv6 : TEXCOORD6;
                #endif
                #if defined(NEED_UV7)
                float4 uv7 : TEXCOORD7;
                #endif
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            
            struct FragmentData
            {
                #if defined(UNITY_PASS_SHADOWCASTER)
                V2F_SHADOW_CASTER;
                #else
                float4 pos : SV_POSITION;
                #endif
            
                float3 normal : RAW_NORMAL;
            
                #if !defined(NEED_FLOAT4_UV)
                // by default all UVs are float 2s
                float2 uv0 : TEXCOORD1;
                float2 uv1 : TEXCOORD2;
                float2 uv2 : TEXCOORD3;
                float2 uv3 : TEXCOORD4;
                #if defined(NEED_UV4)
                float2 uv4 : TEXCOORD5;
                #endif
                #if defined(NEED_UV5)
                float2 uv5 : TEXCOORD6;
                #endif
                #if defined(NEED_UV6)
                float2 uv6 : TEXCOORD7;
                #endif
                #if defined(NEED_UV7)
                float2 uv7 : TEXCOORD8;
                #endif
            
                #else // #if !defined(NEED_FLOAT4_UV)
            
                // Shaders can request to get float4 UVs using
                // #define NEED_FLOAT4_UV
                float4 uv0 : TEXCOORD1;
                float4 uv1 : TEXCOORD2;
                float4 uv2 : TEXCOORD3;
                float4 uv3 : TEXCOORD4;
                #if defined(NEED_UV4)
                float4 uv4 : TEXCOORD5;
                #endif
                #if defined(NEED_UV5)
                float4 uv5 : TEXCOORD6;
                #endif
                #if defined(NEED_UV6)
                float4 uv6 : TEXCOORD7;
                #endif
                #if defined(NEED_UV7)
                float4 uv7 : TEXCOORD8;
                #endif
            
                #endif // #if !defined(NEED_FLOAT4_UV)
            
                float3 worldPos : WORLD_POS;
                float3 worldNormal : WORLD_NORMAL;
                float4 worldTangent : WORLD_TANGENT;
            
                #if !defined(UNITY_PASS_SHADOWCASTER)
                float4 lightmapUv : LM_UV;
                #endif
            
                centroid float4 vertexColor : VERTEX_COLOR;
            
                #if !defined(UNITY_PASS_META)
                UNITY_LIGHTING_COORDS(9, 10)
                float2 fogData : FOG_DATA;
                #endif
            
                #if defined(EDITOR_VISUALIZATION)
                float2 vizUV : VIZ_UV;
                float4 lightCoord : LIGHT_COORD;
                #endif
            
                #if defined(NEED_SCREEN_POS)
                float4 screenPos: SCREENPOS;
                #endif
            
                #if defined(EXTRA_V2F_0)
                float4 extraV2F0 : EXTRA_V2F_BLOCK0;
                #endif
                #if defined(EXTRA_V2F_1)
                float4 extraV2F1 : EXTRA_V2F_BLOCK1;
                #endif
                #if defined(EXTRA_V2F_2)
                float4 extraV2F2 : EXTRA_V2F_BLOCK2;
                #endif
                #if defined(EXTRA_V2F_3)
                float4 extraV2F3 : EXTRA_V2F_BLOCK3;
                #endif
            
                // Additional Fragment Data
                
                // Additional Fragment Data End
            
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };
            
            struct LTCGIAccumulatorStruct {
                float3 diffuse;
                float3 specular;
            };
            
            #define LTCGI_V2_CUSTOM_INPUT LTCGIAccumulatorStruct
            
            struct SurfaceData
            {
                half3 Albedo;
                half3 Emission;
                half Metallic;
                half Smoothness;
                half Occlusion;
                float3 Normal;
                half Alpha;
            
                // Additional Surface Data
                #if defined(INTEGRATE_VRCLIGHTVOLUMES)
                float3 VRCLV_L0;
                float3 VRCLV_L1r;
                float3 VRCLV_L1g;
                float3 VRCLV_L1b;
                #endif
                // Additional Surface Data End
            };
            
            SurfaceData CreateSurfaceData()
            {
                SurfaceData o = (SurfaceData) 0;
                o.Albedo = 1;
                o.Occlusion = 1;
                o.Normal = float3(0, 0, 1);
                o.Smoothness = 0.5;
                o.Alpha = 1;
                return o;
            }
            
            struct MeshData
            {
                #if !defined(NEED_FLOAT4_UV)
                // by default all UVs are float 2s
                float2 uv0;
                float2 uv1;
                float2 uv2;
                float2 uv3;
                #if defined(NEED_UV4)
                float2 uv4;
                #endif
                #if defined(NEED_UV5)
                float2 uv5;
                #endif
                #if defined(NEED_UV6)
                float2 uv6;
                #endif
                #if defined(NEED_UV7)
                float2 uv7;
                #endif
            
                #else // #if !defined(NEED_FLOAT4_UV)
            
                // Shaders can request to get float4 UVs using
                // #define NEED_FLOAT4_UV
                float4 uv0;
                float4 uv1;
                float4 uv2;
                float4 uv3;
                #if defined(NEED_UV4)
                float4 uv4;
                #endif
                #if defined(NEED_UV5)
                float4 uv5;
                #endif
                #if defined(NEED_UV6)
                float4 uv6;
                #endif
                #if defined(NEED_UV7)
                float4 uv7;
                #endif
            
                #endif // #if !defined(NEED_FLOAT4_UV)
            
                #if !defined(UNITY_PASS_SHADOWCASTER)
                half4 lightmapUv;
                #endif
                half4 vertexColor;
                half3 normal;
                half3 worldNormal;
                half3 localSpacePosition;
                half3 worldSpacePosition;
                half3 worldSpaceViewDir;
                half3 tangentSpaceViewDir;
                float3x3 TBNMatrix;
                float4 extraV2F0;
                float4 extraV2F1;
                float4 extraV2F2;
                float4 extraV2F3;
                float4 screenPos;
            
                // Additional Mesh Data
                
                // Additional Mesh Data End
            };
            
            MeshData CreateMeshData(FragmentData i, bool facing)
            {
                MeshData d = (MeshData) 0;
                d.uv0 = i.uv0;
                d.uv1 = i.uv1;
                d.uv2 = i.uv2;
                d.uv3 = i.uv3;
                #if defined(NEED_UV4)
                d.uv4 = i.uv4;
                #endif
                #if defined(NEED_UV5)
                d.uv5 = i.uv5;
                #endif
                #if defined(NEED_UV6)
                d.uv6 = i.uv6;
                #endif
                #if defined(NEED_UV7)
                d.uv7 = i.uv7;
                #endif
                #if !defined(UNITY_PASS_SHADOWCASTER)
                d.lightmapUv = i.lightmapUv;
                #endif
                d.worldNormal = normalize(i.worldNormal);
                d.localSpacePosition = mul(unity_WorldToObject, float4(i.worldPos, 1)).xyz;
                d.worldSpacePosition = i.worldPos;
                d.worldSpaceViewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
            
                d.normal = i.normal;
                d.vertexColor = i.vertexColor;
            
                #if !defined(UNITY_PASS_SHADOWCASTER)
                float3 bitangent = cross(d.worldNormal, i.worldTangent.xyz) * (i.worldTangent.w > 0.0 ? 1.0 : - 1.0);
                d.TBNMatrix = float3x3(normalize(i.worldTangent.xyz), bitangent, d.worldNormal);
                d.TBNMatrix[2].xyz *= facing ? 1 : -1;
                d.tangentSpaceViewDir = mul(d.TBNMatrix, d.worldSpaceViewDir);
                #endif
            
                #if defined(EXTRA_V2F_0)
                d.extraV2F0 = i.extraV2F0;
                #endif
                #if defined(EXTRA_V2F_1)
                d.extraV2F1 = i.extraV2F1;
                #endif
                #if defined(EXTRA_V2F_2)
                d.extraV2F2 = i.extraV2F2;
                #endif
                #if defined(EXTRA_V2F_3)
                d.extraV2F3 = i.extraV2F3;
                #endif
                #if defined(NEED_SCREEN_POS)
                d.screenPos = i.screenPos;
                #endif
            
                // Additional Mesh Data Creator
                
                // Additional Mesh Data Creator End
            
                return d;
            }
            // GlobalVariables



            // Variables
            half4 _Color;
            half4 _MainTex_ST;
            int _AlbedoChannel;
            int _MappingSpace;
            int _PlanarAxisX;
            int _PlanarAxisY;
            int _MetalChannel;
            int _AOChannel;
            int _DetailMaskChannel;
            int _SmoothChannel;
            int _RoughnessMode;
            half _Smoothness;
            half _Metallic;
            half4 _MetallicRemap;
            half4 _SmoothnessRemap;
            half4 _MaskMap_TexelSize;
            half _OcclusionStrength;
            int _DetailAsTintMask;
            half _BumpScale;
            int _FlipBumpY;
            half4 _EmissionColor;
            int _EmissionChannel;
            float2 GLOBAL_uv;
            half4 GLOBAL_maskMap;
            #if defined(PARALLAX)
            half _HeightScale;
            half _HeightRefPlane;
            int _ParallaxScaleBasedOnAngle;
            #endif
            float2 GLOBAL_parallaxUv;
            half GLOBAL_heightMask;
            half GLOBAL_heightMaskSmoothing;
            int GLOBAL_heightSet;
            half GLOBAL_height; 
            #if defined(DETAILS_OVERLAY)
            int _DIgnoreMask;
            half4 _DDetailsMap_ST;
            int _DMappingSpace;
            int _DUVChannel;
            int _DPlanarAxisX;
            int _DPlanarAxisY;
            half _DAlbedoScale;
            half _DNormalScale;
            int _DNormalFlipY;
            half _DSmoothScale;
            int _DAlbedoMixingLegacy;
            #endif
            int _VRCHideInVR;
            int _VRCHideInDesktop;
            int _VRCHideInVRCamera;
            int _VRCHideInDesktopCamera;
            int _VRCHideInVRMirror;
            int _VRCHideInDesktopMirror;
            float _VRChatCameraMode;
            float _VRChatMirrorMode;
            #if defined(INTEGRATE_VRCLIGHTVOLUMES)
            float _VRCLightVolumesSurfacePushoff;
            cbuffer LightVolumeUniforms {
                float _UdonLightVolumeEnabled;
                float _UdonLightVolumeVersion;
                float _UdonLightVolumeCount;
                float _UdonLightVolumeAdditiveMaxOverdraw;
                float _UdonLightVolumeAdditiveCount;
                float _UdonLightVolumeProbesBlend;
                float _UdonLightVolumeSharpBounds;
                float4x4 _UdonLightVolumeInvWorldMatrix[VRCLV_MAX_VOLUMES_COUNT];
                float4 _UdonLightVolumeRotation[VRCLV_MAX_VOLUMES_COUNT * 2];
                float3 _UdonLightVolumeInvLocalEdgeSmooth[VRCLV_MAX_VOLUMES_COUNT];
                float3 _UdonLightVolumeUvw[VRCLV_MAX_VOLUMES_COUNT * 6];
                float4 _UdonLightVolumeOcclusionUvw[VRCLV_MAX_VOLUMES_COUNT];
                float4 _UdonLightVolumeColor[VRCLV_MAX_VOLUMES_COUNT];
                float _UdonPointLightVolumeCount;
                float _UdonPointLightVolumeCubeCount;
                float4 _UdonPointLightVolumePosition[VRCLV_MAX_LIGHTS_COUNT];
                float4 _UdonPointLightVolumeColor[VRCLV_MAX_LIGHTS_COUNT];
                float4 _UdonPointLightVolumeDirection[VRCLV_MAX_LIGHTS_COUNT];
                float3 _UdonPointLightVolumeCustomID[VRCLV_MAX_LIGHTS_COUNT];
                float _UdonLightBrightnessCutoff;
                float _UdonLightVolumeOcclusionCount;
            }
            #endif
            sampler2D _PosterTex;
            float4 _PosterTex_ST;
            float4 _PosterTint;
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
            int _ALUVChannel;
            int _BandFrequency;
            int _BandScrollAxis;
            half _BandHistoryRange;
            half _UVHistoryRange;
            int _UVFlipXY;
            int _UVUseThemeColors;
            int _WVFRMMiddleLine;
            half _WVFRMMiddleLineWidth;
            int _WVFRMFlip;
            half _WVFRMOffset;
            half _WVFRMScale;
            int _WVFRMFlipUVDirection;
            int _PulseBand;
            int _PulseSmoothing;
            int _PulseMode;
            half _PulseStrength;
            int _PulseEmissionMode;
            int _PulseTextureAdjustment;
            half4 _PulseTextureDirection;
            int _BarBand;
            int _BarSmoothing;
            int _BarAxis;
            half _BarScale;
            int _KillEffects;
            half4 _ALTint;
            int _LTCGIEnableOnMobile;
            int _LTCGIClampBrightness;
            half _LTCGIMaxBrightness;
            half _LTCGIDiffuseIntensity;
            half _LTCGISpecularIntensity;
            half _LTCGIRoughnessModifier;
            int _LTCGIAlphaPremultiply;
            #if defined(BAKERY_ENABLED)
                #if defined(BAKERY_RNM) || defined(BAKERY_SH)
            float4 _RNM0_TexelSize;
                #endif
            #endif
            #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME)
            half3 _VolumeMin;
            half3 _VolumeInvSize;
            half3 _GlobalVolumeMin;
            int _Udon_GlobalVolumeAdapterEnabled;
            half3 _Udon_GlobalVolumeMin;
            half3 _GlobalVolumeInvSize;
            half3 _Udon_GlobalVolumeInvSize;
            #if defined(BAKERY_VOLROTATION)
            float4x4 _GlobalVolumeMatrix;
            float4x4 _Udon_GlobalVolumeMatrix;
            float4x4 _VolumeMatrix;
            #endif
            #if defined(BAKERY_VOLROTATIONY)
            float2 _GlobalVolumeRY;
            float2 _Udon_GlobalVolumeRY;
            float2 _VolumeRY;
            #endif
            #endif
            #if defined(GSAA)
            half _GSAAVariance;
            half _GSAAThreshold;
            int _GSAAIncludeNormalMaps;
            #endif
            #if defined(APPLY_COLOR_CORRECTION)
            half _ColorCorrLift;
            half _ColorCorrGamma;
            half _ColorCorrGain;
            #endif
            #if defined(CLEARCOAT)
            half _ClearCoatStrength;
            float _ClearCoatSmoothness;
            half4 _ClearCoatMask_ST;
            int _ClearCoatMaskChannel;
            int _HasClearCoatMask;
            #endif
            #if defined(SHADING_MODE_CLOTH)
            int _ClothHasCustomSheen;
            half4 _ClothSheenColor;
            int _ClothHasSubsurface;
            half4 _ClothSubsurfaceColor;
            #endif
            half _SpecOcclusion;
            half _RealtimeShadowSpecOcclusion;
            float _BakedSpecularOcclusion;
            half _SpecularRoughnessMod;
            int _BoxProjectionContactHardening;
            half _BoxProjectionContactHardeningStrength;
            half _GIEmissiveBoost;
            int _IgnoreRealtimeGI;
            int _RealtimeGIDisableBicubic;
            int _RenderType;
            half _Cutoff;

            // Textures
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            TEXTURE2D(_MaskMap);
            SAMPLER(sampler_MaskMap);
            TEXTURE2D(_BumpMap);
            SAMPLER(sampler_BumpMap);
            TEXTURE2D(_EmissionMap);
            SAMPLER(sampler_EmissionMap);
            #if defined(PARALLAX)
            TEXTURE2D(_Height);
            SAMPLER(sampler_Height);
            #endif
            #if defined(DETAILS_OVERLAY)
            TEXTURE2D(_DDetailsMap);
            SAMPLER(sampler_DDetailsMap);
            TEXTURE2D(_DDetailsNormal);
            SAMPLER(sampler_DDetailsNormal);
            #endif
            #if defined(INTEGRATE_VRCLIGHTVOLUMES)
            TEXTURE3D(_UdonLightVolume);
            TEXTURE2D_ARRAY(_UdonPointLightVolumeTexture);
            SAMPLER(sampler_UdonLightVolume);
            #define LV_SAMPLE(tex, uvw) tex.SampleLevel(sampler_UdonLightVolume, uvw, 0)
            #endif
            TEXTURE2D(_ALMask);
            SAMPLER(sampler_ALMask);
            TEXTURE2D(_WVFRMBottomColor);
            TEXTURE2D(_WVFRMTopColor);
            TEXTURE2D(_WVFRMMiddleColor);
            SAMPLER(sampler_WVFRMBottomColor);
            TEXTURE2D(_PulseTexture);
            SAMPLER(sampler_PulseTexture);
            TEXTURE2D(_BarColor);
            SAMPLER(sampler_BarColor);
            #if defined(BAKERY_ENABLED)
                #if defined(BAKERY_RNM) || defined(BAKERY_SH)
            TEXTURE2D(_RNM0);
            TEXTURE2D(_RNM1);
            TEXTURE2D(_RNM2);
            SAMPLER(sampler_RNM0);
                #endif
            #endif
            #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME)
            TEXTURE3D(_Volume0);
            TEXTURE3D(_Volume1);
            TEXTURE3D(_Volume2);
            TEXTURE3D(_VolumeMask);
                #if defined(BAKERY_COMPRESSED_VOLUME)
            TEXTURE3D(_Volume3);
                #endif
            SAMPLER(sampler_Volume0);
            SAMPLER(sampler_VolumeMask);
            #endif
            TEXTURE2D(_DFG);
            SAMPLER(sampler_DFG);
            TEXTURE2D(_ClearCoatMask);

            // PassFunctions
            #if defined(INTEGRATE_VRCLIGHTVOLUMES)
            
            float LV_Smoothstep01(float x) {
                return x * x * (3 - 2 * x);
            }
            
            float3 LV_MultiplyVectorByQuaternion(float3 v, float4 q) {
                float3 t = 2.0 * cross(q.xyz, v);
                return v + q.w * t + cross(q.xyz, t);
            }
            
            float3 LV_MultiplyVectorByMatrix2x3(float3 v, float3 r0, float3 r1) {
                float3 r2 = cross(r0, r1);
                return float3(dot(v, r0), dot(v, r1), dot(v, r2));
            }
            
            float LV_FastAcos(float x) {
                float absX = abs(x); 
                float res = -0.156583f * absX + LV_PI * 0.5f;
                res *= sqrt(1.0f - absX); 
                return (x >= 0) ? res : (LV_PI - res);
            }
            
            float LV_DistributionGGX(float NoH, float roughness) {
                float f = (roughness - 1) * ((roughness + 1) * (NoH * NoH)) + 1;
                return (roughness * roughness) / ((float) LV_PI * f * f);
            }
            
            bool LV_PointLocalAABB(float3 localUVW) {
                return all(abs(localUVW) <= 0.5);
            }
            
            float3 LV_LocalFromVolume(uint volumeID, float3 worldPos) {
                return mul(_UdonLightVolumeInvWorldMatrix[volumeID], float4(worldPos, 1.0)).xyz;
            }
            
            float LV_EvaluateSH(float L0, float3 L1, float3 n) {
                return L0 + dot(L1, n);
            }
            
            float4 LV_SampleCubemapArray(uint id, float3 dir) {
                float3 absDir = abs(dir);
                float2 uv;
                uint face;
                if (absDir.x >= absDir.y && absDir.x >= absDir.z) {
                    face = dir.x > 0 ? 0 : 1;
                    uv = float2((dir.x > 0 ? -dir.z : dir.z), -dir.y) * rcp(absDir.x);
                } else if (absDir.y >= absDir.z) {
                    face = dir.y > 0 ? 2 : 3;
                    uv = float2(dir.x, (dir.y > 0 ? dir.z : -dir.z)) * rcp(absDir.y);
                } else {
                    face = dir.z > 0 ? 4 : 5;
                    uv = float2((dir.z > 0 ? dir.x : -dir.x), -dir.y) * rcp(absDir.z);
                }
                float3 uvid = float3(uv * 0.5 + 0.5, id * 6 + face);
                return LV_SAMPLE(_UdonPointLightVolumeTexture, uvid);
            }
            
            float4 LV_ProjectQuadLightIrradianceSH(float3 shadingPosition, float3 lightVertices[4]) {
                // Transform the vertices into local space centered on the shading position,
                // project, the polygon onto the unit sphere.
                [unroll] for (uint edge0 = 0; edge0 < 4; edge0++) {
                    lightVertices[edge0] = normalize(lightVertices[edge0] - shadingPosition);
                }
                
                // Precomputed directions of rotated zonal harmonics,
                // and associated weights for each basis function.
                // I.E. \omega_{l,d} and \alpha_{l,d}^m in the paper respectively.
                const float3 zhDir0 = float3(0.866025, -0.500001, -0.000004);
                const float3 zhDir1 = float3(-0.759553, 0.438522, -0.480394);
                const float3 zhDir2 = float3(-0.000002, 0.638694,  0.769461);
                const float3 zhWeightL1y = float3(2.1995339f, 2.50785367f, 1.56572711f);
                const float3 zhWeightL1z = float3(-1.82572523f, -2.08165037f, 0.00000000f);
                const float3 zhWeightL1x = float3(2.42459869f, 1.44790525f, 0.90397552f);
                
                float solidAngle = 0.0;
                float3 surfaceIntegral = 0.0;
                [loop] for (uint edge1 = 0; edge1 < 4; edge1++) {
                    uint next = (edge1 + 1) % 4;
                    uint prev = (edge1 + 4 - 1) % 4;
                    float3 prevVert = lightVertices[prev];
                    float3 thisVert = lightVertices[edge1];
                    float3 nextVert = lightVertices[next];
                
                    // Compute the solid angle subtended by the polygon at the shading position,
                    // using Arvo's formula (5.1) https://dl.acm.org/doi/pdf/10.1145/218380.218467.
                    // The L0 term is directly proportional to the solid angle.
                    float3 a = cross(thisVert, prevVert);
                    float3 b = cross(thisVert, nextVert);
                    float lenA = length(a);
                    float lenB = length(b);
                    solidAngle += LV_FastAcos(clamp(dot(a, b) / (lenA * lenB), -1, 1));
                
                    // Compute the integral of the legendre polynomials over the surface of the
                    // projected polygon for each zonal harmonic direction (S_l in the paper).
                    // Computed as a sum of line integrals over the edges of the polygon.
                    float3 mu = b * rcp(lenB);
                    float cosGamma = dot(thisVert, nextVert);
                    float gamma = LV_FastAcos(clamp(cosGamma, -1, 1));
                    surfaceIntegral.x += gamma * dot(zhDir0, mu);
                    surfaceIntegral.y += gamma * dot(zhDir1, mu);
                    surfaceIntegral.z += gamma * dot(zhDir2, mu);
                }
                solidAngle = solidAngle - LV_PI2;
                surfaceIntegral *= 0.5;
                
                // The L0 term is just the projection of the solid angle onto the L0 basis function.
                const float normalizationL0 = 0.5f * sqrt(1.0f / LV_PI);
                float l0 = normalizationL0 * solidAngle;
                    
                // Combine each surface (sub)integral with the associated weights to get
                // full surface integral for each L1 SH basis function.
                float l1y = dot(zhWeightL1y, surfaceIntegral);
                float l1z = dot(zhWeightL1z, surfaceIntegral);
                float l1x = dot(zhWeightL1x, surfaceIntegral);
                
                // The l0, l1y, l1z, l1x are raw SH coefficients for radiance from the polygon.
                // We need to apply some more transformations before we are done:
                // (1) We want the coefficients for irradiance, so we need to convolve with the
                //     clamped cosine kernel, as detailed in https://cseweb.ucsd.edu/~ravir/papers/envmap/envmap.pdf.
                //     The kernel has coefficients PI and 2/3*PI for L0 and L1 respectively.
                // (2) Unity's area lights underestimate the irradiance by a factor of PI for historical reasons.
                //     We need to divide by PI to match this 'incorrect' behavior.
                // (3) Unity stores SH coefficients (unity_SHAr..unity_SHC) pre-multiplied with the constant
                //     part of each SH basis function, so we need to multiply by constant part to match it.
                const float cosineKernelL0 = LV_PI; // (1)
                const float cosineKernelL1 = LV_PI2 / 3.0f; // (1)
                const float oneOverPi = 1.0f / LV_PI; // (2)
                const float normalizationL1 = 0.5f * sqrt(3.0f / LV_PI); // (3)
                const float weightL0 = cosineKernelL0 * normalizationL0 * oneOverPi; // (1), (2), (3)
                const float weightL1 = cosineKernelL1 * normalizationL1 * oneOverPi; // (1), (2), (3)
                l0  *= weightL0;
                l1y *= weightL1;
                l1z *= weightL1;
                l1x *= weightL1;
                    
                return float4(l1x, l1y, l1z, l0);
            }
            
            void LV_QuadLight(float3 worldPos, float3 centroidPos, float4 rotationQuat, float2 size, float3 color, float sqMaxDist, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float3 lightToWorldPos = worldPos - centroidPos;
                    
                // Normal culling
                float3 normal = LV_MultiplyVectorByQuaternion(float3(0, 0, 1), rotationQuat);
                [branch] if (dot(normal, lightToWorldPos) < 0.0) return;
                    
                // Attenuate the light based on distance to the bounding sphere, so we don't get hard seam at the edge.
                float sqCutoffDist = sqMaxDist - dot(lightToWorldPos, lightToWorldPos);
                color.rgb *= saturate(sqCutoffDist / sqMaxDist) * LV_PI * occlusion;
                        
                // Compute the vertices of the quad
                float2 halfSize = size * 0.5f;
                float3 xAxis = LV_MultiplyVectorByQuaternion(float3(1, 0, 0), rotationQuat);
                float3 yAxis = cross(normal, xAxis);
                float3 verts[4];
                verts[0] = centroidPos + (-halfSize.x * xAxis) + ( halfSize.y * yAxis);
                verts[1] = centroidPos + ( halfSize.x * xAxis) + ( halfSize.y * yAxis);
                verts[2] = centroidPos + ( halfSize.x * xAxis) + (-halfSize.y * yAxis);
                verts[3] = centroidPos + (-halfSize.x * xAxis) + (-halfSize.y * yAxis);
                
                // Project irradiance from the area light
                float4 areaLightSH = LV_ProjectQuadLightIrradianceSH(worldPos, verts);
                
                // If the magnitude of L1 is greater than L0, we may get negative values
                // when reconstructing. To avoid, normalize L1. This is effectively de-ringing.
                float lenL1 = length(areaLightSH.xyz);
                if (lenL1 > areaLightSH.w) areaLightSH.xyz *= areaLightSH.w / lenL1;
                    
                L0  += areaLightSH.w * color.rgb;
                L1r += areaLightSH.xyz * color.r;
                L1g += areaLightSH.xyz * color.g;
                L1b += areaLightSH.xyz * color.b;
                    
                count++;
            }
            
            float3 LV_PointLightAttenuation(float sqdist, float sqlightSize, float3 color, float brightnessCutoff, float sqMaxDist) {
                float mask = saturate(1 - sqdist / sqMaxDist);
                return mask * mask * color * sqlightSize / (sqdist + sqlightSize);
            }
            
            float LV_PointLightSolidAngle(float sqdist, float sqlightSize) {
                return saturate(sqrt(sqdist / (sqlightSize + sqdist)));
            }
            
            void LV_SphereLight(float sqdist, float3 dirN, float sqlightSize, float3 color, float occlusion, float sqMaxDist, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float3 att = LV_PointLightAttenuation(sqdist, sqlightSize, color, _UdonLightBrightnessCutoff, sqMaxDist);
                
                float3 l0 = att * occlusion;
                float3 l1 = dirN * LV_PointLightSolidAngle(sqdist, sqlightSize);
                    
                L0 += l0;
                L1r += l0.r * l1;
                L1g += l0.g * l1;
                L1b += l0.b * l1;
                count++;
                    
            }
            
            void LV_SphereSpotLight(float sqdist, float3 dirN, float sqlightSize, float3 att, float spotMask, float cosAngle, float coneFalloff, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float smoothedCone = LV_Smoothstep01(saturate(spotMask * coneFalloff));
                float3 l0 = att * (occlusion * smoothedCone);
                float3 l1 = dirN * LV_PointLightSolidAngle(sqdist, sqlightSize * saturate(1 - cosAngle));
                    
                L0 += l0;
                L1r += l0.r * l1;
                L1g += l0.g * l1;
                L1b += l0.b * l1;
                count++;
                    
            }
            
            void LV_SphereSpotLightCookie(float sqdist, float3 dirN, float sqlightSize, float3 att, float4 lightRot, float tanAngle, uint customId, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float3 localDir = LV_MultiplyVectorByQuaternion(-dirN, lightRot);
                float2 uv = localDir.xy * rcp(localDir.z * tanAngle);
                [branch] if (
                    localDir.z <= 0.0 || // Culling by direction
                    abs(uv.x) > 1.0 || abs(uv.y) > 1.0 // Culling by UV
                ) return;
                        
                uint id = (uint) _UdonPointLightVolumeCubeCount * 5 - customId - 1;
                float3 uvid = float3(uv * 0.5 + 0.5, id);        
                float angleSize = saturate(rsqrt(1 + tanAngle * tanAngle));
                float4 cookie = LV_SAMPLE(_UdonPointLightVolumeTexture, uvid);
                        
                float3 l0 = att * cookie.rgb * (cookie.a * occlusion);
                float3 l1 = dirN * LV_PointLightSolidAngle(sqdist, sqlightSize * (1 - angleSize));
                    
                L0 += l0;
                L1r += l0.r * l1;
                L1g += l0.g * l1;
                L1b += l0.b * l1;
                count++;
                    
            }
            
            void LV_SphereSpotLightAttenuationLUT(float sqdist, float3 dirN, float sqlightSize, float3 color, float spotMask, float cosAngle, uint customId, float occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                float dirRadius = sqdist * abs(sqlightSize);
                float spot = 1 - saturate(spotMask * rcp(1 - cosAngle));
                uint id = (uint) _UdonPointLightVolumeCubeCount * 5 + customId - 1;
                float3 uvid = float3(sqrt(float2(spot, dirRadius)), id);
                float3 att = color.rgb * LV_SAMPLE(_UdonPointLightVolumeTexture, uvid).xyz * occlusion;
                    
                L0 += att;
                L1r += dirN * att.r;
                L1g += dirN * att.g;
                L1b += dirN * att.b;
                    
                count++;
                    
            }
            
            void LV_PointLight(uint id, float3 worldPos, float4 occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, inout uint count) {
                    
                // IDs and range data
                float3 customID_data = _UdonPointLightVolumeCustomID[id];
                int shadowId = (int) customID_data.y; // Shadowmask id
                int customId = (int) customID_data.x; // Custom Texture ID
                float sqrRange = customID_data.z; // Squared culling distance
                    
                float4 pos = _UdonPointLightVolumePosition[id]; // Light position and inversed squared range 
                float3 dir = pos.xyz - worldPos;
                float sqlen = max(dot(dir, dir), 1e-6);
                [branch] if (sqlen > sqrRange) return; // Early distance based culling
                float3 dirN = dir * rsqrt(sqlen);
                    
                // Processing lights occlusion
                float lightOcclusion = 1;
                if (_UdonLightVolumeOcclusionCount != 0 && shadowId >= 0) {
                    lightOcclusion = dot(occlusion, float4(shadowId == 0, shadowId == 1, shadowId == 2, shadowId == 3));
                }
                    
                float4 color = _UdonPointLightVolumeColor[id]; // Color, angle
                float4 ldir = _UdonPointLightVolumeDirection[id]; // Dir + falloff or Rotation
                    
                [branch] if (pos.w < 0) { // It is a spot light
                
                    float angle = color.w;
                    float spotMask = dot(ldir.xyz, -dirN) - angle;
                    [branch] if(customId >= 0 && spotMask < 0) return; // Spot cone based culling
                        
                    [branch] if (customId > 0) {  // If it uses Attenuation LUT
                            
                        LV_SphereSpotLightAttenuationLUT(sqlen, dirN, -pos.w, color.rgb, spotMask, angle, customId, lightOcclusion, L0, L1r, L1g, L1b, count);
                            
                    } else { // If it uses default parametric attenuation
                
                        float3 att = LV_PointLightAttenuation(sqlen, -pos.w, color.rgb, _UdonLightBrightnessCutoff, sqrRange);
                
                        [branch] if (customId < 0) { // If uses cookie
                                
                            LV_SphereSpotLightCookie(sqlen, dirN, -pos.w, att, ldir, angle, customId, lightOcclusion, L0, L1r, L1g, L1b, count);
                                
                        } else { // If it uses default parametric attenuation
                                
                            LV_SphereSpotLight(sqlen, dirN, -pos.w, att, spotMask, angle, ldir.w, lightOcclusion, L0, L1r, L1g, L1b, count);
                                
                        }
                            
                    }
                        
                } else if (color.w <= 1.5f) { // It is a point light
                        
                    [branch] if (customId > 0) { // Using LUT
                            
                        float invSqRange = abs(pos.w); // Sign of range defines if it's point light (positive) or a spot light (negative)
                        float dirRadius = sqlen * invSqRange;
                        uint id = (uint) _UdonPointLightVolumeCubeCount * 5 + customId;
                        float3 uvid = float3(sqrt(float2(0, dirRadius)), id);
                        float3 att = color.rgb * LV_SAMPLE(_UdonPointLightVolumeTexture, uvid).xyz * lightOcclusion;
                            
                        L0 += att;
                        L1r += dirN * att.r;
                        L1g += dirN * att.g;
                        L1b += dirN * att.b;
                            
                        count++;
                            
                    } else { // If it uses default parametric attenuation
                            
                        float3 l0 = 0, l1r = 0, l1g = 0, l1b = 0;
                        LV_SphereLight(sqlen, dirN, pos.w, color.rgb, lightOcclusion, sqrRange, l0, l1r, l1g, l1b, count);
                
                        float3 cubeColor = 1;
                        [branch] if (customId < 0) { // If it uses a cubemap
                            uint id = -customId - 1; // Cubemap ID starts from zero and should not take in count texture array slices count.
                            cubeColor = LV_SampleCubemapArray(id, LV_MultiplyVectorByQuaternion(dirN, ldir)).xyz;
                        }
                
                        L0 += l0 * cubeColor;
                        L1r += l1r * cubeColor.r;
                        L1g += l1g * cubeColor.g;
                        L1b += l1b * cubeColor.b;
                    }
                        
                } else { // It is an area light
                        
                    LV_QuadLight(worldPos, pos.xyz, ldir, float2(pos.w, color.w - 2.0f), color.rgb, sqrRange, lightOcclusion, L0, L1r, L1g, L1b, count);
                        
                }
                
            }
            
            void LV_SampleLightVolumeTex(float3 uvw0, float3 uvw1, float3 uvw2, out float3 L0, out float3 L1r, out float3 L1g, out float3 L1b) {
                // Sampling 3D Atlas
                float4 tex0 = LV_SAMPLE(_UdonLightVolume, uvw0);
                float4 tex1 = LV_SAMPLE(_UdonLightVolume, uvw1);
                float4 tex2 = LV_SAMPLE(_UdonLightVolume, uvw2);
                // Packing final data
                L0 = tex0.rgb;
                L1r = float3(tex1.r, tex2.r, tex0.a);
                L1g = float3(tex1.g, tex2.g, tex1.a);
                L1b = float3(tex1.b, tex2.b, tex2.a);
            }
            
            float LV_BoundsMask(float3 localUVW, float3 invLocalEdgeSmooth) {
                float3 distToMin = (localUVW + 0.5) * invLocalEdgeSmooth;
                float3 distToMax = (0.5 - localUVW) * invLocalEdgeSmooth;
                float3 fade = saturate(min(distToMin, distToMax));
                return fade.x * fade.y * fade.z;
            }
            
            void LV_SampleLightProbe(inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b) {
                L0 += float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                L1r += unity_SHAr.xyz;
                L1g += unity_SHAg.xyz;
                L1b += unity_SHAb.xyz;
            }
            
            void LV_SampleLightProbeDering(inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b) {
                L0 += float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                L1r += unity_SHAr.xyz * 0.565f;
                L1g += unity_SHAg.xyz * 0.565f;
                L1b += unity_SHAb.xyz * 0.565f;
            }
            
            void LV_SampleVolume(uint id, float3 localUVW, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, out float4 occlusion) {
                    
                // Additive UVW
                //uint uvwID = id * 3;
                //float4 uvwPos0 = _UdonLightVolumeUvwScale[uvwID];
                //float4 uvwPos1 = _UdonLightVolumeUvwScale[uvwID + 1];
                //float4 uvwPos2 = _UdonLightVolumeUvwScale[uvwID + 2];
                //float3 uvwScale = float3(uvwPos0.w, uvwPos1.w, uvwPos2.w);
                    
                //float3 uvwScaled = saturate(localUVW + 0.5) * uvwScale;
                //float3 uvw0 = uvwPos0.xyz + uvwScaled;
                //float3 uvw1 = uvwPos1.xyz + uvwScaled;
                //float3 uvw2 = uvwPos2.xyz + uvwScaled;
                    
                // Legacy! Commented code above will be used in future releases! Legacy!
                uint uvwID = id * 6;
                float3 uvwScaled = saturate(localUVW + 0.5) * (_UdonLightVolumeUvw[uvwID + 1].xyz - _UdonLightVolumeUvw[uvwID].xyz);
                float3 uvw0 = uvwScaled + _UdonLightVolumeUvw[uvwID].xyz;
                float3 uvw1 = uvwScaled + _UdonLightVolumeUvw[uvwID + 2].xyz;
                float3 uvw2 = uvwScaled + _UdonLightVolumeUvw[uvwID + 4].xyz;
                    
                // Sample additive
                float3 l0, l1r, l1g, l1b;
                LV_SampleLightVolumeTex(uvw0, uvw1, uvw2, l0, l1r, l1g, l1b);
                
                // Sample occlusion
                float4 uvwOcclusion = _UdonLightVolumeOcclusionUvw[id];
                [branch] if (uvwOcclusion.x >= 0) {
                    occlusion = 1.0f - LV_SAMPLE(_UdonLightVolume, uvwOcclusion.xyz + uvwScaled * uvwOcclusion.w);
                } else {
                    occlusion = 1;
                }
                    
                // Color correction
                float4 color = _UdonLightVolumeColor[id];
                L0 += l0 * color.rgb;
                l1r *= color.r;
                l1g *= color.g;
                l1b *= color.b;
                    
                // Rotate if needed
                if (color.a != 0) {
                    //float4 r = _UdonLightVolumeRotationQuaternion[id];
                    //L1r = LV_MultiplyVectorByQuaternion(L1r, r);
                    //L1g = LV_MultiplyVectorByQuaternion(L1g, r);
                    //L1b = LV_MultiplyVectorByQuaternion(L1b, r);
                        
                    // Legacy to support older light volumes worlds! Commented code above will be used in future releases! Legacy!
                    float3 r0 = _UdonLightVolumeRotation[id * 2].xyz;
                    float3 r1 = _UdonLightVolumeRotation[id * 2 + 1].xyz;
                    L1r += LV_MultiplyVectorByMatrix2x3(l1r, r0, r1);
                    L1g += LV_MultiplyVectorByMatrix2x3(l1g, r0, r1);
                    L1b += LV_MultiplyVectorByMatrix2x3(l1b, r0, r1);
                } else {
                    L1r += l1r;
                    L1g += l1g;
                    L1b += l1b;
                }
                                
            }
            
            float4 LV_SampleVolumeOcclusion(uint id, float3 localUVW) {
                    
                // Sample occlusion
                float4 uvwOcclusion = _UdonLightVolumeOcclusionUvw[id];
                    
                [branch] if (uvwOcclusion.x >= 0) {
                    //uint uvwID = id * 3;
                    //float4 uvwPos0 = _UdonLightVolumeUvwScale[uvwID];
                    //float4 uvwPos1 = _UdonLightVolumeUvwScale[uvwID + 1];
                    //float4 uvwPos2 = _UdonLightVolumeUvwScale[uvwID + 2];
                    //float3 uvwScale = float3(uvwPos0.w, uvwPos1.w, uvwPos2.w);
                    //float3 uvwScaled = saturate(localUVW + 0.5) * uvwScale;
                        
                    // Legacy to support older light volumes worlds! Commented code above will be used in future releases! Legacy!
                    uint uvwID = id * 6;
                    float3 uvwScaled = saturate(localUVW + 0.5) * (_UdonLightVolumeUvw[uvwID + 1].xyz - _UdonLightVolumeUvw[uvwID].xyz);
                        
                    return 1.0f - LV_SAMPLE(_UdonLightVolume, uvwOcclusion.xyz + uvwScaled * uvwOcclusion.w);
                } else {
                    return 1;
                }
                    
            }
            
            void LV_PointLightVolumeSH(float3 worldPos, float4 occlusion, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b) {
                    
                uint pointCount = min((uint) _UdonPointLightVolumeCount, VRCLV_MAX_LIGHTS_COUNT);
                [branch] if (pointCount == 0) return;
                    
                uint maxOverdraw = min((uint) _UdonLightVolumeAdditiveMaxOverdraw, VRCLV_MAX_LIGHTS_COUNT);
                uint pcount = 0; // Point lights counter
                
                [loop] for (uint pid = 0; pid < pointCount && pcount < maxOverdraw; pid++) {
                    LV_PointLight(pid, worldPos, occlusion, L0, L1r, L1g, L1b, pcount);
                }
                    
            }
            
            void LV_LightVolumeSH(float3 worldPos, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, out float4 occlusion) {
                
                // Initializing output variables
                occlusion = 1;
                float4 mOcclusion = 1; // Multiplicative occlusion. Applies on top of regular occlusion
                    
                // Clamping gloabal iteration counts
                uint volumesCount = min((uint) _UdonLightVolumeCount, VRCLV_MAX_VOLUMES_COUNT);
                    
                //if (_UdonLightVolumeVersion < VRCLV_VERSION || volumesCount == 0 ) { // Fallback to default light probes if Light Volume are not enabled or a version is too old to have a support
                [branch] if (volumesCount == 0) { // Legacy! Fallback to default light probes if Light Volume are not enabled or a version is too old to have a support. Legacy!
                    LV_SampleLightProbe(L0, L1r, L1g, L1b);
                    return;
                }
                    
                uint maxOverdraw = min((uint) _UdonLightVolumeAdditiveMaxOverdraw, VRCLV_MAX_VOLUMES_COUNT);
                uint additiveCount = min((uint) _UdonLightVolumeAdditiveCount, VRCLV_MAX_VOLUMES_COUNT);
                bool lightProbesBlend = _UdonLightVolumeProbesBlend;
                    
                uint volumeID_A = -1; // Main, dominant volume ID
                uint volumeID_B = -1; // Secondary volume ID to blend main with
                
                float3 localUVW   = 0; // Last local UVW to use in disabled Light Probes mode
                float3 localUVW_A = 0; // Main local UVW
                float3 localUVW_B = 0; // Secondary local UVW
                    
                // Are A and B volumes NOT found?
                bool isNoA = true;
                bool isNoB = true;
                    
                // Additive volumes variables
                uint addVolumesCount = 0;
                    
                // Iterating through all light volumes with simplified algorithm requiring Light Volumes to be sorted by weight in descending order
                [loop] for (uint id = 0; id < volumesCount; id++) {
                    localUVW = LV_LocalFromVolume(id, worldPos);
                    [branch] if (LV_PointLocalAABB(localUVW)) { // Intersection test
                        [branch] if (id < additiveCount) { // Sampling additive volumes
                            [branch] if (addVolumesCount < maxOverdraw) {
                                float4 occ; // Multiplicative occlusion
                                LV_SampleVolume(id, localUVW, L0, L1r, L1g, L1b, occ);
                                mOcclusion *= occ;
                                addVolumesCount++;
                            } 
                        } else if (isNoA) { // First, searching for volume A
                            volumeID_A = id;
                            localUVW_A = localUVW;
                            isNoA = false;
                        } else { // Next, searching for volume B if A found
                            volumeID_B = id;
                            localUVW_B = localUVW;
                            isNoB = false;
                            break;
                        }
                    }
                }
                
                // If no volumes found, using Light Probes as fallback
                [branch] if (isNoA && lightProbesBlend) {
                    LV_SampleLightProbe(L0, L1r, L1g, L1b);
                    occlusion *= mOcclusion;
                    return;
                }
                        
                // Fallback to lowest weight light volume if outside of every volume
                localUVW_A = isNoA ? localUVW : localUVW_A;
                volumeID_A = isNoA ? volumesCount - 1 : volumeID_A;
                
                // Volume A SH components, occlusion, and mask to blend volume sides
                float3 L0_A  = 0;
                float3 L1r_A = 0;
                float3 L1g_A = 0;
                float3 L1b_A = 0;
                float4 occlusion_A = 1;
                    
                // Sampling Light Volume A
                LV_SampleVolume(volumeID_A, localUVW_A, L0_A, L1r_A, L1g_A, L1b_A, occlusion_A);
                    
                float mask = LV_BoundsMask(localUVW_A, _UdonLightVolumeInvLocalEdgeSmooth[volumeID_A]);
                [branch] if (mask == 1 || isNoA || (_UdonLightVolumeSharpBounds && isNoB)) { // Returning SH A result if it's the center of mask or out of bounds
                    L0  += L0_A;
                    L1r += L1r_A;
                    L1g += L1g_A;
                    L1b += L1b_A;
                    occlusion = occlusion_A;
                    occlusion *= mOcclusion;
                    return;
                }
                    
                // Volume B SH components and occlusion
                float3 L0_B  = 0;
                float3 L1r_B = 0;
                float3 L1g_B = 0;
                float3 L1b_B = 0;
                float4 occlusion_B = 1;
                
                [branch] if (isNoB && lightProbesBlend) { // No Volume found and light volumes blending enabled
                
                    // Sample Light Probes B
                    LV_SampleLightProbe(L0_B, L1r_B, L1g_B, L1b_B);
                
                } else { // Blending Volume A and Volume B
                            
                    // If no volume b found, use last one found to fallback
                    localUVW_B = isNoB ? localUVW : localUVW_B;
                    volumeID_B = isNoB ? volumesCount - 1 : volumeID_B;
                            
                    // Sampling Light Volume B
                    LV_SampleVolume(volumeID_B, localUVW_B, L0_B, L1r_B, L1g_B, L1b_B, occlusion_B);
                        
                }
                
                // Lerping occlusion
                occlusion = lerp(occlusion_B, occlusion_A, mask);
                occlusion *= mOcclusion;
                
                // Lerping SH components
                L0  += lerp(L0_B,  L0_A,  mask);
                L1r += lerp(L1r_B, L1r_A, mask);
                L1g += lerp(L1g_B, L1g_A, mask);
                L1b += lerp(L1b_B, L1b_A, mask);
                
            }
            
            void LV_LightVolumeAdditiveSH(float3 worldPos, inout float3 L0, inout float3 L1r, inout float3 L1g, inout float3 L1b, out float4 occlusion) {
                
                // Initializing output variables
                occlusion = 1;
                float4 mOcclusion = 1; // Multiplicative occlusion. Applies on top of regular occlusion
                    
                // Clamping gloabal iteration counts
                uint additiveCount = min((uint) _UdonLightVolumeAdditiveCount, VRCLV_MAX_VOLUMES_COUNT);
                //if (_UdonLightVolumeVersion < VRCLV_VERSION || (additiveCount == 0 && pointCount == 0)) return;
                [branch] if (additiveCount == 0 && (uint) _UdonPointLightVolumeCount == 0) return; // Legacy!
                
                uint volumesCount = min((uint) _UdonLightVolumeCount, VRCLV_MAX_VOLUMES_COUNT);
                uint maxOverdraw = min((uint) _UdonLightVolumeAdditiveMaxOverdraw, VRCLV_MAX_VOLUMES_COUNT);
                    
                uint volumeID_A = -1; // Main, dominant volume ID
                uint volumeID_B = -1; // Secondary volume ID to blend main with
                
                float3 localUVW   = 0; // Last local UVW to use in disabled Light Probes mode
                float3 localUVW_A = 0; // Main local UVW for Y Axis and Free rotations
                float3 localUVW_B = 0; // Secondary local UVW
                    
                // Are A and B volumes NOT found?
                bool isNoA = true;
                bool isNoB = true;
                    
                // Additive volumes variables
                uint addVolumesCount = 0;
                
                // Iterating through all light volumes with simplified algorithm requiring Light Volumes to be sorted by weight in descending order
                uint count = min(_UdonLightVolumeOcclusionCount == 0 ? additiveCount : volumesCount, VRCLV_MAX_VOLUMES_COUNT); // Only use all volumes if occlusion volumes are enabled
                [loop] for (uint id = 0; id < count; id++) {
                    localUVW = LV_LocalFromVolume(id, worldPos);
                    [branch] if (LV_PointLocalAABB(localUVW)) { // Intersection test
                        [branch] if (id < additiveCount) { // Sampling additive volumes
                            [branch] if (addVolumesCount < maxOverdraw) {
                                float4 occ; // Multiplicative occlusion
                                LV_SampleVolume(id, localUVW, L0, L1r, L1g, L1b, occ);
                                mOcclusion *= occ;
                                addVolumesCount++;
                            } 
                        } else if (isNoA) { // First, searching for volume A
                            volumeID_A = id;
                            localUVW_A = localUVW;
                            isNoA = false;
                        } else { // Next, searching for volume B if A found
                            volumeID_B = id;
                            localUVW_B = localUVW;
                            isNoB = false;
                            break;
                        }
                    }
                }
                
                // If no volumes found, or we don't need the occlusion data, we are done
                [branch] if (isNoA || _UdonLightVolumeOcclusionCount == 0) {
                    occlusion *= mOcclusion;
                    return;
                }
                    
                // Fallback to lowest weight light volume if outside of every volume
                localUVW_A = isNoA ? localUVW : localUVW_A;
                volumeID_A = isNoA ? volumesCount - 1 : volumeID_A;
                
                // Sampling Light Volume A
                occlusion = LV_SampleVolumeOcclusion(volumeID_A, localUVW_A);
                float mask = LV_BoundsMask(localUVW_A, _UdonLightVolumeInvLocalEdgeSmooth[volumeID_A]);
                    
                [branch] if (mask == 1 || (_UdonLightVolumeSharpBounds && isNoB)) {
                    occlusion *= mOcclusion;
                    return; // Returning A result if it's the center of mask or out of bounds
                }
                
                // Blending Volume A and Volume B
                [branch] if (isNoB) occlusion = lerp(1, occlusion, mask);
                else occlusion = lerp(LV_SampleVolumeOcclusion(volumeID_B, localUVW_B), occlusion, mask);
                
                occlusion *= mOcclusion;
                    
            }
            
            float3 LightVolumeSpecular(float3 f0, float smoothness, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                    
                float3 specColor = max(float3(dot(reflect(-L1r, worldNormal), viewDir), dot(reflect(-L1g, worldNormal), viewDir), dot(reflect(-L1b, worldNormal), viewDir)), 0);
                    
                float3 rDir = normalize(normalize(L1r) + viewDir);
                float3 gDir = normalize(normalize(L1g) + viewDir);
                float3 bDir = normalize(normalize(L1b) + viewDir);
                    
                float rNh = saturate(dot(worldNormal, rDir));
                float gNh = saturate(dot(worldNormal, gDir));
                float bNh = saturate(dot(worldNormal, bDir));
                    
                float roughness = 1 - smoothness * 0.9f;
                float roughExp = roughness * roughness;
                    
                float rSpec = LV_DistributionGGX(rNh, roughExp);
                float gSpec = LV_DistributionGGX(gNh, roughExp);
                float bSpec = LV_DistributionGGX(bNh, roughExp);
                    
                float3 specs = (rSpec + gSpec + bSpec) * f0;
                float3 coloredSpecs = specs * specColor;
                    
                float3 a = coloredSpecs + specs * L0;
                float3 b = coloredSpecs * 3;
                    
                return max(lerp(a, b, smoothness) * 0.5f, 0.0);
                    
            }
            
            float3 LightVolumeSpecular(float3 albedo, float smoothness, float metallic, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                float3 specularf0 = lerp(0.04f, albedo, metallic);
                return LightVolumeSpecular(specularf0, smoothness, worldNormal, viewDir, L0, L1r, L1g, L1b);
            }
            
            float3 LightVolumeSpecularDominant(float3 f0, float smoothness, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                    
                float3 dominantDir = L1r + L1g + L1b;
                float3 dir = normalize(normalize(dominantDir) + viewDir);
                float nh = saturate(dot(worldNormal, dir));
                    
                float roughness = 1 - smoothness * 0.9f;
                float roughExp = roughness * roughness;
                    
                float spec = LV_DistributionGGX(nh, roughExp);
                    
                return max(spec * L0 * f0, 0.0) * 1.5f;
                    
            }
            
            float3 LightVolumeSpecularDominant(float3 albedo, float smoothness, float metallic, float3 worldNormal, float3 viewDir, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                float3 specularf0 = lerp(0.04f, albedo, metallic);
                return LightVolumeSpecularDominant(specularf0, smoothness, worldNormal, viewDir, L0, L1r, L1g, L1b);
            }
            
            float3 LightVolumeEvaluate(float3 worldNormal, float3 L0, float3 L1r, float3 L1g, float3 L1b) {
                return float3(LV_EvaluateSH(L0.r, L1r, worldNormal), LV_EvaluateSH(L0.g, L1g, worldNormal), LV_EvaluateSH(L0.b, L1b, worldNormal));
            }
            
            void LightVolumeSH(float3 worldPos, out float3 L0, out float3 L1r, out float3 L1g, out float3 L1b, float3 worldPosOffset = 0) {
                L0 = 0; L1r = 0; L1g = 0; L1b = 0;
                if (_UdonLightVolumeEnabled == 0) {
                    LV_SampleLightProbeDering(L0, L1r, L1g, L1b);
                } else {
                    float4 occlusion = 1;
                    LV_LightVolumeSH(worldPos + worldPosOffset, L0, L1r, L1g, L1b, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, L1r, L1g, L1b);
                }
            }
            
            void LightVolumeAdditiveSH(float3 worldPos, out float3 L0, out float3 L1r, out float3 L1g, out float3 L1b, float3 worldPosOffset = 0) {
                L0 = 0; L1r = 0; L1g = 0; L1b = 0;
                if (_UdonLightVolumeEnabled != 0) {
                    float4 occlusion = 1;
                    LV_LightVolumeAdditiveSH(worldPos + worldPosOffset, L0, L1r, L1g, L1b, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, L1r, L1g, L1b);
                }
            }
            
            float3 LightVolumeSH_L0(float3 worldPos, float3 worldPosOffset = 0) {
                if (_UdonLightVolumeEnabled == 0) {
                    return float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                } else {
                    float3 L0 = 0; float4 occlusion = 1;
                    float3 unused_L1; // Let's just pray that compiler will strip everything x.x
                    LV_LightVolumeSH(worldPos + worldPosOffset, L0, unused_L1, unused_L1, unused_L1, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, unused_L1, unused_L1, unused_L1);
                    return L0;
                }
            }
            
            float3 LightVolumeAdditiveSH_L0(float3 worldPos, float3 worldPosOffset = 0) {
                if (_UdonLightVolumeEnabled == 0) {
                    return 0;
                } else {
                    float3 L0 = 0; float4 occlusion = 1;
                    float3 unused_L1; // Let's just pray that compiler will strip everything x.x
                    LV_LightVolumeAdditiveSH(worldPos + worldPosOffset, L0, unused_L1, unused_L1, unused_L1, occlusion);
                    LV_PointLightVolumeSH(worldPos, occlusion, L0, unused_L1, unused_L1, unused_L1);
                    return L0;
                }
            }
            
            float LightVolumesEnabled() {
                return _UdonLightVolumeEnabled;
            }
            
            float LightVolumesVersion() {
                return _UdonLightVolumeVersion == 0 ? _UdonLightVolumeEnabled : _UdonLightVolumeVersion;
            }
            
            #endif
            
            #if INCLUDE_LTCGI
            
            void LTCGICallbackDiffuse(inout LTCGIAccumulatorStruct acc, in ltcgi_output output)
            {
                acc.diffuse += output.intensity * output.color;
            }
            
            void LTCGICallbackSpecular(inout LTCGIAccumulatorStruct acc, in ltcgi_output output)
            {
                acc.specular += output.intensity * output.color;
            }    
            
            #define LTCGI_V2_DIFFUSE_CALLBACK LTCGICallbackDiffuse
            #define LTCGI_V2_SPECULAR_CALLBACK LTCGICallbackSpecular
                
            #include "Packages/at.pimaker.ltcgi/Shaders/LTCGI.cginc"
            #endif
            
            // Bakery volume helpers
            #if defined(BAKERY_ENABLED)
            #if defined(BAKERY_VOLUME)
            BakeryVolumeData GetBakeryVolumeTextureData(BakeryVolumeData data)
            {
                #ifdef BAKERY_COMPRESSED_VOLUME
                    data.tex0 = _Volume0.Sample(sampler_Volume0, data.uv);
                    data.tex1 = _Volume1.Sample(sampler_Volume0, data.uv) * 2 - 1;
                    data.tex2 = _Volume2.Sample(sampler_Volume0, data.uv) * 2 - 1;
                    data.tex3 = _Volume3.Sample(sampler_Volume0, data.uv) * 2 - 1;
                    data.L0 = data.tex0.xyz;
                    data.L1x = data.tex1.xyz * data.L0 * 2;
                    data.L1y = data.tex2.xyz * data.L0 * 2;
                    data.L1z = data.tex3.xyz * data.L0 * 2;
                #else
                    data.tex0 = _Volume0.Sample(sampler_Volume0, data.uv);
                    data.tex1 = _Volume1.Sample(sampler_Volume0, data.uv);
                    data.tex2 = _Volume2.Sample(sampler_Volume0, data.uv);
                    data.L0 = data.tex0.xyz;
                    data.L1x = data.tex1.xyz;
                    data.L1y = data.tex2.xyz;
                    data.L1z = float3(data.tex0.w, data.tex1.w, data.tex2.w);
                #endif
                return data;
            }
            
            BakeryVolumeSpecularData GetBakeryVolumeSpecularData(BakeryVolumeData data)
            {
                BakeryVolumeSpecularData ret = (BakeryVolumeSpecularData) 0;
            
                float3 nL1x = data.L1x / data.L0;
                float3 nL1y = data.L1y / data.L0;
                float3 nL1z = data.L1z / data.L0;
                ret.direction = float3(dot(nL1x, lumaConv), dot(nL1y, lumaConv), dot(nL1z, lumaConv));
                ret.color = data.L0 + ret.direction.x * data.L1x + ret.direction.y * data.L1y + ret.direction.z * data.L1z;
                ret.NoV = dot(data.normal, data.viewDir);
                ret.NoV = max(ret.NoV, 0.0001);
                return ret;
            }
            
            #endif
            
            #endif

            // Functions
            void PBRFragment(MeshData d, inout SurfaceData o) {
                // this allows us to handle things like parallax nicely
                #if defined(PARALLAX)
                    GLOBAL_uv = GLOBAL_parallaxUv;
                #else
                    GLOBAL_uv = d.uv0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                #endif
            
                // Do Triplanar
                if (_MappingSpace == 3)
                {
                    // Fast (bad) Triplanar
                    float3 axisProjection = mul(float3(0.0001, 0.0001, 1), d.TBNMatrix);
                    axisProjection = abs(axisProjection);
                    axisProjection = pow(axisProjection, 160);
                    axisProjection /= axisProjection.x + axisProjection.y + axisProjection.z;
                    axisProjection = saturate(invLerp(axisProjection, 0.5, 0.5001));
                    axisProjection.z += saturate(1 - length(axisProjection));
            
                    float3 pos = d.worldSpacePosition * _MainTex_ST.x;
                    GLOBAL_uv = pos.zy;
                    GLOBAL_uv *= axisProjection.x;
                    GLOBAL_uv += pos.xz * axisProjection.y;
                    GLOBAL_uv += pos.xy * axisProjection.z;
            
                }
                else if (_MappingSpace > 0)
                {
                    GLOBAL_uv = (_MappingSpace - 1) ? half2(d.worldSpacePosition[_PlanarAxisX], d.worldSpacePosition[_PlanarAxisY]) : half2(d.localSpacePosition[_PlanarAxisX], d.localSpacePosition[_PlanarAxisY]);
                    GLOBAL_uv *= _MainTex_ST.xy + _MainTex_ST.zw;
                }
                half4 albedo = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, GLOBAL_uv);
                if (_AlbedoChannel > 0)
                {
                    albedo.rgb = albedo[_AlbedoChannel - 1].xxx;
                }
                half4 masks = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, GLOBAL_uv);
                float4 normalTex = SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, GLOBAL_uv);
                if (_FlipBumpY)
                {
                    normalTex.y = 1 - normalTex.y;
                }
                    
                float3 normal = UnpackNormalScale(normalTex, _BumpScale);
            
                half3 emission = SAMPLE_TEXTURE2D(_EmissionMap, sampler_EmissionMap, GLOBAL_uv).rgb;
                if (_EmissionChannel > 0)
                {
                    emission.rgb = emission[_EmissionChannel - 1].xxx;
                }
                int hasMasks = _MaskMap_TexelSize.z > 8;
                half metal = masks[_MetalChannel];
                half smooth = masks[_SmoothChannel];
                if (_RoughnessMode)
                {
                    smooth = 1 - smooth;
                }
                half detailMask = masks[_DetailMaskChannel];
                half occlusion = masks[_AOChannel];
                metal = remap(metal, 0, 1, _MetallicRemap.x, _MetallicRemap.y);
                smooth = remap(smooth, 0, 1, _SmoothnessRemap.x, _SmoothnessRemap.y);
                GLOBAL_maskMap = half4(metal, occlusion, detailMask, smooth);
                o.Metallic = lerp(_Metallic, metal, hasMasks);
                o.Smoothness = lerp(_Smoothness, smooth, hasMasks);
                o.Occlusion = lerp(1, occlusion, _OcclusionStrength);
                o.Normal = normal;
                if (!_DetailAsTintMask)
                {
                    o.Albedo *= albedo.rgb * _Color.rgb;
                }
                else
                {
                    o.Albedo *= lerp(albedo, albedo.rgb * _Color.rgb, detailMask);
                }
                // Fix BC7 compression issues, unity PLS fix
                {
                    uint a = uint(o.Alpha * 255.0);
                    a = a > 254 ? 255 : a;
                    a = a < 5 ? 0 : a;
                    o.Alpha =  a / 255.0;
                }
            
                o.Alpha *= albedo.a * _Color.a;
                #if defined(_EMISSION)
                    o.Emission = emission * pow(_EmissionColor,2.2);
                #endif
            }
            

            #if defined(_PARALLAXSTEPS_EIGHT)
                #define PARALLAX_STEPS 8
            #elif defined(_PARALLAXSTEPS_SIXTEEN)
                #define PARALLAX_STEPS 16
            #elif defined(_PARALLAXSTEPS_THIRTYTWO)
                #define PARALLAX_STEPS 32
            #elif defined(_PARALLAXSTEPS_SIXTYFOUR)
                #define PARALLAX_STEPS 64
            #else
                #define PARALLAX_STEPS 1
            #endif
            
            float2 POM_simple(TEXTURE2D_PARAM(heightMap, heightSampler), float currentHeight, float scale, float2 uv, float3 tangetSpaceViewDir, float refPlane, out float heightOffset)
            {
                heightOffset = 0;
                float2 uvOffset = 0;
                float stepSize = 1.0 / PARALLAX_STEPS;
                float stepHeight = 1;
                tangetSpaceViewDir.xy /= (tangetSpaceViewDir.z + 0.42);
                float2 uvDelta = tangetSpaceViewDir.xy * (stepSize * scale);
            
                float2 derivatives = float2(ddx(uv.x), ddy(uv.y));
            
                [unroll(PARALLAX_STEPS)]
                for (int i = 1; i <= PARALLAX_STEPS && stepHeight > currentHeight; i++)
                {
                    uvOffset -= uvDelta;
                    stepHeight -= stepSize;
                    currentHeight = SAMPLE_TEXTURE2D_GRAD(heightMap, heightSampler, uv + uvOffset, derivatives.x, derivatives.y).r + refPlane;
                }
            
                [unroll(3)]
                for (int k = 0; k < 3; k++)
                {
                    uvDelta *= 0.5;
                    stepSize *= 0.5;
            
                    if (stepHeight < currentHeight)
                    {
                        uvOffset += uvDelta;
                        stepHeight += stepSize;
                    } else {
                        uvOffset -= uvDelta;
                        stepHeight -= stepSize;
                    }
                    currentHeight = SAMPLE_TEXTURE2D_GRAD(heightMap, heightSampler, uv + uvOffset, derivatives.x, derivatives.y).r + refPlane;
                }
            
                heightOffset = currentHeight;
                return uvOffset;
            }
            
            void ParallaxFragment(MeshData d, FragmentData i)
            {
                // this is a bit "magical" but basically we just push to global UVs
                // and then any other module will read from them
                // we use FragmentQueue to push the actual function call above the other modules
                GLOBAL_parallaxUv = d.uv0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                #if defined(PARALLAX) && !defined(PLAT_QUEST)
                {
                    float customHeight = 0;
                    if (_ParallaxScaleBasedOnAngle)
                    {
                        float3 forwardRay = TransformViewToWorldDir(float3(0,0,1));
                        _HeightScale *= pow(saturate(dot(d.worldNormal, forwardRay)), 1.0/1.5);
                    }
                    half startingPoint = SAMPLE_TEXTURE2D(_Height, sampler_Height, GLOBAL_parallaxUv).r;
                    float2 uvOffset = POM_simple(TEXTURE2D_ARGS(_Height, sampler_Height), startingPoint, _HeightScale, GLOBAL_parallaxUv, d.tangentSpaceViewDir, _HeightRefPlane, customHeight);
                    GLOBAL_parallaxUv += uvOffset;
            
                    GLOBAL_height = customHeight;
                    GLOBAL_heightSet = 1;
                }
                #endif
            }
            

            void DetailsFragment(MeshData d, inout SurfaceData o)
            {
                #if !defined(DETAILS_OVERLAY)
                    return;
                #else
                half masks = 0;
            
                // we can grab the mask map from the Base Shader if it was present
                #if defined(_MASKMAP_SAMPLED)
                masks = GLOBAL_maskMap.b;
                #else
                masks = 1;
                #endif
            
                half mask = lerp(masks, 1, _DIgnoreMask);
                float2 uv = d.uv0.xy;
                switch(_DUVChannel)
                {
                    case 1: uv = d.uv1.xy; break;
                    case 2: uv = d.uv2.xy; break;
                    case 3: uv = d.uv3.xy; break;
                    default: uv = d.uv0.xy; break;
                }
                uv = uv * _DDetailsMap_ST.xy + _DDetailsMap_ST.zw;
                if (_DMappingSpace > 0)
                {
                    uv = (_DMappingSpace - 1) ? half2(d.worldSpacePosition[_DPlanarAxisX], d.worldSpacePosition[_DPlanarAxisY]) : half2(d.localSpacePosition[_DPlanarAxisX], d.localSpacePosition[_DPlanarAxisY]);
                    uv = uv * _DDetailsMap_ST.xy + _DDetailsMap_ST.zw;
                }
            
                half4 detailsMap = SAMPLE_TEXTURE2D(_DDetailsMap, sampler_DDetailsMap, uv);
            
                #if defined(DETAILS_MODE_PACKED)
                    
                // 0.5 is the neutral value
                half detailAlbedo = detailsMap.r * 2.0 - 1.0;
                half detailSmooth = detailsMap.b * 2.0 - 1.0;
                half3 detailNormal = 0;
                if (_DNormalFlipY)
                {
                    detailsMap.g = 1 - detailsMap.g;
                }
                detailNormal = UnpackNormalScale(float4(detailsMap.ag, 1, 1), _DNormalScale);
                half detailAlbedoSpeed = saturate(abs(detailAlbedo) * _DAlbedoScale);
                half3 albedoOverlay = lerp(sqrt(o.Albedo), (detailAlbedo < 0.0) ? 0.0.xxx : 1.0.xxx, detailAlbedoSpeed * detailAlbedoSpeed);
                albedoOverlay *= albedoOverlay;
            
                // Packed mode only supports HDRP-style albedo mixing
                o.Albedo = lerp(o.Albedo, saturate(albedoOverlay), mask);
            
                #elif defined(DETAILS_MODE_SEPARATED)        
                half detailSmooth = detailsMap.a * 2.0 - 1.0;
            
                half4 packedNormal = SAMPLE_TEXTURE2D(_DDetailsNormal, sampler_DDetailsNormal, uv);
                if (_DNormalFlipY)
                {
                    packedNormal.g = 1 - packedNormal.g;
                }
                half3 detailNormal = UnpackNormalScale(packedNormal, _DNormalScale);
            
                // Separated mdoe supports BIRP-style 2x albedo mixing
                if (_DAlbedoMixingLegacy) {
                    o.Albedo *= LerpWhiteTo(detailsMap.rgb * unity_ColorSpaceDouble.rgb, mask * _DAlbedoScale);
                } else {
                    half3 detailAlbedo = detailsMap.rgb * 2.0 - 1.0;
                    half3 detailAlbedoSpeed = saturate(abs(detailAlbedo) * _DAlbedoScale);
                    half3 albedoOverlay = lerp(sqrt(o.Albedo), (detailAlbedo < 0.0) ? 0.0.xxx : 1.0.xxx, detailAlbedoSpeed * detailAlbedoSpeed);
                    albedoOverlay *= albedoOverlay;
                    o.Albedo = lerp(o.Albedo, saturate(albedoOverlay), mask);
                }
                #endif
            
                // do the smooth details
                half detailSmoothSpeed = saturate(abs(detailSmooth) * _DSmoothScale);
                half smoothOverlay = lerp(o.Smoothness, (detailSmooth < 0.0) ? 0.0 : 1.0, detailSmoothSpeed * detailSmoothSpeed);
                o.Smoothness = lerp(o.Smoothness, saturate(smoothOverlay), mask);
            
                // do the normal details
                o.Normal = lerp(o.Normal, BlendNormals(o.Normal, detailNormal), mask);
                #endif
            }
            

            bool isVR__local()
            {
            #if UNITY_SINGLE_PASS_STEREO
                return true;
            #else
                return false;
            #endif
            }
            
            void VRCFeaturesVertex(inout VertexData v)
            {
                #if defined(VRC_FEATURES)
                bool isMainView = _VRChatCameraMode == 0 && _VRChatMirrorMode == 0;
                bool isInVRHandCam = _VRChatCameraMode == 1;
                bool isInDesktopHandCam = _VRChatCameraMode == 2;
                bool isInVR = isVR__local();
                bool isInDesktop = !isInVR && !isInDesktopHandCam;
                bool isInVRMirror = _VRChatMirrorMode == 1;
                bool isInDesktopMirror = _VRChatMirrorMode == 2;
            
                if (_VRCHideInVR && isInVR && isMainView)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInDesktop && isInDesktop && isMainView)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInVRCamera && isInVRHandCam)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInDesktopCamera && isInDesktopHandCam)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInVRMirror && isInVRMirror)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                if (_VRCHideInDesktopMirror && isInDesktopMirror)
                {
                    v.vertex = asfloat(-1);
                    return;
                }
                #endif
            }
            

            void VRCLightVolumesCustomProbesSetup(MeshData d, inout SurfaceData o)
            {
                #if defined(INTEGRATE_VRCLIGHTVOLUMES) && !defined(ORL_LIGHTING_MODEL_UI)
                {
                    float3 L0, L1r, L1g, L1b;
                    LightVolumeSH(d.worldSpacePosition + d.worldNormal * _VRCLightVolumesSurfacePushoff, L0, L1r, L1g, L1b);
                    o.VRCLV_L0 = L0;
                    o.VRCLV_L1r = L1r;
                    o.VRCLV_L1g = L1g;
                    o.VRCLV_L1b = L1b;
            
                    // Since toon shaders can derive light directions from probes
                    // we need to directly modify these values
                    #if defined(ORL_LIGHTING_MODEL_TOON_V2)
                    unity_SHAr = float4(L1r, L0.r);
                    unity_SHAg = float4(L1g, L0.g);
                    unity_SHAb = float4(L1b, L0.b);
                    #endif
                }
                #endif
            }
            

            void VRCLightVolumesCustomProbes(SurfaceData o, MeshData d, inout half3 indirectDiffuse)
            {
                // Custom Probes
                #if defined(INTEGRATE_VRCLIGHTVOLUMES) && !defined(ORL_LIGHTING_MODEL_UI)
                {
                    #if defined(ORL_LIGHTING_MODEL_TOON_V2)
                    {
                        o.Normal = _IgnoreLightprobeNormal ? float3(0, 0.5, 0) : o.WorldNormal;
                    }
                    #endif
                    indirectDiffuse = LightVolumeEvaluate(o.Normal, o.VRCLV_L0, o.VRCLV_L1r, o.VRCLV_L1g, o.VRCLV_L1b);
                }
                #endif
            }
            

            void VRCLightVolumesCustomProbesBakedSpecular(SurfaceData o, MeshData d, inout half3 indirectSpecular, inout half3 bakedSpecularColor, inout half3 bakedDominantDirection)
            {
                #if defined(INTEGRATE_VRCLIGHTVOLUMES) && !defined(ORL_LIGHTING_MODEL_UI)
                bakedSpecularColor = o.VRCLV_L0;
                bakedDominantDirection = o.VRCLV_L1r.xyz + o.VRCLV_L1g.xyz + o.VRCLV_L1b.xyz;
                #endif
            }
            

            void VRCLightVolumesCustomGI(SurfaceData o, MeshData d, inout half3 indirectDiffuse)
            {
                #if defined(INTEGRATE_VRCLIGHTVOLUMES)
                {
                    #if defined(LIGHTMAP_ON)
                    {
                        float3 L0, L1r, L1g, L1b;
                        LightVolumeAdditiveSH(d.worldSpacePosition + d.worldNormal * _VRCLightVolumesSurfacePushoff, L0, L1r, L1g, L1b);
                        indirectDiffuse += LightVolumeEvaluate(o.Normal, L0, L1r, L1g, L1b);
                    }
                    #endif
                }
                #endif
            }
            

            void VRCLightVolumesColor(MeshData d, bool facing, inout half4 FinalColor)
            {
                #if !defined(UNITY_PASS_FORWARDBASE)
                return;
                #endif
                #if !defined(ORL_LIGHTING_MODEL_UI)
                return;
                #endif
            
                #if defined(INTEGRATE_VRCLIGHTVOLUMES)
                {
                    float3 L0, L1r, L1g, L1b;
                    float3 worldNormal = d.worldNormal;
                    if (!facing) {
                        worldNormal = -worldNormal;
                    }
                    LightVolumeSH(d.worldSpacePosition + worldNormal * _VRCLightVolumesSurfacePushoff, L0, L1r, L1g, L1b);
                    half3 indirectDiffuse = LightVolumeEvaluate(worldNormal, L0, L1r, L1g, L1b);
                    FinalColor.rgb *= indirectDiffuse;
                }
                #endif
            
            }
            

            void PosterDisplayFragment(FragmentData i, inout SurfaceData o)
            {
                fixed4 col = GetPosterColor(
                    i.uv0.xy,
                    _TimeOffset,
                    _DurationStatic,
                    _DurationEase,
                    _GridHorizontal,
                    _GridVertical,
                    _CellMargin,
                    _EaseFunction,
                    _EaseAnimation,
                    _PosterTex, _PosterTex_ST, _PosterTint,
                    _IdleTex, _IdleTex_ST, _IdleTint,
                    _Idling
                );
            
                o.Albedo *= col;
                o.Emission *= col;
            }
            

            
                void ALFragment(MeshData d, inout SurfaceData o)
                {
                    UNITY_BRANCH
                    if (_KillEffects) return;
            
                    UNITY_BRANCH
                    if (!AudioLinkIsAvailable()) return;
            
                    half3 finalEmission = 0;
                    half finalAlpha = 1;
                    float2 uv = 0;
                    switch(_ALUVChannel)
                    {
                        case 0: uv = d.uv0.xy; break;
                        case 1: uv = d.uv1.xy; break;
                        case 2: uv = d.uv2.xy; break;
                        case 3: uv = d.uv3.xy; break;
                    }
                    half4 mask = SAMPLE_TEXTURE2D(_ALMask, sampler_ALMask, uv);
                    
                    #if defined(AL_EFFECT_BAND_SELECTION)
            
                    half uvSource = lerp(uv.x, lerp(uv.y, lerp(1 - uv.x, 1 - uv.y, saturate(_BandScrollAxis - 2)), saturate(_BandScrollAxis - 1)), saturate(_BandScrollAxis));
                    half scaledUv = (uvSource * _BandHistoryRange) % 128.0;
                    half4 bandData = AudioLinkLerp(float2(scaledUv, clamp(_BandFrequency - 1, 0, 3)));
                    finalEmission = bandData.rgb * _ALTint;
                    finalAlpha = bandData.r;
            
                    #elif defined(AL_EFFECT_UV_BASED)
            
                    float2 scaledUv = float2(lerp(uv.x, uv.y, _UVFlipXY) * _UVHistoryRange % 128, floor(lerp(uv.y, uv.x, _UVFlipXY) * 4));
                    half4 bandData = AudioLinkLerp(scaledUv).rrra;
                    if (_UVUseThemeColors)
                    {
                        int band = clamp(floor(scaledUv.y), 0, 3);
                        switch(band)
                        {
                            case 0:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR0);
                                break;
                            case 1:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR1);
                                break;
                            case 2:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR2);
                                break;
                            case 3:
                                bandData *= AudioLinkData(ALPASS_THEME_COLOR3);
                                break;
                        }
                    }
                    finalEmission = bandData.rgb * _ALTint;
                    finalAlpha = bandData.r;
            
                    #elif defined(AL_EFFECT_WAVEFORM)
            
                    half noteno = abs(uv.x) * AUDIOLINK_ETOTALBINS;
                    half wvfrm = AudioLinkLerpMultiline(ALPASS_DFT + half2(noteno, 0)).z * _WVFRMScale;
                    half2 gradientUvs = uv;
                    if (_WVFRMFlipUVDirection) {
                        gradientUvs = half2(gradientUvs.y, gradientUvs.x);
                    }
                    half4 bottomColor = SAMPLE_TEXTURE2D(_WVFRMBottomColor, sampler_WVFRMBottomColor, gradientUvs);
                    half4 topColor = SAMPLE_TEXTURE2D(_WVFRMTopColor, sampler_WVFRMBottomColor, gradientUvs);
                    half4 midColor = SAMPLE_TEXTURE2D(_WVFRMMiddleColor, sampler_WVFRMBottomColor, gradientUvs);
                    half4 finalBlend = lerp(lerp(bottomColor, midColor, _WVFRMMiddleLine > 0 && lerp(uv.y, 1 - uv.y, _WVFRMFlip) > (wvfrm + _WVFRMOffset) - _WVFRMMiddleLineWidth), topColor, lerp(uv.y, 1 - uv.y, _WVFRMFlip) > (wvfrm + _WVFRMOffset));
                    finalEmission = finalBlend.rgb;
                    finalEmission *= _ALTint;
                    finalAlpha = finalBlend.a;
            
                    #elif defined(AL_EFFECT_PULSE)
            
                    half pulseData = 0;
                    UNITY_BRANCH
                    if (_PulseSmoothing == 0) {
                        pulseData = AudioLinkData(int2(0, clamp(_PulseBand - 1, 0, 3))).r;
                    } else {
                        pulseData = AudioLinkData(ALPASS_FILTEREDAUDIOLINK + int2(16 - _PulseSmoothing, clamp(_PulseBand - 1, 0, 3))).r;
                    }
                    if (_PulseMode == 0)
                    {
                        if (!_PulseEmissionMode)
                        {
                            finalEmission = o.Emission + pulseData * _ALTint * _PulseStrength;
                        }
                        else
                        {
                            finalEmission = o.Emission * pulseData * _ALTint * _PulseStrength;
                        }
                    }
                    else
                    {
                        finalEmission = pulseData * _PulseStrength * _ALTint;
                        if (_PulseTextureAdjustment == 0)
                        {
                            uv += _PulseTextureDirection.xy * pulseData;
                        }
                        else
                        {
                            float chrono = (AudioLinkDecodeDataAsUInt(ALPASS_CHRONOTENSITY + uint2(1, 0)) % 1000000) / 1000000.0;
                            uv += _PulseTextureDirection.xy * chrono;
                        }
                        finalEmission += SAMPLE_TEXTURE2D(_PulseTexture, sampler_PulseTexture, uv) * _ALTint;
                    }
            
                    #elif defined(AL_EFFECT_BAR)
            
                    float uvSource = lerp(uv.x, lerp(uv.y, lerp(1 - uv.x, 1 - uv.y, saturate(_BarAxis - 2)), saturate(_BarAxis - 1)), saturate(_BarAxis));
                    half3 color = SAMPLE_TEXTURE2D(_BarColor, sampler_BarColor, half2(uvSource, 0)).rgb;
                    half bandData = 0;
                    UNITY_BRANCH
                    if (_BarSmoothing == 0) {
                        bandData = saturate(AudioLinkData(int2(0, clamp(_BarBand - 1, 0, 3))).r * _BarScale);
                    } else {
                        bandData = saturate(AudioLinkData(ALPASS_FILTEREDAUDIOLINK + int2(16 - _BarSmoothing, clamp(_BarBand - 1, 0, 3))).r * _BarScale);
                    }
                    half barData = smoothstep((1 - bandData), (1 - bandData) + 0.01, uvSource);
                    finalEmission = lerp(0, barData.xxx * _ALTint.rgb * color.rgb, bandData);
                    finalAlpha = barData * bandData;
            
                    #endif
            
                    o.Emission = lerp(o.Emission, finalEmission, mask.r);
                    #if defined(AL_CUTOUT)
                    o.Alpha = finalAlpha;
                    #endif
                }
            

            void LTCGICustomGI(MeshData d, SurfaceData o, inout half3 customGISpecular, inout half3 customGIDiffuse)
            {
                #if !defined(ORL_LIGHTING_MODEL_VFX)
                {
                    #if defined(PLAT_QUEST)
                    if (!_LTCGIEnableOnMobile) return;
                    #endif
            
                    #if defined(INTEGRATE_LTCGI)
                        LTCGIAccumulatorStruct ltcgiData = (LTCGIAccumulatorStruct) 0;
            
                        LTCGI_Contribution(
                            ltcgiData,
                            d.worldSpacePosition.xyz,
                            o.Normal.xyz,
                            d.worldSpaceViewDir,
                            saturate((1 - o.Smoothness) + _LTCGIRoughnessModifier),
                            d.uv1.xy
                        );
            
                        if (_LTCGIClampBrightness) {
                            half3 hsv = RGB2HSV(ltcgiData.specular);
                            hsv.z = tanh(hsv.z) * max(0, _LTCGIMaxBrightness);
                            customGISpecular += HSV2RGB(hsv) * _LTCGISpecularIntensity;
                        } else {
                            customGISpecular += ltcgiData.specular * _LTCGISpecularIntensity;
                        }
                        customGIDiffuse += ltcgiData.diffuse * _LTCGIDiffuseIntensity;
                    #endif
                }
                #endif
            }
            

            void LTCGIColor(MeshData d, FragmentData i, inout half4 FinalColor, bool facing)
            {
                #if defined(ORL_LIGHTING_MODEL_VFX)
                {
                    #if defined(PLAT_QUEST)
                    if (!_LTCGIEnableOnMobile) return;
                    #endif
            
                    #if defined(INTEGRATE_LTCGI)
                        LTCGIAccumulatorStruct ltcgiData = (LTCGIAccumulatorStruct) 0;
            
                        float3 viewDir = d.worldSpaceViewDir;
                        if (!facing)
                        {
                            viewDir = -d.worldSpaceViewDir;
                        }
            
                        LTCGI_Contribution(
                            ltcgiData,
                            d.worldSpacePosition.xyz,
                            d.worldNormal.xyz,
                            viewDir,
                            saturate(0.5 + _LTCGIRoughnessModifier),
                            d.uv1.xy
                        );
            
                        if (_LTCGIClampBrightness) {
                            half3 hsv = RGB2HSV(ltcgiData.specular);
                            hsv.z = tanh(hsv.z) * max(0, _LTCGIMaxBrightness);
                            FinalColor.rgb += HSV2RGB(hsv) * _LTCGISpecularIntensity;
                        } else {
                            FinalColor.rgb += ltcgiData.specular * _LTCGISpecularIntensity;
                        }
                        FinalColor.rgb += ltcgiData.diffuse * _LTCGIDiffuseIntensity;
                        if (_LTCGIAlphaPremultiply)
                        {
                            FinalColor.rgb *= FinalColor.a;
                        }
                    #endif
                }
                #endif
            }
            

            void FragmentBase(MeshData d, FragmentData i, SurfaceData o, inout half4 FinalColor)
            {
                #if defined(UNITY_PASS_SHADOWCASTER)
                    return;
                #else
            
                half reflectance = 0.5;
                float oneMinusReflectivity = 1.0 - 0.04 - o.Metallic * (1.0 - 0.04);
                half3 f0 = 0.16 * reflectance * reflectance * oneMinusReflectivity + o.Albedo * o.Metallic;
            
                half3 indirectDiffuse = 0;
                half3 indirectSpecular = 0;
                    
                half occlusion = o.Occlusion;
            
                half perceptualRoughness = 1 - o.Smoothness;
            
                float3 tangentNormal = o.Normal;
            
                #if defined(SHADING_MODE_CLOTH)
                half3 albedoSqrt = sqrt(o.Albedo);
                #endif
                    
                o.Normal = Unity_SafeNormalize(mul(o.Normal, d.TBNMatrix));
            
                #ifndef USING_DIRECTIONAL_LIGHT
                float3 lightDir = Unity_SafeNormalize(UnityWorldSpaceLightDir(d.worldSpacePosition));
                #else
                float3 lightDir = Unity_SafeNormalize(_WorldSpaceLightPos0.xyz);
                #endif
            
                #if defined(GSAA)
                perceptualRoughness = GSAA_Filament(_GSAAIncludeNormalMaps ? o.Normal : d.worldNormal, perceptualRoughness, _GSAAVariance, _GSAAThreshold);
                #endif
            
                UNITY_LIGHT_ATTENUATION(lightAttenuation, i, d.worldSpacePosition);
                half3 lightColor = lightAttenuation * _LightColor0.rgb;
            
                float3 lightHalfVector = Unity_SafeNormalize(lightDir + d.worldSpaceViewDir);
                half lightNoL = saturate(dot(o.Normal, lightDir));
                half lightLoH = saturate(dot(lightDir, lightHalfVector));
            
                half NoV = abs(dot(o.Normal, d.worldSpaceViewDir)) + 1e-5;
            
                // Standard BRDF Setup
                half3 dfguv = half3(NoV, perceptualRoughness, 0);
                float2 dfg = SAMPLE_TEXTURE2D(_DFG, sampler_DFG, dfguv).xy;
                half3 energyCompensation = 1.0 + f0 * (1.0 / dfg.y - 1.0);
            
                float rough = perceptualRoughness * perceptualRoughness;
                half clampedRoughness = max(rough, ORL_MIN_ROUGHNESS);
            
                // Clear Coat BRDF Setup
                #if defined(CLEARCOAT)
                half3 clearcoatdfguv = 0;
                float2 clearcoatdfg = 0;
            
                float clearCoatAttenuation = 1.0;
                float clearCoatRoughness = 1.0 - _ClearCoatSmoothness;
                half clampedClearCoatRoughness = max(clearCoatRoughness * clearCoatRoughness, ORL_MIN_ROUGHNESS);
                half3 clearCoatMainLightSpecular = 0;
                half3 clearCoatIndirectSpecular = 0;
                #endif
            
                half3 mainLightDiffuse = 0;
                half3 mainLightSpecular = 0;
            
                mainLightDiffuse = Fd_Burley(perceptualRoughness, NoV, lightNoL, lightLoH);
            
                #if defined(SHADING_MODE_CLOTH)
                {
                    if (_ClothHasSubsurface)
                    {
                        mainLightDiffuse *= Fd_Wrap(dot(o.Normal, lightDir), 0.5);
                        mainLightDiffuse *= saturate(_ClothSubsurfaceColor.rgb + lightNoL);
                    } else {
                        mainLightDiffuse *= lightNoL;
                    }
                    mainLightDiffuse *= lightColor;
                }
                #else
                mainLightDiffuse *= lightColor * lightNoL;
                #endif
            
            
                // Collect Vertex Light Data and calculate direct diffuse
                #if defined(SHADE_VERTEXLIGHTS) &&defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                float4x4 vLightColors = getVertexLightsColors(d.worldSpacePosition, o.Normal, false);
                float4x4 vLightDirections = getVertexLightsDir(d.worldSpacePosition);
                float4x4 vLightHalfVectors = 0;
                float4 vLightNoLs = 0;
                float4 vLightLoHs = 0;
            
                half3 vertexLightDiffuse = 0;
                half3 vertexLightSpecular = 0;
                half3 clearCoatVertexLightSpecular = 0;
            
                [unroll(4)]
                for (int i = 0; i < 4; i++)
                {
                    vLightHalfVectors[i].rgb = Unity_SafeNormalize(vLightDirections[i] + d.worldSpaceViewDir);
                    vLightLoHs[i] = saturate(dot(vLightDirections[i], vLightHalfVectors[i]));
                    vLightNoLs[i] = saturate(dot(o.Normal, vLightDirections[i]));
            
                    half3 vLightDiffuse = Fd_Burley(perceptualRoughness, NoV, vLightNoLs[i], vLightLoHs[i]);
            
                    #if defined(SHADING_MODE_CLOTH)
                    {
                        if (_ClothHasSubsurface)
                        {
                            vLightColors[i].rgb *= Fd_Wrap(dot(o.Normal, vLightDirections[i]), 0.5);
                            vLightColors[i].rgb *= saturate(_ClothSubsurfaceColor.rgb + vLightNoLs[i]);
                        } else {
                            vLightDiffuse *= vLightNoLs[i];
                        }
                        vLightDiffuse *= vLightColors[i];
                    }
                    #else
                    vLightDiffuse *= vLightColors[i] * vLightNoLs[i];
                    #endif
            
                    vertexLightDiffuse += vLightDiffuse;
                }
                #endif
            
                // https://assetstore.unity.com/packages/tools/level-design/bakery-gpu-lightmapper-122218
                #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME)
                    BakeryVolumeData volumeData = (BakeryVolumeData) 0;
            
                    if (_Udon_GlobalVolumeAdapterEnabled == 1)
                    {
                        _GlobalVolumeMin = _Udon_GlobalVolumeMin;
                        _GlobalVolumeInvSize = _Udon_GlobalVolumeInvSize;
            
                        // Arbitrary rotation (runtime only)
                        #if defined(BAKERY_VOLROTATION)
                        _GlobalVolumeMatrix = _Udon_GlobalVolumeMatrix;
                        #endif
            
                        // Y Rotation (baked)
                        #if defined(BAKERY_VOLROTATIONY)
                        _GlobalVolumeRY = _Udon_GlobalVolumeRY;
                        #endif
                    }
                        
                    bool isGlobalVolume = _VolumeInvSize.x > 1000000; // ~inf
                    volumeData.viewDir = Unity_SafeNormalize(d.worldSpaceViewDir);
                        
                    // Runtime volume rotation
                    // Requires a special adapter to work in VRChat
                    #if defined(BAKERY_VOLROTATION)
                        float4x4 volMatrix = (isGlobalVolume ? _GlobalVolumeMatrix : _VolumeMatrix);
                        float3 volInvSize = (isGlobalVolume ? _GlobalVolumeInvSize : _VolumeInvSize);
                        volumeData.uv = mul(volMatrix, float4(d.worldSpacePosition,1)).xyz * volInvSize + 0.5f;
            
                        volumeData.normal = mul((float3x3)volMatrix, o.Normal);
                        volumeData.normal = Unity_SafeNormalize(volumeData.normal);
                            
                        #if defined(BAKED_SPECULAR)
                            volumeData.viewDir = mul((float3x3)volMatrix, volumeData.viewDir);
                        #endif
                    #else
                        volumeData.uv = d.worldSpacePosition - (isGlobalVolume ? _GlobalVolumeMin : _VolumeMin);
                        #if defined(BAKERY_VOLROTATIONY)
                            float2 sc = (isGlobalVolume ? _GlobalVolumeRY : _VolumeRY);
                            volumeData.uv.xz = mul(float2x2(sc.y, -sc.x, sc.x, sc.y), volumeData.uv.xz);
                        #endif
                        volumeData.uv *= (isGlobalVolume ? _GlobalVolumeInvSize : _VolumeInvSize);
                        volumeData.normal = o.Normal;
                    #endif
            
                    volumeData.occlusion = saturate(dot(_VolumeMask.Sample(sampler_VolumeMask, volumeData.uv), unity_OcclusionMaskSelector));
            
                    lightColor *= volumeData.occlusion;
                    mainLightDiffuse *= volumeData.occlusion;
            
                    #if defined(SHADE_VERTEXLIGHTS) &&defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                    {
                        vertexLightDiffuse *= volumeData.occlusion;
                    }
                    #endif
            
                #endif    
            
                // READ THE LIGHTMAP
                // Can be Baked, Realtime, both or either
                #if (defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)) && defined(UNITY_PASS_FORWARDBASE)
                    half3 lightMap = 0;
                    half4 bakedColorTex = 0;
                    half2 lightmapUV = d.lightmapUv.xy;
            
                    // explicitly checking for lightmap on because we can be in rtgi only mode
                    #if defined(LIGHTMAP_ON)
                        
                    // UNITY LIGHTMAPPING
                    #if !defined(BAKERYLM_ENABLED) || !defined(BAKERY_ENABLED)
                        lightMap = tex2DFastBicubicLightmap(lightmapUV, bakedColorTex);
                    #endif
            
                    // BAKERY RNM MODE
                    #if defined(BAKERY_RNM) && defined(BAKERY_ENABLED)
                        float3 rnm0 = DecodeLightmap(BakeryTex2D(_RNM0, sampler_RNM0, lightmapUV, _RNM0_TexelSize));
                        float3 rnm1 = DecodeLightmap(BakeryTex2D(_RNM1, sampler_RNM0, lightmapUV, _RNM0_TexelSize));
                        float3 rnm2 = DecodeLightmap(BakeryTex2D(_RNM2, sampler_RNM0, lightmapUV, _RNM0_TexelSize));
                            
                        lightMap = saturate(dot(rnmBasis0, tangentNormal)) * rnm0 +
                        saturate(dot(rnmBasis1, tangentNormal)) * rnm1 +
                        saturate(dot(rnmBasis2, tangentNormal)) * rnm2;
                    #endif
            
                    // BAKERY SH MODE (these are also used for the specular)
                    #if defined(BAKERY_SH) && defined(BAKERY_ENABLED)
                        half3 L0 = DecodeLightmap(BakeryTex2D(unity_Lightmap, samplerunity_Lightmap, lightmapUV, _RNM0_TexelSize));
                            
                        half3 nL1x = BakeryTex2D(_RNM0, sampler_RNM0, lightmapUV, _RNM0_TexelSize) * 2.0 - 1.0;
                        half3 nL1y = BakeryTex2D(_RNM1, sampler_RNM0, lightmapUV, _RNM0_TexelSize) * 2.0 - 1.0;
                        half3 nL1z = BakeryTex2D(_RNM2, sampler_RNM0, lightmapUV, _RNM0_TexelSize) * 2.0 - 1.0;
                        half3 L1x = nL1x * L0 * 2.0;
                        half3 L1y = nL1y * L0 * 2.0;
                        half3 L1z = nL1z * L0 * 2.0;
                            
                        // Non-Linear mode
                        #if defined(BAKERY_SHNONLINEAR)
                        half lumaL0 = dot(L0, half(1));
                        half lumaL1x = dot(L1x, half(1));
                        half lumaL1y = dot(L1y, half(1));
                        half lumaL1z = dot(L1z, half(1));
                        half lumaSH = shEvaluateDiffuseL1Geomerics(lumaL0, half3(lumaL1x, lumaL1y, lumaL1z), o.Normal);
                            
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        half regularLumaSH = dot(lightMap, 1.0);
                        lightMap *= lerp(1.0, lumaSH / regularLumaSH, saturate(regularLumaSH * 16.0));
                        #else
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        #endif
                    #endif
            
                    // Load directional lightmap
                    #if defined(DIRLIGHTMAP_COMBINED)
                        half4 lightMapDirection = tex2DFastBicubicSample(TEXTURE2D_ARGS(unity_LightmapInd, samplerunity_Lightmap), lightmapUV);
                        #if !defined(BAKERY_MONOSH)
                            lightMap = DecodeDirectionalLightmap(lightMap, lightMapDirection, o.Normal);
                        #endif
                    #endif
            
                    // Unity+Bakery often results in a full clear of DIRLIGHTMAP_COMBINED keyword
                    // which in turn results in no lightmap being applied when MONOSH is enabled
                    // this is an escape hatch for such a case to improve dev experience
                    #if defined(BAKERY_MONOSH) && defined(BAKERY_ENABLED) && !defined(DIRLIGHTMAP_COMBINED)
                        lightMap = tex2DFastBicubicLightmap(lightmapUV, bakedColorTex);
                    #endif
            
                    // Bakery MonoSH handling
                    #if defined(BAKERY_MONOSH) && defined(BAKERY_ENABLED) && defined(DIRLIGHTMAP_COMBINED)
                        half3 L0 = tex2DFastBicubicLightmap(lightmapUV, bakedColorTex);
                        half3 nL1 = lightMapDirection.xyz * 2.0 - 1.0;
                        half3 L1x = nL1.x * L0 * 2.0;
                        half3 L1y = nL1.y * L0 * 2.0;
                        half3 L1z = nL1.z * L0 * 2.0;
            
                        #if defined(BAKERY_SHNONLINEAR)
                        half lumaL0 = dot(L0, 1);
                        half lumaL1x = dot(L1x, 1);
                        half lumaL1y = dot(L1y, 1);
                        half lumaL1z = dot(L1z, 1);
                        half lumaSH = shEvaluateDiffuseL1Geomerics(lumaL0, half3(lumaL1x, lumaL1y, lumaL1z), o.Normal);
            
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        half regularLumaSH = dot(lightMap, 1);
                        lightMap *= lerp(1, lumaSH / regularLumaSH, saturate(regularLumaSH*16));
                        #else
                        lightMap = L0 + o.Normal.x * L1x + o.Normal.y * L1y + o.Normal.z * L1z;
                        #endif
            
                        lightMap = max(lightMap, 0.0);
                    #endif
            
                    #endif // defined(LIGHTMAP_ON)
            
                    // Handle RTGI specifically
                    #if defined(DYNAMICLIGHTMAP_ON) && !defined(PLAT_QUEST)
                        // only branch on non-meta passes
                        #if !defined(UNITY_PASS_META)
                        {
                            [branch]
                            if (!_IgnoreRealtimeGI) {
                                half3 realtimeLightMap = getRealtimeLightmap(d.lightmapUv.zw, o.Normal, _RealtimeGIDisableBicubic);
                                lightMap += realtimeLightMap;
                            }
                        }
                        #else
                        {
                            half3 realtimeLightMap = getRealtimeLightmap(d.lightmapUv.zw, o.Normal);
                            lightMap += realtimeLightMap;
                        }
                        #endif
                    #endif
            
                    #if defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN)
                        mainLightDiffuse = 0;
                        lightMap = SubtractMainLightWithRealtimeAttenuationFromLightmapMultiply(lightMap, lightAttenuation, bakedColorTex, o.Normal);
                    #endif
            
                    indirectDiffuse = lightMap;
            
                // Lightmapping end
            
                // Bakery Volume Sampling (replaces probes and LPPVs)
                #elif defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME) && defined(UNITY_PASS_FORWARDBASE)
                    // Sample the volume textures
                    volumeData = GetBakeryVolumeTextureData(volumeData);
                    // Sample using Geomerics approach, similar to lightprobes and LPPVs
                    indirectDiffuse = max(0, GetNonLinearSH(
                        volumeData.L0, 
                        float3(volumeData.L1x.r, volumeData.L1y.r, volumeData.L1z.r),
                        float3(volumeData.L1x.g, volumeData.L1y.g, volumeData.L1z.g),
                        float3(volumeData.L1x.b, volumeData.L1y.b, volumeData.L1z.b),
                        volumeData.normal)
                    );
            
                // Lightprobes Sampling
                #elif defined(UNITY_PASS_FORWARDBASE)
                    #if defined(_INTEGRATE_CUSTOMPROBES)
                    {
                        VRCLightVolumesCustomProbesSetup(d, o);
                    }
                    #endif
                    // LPPV support
                    #if UNITY_LIGHT_PROBE_PROXY_VOLUME
                    {
                        UNITY_BRANCH
                        if (unity_ProbeVolumeParams.x == 1)
                        {
                            indirectDiffuse = SHEvalLinearL0L1_SampleProbeVolume(half4(o.Normal, 1), d.worldSpacePosition);
                        }
                        else // Mesh has BlendProbes instead of LPPV
                        {
                            // Enable Integration of Custom Lightprobe solutions
                            #if defined(_INTEGRATE_CUSTOMPROBES)
                            {
                                VRCLightVolumesCustomProbes(o, d, indirectDiffuse);
                            }
                            #else
                            {
                                #if defined(NONLINEAR_SH)
                                {
                                    half3 L0 = half3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                                    half3 L0L2 = half3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0;
                                    L0 = L0+L0L2;
                                    indirectDiffuse = max(0, GetNonLinearSH(L0, unity_SHAr, unity_SHAg, unity_SHAb, o.Normal));
                                    indirectDiffuse += SHEvalLinearL2(float4(o.Normal, 1));
                                }
                                #else
                                {
                                    indirectDiffuse = max(0, ShadeSH9(half4(o.Normal, 1)));   
                                }
                                #endif
                            }
                            #endif
                        }
                    }
                    #else // No LPPVs enabled project-wide
                    {
                        // Enable Integration of Custom Lightprobe solutions
                        #if defined(_INTEGRATE_CUSTOMPROBES)
                        {
                            VRCLightVolumesCustomProbes(o, d, indirectDiffuse);
                        }
                        #else
                        {
                            #if defined(NONLINEAR_SH)
                            {
                                half3 L0 = half3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                                half3 L0L2 = half3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0;
                                L0 = L0+L0L2;
                                indirectDiffuse = max(0, GetNonLinearSH(L0, unity_SHAr, unity_SHAg, unity_SHAb, o.Normal));
                                indirectDiffuse += SHEvalLinearL2(float4(o.Normal, 1));
                            }
                            #else
                            {
                                indirectDiffuse = max(0, ShadeSH9(half4(o.Normal, 1)));   
                            }
                            #endif
                        }
                        #endif
                    }
                    #endif
                #endif // end of #if defined(LIGHTMAP_ON) && !defined(UNITY_PASS_FORWARDADD)
            
                // Attenuate main light diffuse by shadowmask
                float3 forwardShadows = 1;
                #if defined(LIGHTMAP_SHADOW_MIXING) && defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) && defined(LIGHTMAP_ON) && !defined(UNITY_PASS_FORWARDADD)
                {
                    forwardShadows = UnityComputeForwardShadows(d.lightmapUv.xy, d.worldSpacePosition, d.screenPos);
                    mainLightDiffuse *= forwardShadows;
                }
                #endif
            
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                clearcoatdfguv = half3(NoV, clearCoatRoughness, 0);
                clearcoatdfg = SAMPLE_TEXTURE2D(_DFG, sampler_DFG, clearcoatdfguv).xy;
            
                half clearCoatMask = _ClearCoatStrength;
                [branch]
                if (_HasClearCoatMask)
                {
                    clearCoatMask *= SAMPLE_TEXTURE2D(_ClearCoatMask, sampler_MainTex, d.uv0.xy * _ClearCoatMask_ST.xy + _ClearCoatMask_ST.zw)[_ClearCoatMaskChannel];
                }
                #endif
            
                // DIRECT REALTIME SPECULAR
                #if !defined(SPECULAR_HIGHLIGHTS_OFF) && defined(USING_LIGHT_MULTI_COMPILE)
                {
                    // Main Light
                    {
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            mainLightSpecular = GetSpecularHighlights(lightColor, f0, o.Normal, lightHalfVector, lightLoH, lightNoL, NoV, clampedRoughness, energyCompensation);
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            mainLightSpecular = GetSpecularHighlightsCloth(lightColor, o.Normal, lightHalfVector, lightNoL, NoV, clampedRoughness, energyCompensation, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                        }
                        #endif
            
                        mainLightSpecular *= lightNoL;
            
                        #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                        {
                            clearCoatMainLightSpecular = GetSpecularHighlightsClearCoat(lightColor, f0, d.worldNormal, lightHalfVector, lightLoH, clampedClearCoatRoughness, clearCoatMask, clearCoatAttenuation);
                            clearCoatMainLightSpecular *= saturate(dot(d.worldNormal, lightDir));
                        }
                        #endif
                    }
            
                    // Vertex Lights
                    #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                    {
                        [unroll(4)]
                        for (int i = 0; i < 4; i++)
                        {
                            #if defined(SHADING_MODE_DEFAULT)
                            {
                                vertexLightSpecular += vLightNoLs[i] * GetSpecularHighlights(vLightColors[i], f0, o.Normal, vLightHalfVectors[i], vLightLoHs[i], vLightNoLs[i], NoV, clampedRoughness, energyCompensation);
                            }
                            #elif defined(SHADING_MODE_CLOTH)
                            {
                                vertexLightSpecular += vLightNoLs[i] * GetSpecularHighlightsCloth(vLightColors[i], o.Normal, vLightHalfVectors[i], vLightNoLs[i], NoV, clampedRoughness, energyCompensation, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                            }
                            #endif
            
                            // Clear Coat
                            #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                            {
                                clearCoatVertexLightSpecular += GetSpecularHighlightsClearCoat(vLightColors[i], f0, d.worldNormal, vLightHalfVectors[i], vLightLoHs[i], clampedClearCoatRoughness, clearCoatMask, clearCoatAttenuation) * saturate(dot(d.worldNormal, vLightDirections[i]));
                            }
                            #endif
                        }
                    }
                    #endif
                }
                #endif
            
                // Attenuate main light specular by shadowmask
                #if defined(LIGHTMAP_SHADOW_MIXING) && defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) && defined(LIGHTMAP_ON) && !defined(UNITY_PASS_FORWARDADD)
                {
                    mainLightSpecular *= forwardShadows;
                }
                #endif
            
                // BAKED SPECULAR
                half3 bakedDirectSpecular = 0;
                #if defined(BAKED_SPECULAR) && !defined(BAKERYLM_ENABLED) && defined(UNITY_PASS_FORWARDBASE)
                {
                    half3 bakedDominantDirection = 1;
                    half3 bakedSpecularColor = 0;
            
                    // only do it if we have a directional lightmap
                    #if defined(DIRLIGHTMAP_COMBINED) && defined(LIGHTMAP_ON)
                    bakedDominantDirection = (lightMapDirection.xyz) * 2 - 1;
                    half directionality = max(0.001, length(bakedDominantDirection));
                    bakedDominantDirection /= directionality;
                    bakedSpecularColor = indirectDiffuse;
                    #endif
            
                    // if we do not have lightmap - derive the specular from probes
                    #if !defined(LIGHTMAP_ON)
                    bakedSpecularColor = half3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w);
                    bakedDominantDirection = unity_SHAr.xyz + unity_SHAg.xyz + unity_SHAb.xyz;
            
                    // Enable Custom Lightprobes to write to baked specular
                    #if defined(_INTEGRATE_CUSTOMPROBES)
                    {
                        VRCLightVolumesCustomProbesBakedSpecular(o, d, indirectSpecular, bakedSpecularColor, bakedDominantDirection);
                    }
                    #endif
                    #endif
            
                    bakedDominantDirection = normalize(bakedDominantDirection);
                    #if defined(SHADING_MODE_DEFAULT)
                    {
                        bakedDirectSpecular = GetSpecularHighlights(o.Normal, bakedSpecularColor, bakedDominantDirection, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, energyCompensation);
                    }
                    #elif defined(SHADING_MODE_CLOTH)
                    {
                        bakedDirectSpecular = GetSpecularHighlightsCloth(o.Normal, bakedSpecularColor, bakedDominantDirection, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                    }
                    #endif
                }
                #endif
            
                // BAKERY DIRECT SPECULAR
                #if defined(LIGHTMAP_ON) && defined(BAKERY_LMSPEC) && defined(BAKERY_ENABLED) && defined(UNITY_PASS_FORWARDBASE)
                    #if defined(BAKERY_RNM)
                    {
                        float3 viewDirTangent = -Unity_SafeNormalize(d.tangentSpaceViewDir);
                        float3 dominantDirTangent = rnmBasis0 * dot(rnm0, lumaConv) +
                        rnmBasis1 * dot(rnm1, lumaConv) +
                        rnmBasis2 * dot(rnm2, lumaConv);
            
                        float3 dominantDirTangentNormalized = Unity_SafeNormalize(dominantDirTangent);
            
                        half3 specColor = saturate(dot(rnmBasis0, dominantDirTangentNormalized)) * rnm0 +
                        saturate(dot(rnmBasis1, dominantDirTangentNormalized)) * rnm1 +
                        saturate(dot(rnmBasis2, dominantDirTangentNormalized)) * rnm2;
            
                        float3 halfVector = Unity_SafeNormalize(dominantDirTangentNormalized - viewDirTangent);
                        float NoH = saturate(dot(tangentNormal, halfVector));
                        half3 F = 0
                        float D = 0;
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            F =  F_Schlick(NoV, f0);
                            D = D_GGX(NoH, lerp(1, clampedRoughness, _SpecularRoughnessMod)) * energyCompensation;
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            F = _ClothHasCustomSheen ? _ClothSheenColor : albedoSqrt;
                            D = D_Charlie(lerp(1, clampedRoughness, _SpecularRoughnessMod), NoH);
                        }
                        #endif
                        bakedDirectSpecular += D * specColor * F;
                    }
                    #endif
            
                    #if defined(BAKERY_SH)
                    {
                        half3 dominantDir = half3(dot(nL1x, lumaConv), dot(nL1y, lumaConv), dot(L1z, lumaConv));
                        half3 sh = L0 + dominantDir.x * L1x + dominantDir.y * L1y + dominantDir.z * L1z;
                        dominantDir = normalize(dominantDir);
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            bakedDirectSpecular += GetSpecularHighlights(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, energyCompensation);
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            bakedDirectSpecular += GetSpecularHighlightsCloth(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                        }
                        #endif
                    }
                    #endif
            
                    #if defined(BAKERY_MONOSH) && defined(DIRLIGHTMAP_COMBINED)
                    {
                        half3 dominantDir = nL1;
                        half3 sh = L0 + dominantDir.x * L1x + dominantDir.y * L1y + dominantDir.z * L1z;
                        dominantDir = normalize(dominantDir);
                        #if defined(SHADING_MODE_DEFAULT)
                        {
                            bakedDirectSpecular += GetSpecularHighlights(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, energyCompensation);
                        }
                        #elif defined(SHADING_MODE_CLOTH)
                        {
                            bakedDirectSpecular += GetSpecularHighlightsCloth(o.Normal, sh, dominantDir, f0, d.worldSpaceViewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                        }
                        #endif
                    }
                    #endif
                #endif // End of #if defined(BAKERY_LMSPEC) && defined(BAKERY_ENABLED) && !defined(UNITY_PASS_FORWARDADD)
            
                // BAKERY VOLUME SPECULAR
                #if defined(BAKERY_ENABLED) && defined(BAKERY_VOLUME) && defined(BAKERY_LMSPEC) && defined(UNITY_PASS_FORWARDBASE)
                    BakeryVolumeSpecularData volumeSpecularData = GetBakeryVolumeSpecularData(volumeData);
                    #if defined(SHADING_MODE_DEFAULT)
                    {
                        bakedDirectSpecular += GetSpecularHighlights(volumeData.normal, volumeSpecularData.color, volumeSpecularData.direction, f0, volumeData.viewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), volumeSpecularData.NoV, energyCompensation);
                    }
                    #elif defined(SHADING_MODE_CLOTH)
                    {
                        bakedDirectSpecular += GetSpecularHighlightsCloth(volumeData.normal, volumeSpecularData.color, volumeSpecularData.direction, f0, volumeData.viewDir, lerp(1, clampedRoughness, _SpecularRoughnessMod), volumeSpecularData.NoV, albedoSqrt, _ClothHasCustomSheen, _ClothSheenColor);
                    }
                    #endif
                #endif
            
                // REFLECTIONS
                #if !defined(UNITY_PASS_FORWARDADD)
                float3 reflDir = reflect(-d.worldSpaceViewDir, o.Normal);
            
                // Box projection contact hardening is only available on PC
                #if !defined(PLAT_QUEST)
                {
                    // This is based on David M's improved box projection code https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections
                    // Licensed under MIT license, see https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections/blob/master/LICENSE for details
                    // Only used if probe is set to be box projected
                    if (_BoxProjectionContactHardening && unity_SpecCube0_ProbePosition.w > 0)
                    {
                        indirectSpecular = getEnvReflectionHardened(reflDir, d.worldSpacePosition, perceptualRoughness, _BoxProjectionContactHardeningStrength);
                    } else {
                        indirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, o.Normal, perceptualRoughness, -1);
                    }
                }
                #else
                {
                    indirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, o.Normal, perceptualRoughness, -1);
                }
                #endif
            
                half horizon = min(1 + dot(reflDir, o.Normal), 1);
                indirectSpecular *= horizon * horizon;
            
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                {
                    // Clear Coat uses a different roughness and a mesh normal instead of the normal map
                    reflDir = reflect(-d.worldSpaceViewDir, d.worldNormal);
            
                    // Box projection contact hardening is only available on PC
                    #if !defined(PLAT_QUEST)
                    {
                        // This is based on David M's improved box projection code https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections
                        // Licensed under MIT license, see https://github.com/frostbone25/Unity-Improved-Box-Projected-Reflections/blob/master/LICENSE for details
                        // Only used if probe is set to be box projected
                        if (_BoxProjectionContactHardening && unity_SpecCube0_ProbePosition.w > 0)
                        {
                            clearCoatIndirectSpecular = getEnvReflectionHardened(reflDir, d.worldSpacePosition, clearCoatRoughness, _BoxProjectionContactHardeningStrength);
                        } else {
                            clearCoatIndirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, d.worldNormal, clearCoatRoughness, -1);
                        }
                    }
                    #else
                    {
                        clearCoatIndirectSpecular = getEnvReflectionDirect(reflDir, d.worldSpacePosition, d.worldNormal, clearCoatRoughness, -1);
                    }
                    #endif
            
                    half clearCoatHorizon = min(1 + dot(reflDir, d.worldNormal), 1);
                    clearCoatIndirectSpecular *= clearCoatHorizon * clearCoatHorizon;
                    clearCoatIndirectSpecular *= clearCoatMask;
                }
                #endif
            
                half indirectSpecularOcclusion = saturate(length(indirectDiffuse) * (1.0 / _SpecOcclusion));
            
                // We should only add dfg _after_ we calculated spec occlusion factors
                half3 envBRDF = EnvBRDFMultiscatter(dfg, f0);
                indirectDiffuse *= 1.0 - envBRDF;
                indirectSpecular *= envBRDF;
            
                indirectSpecularOcclusion *= lerp(1, lightAttenuation, _RealtimeShadowSpecOcclusion);
            
                half computedSpecularOcclusion = computeSpecularAO(NoV, o.Occlusion * indirectSpecularOcclusion, clampedRoughness);
                computedSpecularOcclusion *= energyCompensation;
                    
                #if defined(BAKED_SPECULAR)
                {
                    bakedDirectSpecular *= saturate(lerp(1, computedSpecularOcclusion, _BakedSpecularOcclusion));
                }
                #endif
            
                indirectSpecular *= gtaoMultiBounce(computedSpecularOcclusion, f0);
            
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                {
                    half clearcoatNoV = abs(dot(d.worldNormal, d.worldSpaceViewDir)) + 1e-5;
                    computedSpecularOcclusion = computeSpecularAO(clearcoatNoV, o.Occlusion * indirectSpecularOcclusion, clampedRoughness);
                    computedSpecularOcclusion *= energyCompensation;
            
                    half3 envBRDF = EnvBRDFMultiscatter(clearcoatdfg, f0);
                    clearCoatIndirectSpecular *= envBRDF;
                    clearCoatIndirectSpecular *= gtaoMultiBounce(computedSpecularOcclusion, f0);
                }
                #endif
            
                #endif // !defined(UNITY_PASS_FORWARDADD)
            
                // Standard-Like transparent (premult alpha)
                if (_RenderType == 2)
                {
                    o.Albedo.rgb *= o.Alpha;
                    o.Alpha = 1 - (oneMinusReflectivity) + o.Alpha * (oneMinusReflectivity);
                }
            
                #if !defined(_NATIVE_A2C) || (!defined(UNITY_PASS_FORWARDBASE))
                {
                    // Standard-Like cutout
                    if (_RenderType == 1)
                    {
                        clip(o.Alpha - _Cutoff);
                    }
                }
                #endif
            
                FinalColor.rgb = o.Albedo.rgb * (oneMinusReflectivity);
            
                half3 customGIDiffuse = 0;
                half3 customGISpecular = 0;
                // Custom GI
                {
                    #if defined(_INTEGRATE_CUSTOMGI) && !defined(UNITY_PASS_FORWARDADD)
                    IntegrateCustomGI(d, o, indirectSpecular, indirectDiffuse);
                    #endif
            
                    #if defined (_INTEGRATE_CUSTOMGI_FLEX) && !defined(UNITY_PASS_FORWARDADD)
                    VRCLightVolumesCustomGI(o, d, indirectDiffuse);
            
                    LTCGICustomGI(d, o, customGISpecular, customGIDiffuse);
                    #endif
                }
            
                // Diffuse Contributions
                half3 diffuseContributions = 0;
                diffuseContributions += mainLightDiffuse;
                diffuseContributions += indirectDiffuse * occlusion;
                diffuseContributions += customGIDiffuse * occlusion;
            
                // Add vertex Lights
                #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                {
                    diffuseContributions += vertexLightDiffuse;
                }
                #endif
            
                // Specular Contributions
                half3 specularContributions = 0;
                specularContributions += mainLightSpecular;
                specularContributions += bakedDirectSpecular;
                specularContributions += indirectSpecular;
                specularContributions += customGISpecular;
            
                // Add vertex Lights
                #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                {
                    specularContributions += vertexLightSpecular;
                }
                #endif
            
                // Add clear coat layer
                #if defined(CLEARCOAT) && defined(SHADING_MODE_DEFAULT)
                {
                    specularContributions += clearCoatMainLightSpecular;
                    specularContributions += clearCoatIndirectSpecular;
            
                    // Add vertex Lights
                    #if defined(SHADE_VERTEXLIGHTS) && defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
                    {
                        specularContributions += clearCoatVertexLightSpecular;
                    }
                #endif
                }
                #endif
            
                // Compositing
                FinalColor.rgb *= diffuseContributions;
                FinalColor.rgb += specularContributions;
            
                if (_RenderType > 1)
                {
                    FinalColor.a = o.Alpha;
                }
                    
                #if defined(UNITY_PASS_FORWARDBASE)
                FinalColor.rgb += o.Emission;
                #endif
            
                // Premulty output by alpha for correct `Fade` mode
                #if defined(UNITY_PASS_FORWARDADD)
                if (_RenderType == 3)
                {
                    FinalColor.rgb *= o.Alpha;
                }
                #endif
            
                #endif // shadowcaster check
            }
            

            void FragmentBaseMetaColor(inout SurfaceData o)
            {
                // Boost emissive for Meta (mostly for RTGI)
                #if defined(UNITY_PASS_META)
                o.Emission *= pow(_GIEmissiveBoost, 2.2);
                #endif
            }
            

            void FragmentBaseColorCorr(inout half4 FinalColor) {
                #if defined(APPLY_COLOR_CORRECTION) && defined(PLAT_QUEST)
                    
                #if defined(MOBILE_TONEMAP_ACES)
                FinalColor.rgb = Tonemap_ACES(FinalColor.rgb);
                #elif defined(MOBILE_TONEMAP_UNREAL)
                FinalColor.rgb = pow(Tonemap_Unreal(FinalColor.rgb), 2.2);
                #elif defined(MOBILE_TONEMAP_UNCHARTED)
                FinalColor.rgb = pow(Tonemap_Uncharted2(FinalColor.rgb),2.2);
                #endif
            
                FinalColor.rgb = applyLiftGammaGainEffect(FinalColor.rgb, _ColorCorrLift, _ColorCorrGamma, _ColorCorrGain);
                #endif
            }
            

            void PBRBaseShadow(SurfaceData o) {
                if (_RenderType == 1)
                {
                    clip(o.Alpha - _Cutoff);
                }
            }
            

            void VertexBase(inout VertexData v, inout FragmentData o)
            {
            
                #if defined(UNITY_PASS_META) && !defined(UNITY_PASS_BAKERY_META)
                o.pos = UnityMetaVertexPosition(v.vertex, v.uv1.xy, v.uv2.xy, unity_LightmapST, unity_DynamicLightmapST);
                #else
                o.pos = TransformObjectToHClip(v.vertex);
                #endif
                o.normal = v.normal;
                o.uv0 = v.uv0;
                o.uv1 = v.uv1;
                o.uv2 = v.uv2;
                o.uv3 = v.uv3;
                #if defined(NEED_UV4)
                o.uv4 = v.uv4;
                #endif
                #if defined(NEED_UV5)
                o.uv5 = v.uv5;
                #endif
                #if defined(NEED_UV6)
                o.uv6 = v.uv6;
                #endif
                #if defined(NEED_UV7)
                o.uv7 = v.uv7;
                #endif
                o.worldPos = mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1));
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldTangent.xyz = UnityObjectToWorldDir(v.tangent.xyz);
                o.worldTangent.w = v.tangent.w * unity_WorldTransformParams.w;
                o.vertexColor = v.color;
            
                #if defined(EDITOR_VISUALIZATION)
                o.vizUV = 0;
                o.lightCoord = 0;
                if (unity_VisualizationMode == EDITORVIZ_TEXTURE)
                {
                    o.vizUV = UnityMetaVizUV(unity_EditorViz_UVIndex, v.uv0.xy, v.uv1.xy, v.uv2.xy, unity_EditorViz_Texture_ST);
                }
                else if (unity_VisualizationMode == EDITORVIZ_SHOWLIGHTMASK)
                {
                    o.vizUV = v.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.lightCoord = mul(unity_EditorViz_WorldToLight, mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1)));
                }
                #endif
            
                #if defined(NEED_SCREEN_POS)
                o.screenPos = GetScreenPosition(o.pos);
                o.screenPos.z = -TransformWorldToView(TransformObjectToWorld(v.vertex)).z;
                #endif
            
                #if !defined(UNITY_PASS_META)
                    #if defined(LIGHTMAP_ON)
                    o.lightmapUv.xy = v.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    #endif
                    #if defined(DYNAMICLIGHTMAP_ON)
                    o.lightmapUv.zw = v.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                    #endif
            
                    UNITY_TRANSFER_LIGHTING(o, v.uv1.xy);
            
                    o.fogData.x = o.pos.z;
                    #if defined(FOG_EXP2)
                    o.fogData.y = 1;
                    #else
                    o.fogData.y = 0;
                    #endif
                #endif
            }
            

            // FreeFunctions

            // ShadowCaster Vertex
            #if !defined(TESS_ENABLED)
            FragmentData Vertex(VertexData v)
            {
                UNITY_SETUP_INSTANCE_ID(v);
                FragmentData o;
                UNITY_INITIALIZE_OUTPUT(FragmentData, o);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                // ShadowCaster Vertex Chain
                VRCFeaturesVertex(v);

                // ShadowCaster VertexBase
                VertexBase(v, o);

                // ShadowCaster PostVertex Chain

                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o);

                return o;
            }
            #endif

            // ShadowCaster Fragment
            half4 Fragment(FragmentData i, bool facing: SV_IsFrontFace
                #if defined(NEED_SV_DEPTH)
                , out float depth: SV_Depth
                #endif
                #if defined(NEED_SV_DEPTH_LEQUAL)
                , out float depth: SV_DepthLessEqual
                #endif
            ) : SV_TARGET
            {
                #if !defined(NEED_SV_DEPTH) && !defined(NEED_SV_DEPTH_LEQUAL)
                float depth = 0;
                #endif
                UNITY_SETUP_INSTANCE_ID(i);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

                #if defined(NEED_FRAGMENT_IN_SHADOW)
                SurfaceData o = CreateSurfaceData();
                MeshData d = CreateMeshData(i, facing);
                half4 FinalColor = 1;

                // ShadowCaster Fragment Chain
                ParallaxFragment(d, i);

                PBRFragment(d, o);

                DetailsFragment(d, o);

                PosterDisplayFragment(i, o);

                ALFragment(d, o);

                FinalColor = half4(o.Albedo, o.Alpha);

                // ShadowCaster Color Chain
                VRCLightVolumesColor(d, facing, FinalColor);

                LTCGIColor(d, i, FinalColor, facing);

                FragmentBaseMetaColor(o);

                FragmentBaseColorCorr(FinalColor);
                #endif

                PBRBaseShadow(o);

                SHADOW_CASTER_FRAGMENT(i);
            }

            ENDCG
            // ShadowCaster Pass End
        }

        // ExtraPasses

        // PostPasses
    }
    CustomEditor "ORL.ShaderInspector.InspectorGUI"
}
