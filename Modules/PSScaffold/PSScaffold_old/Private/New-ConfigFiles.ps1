Function New-ConfigFiles {
    <#
    .SYNOPSIS
        Creates .psm1, .psd1, readme, and about files based on module's name.
    .PARAMETER ModuleName
        The name of your module.
    .DESCRIPTION
        
    #>

    param(
        [Parameter(Mandatory = $True)]
        [string]$ModuleName
    )


    # Create psm1
    [string]$psm1Path = ".\$ModuleName\$ModuleName.psm1"

    [string]$psm1Content = @'
# Loops through Public and Private folders to import functions
$Public = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)
    
Foreach ($import in @($Public + $Private)) {
    try {
        Import-Module $import.fullname
    }
    catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"   
    }
}

# Exports only functions from Public
Export-ModuleMember -Function $Public.BaseName
'@

    try {
        New-Item -Path $psm1Path
        Add-Content -Path $psm1Path -Value $psm1Content
        # Get-Content ..\Private\Content\psm1.txt | ForEach-Object { Add-Content -Path $psm1Path -Value $_ } 
    }
    catch {
        Write-Error "Unable to create $ModuleName.psm1: $_"
    }
    

    # Create psd1
    [hashtable]$manifest = @{
        Path              = ".\$ModuleName\$ModuleName.psd1"
        RootModule        = ".\$ModuleName\$ModuleName.psm1"
        FunctionsToExport = @()
        AliasesToExport   = @()
    }

    New-ModuleManifest @manifest
   

    # Create README
    [string]$readmePath = ".\$ModuleName\README.txt"
    try {
        New-Item -Path $readmePath
        Get-Content ..\Private\Content\readme.txt | ForEach-Object { Add-Content -Path $readmePath -Value $_ }
    }
    catch {
        Write-Error "Unable to create README.md: $_" 
    }

    # Create about file

    [scriptblock]$createAbout = {
        [string]$aboutPath = ".\$ModuleName\en-US\about_$ModuleName.help.txt"
        New-Item -path $aboutPath
        Add-Content $aboutPath -Value "TOPIC"
        Add-Content $aboutPath -Value "`tabout_$($ModuleName)"
        Add-Content $aboutPath -Value ""
        Get-Content ..\Private\Content\about.txt | ForEach-Object { Add-Content -Path $aboutPath -Value $_ }
    }

    try {
        if (-not (Test-Path .\$ModuleName\en-US)) { New-Item -Type Directory .\$ModuleName\en-US }
        & $createAbout
    }
    catch {
        Write-Error "Unable to create about_$ModuleName.help.txt: $_"  
    }

}