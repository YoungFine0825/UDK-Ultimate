# UDK-Ultimate
UDK-Ultimate source code

## 构建与运行要求

- 构建：需要 Visual Studio 2008。
- 运行：需要 UDK 安装版中包含资产的文件夹“UDKGame”才能运行游戏。
- 构建：需要安装 DirectX SDK，并设置环境变量 `DXSDK_DIR`。

### DirectX SDK 与环境变量 DXSDK_DIR

构建系统不写死 DirectX SDK 路径，而是统一通过环境变量 `$(DXSDK_DIR)` 引用：

- `Development/Src/UnrealBuildTool/Configuration/UE3BuildWin32.cs`
  - `SystemIncludePaths.Add("$(DXSDK_DIR)/include")`
  - `LibraryPaths.Add("$(DXSDK_DIR)/Lib/x64")` / `"$(DXSDK_DIR)/Lib/x86"`
  - 链接 `dxguid.lib`、`d3d11.lib`（delay load `d3d11.dll`）、`d3d9.lib`
  - 链接 `d3dcompiler.lib`、`d3dx9d.lib`/`d3dx11d.lib`（Debug）、`d3dx9.lib`/`d3dx11.lib`（Release）
- `Development/Tools/ShaderCompileWorker/ShaderCompileWorker.vcproj`：`$(DXSDK_DIR)Include`、`$(DXSDK_DIR)Lib\x86|x64`
- `Development/Tools/UnrealLightmass/UnrealLightmass.vcproj`：`"$(DXSDK_DIR)/include"`、`"$(DXSDK_DIR)/lib/x86|x64"`

因此 `DXSDK_DIR` 未设置或指向错误目录时，编译会直接失败（找不到 d3d9.h / d3dx9.h，或链接不到
dxguid.lib / d3dx9.lib）。

设置方法（按自身 SDK 安装位置设置，二选一）：

1. 命令行（管理员 cmd，永久生效）：

       setx DXSDK_DIR "C:\Path\To\Microsoft DirectX SDK (Version)\" /M

2. GUI：系统属性 → 高级 → 环境变量 → 新建系统变量 `DXSDK_DIR`。

注意结尾必须带反斜杠：源码里按 `$(DXSDK_DIR)/include` 拼接，若缺少结尾 `\` 会拼成
`...Versioninclude` 而失效。

SDK 目录中必须存在：`Include\`（含 `d3d9.h`、`D3D11.h`、`d3dx9.h`、`D3DX11.h`）、
`Lib\x86\`、`Lib\x64\`。

版本提示：UDK/UE3 该年代官方配套版本通常为 DirectX SDK (March/August 2009)。选择其他
版本时，若出现 d3dx9/d3dx11 相关链接或 shader 编译错误，优先怀疑 SDK 版本差异。

注：仓库内有两处与 UDK 主构建无关的历史硬编码路径（`External/GamersSDK/.../VoiceCmd.vcproj`
硬编码 December 2005 路径；`External/nvTextureTools-*/src/cmake/FindDirectX.cmake` 按
`%PROGRAMFILES%\Microsoft DirectX SDK\` 探测），不编译这些外部示例工具时可忽略。
