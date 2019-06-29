Function New-Scaffold {
    <#
    .SYNOPSIS
        Generates boilerplate code for PowerShell module projects.
    #>

    param(
        [Parameter(Mandatory = $True)]
        [string]
        $ModuleName
    )

    # Create directories
    [array]$directories = @(
        "$((Get-Location))\$ModuleName\Public",
        "$((Get-Location))\$ModuleName\Private",
        "$((Get-Location))\$ModuleName\en-US"
    )

    New-Directories $directories
    
    # Create Config files
    New-ConfigFiles $ModuleName
}