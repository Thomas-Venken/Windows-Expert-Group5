Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "CompanyX.local" -InstallDNS -DomainMode Win2012R2 -ForestMode Win2012R2 -SafeAdministratorPassword (ConvertTo-SecureString "Pass1234" -AsPlainText -Force) -Confirm:$false
