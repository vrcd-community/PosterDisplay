# Poster Display

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