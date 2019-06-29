Function MakePsm1 {
    param(
        [Parameter(Mandatory = $true)][string]$ModuleName,
        [Parameter(Mandatory = $true)][string]$Path
    )
    
    New-Item -Path "$Path\$ModuleName.psm1" -Value @'
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

Export-ModuleMember -Function $Public.BaseName    
'@

}