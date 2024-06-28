<h1>mailserver in a TEE</h1>
usng gramine shielded containers 


```
git clone https://github.com/gramineproject/gsc && cd gsc
openssl genrsa -3 -out enclave-key.pem 3072
docker build -t tdx-smtp .
./gsc build --insecure-args tdx-smtp tdx-smtp.manifest
./gsc sign-image tdx:smtp enclave-key.pem
./gsc info-image tdx:smtp
docker run --device=/dev/sgx_enclave \
-v /var/run/aesmd/aesm.socket:/var/run/aesmd/aesm.socket \
tdx-smtp
```

now you can bring web2 things into web3! 
