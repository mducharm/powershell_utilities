. ..\Private\New-ConfigFiles.ps1
Import-Module Pester
# Should create psm1, psd1, and about files

$ModuleName = "TestModule"

New-ConfigFiles -ModuleName $ModuleName



Describe 'New-ConfigFiles' {
    It "creates a .psm1 file" {
        Test-Path "$ModuleName.psm1" | Should -Be True
    }
    It "creates a .psd1 file" {
        Test-Path "$ModuleName.psd1" | Should -Be True
    }
    It "creates a README file" {
        Test-Path "README.md" | Should -Be True
    }
    It "creates an about file" {
        Test-Path "en-US\about_$ModuleName.help.txt" | Should -Be True
    }
}

# Cleanup
if (Test-Path "$ModuleName.psm1") { ri "$ModuleName.psm1" }
if (Test-Path "$ModuleName.psd1") { ri "$ModuleName.psd1" }
if (Test-Path "README.md") { ri "README.md" }
if (Test-Path ".\en-US\about_$ModuleName.help.txt") { ri ".\en-US\about_$ModuleName.help.txt" }
if (Test-Path ".\en-US\") { ri ".\en-US\" -Confirm:$false -Force }