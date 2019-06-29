Function MakeAbout {
    param(
        [Parameter(Mandatory = $true)][string]$ModuleName,
        [Parameter(Mandatory = $true)][string]$Path

    )
    New-Item -ItemType Directory en-US
    [System.IO.FileInfo]$aboutFile = New-Item "$Path\en-US\about_$ModuleName.help.txt"

    Add-Content -Path $aboutFile -Value "TOPIC"
    Add-Content -Path $aboutFile -Value "`tabout_$ModuleName"
    Add-Content -Path $aboutFile -Value @'

SHORT DESCRIPTION
    A tool for generating module boilerplate for PowerShell.

LONG DESCRIPTION
    A tool for generating module boilerplate for PowerShell. Allows you to jump right into your project while making it easy to maintain.

DETAILED DESCRIPTION

'@

}