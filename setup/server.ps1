New-NetIPAddress -InterfaceAlias "Ethernet0" -IPAddress 10.128.12.117 -PrefixLength 24 -DefaultGateway 10.128.12.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses 1.1.1.1, 8.8.8.8
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "CompanyX.local" -InstallDNS -DomainMode Win2012R2 -ForestMode Win2012R2 -SafeAdministratorPassword (ConvertTo-SecureString "Pass1234" -AsPlainText -Force) -Confirm:$false
