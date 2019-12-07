# entrypoint.sh
This script is called whenever the action is executed

It tests if an issue comment is a command and executes a bash script at /commands/<name> if it is a command

exported Variables:

- GITHUB_TOKEN: the GitHub token(see $1)

- REPO_FULLNAME: the name of the Repository: <username>/<repo-name>

- MESSAGE_AUTHOR: the username of the author of the comment

- GH_EVENT_PATH: the json path in the GITHUB_EVENT_PATH where the data of the event can be found

- API_PATH: the path where requests to the api should be sent to

Arguments:

- The GitHub token to be used

