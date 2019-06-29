. ..\Public\New-Scaffold.ps1
. ..\Private\New-ConfigFiles.ps1
. ..\Private\New-Directories.ps1


# Should result in creation of new module with directories, .psm1 and .psd1 files.

$ModuleName = "TestModule"

New-Scaffold $ModuleName 