New-NetIPAddress -InterfaceAlias "Ethernet0" -IPAddress 172.16.60.191 -PrefixLength 24 -DefaultGateway 172.16.60.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses 172.16.60.190, 8.8.8.8
$username = "companyx\administrator"
$password = (ConvertTo-SecureString "Pass1234" -AsPlainText -Force)
$credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password
Add-Computer -NewName Client -DomainName CompanyX.local -DomainCredential $credentials
