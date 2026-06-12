# Poster Display - VRChat 海报展示组件

这是一款用于在 VRChat 世界中展示海报内容 的组件，适用于公告栏、活动宣传、展览展示、广告位、信息面板等场景。

组件支持通过 网络加载纹理，也支持直接使用 静态纹理资源。用户可以配置多张海报进行轮转展示，并根据实际展示需求自定义切换动画效果。

## 核心功能

- 纹理来源配置
  - 支持通过网络加载纹理，也支持使用项目中的静态纹理资源，适配需要动态更新或固定展示的不同场景。
- 多海报轮转与纹理平铺存储
  - 支持配置多张海报，并按顺序自动切换展示。海报可通过纹理平铺方式进行存储，用户可设置平铺的行数与列数，以适应不同数量的海报轮转需求。
- 自定义切换动画
  - 支持自定义海报切换时的过渡动画持续时间与缓动函数，使海报切换效果更加自然，并适配不同展示风格。

## 适用场景

- VRChat 世界公告栏
- 活动海报展示
- 虚拟展厅信息墙
- 商业广告位
- 社群内容轮播
- 游戏内更新提示面板

## 如何使用

见 [Documentation](Documentation/zh-CN.md)

---

This component is designed for displaying poster content in VRChat worlds. It is suitable for announcement boards, event promotion, exhibition displays, advertising spaces, information panels, and similar use cases.

The component supports both network-loaded textures and static texture assets included in the project. Users can configure multiple posters for rotation and customize the transition animation according to their display requirements.

## Core Features

- Texture Source Configuration
  - Supports loading textures from the network, as well as using static texture assets from the project. This makes it suitable for both dynamically updated content and fixed poster displays.
- Multi-Poster Rotation and Tiled Texture Storage
  - Supports configuring multiple posters and switching between them automatically in sequence. Posters can be stored using a tiled texture layout, with configurable row and column counts to accommodate different numbers of posters.
- Custom Transition Animation
  - Supports customization of poster transition duration and easing functions, allowing smoother switching effects and better adaptation to different display styles.

## Use Cases

- VRChat world announcement boards
- Event poster displays
- Virtual exhibition information walls
- Advertising spaces
- Community content carousels
- In-world update notice panels

## How to Use

See [Documentation](Documentation/)

## Development

### 1. Configure Git for U# (Windows)

The U# compiler makes extensive GUID changes to scene, prefab, and asset files to associate compiled outputs. This causes version control to track numerous irrelevant changes, making it hard to follow real updates. Therefore, we require these volatile changes not be included when committing code modifications. Use the following Git configuration commands with your chosen runtime to automatically filter out these changes and prevent accidental commits.

#### Option 1) Using Python runtime

```sh
git config filter.usharp.process "python .gitscripts/filter_usharp_process.py"
```

#### Renormalized the repository

**<span style="color:red">Note: Whenever the clean filter is changed, the repo should be renormalized. See：[Git - attributes Documentation](https://git-scm.com/docs/gitattributes#:~:text=Note:%20Whenever%20the%20clean%20filter%20is%20changed,%20the%20repo%20should%20be%20renormalized)</span>**

```sh
git add --renormalize .
```

### 2. Configure Git for Unity (Optional)

You can optionally use Unity’s YAML merge tool to handle potential Git merge conflicts (see: [Unity Docs](https://docs.unity3d.com/2022.3/Documentation/Manual/SmartMerge.html)). This tool allows Git to:

> merge scene and prefab and prefab files in a semantically correct way.

**<span style="color:red">⚠ Warning: This tool only guarantees semantic correctness in YAML, not correctness of the actual merged content. You are still responsible for verifying the final result.</span>**

If you understand and require this feature, use the following Git configuration command:

```sh
git config merge.unityyamlmerge.driver '"C:/Program Files/Unity/Hub/Editor/2022.3.22f1/Editor/Data/Tools/UnityYAMLMerge.exe" merge -p "$BASE" "$REMOTE" "$LOCAL" "$MERGED"'
```

Note: The path to `UnityYAMLMerge.exe` may vary depending on your Unity installation method, and should be adapted accordingly.