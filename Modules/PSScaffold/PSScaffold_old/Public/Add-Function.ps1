Function Add-Function {
    <#
    .SYNOPSIS
        Generates .ps1 function boilerplate and adds to corresponding folder.
    #>

    param(
        [Parameter(Mandatory = $True)]
        [string]
        $Name,
        [ValidateSet("Public", "Private")]
        [string]$Folder
    )

    [bool]$folderExists = Test-Path ".\$Folder"
    [bool]$psm1 = Test-Path -Path .\*.psm1
    [bool]$psd1 = Test-Path -Path .\*.psd1

    [scriptblock]$createFunction = {
        # [System.IO.FileInfo]$functionPath = New-Item ".\$Folder\$Name.ps1" 
        [string]$functionPath = ".\$Folder\$Name.ps1" 
        New-Item $functionPath
        Add-Content -Path $functionPath -Value "Function $Name {"
        Get-Content ..\Private\Content\function.txt | ForEach-Object { Add-Content $functionPath -Value $_ }
        Add-Content -Path $functionPath -Value "}"
    }

    if ($psm1 -and $psd1 -and $folderExists) {
        try {
            # New-Item ".\$Folder\$Name.ps1"
            & $createFunction
        }
        catch {
            Write-Error "Problem while creating $Name.ps1: $_" 
        }
    }

    if (-not $psm1) {
        Write-Host "Module .psm1 file not located, are you in your module's root directory?" -ForegroundColor Yellow
    }
    if (-not $psd1) {
        Write-Host "Module .psd1 file not located, are you in your module's root directory?" -ForegroundColor Yellow
    }

}