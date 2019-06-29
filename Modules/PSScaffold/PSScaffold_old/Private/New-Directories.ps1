Function New-Directories {
    <#
    .SYNOPSIS
        Creates specified directories using array of absolute paths.
    #>

    param(
        [array]$Directories
    )
    
    $Directories.ForEach( {
            New-Item $_ -ItemType Directory
        })
}