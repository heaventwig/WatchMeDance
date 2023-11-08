# Contributing to WatchMeDance

🌟 First off, thanks for taking the time to contribute! 🌟

The following is a set of guidelines for contributing to WatchMeDance, which is hosted on GitHub. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this (or any) document in a pull request.

## Table of Contents

1. [Code of Conduct](CONDUCT.md)
2. [What should I know before I get started?](#what-should-i-know-before-i-get-started)
   - [Project Design and Architecture](DESIGN_AND_ARCHITECTURE.md)
   - [Technical Specifications and Roadmap](TECH_SPEC_AND_ROADMAP.md)
3. [How Can I Contribute?](#how-can-i-contribute)
   - [Reporting Bugs](#reporting-bugs)
   - [Suggesting Enhancements](#suggesting-enhancements)
   - [Pull Requests](#pull-requests)
4. [Styleguides](#styleguides)
   - [Git Commit Messages](#git-commit-messages)
   - [JavaScript Styleguide](#javascript-styleguide)
   - [Swift Styleguide](#swift-styleguide)
   - [Kotlin Styleguide](#kotlin-styleguide)
   - [Documentation Styleguide](#documentation-styleguide)
5. [Linting](#linting)
6. [Community and Behavioral Expectations](#community-and-behavioral-expectations)

## Code of Conduct
This guide for contributor interactions is important enough that we maintain it as [a separate document](CONDUCT.md).

## What should I know before I get started?

Before you jump into the code, it's a good idea to familiarize yourself with the design philosophy, project structure, and development roadmap of the app. This will help you understand the bigger picture and where your contributions can fit in.

### Project Design and Architecture

See [DESIGN_AND_ARCHITECTURE.md](DESIGN_AND_ARCHITECTURE.md) for an overview of WatchMeDance's design principles and architectural decisions.

### Technical Specifications and Roadmap

Our [TECH_SPEC_AND_ROADMAP.md](TECH_SPEC_AND_ROADMAP.md) outlines the technical specifics and the planned progression of the project.

## How Can I Contribute?

### Reporting Bugs

This section guides you through submitting a bug report. Following these guidelines helps maintainers and the community understand your report, reproduce the behavior, and find related reports.

**Before Submitting A Bug Report:**

- Check the debugging guide — you might be able to find the cause of the problem and fix it yourself.
- Determine [which repository](https://github.com/WatchMeDance) the problem should be reported in.
- Check if the issue has already been reported.
- If you're unable to find an open issue addressing the problem, open a new one. Be sure to include a title and clear description, as much relevant information as possible, and a code sample or an executable test case demonstrating the expected behavior that is not occurring.

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for WatchMeDance, including completely new features and minor improvements to existing functionality. 

**Before Submitting An Enhancement Suggestion:**

- Check if the enhancement has already been suggested.
- Determine which repository the enhancement should be suggested in.
- If you find a suggestion similar to yours, add a comment to the existing issue instead of opening a new one. Otherwise, start the discussion with a new issue.

### Pull Requests

The process described here has several goals:

- Maintain WatchMeDance's quality
- Fix problems that are important to users
- Engage the community in working toward the best possible WatchMeDance

Here are a couple of pointers to keep in mind while making a pull request:

- Fill in the required template
- Follow the [styleguides](#styleguides)
- Keep pull requests small to facilitate easier review
- It can help to include screenshots and animated GIFs in pull requests that produce a visible change in the app or its interface or processes

## Styleguidess

Adhering to style guides helps keep our codebase clean, organized, and accessible to all contributors. Please ensure you follow the language-specific style guides and use the configured linters before submitting your code.

### Git Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line

### JavaScript Styleguide

- All JavaScript must adhere to [JavaScript Standard Style](https://standardjs.com/).
- Ensure that your code passes the linter checks by running `eslint` before committing.

### Swift Styleguide

- All Swift code must follow the [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/).
- We use [SwiftLint](https://github.com/realm/SwiftLint) to enforce the style guide. 
- Run `swiftlint` in your project directory before committing to ensure your code complies with the style guide.

### Kotlin Styleguide

- Kotlin code should adhere to the [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html).
- We use [ktlint](https://github.com/pinterest/ktlint) for linting Kotlin code.
- To check your code, run `ktlint` in your project directory, and address any issues it reports before committing.

### Documentation Styleguide

- Use [Markdown](https://daringfireball.net/projects/markdown/) for all documentation.
- Follow the [Markdown Style Guide](https://cirosantilli.com/markdown-style-guide/) to maintain consistency in documentation formatting.

## Linting

Linting helps us to maintain code quality and consistency throughout our codebase. We have included linter configuration files in the repository to make it easier to comply with our coding standards.

Before submitting a pull request, please make sure to run the linters for your code:

- For JavaScript: `npm run lint` or `yarn lint` (make sure you have `eslint` installed).
- For Swift: `swiftlint` (after installing SwiftLint following the instructions in our `README.md`).
- For Kotlin: `./gradlew ktlintCheck` (if using Gradle) or simply `ktlint` if you have it installed globally.

If there are any linter warnings or errors, please fix them before submitting your pull request. This will speed up the review process and increase the chance of your pull request being merged without additional modifications.


## Community and Behavioral Expectations

In all interactions, we adhere to the Code of Conduct outlined in [CONDUCT.md](CONDUCT.md). This code describes the minimum behavior expectations for all contributors.

---

Again, thank you for your contributions to WatchMeDance. We eagerly anticipate your creative ideas and energy.

Happy coding!
