Function Add-Function {

    param(
        [Parameter(Mandatory = $true)][string]$FunctionName,
        [Parameter(Mandatory = $true)][string]$ModuleName,
        [ValidateSet("Public", "Private")]$Type
    )

    $Path = (Get-Location)


    [bool]$psm1 = Test-Path "$Path\*.psm1"
    [bool]$psd1 = Test-Path "$Path\*.psd1"
    [bool]$folderExists = Test-Path "$Path\$Type"

    # [string]$psd1Path = 

    if ($psm1 -and $psd1 -and $folderExists) {

        try {
            [string]$functionPath = "$Path\$Type\$FunctionName.ps1"
            New-Item $functionPath
            Add-Content $functionPath -Value "Function $FunctionName {"
            Add-Content $functionPath -Value @'
            
<#
.SYNOPSIS
    Add your function's purpose here.

.PARAMETER example
    Explain parameters like this.

.DESCRIPTION
    Add your function's description here.
#>

param(
    [string]$example
)

    
'@          
            Add-Content $functionPath -Value "}"

            $exportedFunctions = (Test-ModuleManifest -Path $ModuleName.psd1).ExportedFunctions 
            Update-ModuleManifest -Path $ModuleName.psd1 -FunctionsToExport @($exportedFunctions + @($FunctionName))
        }
        catch {
            Write-Error "Unable to create $FunctionName.ps1: $_"
        }
    }

    if (-not $psm1) { Write-Warning "No psm1 file found - are you in your module's root directory?" }
    if (-not $psd1) { Write-Warning "No psd1 file found - are you in your module's root directory?" }
}