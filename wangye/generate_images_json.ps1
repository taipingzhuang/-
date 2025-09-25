# 扫描当前目录中图片，生成 images.json
# 用法：在 wangye 目录中执行：
#   .\generate_images_json.ps1

$dir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $dir

$files = Get-ChildItem -File -Include *.jpg,*.jpeg,*.png,*.gif | Where-Object { $_.Name -ne 'images.json' }

# 简单的分类映射规则（可根据需要扩展）：
# fire -> 文件名包含 xfsd
# medical -> jsy
# flood -> fxsd
# tools -> kyq
# communication -> xc
# lighting -> zmd
# protection -> zys
# rescue -> mhq

$categories = @{}
$items = @{}

foreach ($f in $files) {
    $name = $f.Name
    $lower = $name.ToLower()
    $path = "./wangye/$name"

    if ($lower -match 'xfsd') { $categories['fire'] = $path }
    elseif ($lower -match 'jsy') { $categories['medical'] = $path }
    elseif ($lower -match 'fxsd') { $categories['flood'] = $path }
    elseif ($lower -match 'kyq') { $categories['tools'] = $path }
    elseif ($lower -match 'xc') { $categories['communication'] = $path }
    elseif ($lower -match 'zmd') { $categories['lighting'] = $path }
    elseif ($lower -match 'zys') { $categories['protection'] = $path }
    elseif ($lower -match 'mhq') { $categories['rescue'] = $path }
    else {
        # 未匹配的文件，保存在 items 里以文件名（无扩展）为 key
        $key = [System.IO.Path]::GetFileNameWithoutExtension($name)
        $items[$key] = "./wangye/$name"
    }
}

$out = @{ categories = $categories; items = $items } | ConvertTo-Json -Depth 5
$out | Set-Content -Encoding UTF8 images.json
Write-Host "生成 images.json 完成，包含 $($categories.Keys.Count) 类别映射和 $($items.Keys.Count) 项目映射。"