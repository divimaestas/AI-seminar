# GitHub Workflow Concepts

A practical guide to the core ideas behind working with Git and GitHub, from your first commit to collaborating through pull requests.

---

## 1. Git vs. GitHub

| | **Git** | **GitHub** |
|---|---|---|
| What it is | A version control tool that runs on your computer | A website that hosts Git repositories online |
| What it does | Tracks changes to files over time | Adds collaboration: sharing, code review, issues, automation |
| Works offline? | Yes | No |

Git is the engine; GitHub is a place to store and share what Git tracks.

---

## 2. Repository (Repo)

A **repository** is a project folder that Git tracks. It contains your files plus a hidden `.git/` folder holding the full history of every change.

- **Local repo**: the copy on your computer.
- **Remote repo**: the copy on GitHub (usually named `origin`).

```bash
git clone https://github.com/<user>/<repo>.git   # copy a remote repo to your machine
git init                                         # turn an existing folder into a repo
```

---

## 3. The Three Areas: Working Directory → Staging → Commit

Git moves changes through three stages:

```
 Working Directory  ──git add──▶  Staging Area  ──git commit──▶  Repository (history)
 (files you edit)                 (changes queued              (permanent snapshots)
                                   for the next commit)
```

```bash
git status            # see what's changed and what's staged
git add README.md     # stage one file
git add .             # stage everything
git commit -m "Describe what changed and why"
```

### Commits
A **commit** is a saved snapshot of the project with a message, author, timestamp, and a unique ID (hash, e.g. `80ee0cd`).

Good commit habits:
- Make small, focused commits (one logical change each).
- Write messages that explain *what* and *why*, e.g. `Add setup instructions to README`.

```bash
git log --oneline     # view commit history
git diff              # see unstaged changes
```

---

## 4. Branches

A **branch** is an independent line of development. The default branch is usually `main`.

Branches let you work on a feature or fix without affecting `main` until it's ready.

```
main:      A───B───────────E   (merge)
                \         /
feature:         C───D───┘
```

```bash
git branch                    # list branches
git switch -c add-notes       # create and switch to a new branch
git switch main               # switch back to main
```

**Rule of thumb:** never work directly on `main` — create a branch for each task.

---

## 5. Remotes: Push, Pull, Fetch

These commands sync your local repo with GitHub.

| Command | Direction | What it does |
|---|---|---|
| `git push` | local → GitHub | Upload your commits |
| `git fetch` | GitHub → local | Download new commits without changing your files |
| `git pull` | GitHub → local | Fetch **and** merge into your current branch |

```bash
git push -u origin add-notes   # first push of a new branch
git pull                       # get the latest changes
```

---

## 6. Pull Requests (PRs)

A **pull request** is a proposal on GitHub to merge one branch into another (usually into `main`). It's where collaboration happens:

- Shows the exact changes (the **diff**)
- Lets teammates **review**, comment, and request changes
- Runs automated checks (tests, linting)
- Records discussion alongside the code

Typical lifecycle:
1. Push your branch to GitHub.
2. Open a PR from your branch → `main`.
3. Reviewers comment; you push more commits to address feedback.
4. Once approved and checks pass, the PR is **merged**.
5. Delete the branch.

---

## 7. Merging and Merge Conflicts

**Merging** combines the history of two branches.

A **merge conflict** happens when two branches change the same lines of the same file. Git can't decide which to keep, so it marks the file:

```
<<<<<<< HEAD
Text from your branch
=======
Text from the other branch
>>>>>>> main
```

To resolve:
1. Edit the file to keep the correct content and delete the markers.
2. `git add <file>`
3. `git commit` (or continue the merge/rebase).

### Merge strategies on GitHub
- **Merge commit**: keeps all commits plus a merge commit.
- **Squash and merge**: combines all PR commits into one clean commit.
- **Rebase and merge**: replays commits onto `main` for a linear history.

---

## 8. Forks

A **fork** is your own copy of someone else's repository on GitHub. Use forks to contribute to projects you don't have write access to:

1. Fork the repo on GitHub.
2. Clone your fork, create a branch, and make changes.
3. Push to your fork.
4. Open a PR from your fork back to the original repo.

---

## 9. Issues

**Issues** track tasks, bugs, ideas, and questions. They can be:
- Assigned to people
- Labeled (`bug`, `enhancement`, `question`)
- Linked to PRs — writing `Closes #12` in a PR description automatically closes issue #12 when the PR merges.

---

## 10. GitHub Actions (Automated Workflows)

**GitHub Actions** runs automated jobs when something happens in your repo — for example, running tests on every pull request.

Workflows are YAML files stored in `.github/workflows/`:

```yaml
# .github/workflows/ci.yml
name: CI
on: [push, pull_request]        # trigger: when this runs
jobs:
  test:
    runs-on: ubuntu-latest      # the machine it runs on
    steps:
      - uses: actions/checkout@v4   # get the code
      - run: echo "Run tests here"  # a command to execute
```

Key terms:
- **Workflow**: the whole automated process (one YAML file).
- **Event / trigger**: what starts it (`push`, `pull_request`, a schedule).
- **Job**: a group of steps that run on one machine.
- **Step**: a single command or reusable **action**.

---

## 11. Putting It All Together: The Feature Branch Workflow

The most common day-to-day workflow:

```bash
git switch main
git pull                              # 1. start from the latest main
git switch -c my-feature              # 2. create a branch
# ...edit files...
git add .
git commit -m "Add my feature"        # 3. commit your work
git push -u origin my-feature         # 4. push the branch
# 5. open a pull request on GitHub
# 6. address review feedback, push more commits
# 7. merge the PR, then clean up:
git switch main
git pull
git branch -d my-feature
```

---

## 12. Other Useful Pieces

- **`.gitignore`**: lists files Git should never track (e.g. secrets, `node_modules/`, `.env`).
- **`README.md`**: the front page of a repo — explains what the project is and how to use it.
- **Tags / Releases**: mark specific commits as versions (e.g. `v1.0`).
- **Undoing things**:
  - `git restore <file>` — discard unstaged edits to a file
  - `git restore --staged <file>` — unstage a file
  - `git revert <commit>` — create a new commit that undoes an earlier one (safe for shared history)

---

## Quick Reference

| Task | Command |
|---|---|
| Check status | `git status` |
| Stage changes | `git add <file>` |
| Commit | `git commit -m "message"` |
| New branch | `git switch -c <name>` |
| Switch branch | `git switch <name>` |
| Upload | `git push` |
| Download + merge | `git pull` |
| View history | `git log --oneline` |
| See changes | `git diff` |
