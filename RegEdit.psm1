function Open-RegEdit {
	[cmdletbinding()]
	param($Key)
	 
	$Replacements = @{':'='' # Remove PowerShell syntax
					  'HKCU'='HKEY_CURRENT_USER'
					  'HKLM'='HKEY_LOCAL_MACHINE'
					  'HKU'='HKEY_USERS'
					  'HKCC'='HKEY_CURRENT_CONFIG'
					  'HKCR'='HKEY_CLASSES_ROOT'}
	$Replacements.Keys | % {
		$key = $key.ToUpperInvariant().Replace($_, $Replacements[$_])
	}
	Write-Verbose "Open $Key"
	sp HKCU:\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit\ -Name LastKey -Value "$Key" -Force
	regedit -m # Open new instance
}