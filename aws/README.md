# Project to test policy on resources' tags

This project aims to test the implementation of policy as code on terraform plans. The directory where policy files are stored at the root level is `/policies`.

## Tools
- Policy as code tool: [Open Policy Agent (OPA)](https://www.openpolicyagent.org/docs/latest/).
- Utility to evaluate policies: [Conftest](https://www.conftest.dev/)

## Installation for testing (acloudguru sandbox)
1. [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
2. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
3. [Open Policy Agent (OPA)](https://www.openpolicyagent.org/docs/latest/#running-opa)
4. [Conftest](https://www.conftest.dev/install/)

## Run
```
# terraform setup and generate plan in JSON as for policy evaluation.
terraform init
terraform plan -out tfplan.binary
terraform show -json tfplan.binary > tfplan.json

# Evaluate code against policies defined in root file directory /policies
conftest test tfplan.json --policy=../../../policies/
```

## Test only on policy
A terraform plan in JSON `tfplan.json` is included in this project to allow testing on policy without setting up terraform.
```
# Evaluate code against policies defined in root file directory /policies
conftest test tfplan.json --policy=../../../policies/
```

## Sample output

```
WARN - tfplan.json - main - Tag values are not compliant on: aws_instance.api-canary01 
        Non-compliant tags: [{"OS": "redhat"}]
WARN - tfplan.json - main - Tag values are not compliant on: aws_instance.rpc-canary01 
        Non-compliant tags: [{"Cluster": "rpc"}, {"Service": "rpc"}]
FAIL - tfplan.json - main - Incomplete required tags on: aws_instance.api-canary01 
        Missing tags: ["Cluster"]
FAIL - tfplan.json - main - Incomplete required tags on: aws_instance.api-canary02 
        Missing tags: ["Cluster", "OS"]

4 tests, 0 passed, 2 warnings, 2 failures, 0 exceptions
```

## Next
- test policy evaluation on github actions
