# perm
tests the permission of a user

arguments:

- the user whose permission should be tested

- the required permission level of the user (can be empty)

Permission Levels:

- 3...admin

- 2...write/push access

- 1...read/pull access

- 0...no permission/invalid user

Exit Code:

- if a permission level is specified (second argument), 0 will be returned if the user owns this permission

- if no permission level is specified, the permission level will be returned

Output:

- the name of the permission, the user has

