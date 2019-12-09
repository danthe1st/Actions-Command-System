# commentType
This script tests if a comment is an issue or a PR review comment

Arguments:

- The id of the issue to test (the issue of the event will be used if null)

- The expected type(either `pr` or `issue`, `pr` if empty)

exit code:

- 0 if the expected type matches the real type

- 1 if the expected type **does not** match the real type

- 2 if an error occured

