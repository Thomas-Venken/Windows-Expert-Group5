Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "CompanyX.local" -CreateDNSDelegation -DomainMode Win2012R2 -ForestMode Win2012R2 -SafeAdministratorPassword (ConvertTo-SecureString "Pass1234" -AsPlainText -Force)
