# comment
performs an action to the comments api

Arguments:

- the body that is sent to the api (if it is empty, it will be a HTTP request without any body)

- the HTTP Method that should be used when calling the API (if it is empty, POST will be used)

- the id of the comment, the api call refers to (if it is empty, the call will not refer to any specific comment)

- the id of the issue/PR, the api call refers to (if it is empty, the request will not refer to any specific issue/PR, if it is not a number, the request will refer to the current issue)

Output:

- the output of the request will be sent to stdout

