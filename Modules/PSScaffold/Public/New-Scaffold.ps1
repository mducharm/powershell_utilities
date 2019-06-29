Function New-Scaffold {

    param(
        [Parameter(Mandatory = $true)][string]$ModuleName
    )

    MakeAbout -ModuleName $ModuleName -Path (Get-Location)
    MakeDirectories -ModuleName $ModuleName -Path (Get-Location) -Directories @("Public", "Private")
    MakePsm1 -ModuleName $ModuleName -Path (Get-Location)
    MakePsd1 -ModuleName $ModuleName -Path (Get-Location)
    
}