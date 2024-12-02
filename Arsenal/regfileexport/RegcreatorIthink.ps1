function ConvertTo-RegistryHive
{
<#
.SYNOPSIS
Convert a registry-exported  text (contents of a .reg file) to a binary registry hive file.

.EXAMPLE
PS> ConvertTo-RegistryHive -Text (Get-Content my.reg) -Hive my.hive
#>
    param(
        ## The contents of registry exported (.reg) file to convert into the hive.
        [string[]] $Text,
        ## The hive file name to write the result to.
        [parameter(Mandatory=$true)]
        [string] $Hive
    )

    $basefile = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())
    $regfile = $basefile + ".reg"
    $inifile = $basefile + ".ini"
    $subkey = [System.Guid]::NewGuid().ToString()

    &{
        foreach ($chunk in $Text) {
            foreach ($line in ($chunk -split "`r")) {
                $line -replace "^\[\w*\\\w*","[HKEY_LOCAL_MACHINE\$subkey"
            }
        }
    } | Set-Content $regfile

    # Since bcdedit stores its data in the same hives as registry,
    # this is the way to create an almost-empty hive file.
    bcdedit /createstore $Hive
    if (!$?) { throw "failed to create the new hive '$Hive'" }

    reg load "HKLM\$subkey" $Hive
    if (!$?) { throw "failed to load the hive '$Hive' as 'HKLM\$subkey'" }

    try {
        # bcdedit creates some default entries that need to be deleted,
        # but first the permissions on them need to be changed to allow deletion
@"
HKEY_LOCAL_MACHINE\$subkey\Description [1]
HKEY_LOCAL_MACHINE\$subkey\Objects [1]
"@ | Set-Content $inifile
        regini $inifile
        if (!$?) { throw "failed to change permissions on keys in 'HKLM\$subkey'" }
        Remove-Item -LiteralPath "hklm:\$subkey\Description" -Force -Recurse
        Remove-Item -LiteralPath "hklm:\$subkey\Objects" -Force -Recurse

        # now import the file contents
        reg import $regfile
        if (!$?) { throw "failed to import the data from '$regfile'" }
    } finally {
        reg unload "HKLM\$subkey"
        Remove-Item -LiteralPath $inifile -Force
    }

    Remove-Item -LiteralPath $regfile -Force
}

ConvertTo-RegistryHive -Text (Get-Content C:\MyHive.reg) -Hive HiveName