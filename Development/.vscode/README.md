# VS Code 配置目录 (Development/.vscode)

本目录为在 `Development/` 下用 VS Code 进行 UDK-Ultimate 引擎源码开发而准备的配置。
用 VS Code 直接打开 `Development/` 文件夹（或将其加入工作区）即可生效。

## 文件说明

- settings.json         编辑器/语言关联/排除项/C_Cpp 默认配置
- c_cpp_properties.json IntelliSense 包含路径、宏定义、编译器路径（Win32 / Win64 两套）
- tasks.json            构建任务（调用 Src/Targets/Build.bat）
- launch.json           调试 UDKGame.exe 的启动配置（cppvsdbg）
- extensions.json       推荐扩展（C/C++、C#、EditorConfig）

## 重要前提

1. 构建需要 Visual Studio 2008（工程为 .vcproj / sln Format Version 10.00，MSVC v9 工具集）。
   - tasks.json 中的 “Build: ...” 任务通过 `Src/Targets/Build.bat` 调用
     `Src/Intermediate/UnrealBuildTool/Release/UnrealBuildTool.exe`。
     首次构建前必须先用 VS2008 编译 `Src/UnrealBuildTool/UnrealBuildTool.csproj`（Release），
     否则 Build.bat 会报 “UnrealBuildTool.exe not found”。
   - 构建本质上仍依赖 MSVC v9 编译器；VS Code 只负责编辑与调用，不替代 VS2008 工具链。
2. 需要官方 UDK 安装版中的 `UDKGame` 资产文件夹（含 Content/、Config/、UDKGame.exe 依赖的
   资产）才能实际运行游戏。请将本项目构建出的可执行文件/脚本部署到该 UDK 安装目录下运行，
   或将 UDK 的 `UDKGame` 内容并入运行时目录。
3. c_cpp_properties.json 中的 compilerPath 假设 VS2008 安装在默认路径
   `C:\Program Files (x86)\Microsoft Visual Studio 9.0`。若安装位置不同，请自行修改。
4. 需要安装 DirectX SDK，并设置环境变量 `DXSDK_DIR`。

## DirectX SDK 与环境变量 DXSDK_DIR

构建系统不写死 SDK 路径，而是统一通过环境变量 `$(DXSDK_DIR)` 引用：

- `Src/UnrealBuildTool/Configuration/UE3BuildWin32.cs`
  - 262 行：`SystemIncludePaths.Add("$(DXSDK_DIR)/include")`
  - 265 / 269 行：`LibraryPaths.Add("$(DXSDK_DIR)/Lib/x64" | ".../Lib/x86")`
  - 274、282-285 行：链接 `dxguid.lib`、`d3d11.lib`（delay load `d3d11.dll`）、`d3d9.lib`
  - 292-301 行：链接 `d3dcompiler.lib`、`d3dx9d.lib`/`d3dx11d.lib`（Debug）、`d3dx9.lib`/`d3dx11.lib`（Release）
- `Tools/ShaderCompileWorker/ShaderCompileWorker.vcproj`：`$(DXSDK_DIR)Include`、`$(DXSDK_DIR)Lib\x86` / `\x64`
- `Tools/UnrealLightmass/UnrealLightmass.vcproj`：`"$(DXSDK_DIR)/include"`、`"$(DXSDK_DIR)/lib/x86|x64"`

因此 `DXSDK_DIR` 未设置或指向错误目录时，编译会直接失败（找不到 d3d9.h / d3dx9.h，或链接不到
dxguid.lib / d3dx9.lib）。

设置方法（本机实例）：

    DXSDK_DIR = D:\Env\Microsoft DirectX SDK (June 2010)\

注意结尾必须带反斜杠：源码里按 `$(DXSDK_DIR)/include` 拼接，若缺少结尾 `\` 会拼成
`...June 2010include` 而失效。

命令行设置（管理员 cmd，永久生效）：

    setx DXSDK_DIR "D:\Env\Microsoft DirectX SDK (June 2010)\" /M

或 GUI：系统属性 → 高级 → 环境变量 → 新建系统变量 `DXSDK_DIR`。

必须存在的内容（本机已确认）：`Include\`、`Lib\x86`、`Lib\x64`，且 `Include\` 下有
`d3d9.h`、`D3D11.h`、`d3dx9.h`、`D3DX11.h`、`dxguid.lib`。

版本提示：UDK/UE3 该年代官方配套版本通常为 DirectX SDK (March/August 2009)；本机为
June 2010（微软最后一个独立 DirectX SDK），API 向后兼容，一般可用。若出现 d3dx9/d3dx11
相关链接或 shader 编译错误，优先怀疑 SDK 版本差异。

注：仓库内有两处与 UDK 主构建无关的历史硬编码路径（`External/GamersSDK/.../VoiceCmd.vcproj`
硬编码 December 2005 路径；`External/nvTextureTools-*/src/cmake/FindDirectX.cmake` 按
`%PROGRAMFILES%\Microsoft DirectX SDK\` 探测），不编译这些外部示例工具时可忽略。

## 主要构建入口

    Src/UDK_PC.sln    → 用 VS2008 打开，生产构建/调试
    Src/Targets/Build.bat UDKGame Win32 Debug
    Src/Targets/CleanGame.bat
