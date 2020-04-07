# Variables for Script Execution
$MyUser = "YourUser"
$MyPlainPW = "YourPw"
$baraServer = "BARA-SRV"
$Client = "ExampleHost1"
$PrimUser = "String"
$Comment = "String2"

# Import Module
Import-Module bConnect

# Create Credential Object
$MyPW = ConvertTo-SecureString -AsPlainText $MyPlainPW -Force
$cred = New-Object System.Management.Automation.PSCredential($MyUser,$MyPW)

# Initialize bConnect Module (maybe use switch '-AcceptSelfSignedCertifcate' in case of certificate errors)
Initialize-bConnect -Server $baraServer -Credentials $cred -a

# Get endpoint-id (maybe specify with '| Where-Object {$_.Name -eq $Client}' in case multiple endpoints are returned and only one is wanted,
# e.g. search term PC12 - returned endpoints PC12 & PC120)
$epGUID = Search-bConnectEndpoint -Term $Client | Where-Object {$_.Name -eq $Client}

# Get endpoint and change registered user and comments in endpoint object
$ep = Get-bConnectEndpoint -EndpointGuid $epGUID.id
$ep.PrimaryUser = $PrimUser
$ep.Comments = $Comment

# Update endpoint
Edit-bConnectEndpoint -Endpoint $ep
