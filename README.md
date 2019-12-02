# Actons command System

This allows you to enter commands by writing comments to issues and pull requests.

In order to use this, you just have to add a `yml` file in the `.github/workflows` directory of your repository:

```yaml
on: 
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]

jobs:
  run:
    runs-on: ubuntu-latest
    name: Runs the action
    steps:
    - name: Checkout
      uses: actions/checkout@v1
    - uses: danthe1st/Actions-Command-System@master
      with:
        token: '${{ secrets.GITHUB_TOKEN }}'
```

After adding this file, create an issue, write `/say Hi!` in a comment there and wait a minute.

You should get response containing `Hi!`.
