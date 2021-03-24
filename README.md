# Remove merged branches

Remove the branches that were merged in the branch in which you run this action.

🟡 Do you really need this? Github has the possibility to delete branches automatically after PR. [Check it](https://docs.github.com/en/github/administering-a-repository/managing-the-automatic-deletion-of-branches) 🟡

This Action is useful when your workflow does not merge changes (after PR) against your main branch directly.

## How does it work?

1. Using `git`, all merged branches in the current branch (`$GITHUB_ACTION_REF`) are fetched
2. Branches are removed, exc.:
  - current branch
  - the branches added to the ignore list
3. A message is logged for each branch that is removed or ignored

__ATTENTION__: some branches are ignored by default, see [considerations](#considerations).

## 🚀 Running in GitHub actions

Run this action in Github Actions by adding `pcvg/remove-merged-branches@main` to your steps.

### Parameters

| Name | Meaning                                                                | Default | Required  |
| ---          | ---                                                            | ---     | ---   |
| `protected_branch`    | Branch that will be ignored in the removal process    | -       | false |

### Example

In the below example all branches merged to `main` will be removed:

```yml
name: Remove merged branches
on:
  push:
    branches:
      - main
  
jobs:
  remove-branches:
    runs-on: ubuntu-latest
    steps:
      - name: Remove branches
        uses: pcvg/remove-merged-branches@main
        with:
          protected_branch: some-branch
```

### Considerations
- Any branch that is a copy of the default branch (without any diff) will also be removed
 - Following branches will be ignored and not removed by default:
   - `main`
   - `staging`
   - `production`
   - `master`

## ⚖️ License
This project is licensed under the GPL-3.0 License - see the [LICENSE](LICENSE) file for details