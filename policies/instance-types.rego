package main

import input as params
import future.keywords

allowed_instance_types = { "t2.micro" }

# deny if instances for creation do not have allowed instance types
deny[msg] {
    r := params.resource_changes[_]
    r_address = r.address
    r.type == "aws_instance"
    r_instance_type = r.change.after.instance_type
    "create" in r.change.actions
    not r_instance_type in allowed_instance_types

    msg := sprintf("Forbidden instance type on: %v \n\tInstance_type: %v", [r_address, r_instance_type])
}
