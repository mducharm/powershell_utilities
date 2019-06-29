function vi($File) {
    <#
    .SYNOPSIS
        Allows you to open a file using Vim. Assumes you have the Git Bash installed.
    .EXAMPLE
        vi .\myFile.ps1

        Opens file in Vim.
    #>

    $File = $File -replace "\\", "/" -replace " ", "/"
    bash -c "vi $File"
}

function Get-MyModules {
    <#
    .SYNOPSIS
        Shortcut for getting to my PowerShell modules folder.
    #>
    [Alias("gmm")]
    param()
    Set-Location $HOME\Documents\WindowsPowerShell\Modules\
}

function Invoke-GitAddCommit {
    <#
    .SYNOPSIS
        Shortcut for adding and committing files using git.
    .EXAMPLE
        Invoke-GitAddCommit "initial commit"
        gac "my commit" .\myFile.ps1
    #>
    [Alias("gac")]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]
        $Message,
        [Parameter(Position = 1)]
        [string]
        $File
    )
    if ($File) {
        git add $File
    }
    else {
        git add .
    }
    git commit -m $Message
}