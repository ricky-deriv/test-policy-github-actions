# Simple OPA policy on terraform plan (json)

## Aim
- to test Open Policy Agent (OPA) policies on JSON output of a terraform plan in a Github Action

## Policies
- a policy on instances' tags is created in `policies/tag-policy.rego`.
  - checks if instances created have the required tags.
  - checks if the values added to a certain tag is contained in the allowed list of values.

## Why 
### OPA
- OPA is not tied to an entity such as Sentinel by Hashicorp.
- It has simple policy evaluation rules namely:
  - deny (returns error, denies operation)
  - warn (returns warning, passable operation)
- it has ability to add exceptions if needed.

### Conftest
Conftest is a utility tool used with OPA to evaluate policies.
- to enable evaluation of policy files contained in a directory.
- to have the ability to produce different form of outputs (json, table, etc).

## How
for this example, a terraform plan in JSON has been provided in `\aws\tfplan.json` for a direct evaluation of the policy to skip running terraform operations.
- pull request is the trigger for the evaluation in GitHub Actions.
- conftest is run against `tfplan.json` using the policies defined in `\policies`.
- output of the evaluation of inserted into a comment in the PR.
- an example of this is in this [pull request](https://github.com/ricky-deriv/test-policy-github-actions/pull/42)

## References
- [Open Policy Agent](https://www.openpolicyagent.org/docs/latest/)
- [Conftest](https://www.conftest.dev/)
