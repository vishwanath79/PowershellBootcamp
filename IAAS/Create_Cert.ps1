$certName = "CertVM"

$thumbprint = (New-SelfSignedCertificate -DnsName $certName -CertStoreLocation "cert:\LocalMachine\My")

$cert = (Get-ChildItem -path cert:\Currentuser\My\$thumbprint)

$password Read-Host -Prompt "Please enter certificate password " -AsSecureString
Export-PfxCertificate -Cert $cert -FilePath ".\$certName.pfx" -Password $password



