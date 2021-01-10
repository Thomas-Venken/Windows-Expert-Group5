New-NetIPAddress -InterfaceAlias "Ethernet0" -IPAddress 172.16.60.190 -PrefixLength 22 -DefaultGateway 172.16.60.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses 1.1.1.1, 8.8.8.8
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "Company1.local" -DomainNetbiosName "COMPANY1" -InstallDNS -DomainMode Win2012 -ForestMode Win2012 -SafeModeAdministratorPassword (ConvertTo-SecureString "Pass1234" -AsPlainText -Force) -Confirm:$false


