# Contributing to WatchMeDance

Thanks for taking the time to contribute. WatchMeDance welcomes contributors at any experience level who bring empathy, curiosity, and respect to the work.

These are guidelines, not a substitute for judgment. If a guideline makes a useful contribution harder without protecting users, maintainers, or the project, please raise that concern.

## Before you start

Please skim:

- [CONDUCT.md](CONDUCT.md) for interaction expectations;
- [DESIGN_AND_ARCHITECTURE.md](DESIGN_AND_ARCHITECTURE.md) for current design principles;
- [TECH_SPEC_AND_ROADMAP.md](TECH_SPEC_AND_ROADMAP.md) for product direction and current milestones.

For the current watchOS development loop, see [docs/ALPHA_TESTING.md](docs/ALPHA_TESTING.md).

## Ways to contribute

Useful contributions include code, tests, bug reports, accessibility observations, documentation, design work, research, platform experiments, review, and helping another contributor get unstuck.

### Report a bug

Before opening a new issue, check whether it has already been reported. If not, include:

- what you expected;
- what happened instead;
- the platform/device and relevant OS/app version;
- the smallest reproduction you know;
- logs, screenshots, or recordings only when they add useful evidence and do not disclose sensitive data.

Report issues in this repository: <https://github.com/heaventwig/WatchMeDance/issues>.

### Suggest an enhancement

Describe the user need or problem before prescribing an implementation when possible. If a similar issue exists, add useful evidence there instead of creating a duplicate.

### Pull requests

- Keep a PR as small as is practical while still making a coherent change.
- Explain the user/project outcome, not only the files changed.
- Include or update tests when behavior is deterministic and testable.
- State checks you actually ran and any checks you could not run.
- Screenshots or short recordings are useful for visible interaction changes, but are not required when they add little information.
- Do not bundle unrelated cleanup into a functional change merely because you noticed it nearby.

## Current development commands

From the repository root, the platform-neutral Swift core can be tested with:

```sh
swift test
```

The watchOS app is built with Xcode. Current physical-device steps are in [docs/ALPHA_TESTING.md](docs/ALPHA_TESTING.md).

## Style guides

### Git commit messages

- Use the imperative mood when practical (`Add prompt test`, not `Added prompt test`).
- Keep the subject concise and describe rationale in the body when it will help future readers.
- Reference issues or PRs when they materially explain the change.

### Swift

- Follow the [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/).
- Prefer compiler-checked clarity and small explicit interfaces over cleverness.
- The repository does not currently require SwiftLint. If/when SwiftLint is configured, the checked-in configuration and reproducible command become authoritative.

### Kotlin

When the Wear OS implementation begins:

- follow the [Kotlin coding conventions](https://kotlinlang.org/docs/coding-conventions.html);
- prefer automated formatting/linting such as ktlint once the repository contains an agreed configuration and command.

### JavaScript

JavaScript is not currently part of the app implementation. If it is introduced, document the selected formatter/linter and reproducible command with that code rather than imposing an unused dependency today.

### Documentation

- Use Markdown for repository documentation.
- Prefer short sections, descriptive headings, and direct language.
- Keep factual platform observations distinct from hypotheses and proposed behavior.

## Linting and formatting

Do not install a tool merely because an old document mentions it. Use the formatter, linter, and static-analysis commands that are actually configured in the repository for the code you are changing.

We prefer CI to enforce mechanical style once a tool is adopted so human review can focus on behavior, architecture, accessibility, evidence, and maintainability.

## Community and behavioral expectations

All project interaction is governed by [CONDUCT.md](CONDUCT.md). Contributions of different sizes and kinds should be treated with respect; asking a good question, reproducing a bug, or improving onboarding can be as valuable as writing a large feature.
