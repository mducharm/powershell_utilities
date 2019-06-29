function vi($File) {
    $File = $File -replace "\\", "/" -replace " ", "/"
    bash -c "vi $File"
}

function Get-MyModules {
    [Alias("gmm")]
    param()
    Set-Location $HOME\Documents\WindowsPowerShell\Modules\
}