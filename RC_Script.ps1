$sourcePath = Get-Location

$newFolderName = "AF_HSK_Extension"

$destinationPath = Join-Path -Path $sourcePath -ChildPath $newFolderName

$itemsToCopy = @(
    "LoadFolders.xml",
    "About",
    "Defs",
    "Patches",
    "Textures",
    "RWWeaponModularization"
)

if (-Not (Test-Path -Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath
    Write-Host "Папка створена: $destinationPath"
}

foreach ($item in $itemsToCopy) {
    $sourceItem = Join-Path -Path $sourcePath -ChildPath $item
    $destinationItem = Join-Path -Path $destinationPath -ChildPath $item
    if (Test-Path -Path $sourceItem) {
        Copy-Item -Path $sourceItem -Destination $destinationItem -Recurse -Force
        Write-Host "Скопійовано: $sourceItem до $destinationItem"
    } else {
        Write-Host "Елемент не знайдено: $sourceItem"
    }
}

$zipFilePath = Join-Path -Path $sourcePath -ChildPath "AF_HSK_Extension.zip"
Compress-Archive -Path $destinationPath -DestinationPath $zipFilePath -Force
Write-Host "Папка запакована в архів: $zipFilePath"


Start-Sleep -Seconds 2
Stop-Process -Id $PID
