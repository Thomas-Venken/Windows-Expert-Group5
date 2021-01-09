New-NetIPAddress -InterfaceAlias "Ethernet0" -IPAddress 172.16.60.190 -PrefixLength 24 -DefaultGateway 172.16.60.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses 1.1.1.1, 8.8.8.8
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "CompanyX.local" -InstallDNS -DomainMode Win2012R2 -ForestMode Win2012R2 -SafeAdministratorPassword (ConvertTo-SecureString "Pass1234" -AsPlainText -Force) -Confirm:$false
