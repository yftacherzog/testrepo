# Verify Enterprise Contract Task

This task verifies a signature and attestation for an image and then runs a policy against the image's attestation using the ```ec validate image``` command.

## Install the task
kubectl apply -f https://raw.githubusercontent.com/enterprise-contract/ec-cli/main/tasks/verify-enterprise-contract/0.1/verify-enterprise-contract.yaml

## Parameters
### Required
* **IMAGES**: A JSON formatted list of images.
### Optional
* **POLICY_CONFIGURATION**: Name or inline policy in JSON configuration to use. For name `namespace/name` or `name` syntax supported. If
        namespace is omitted the namespace where the task runs is used. For inline policy provide the [specification](https://enterprise-contract.github.io/ecc/main/reference.html#k8s-api-github-com-enterprise-contract-enterprise-contract-controller-api-v1alpha1-enterprisecontractpolicyspec) as JSON.
* **PUBLIC_KEY**: Public key used to verify signatures. Must be a valid k8s cosign
        reference, e.g. k8s://my-space/my-secret where my-secret contains
        the expected cosign.pub attribute.
* **REKOR_HOST**: Rekor host for transparency log lookups
* **SSL_CERT_DIR**: Path to a directory containing SSL certs to be used when communicating
        with external services.
* **STRICT**: Fail the task if policy fails. Set to "false" to disable it.
* **HOMEDIR**: Value for the HOME environment variable.
* **EFFECTIVE_TIME**: Run policy checks with the provided time.


## Usage

This TaskRun runs the Task to verify an image. This assumes a policy is created and stored on the cluster with the namespaced name of `enterprise-contract-service/default`. For more information on creating a policy, refer to the Enterprise Contract [documentation](https://enterprise-contract.github.io/ecc/main/index.html).

```yaml
apiVersion: tekton.dev/v1
kind: TaskRun
metadata:
  name: verify-enterprise-contract
spec:
  taskRef:
    name: verify-enterprise-contract
  params:
  - name: IMAGES
    value: '{"components": ["containerImage": "quay.io/example/repo:latest"]}'
```
