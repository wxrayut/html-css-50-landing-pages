<#
.SYNOPSIS
    Clones a template directory structure to one or more destination directories.

.DESCRIPTION
    This script copies the contents of a specified template directory to one or more
    target destination directories. If image and font asset folders are missing in the 
    destination, it will create them automatically.

.PARAMETER TemplateTarget
    Path to the template directory to clone from. If not provided or invalid, defaults to '.\00'.

.PARAMETER Destination
    One or more destination directories to copy the template to. Required.

.PARAMETER Recurse
    Indicates that subdirectories and their contents should be copied recursively.

.PARAMETER Force
    Allows the copy to overwrite read-only files or otherwise protected files.

.EXAMPLE
    .\Clone-Template.ps1 -TemplateTarget '.\MyTemplate' -Destination 'Site1', 'Site2' -Recurse -Force

.NOTES
    - The script ensures 'assets/images' and 'assets/fonts' folders exist in each destination.
    - Default asset directory name is 'assets'.
#>

[CmdletBinding()]
param(
    [String]$TemplateTarget = ".\00",
    [String[]]$Destination,
    [Switch]$Recurse,
    [Switch]$Force
)

$AssetDirectoryName = "assets"

if (-not (Test-Path $TemplateTarget)) {
    Write-Error "Template '$TemplateTarget' does not exist."
    exit 1
}

Write-Host "Cloning from: $TemplateTarget"

if (-not $Destination) {
    Write-Error "Please specify at least one destination using: -Destination"
    exit 1
}


foreach ($dest in $Destination) {
    $destPath = ".\$dest"
    Write-Host "Cloning to: $destPath"

    if (-not (Test-Path $destPath)) {
        New-Item -ItemType Directory -Path $destPath | Out-Null
    }

    $copyParams = @{
        Path        = "$TemplateTarget\*"
        Destination = $destPath
    }

    if ($Recurse.IsPresent) {
        $copyParams.Recurse = $true 
    }
    if ($Force.IsPresent) { 
        $copyParams.Force   = $true
    }

    Copy-Item @copyParams

    $ImagePath = "$destPath\$AssetDirectoryName\images"
    $FontPath  = "$destPath\$AssetDirectoryName\fonts"

    foreach ($path in @($ImagePath, $FontPath)) {
        if (-not (Test-Path $path)) {
            New-Item -ItemType Directory -Path $path | Out-Null
        }
    }
}


Write-Host "Done!"
