New-NetIPAddress -InterfaceAlias "Ethernet0" -IPAddress 10.128.12.118 -PrefixLength 24 -DefaultGateway 10.128.12.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses 1.1.1.1, 8.8.8.8
$username = "companyx\administrator"
$password = (ConvertTo-SecureString "Pass1234" -AsPlainText -Force)
$credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password
Add-Computer -NewName Client -DomainName CompanyX.local -DomainCredential $credentials
