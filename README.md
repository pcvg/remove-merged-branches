# Remove merged branches

Remove the branches that were merged in the branch in which you run this action.

## :warning: Warning

- __Do you really need this?__ GitHub can also delete branches automatically after PR has been merged. See [managing the automatic deletion of branches](https://docs.github.com/en/github/administering-a-repository/managing-the-automatic-deletion-of-branches).
- __This action WILL delete branches!__ Please do your due diligence before using this tool. The provider of this software will not take liability over any mishaps that may occur.

This Action is useful when your workflow does not merge changes (after PR) against your default branch directly.

## :gear: How does it work?

1. Using `git`, all merged branches in the current branch (`$GITHUB_ACTION_REF`) are fetched
2. Branches are removed, except for:
  - current branch
  - the branches added to the ignore list
3. Message is logged for each branch that is removed or ignored

__ATTENTION__: some branches are ignored by default, see [considerations](#considerations).

## :rocket: Running in GitHub Actions

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
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0
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
This project is licensed under the GPL-3.0 License - see the [LICENSE](LICENSE) file for details.
