Function MakePsd1 {
    param(
        [Parameter(Mandatory = $true)][string]$ModuleName,
        [Parameter(Mandatory = $true)][string]$Path
    )
    
    [hashtable]$manifest = @{
        Path       = "$Path\$ModuleName.psd1"
        RootModule = "$Path\$ModuleName.psm1"
    }

    New-ModuleManifest @manifest
}