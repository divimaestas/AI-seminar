# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A documentation-only repository for an AI seminar. There is no source code, build system, package manager, linter, or test suite, so there are no build or test commands to run. Work here means writing and editing Markdown.

## Contents

- `README.md`: the repo title only. It starts with a UTF-8 byte order mark (BOM). Preserve it, or remove it deliberately, rather than changing it as a side effect of an edit.
- `GITHUB_WORKFLOW.md`: a beginner-oriented guide to Git and GitHub concepts (repos, staging and commits, branches, push/pull/fetch, pull requests, merge conflicts, forks, issues, GitHub Actions, the feature branch workflow).

## Conventions in GITHUB_WORKFLOW.md

Keep new or edited material consistent with the existing guide:

- Numbered `##` sections separated by `---` horizontal rules, ending with a "Quick Reference" command table.
- Each concept gets a short plain-language definition, then a fenced `bash` block with commented commands.
- Comparisons use tables. Flows use small ASCII diagrams in plain code blocks.
- Commands use modern Git syntax (`git switch`, `git restore`) rather than `git checkout`.
- The audience is beginners. Prefer concrete examples over exhaustive option lists.

## Git workflow

- `main` is the default branch. The guide itself recommends never working directly on `main`, and this repo follows that: make changes on a feature branch and merge through a pull request.
- Remote: `origin` at `https://github.com/divimaestas/AI-seminar`.
