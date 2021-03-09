# Remove merged branches

Remove the branches that were merged in the branch in which you run this action.

🟡 Do you really need this? Github has the possibility to delete branches automatically after PR. [Check it](https://docs.github.com/en/github/administering-a-repository/managing-the-automatic-deletion-of-branches) 🟡

This Action is useful when your workflow does not merge changes (after PR) against your main branch directly.

## How it works?

Using `git` we get all the merged branches in the current branch (`$GITHUB_ACTION_REF`) and then they are removed, except the branch added to the ignore list and the branch that run the action. A message is displayed in the log for each branch removed or ignored. Some additional branches are ignored by default, it is important to check in [considerations](#considerations).

## 🚀 Running in GitHub actions

Run this action in Github Actions adding `pcvg/remove-merged-branches@master` in your steps.

### Parameters

| Name | Meaning                                                                | Default | Required  |
| ---          | ---                                                            | ---     | ---   |
| `protected_branch`    | Branch that will be ignored in the removal process    | -       | false |

### Example

In this example all branches that were merged with `master` will be removed.

```yml
name: Remove merged branches
on:
  push:
    branches:
      - master
  
jobs:
  remove-branches:
    runs-on: ubuntu-latest
    steps:
      - name: Remove branches
        uses: pcvg/remove-merged-branches@master
        with:
          protected_branch: some-branch
```

### Considerations
 - Any branch that is a copy of main(base) branch (without any diff) will also be removed.
 - By default the `staging`, `production` and `master` branches will always be ignored in the removal process.


## ⚖️ License
This project is licensed under the GPL-3.0 License - see the [LICENSE](LICENSE) file for details