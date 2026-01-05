To obtain the certificates with the DNS-01 challenge, we're using the acmedns
provider hosted on helga. To see how it's configured, see here:

    https://cert-manager.io/docs/configuration/acme/dns01/acme-dns/

Due to a limitation mentioned in that page, we create a pair of credentials for
each domain we want to verify. All instructions are provided in the cert manager
documentation.

When you want to add new credentials for a new domain, you should edit the
`acme-dns` secret in the `cert-manager` namespace.

To add credentials for a new domain to the secret, you can:

1. Get the current secret:
    ```
    $ kubectl get secret cert-manager-acme-dns -n cert-manager -o json | jq -r '.data."acmedns.json"' | base64 --decode > acmedns.json
    ```
    The filname `acmedns.json` is important and should not be changed!
2. Edit the json file to add the new credentials.
    You can obtain new credentials with: `curl -X POST https://auth.helga.teapot.ovh/register | jq`.
3. To update the secret, encrypt the value for storing in the sealedsecret:
    ```
    $ cat acmedns.json | kubeseal --raw --namespace cert-manager --scope namespace-wide | wl-copy
    ```
    Then, update the `data."acmedns.json"` value in `issuers/secret.yaml`.
