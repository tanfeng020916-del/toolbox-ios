# 不要 Mac，用 GitHub 免费编译出 IPA

这条路不需要买任何东西：GitHub 提供免费的 macOS 机器，用它跑 Xcode 把工程编译成
**未签名 IPA**，你下载后丢进全能签签名安装。

## 一次性准备（约 5 分钟）

1. 注册/登录 GitHub（免费）
2. 右上角 **+ → New repository**
   - Repository name：`toolbox-ios`
   - **Public**（公开仓库 macOS 构建完全免费；私有仓库每月只有 200 分钟额度，也够用）
   - 勾 **Add a README file** → Create
3. 进入仓库 → **Add file → Upload files**
   把本目录里的这些**原样**拖进去（注意 `.github` 是隐藏文件夹，拖整个目录层级）：
   ```
   .github/workflows/build.yml
   project.yml
   Sources/WebShellApp.swift
   www/（11 个 html + icons/）
   ```
   → **Commit changes**
4. 点仓库上方 **Actions** 标签 → 左侧 **build-ipa** → 右侧 **Run workflow** → 绿色按钮

## 等 3~6 分钟

构建完成后：

- 进入这次运行 → 页面底部 **Artifacts** → 下载 **WebShell-unsigned-ipa**
- 解压得到 `WebShell-unsigned.ipa`

## 签名安装

把 `WebShell-unsigned.ipa` 导入全能签 → 选你的证书 → 签名 → 安装。

> 这是**未签名**包（没有 `_CodeSignature`、没有 `embedded.mobileprovision`），
> 正是签名工具需要的形态。

## 产物是什么

- 包名 `cn.qingji.toolbox`（可在 `project.yml` 里改 `PRODUCT_BUNDLE_IDENTIFIER`）
- 显示名「授权工具箱」
- 启动即全屏显示 `www/index.html`，10 个签发台都在里面，纯离线
- 最低 iOS 14

## 常见问题

**Q：Actions 里没有 build-ipa 这个 workflow？**
A：`.github/workflows/build.yml` 没传上去（隐藏目录容易漏）。用 Add file → Create new file，
路径填 `.github/workflows/build.yml`，把内容粘进去再提交。

**Q：构建报 `xcodegen: command not found`？**
A：macos-14 镜像自带 brew，正常不会；若失败点开日志，把报错发我。

**Q：想要自己的图标？**
A：把 1024×1024 的 `AppIcon.png` 加到 `Sources/`，在 `project.yml` 的 target 下加
`settings.base.ASSETCATALOG_COMPILER_APPICON_NAME: AppIcon` 并补一个
`Sources/Assets.xcassets`（或者干脆先用默认图标，能装就行）。
