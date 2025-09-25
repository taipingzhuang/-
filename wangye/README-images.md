图片管理与命名约定

目的：使页面能够通过 `wangye/images.json` 管理分类缩略图和物资级图片，方便替换与自动化生成。

文件
- `wangye/images.json`：包含两个字段：
  - `categories`：类别->图片路径 的映射（例：`"fire": "./wangye/xfsd.jpg"`）
  - `items`：物资项（按 id）->图片路径 的映射（可选，覆盖分类缩略图）

命名约定（建议）
- 分类缩略图使用可识别的简称，例如：
  - 消防器材：`xfsd.jpg`
  - 医疗急救：`jsy.jpg`
  - 防汛物资：`fxsd.jpg`
  - 抢险工具：`kyq.jpg`
  - 通讯设备：`xc.jpg`
  - 照明设备：`zmd.jpg`
  - 防护装备：`zys.jpg`
  - 应急救援：`mhq.png`
- 如果为单个物资准备图片，使用物资 id 命名，建议小写、短横连接，例如：`fire-extinguisher.jpg` 对应物资 id `fire-extinguisher`。

自动生成 `images.json`
- 已提供 PowerShell 脚本 `wangye/generate_images_json.ps1`：
  - 在 Windows PowerShell 中进入 `wangye` 目录，运行：

```powershell
# 进入 wangye 目录
Set-Location -Path "c:\Users\Antia\Desktop\wangye"
# 运行生成脚本
.\generate_images_json.ps1
```

- 脚本会根据文件名做简单匹配生成 `categories` 映射，并将未匹配的图片加入 `items` 映射（key 为去除扩展名的文件名）。

手动编辑
- 若需要覆盖自动生成的映射，请直接编辑 `wangye/images.json`，确保路径为相对于 `yjck.html` 的正确相对路径（示例使用 `./wangye/<filename>`）。

页面行为
- 页面在加载时会尝试 fetch `./wangye/images.json`：
  - 成功则使用其中映射；失败则退回到内置默认映射。
  - 若 `items` 中为某物资提供图片，会在物资详情表格中优先显示该图片，否则显示对应分类缩略图。

注意
- 保证图片路径相对于 `yjck.html` 是可访问的（本仓库中 `yjck.html` 与 `wangye/` 同级，因此使用 `./wangye/<file>`）。
- 若部署到服务器，确保 `wangye/` 目录被正确发布并可通过 HTTP 访问。
