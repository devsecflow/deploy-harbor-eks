# Branching Strategy

For our open-source project, we've adopted a simplified GitHub Flow-inspired strategy. This approach balances flexibility with best practices, making it easier for contributors while maintaining code quality.

## Core Principles

1. The `main` branch is always deployable.
2. Work is done in feature branches.
3. Pull Requests (PRs) are the unit of review and integration.
4. Continuous Integration (CI) runs on all branches and PRs.
5. Releases are tagged directly from `main`.

## Detailed Workflow

### Main Branch

- `main`: This branch always contains production-ready code.
- Direct commits to `main` are not allowed; changes come through Pull Requests.

### Feature Branches

- Create a branch from `main` for each new feature, bug fix, or improvement.
- Use a clear, descriptive name for your branch, e.g.:
  - `feature/add-efs-encryption`
  - `bugfix/rds-connection-issue`
  - `docs/update-deployment-guide`

### Working in Branches

1. Create your branch from the latest `main`.
2. Make your changes, committing often with clear, descriptive commit messages.
3. Push your branch to the remote repository regularly.
4. Open a Pull Request early for discussion, marking it as "Draft" if it's not ready for review.

### Pull Requests

- When your work is ready for review, open a Pull Request (or mark it "Ready for Review" if it was a draft).
- Provide a clear description of the changes and the motivation behind them.
- Link any related issues in the PR description.
- Engage in code review discussions.
- Make requested changes in new commits in your branch.
- Once approved and all CI checks pass, the PR can be merged.

### Continuous Integration

- Our CI pipeline runs on all branches and Pull Requests.
- All checks must pass before a PR can be merged.
- CI includes automated tests, linting, and security scans.

### Merging

- We use "Squash and Merge" for most PRs to keep the `main` branch history clean.
- The PR title becomes the commit message on `main`, so ensure it's descriptive.

### Releases

- We tag releases directly from the `main` branch.
- Use semantic versioning for release tags (e.g., v1.2.3).
- Create a GitHub Release for each tag, detailing the changes.

### Hotfixes

- For urgent fixes to production, create a `hotfix/` branch from the latest release tag.
- Follow the normal PR process, but merge directly to `main`.
- After merging, immediately create a new release with an incremented patch version.

## Best Practices

1. Keep branches short-lived. Aim to merge within a few days.
2. Regularly sync your feature branch with `main` to reduce merge conflicts.
3. Write clear, concise commit messages.
4. Use draft PRs for work-in-progress to signal early and get feedback.
5. Engage actively in code reviews, both as an author and a reviewer.

## Benefits of This Strategy

- Simplicity: Easy to understand and follow for new contributors.
- Flexibility: Accommodates various contribution patterns and frequencies.
- Continuous Delivery: Always having a deployable `main` branch enables frequent releases.
- Quality Control: All changes go through PR review and CI checks.
- Community-Friendly: Aligns well with GitHub's features and open-source collaboration patterns.

This strategy aims to strike a balance between structure and flexibility, making it easier for contributors to participate while maintaining high code quality standards. It's designed to be inclusive of both frequent and occasional contributors, which is crucial for open-source projects.

Remember, while this is our recommended workflow, we're open to adjusting it based on the project's and community's needs. If you have suggestions for improvements, please open an issue for discussion.