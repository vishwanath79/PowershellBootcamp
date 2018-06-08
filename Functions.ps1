function Get-Fullname($firstname,$lastName)
{
    Write-Host ($firstname + " " + $lastName)
}

Get-Fullname "Arcane" "Code"

# Rather than using Set-Variable with its -scope, pass it by ref
#Note however it turns it into an object, this requisitng the .value syntax
function Set-FVar([ref] $myparam)
{
    $myparam.Value = 33
}

Clear-Host

$fvar = 43

"fvar before: $fvar"
Set-FVar([ref] $fvar)
"fvar after: $fvar"

#Read from pipeline

function Get-Coolfiles ()
{
    begin { $retval = "Here are some files: `r`n"}
    process {
        if ($_.Name -like "*.pdf")
        { $retval = $retval + "`t" + $_.Name + "`r`n"}
    }

    end { return $retval}
}

Clear-Host
Get-ChildItem | Get-Coolfiles


#Filters can be built to remove unwanted files
filter Show-PS1Files
{
    $filename = $_.Name
    if ($filename -like "*.ps1")
    {
        return $_
    }
}

Get-ChildItem | Show-PS1Files

#this version doesnt check for ps1, it just lists whats passed in

function List-Filenames()
{
    begin { $retval = "Here are some cool files: `r` " }
    process {
    $retval = $retval + "`t" + $_.Name + "`r`n"
}
    end { return $retval }
    }

Get-ChildItem | List-Filenames

#Combine the two for real flexibility
Get-ChildItem | Show-PS1Files | List-Filenames

#Output pipelines

Set-Location "/Users/vsubrama/Projects/Azure/Powershell"
Get-ChildItem | Select-Object "Name"

function Get-ChildName ()
{
    Write-Output (Get-ChildItem | Select-Object "Name")
}

Get-ChildName | Where-Object {$_.Name -like "*.ps1"}

