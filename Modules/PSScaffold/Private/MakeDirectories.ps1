Function MakeDirectories {
    param(
        [Parameter(Mandatory = $true)][string]$ModuleName,
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string[]]$Directories
    )
    
    $Directories.ForEach( {
            New-Item -ItemType Directory -Name $_
        })
    
}