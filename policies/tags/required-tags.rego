package main

import input as params
import future.keywords

required_tags = { "Name", "Service", "Cluster", "Env", "OS" }
allowed_tags_values = {
    "Service": ["api", "qa-box"],
    "Cluster": ["api", "qa-box"],
    "Env": ["qa", "canary"],
    "OS": ["linux", "windows"]
}

# deny if instances for creation do not have complete required tags
deny[msg] {
    r := params.resource_changes[_]
    r_address = r.address
    r.type == "aws_instance"
    "create" in r.change.actions
    keys := object.keys(r.change.after.tags)
    missing_tags := [x | x := required_tags[_]; not x in keys]
    count(missing_tags) != 0

    msg := sprintf("Incomplete required tags on: %v \n\tMissing tags: %v", [r_address, missing_tags])
}

# warn if instances for creation have tag values that are not included
warn[msg] {
    r := params.resource_changes[_]
    r.type == "aws_instance"
    r_address = r.address
    "create" in r.change.actions
    restricted_tag_keys := object.keys(allowed_tags_values)
    tags := r.change.after.tags
    non_compliant_tags := [{x: tags[x]} | x := restricted_tag_keys[_]; not tags[x] in allowed_tags_values[x] ]
    count(non_compliant_tags) != 0

    msg := sprintf("Tag values are not compliant on: %v \n\tNon-compliant tags: %v", [r_address, non_compliant_tags])
}
