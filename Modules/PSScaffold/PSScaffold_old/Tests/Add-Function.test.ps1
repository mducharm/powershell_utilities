. ..\Public\Add-Function.ps1

$FunctionName = "Test-Function"

cd .\TestModule

Add-Function $FunctionName -Folder Private
# Add-Function $FunctionName -Folder Public

Describe "Add-Function" {

    It "creates a .ps1 file" {
        Test-Path .\Public\$FunctionName.ps1 | Should -Be True
    }
}

# Cleanup
if (Test-Path .\$FunctionName.ps1) { ri .\$FunctionName.ps1 }
cd ..