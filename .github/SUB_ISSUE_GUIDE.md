# Sub-Issue Workflow Guide

This guide explains how to use sub-issues effectively in the Expo repository to break down complex work into manageable tasks.

## What are Sub-Issues?

Sub-issues are GitHub issues that represent individual tasks or components of a larger issue (the "parent issue"). They help organize work, track progress, and enable better collaboration on complex features or bug fixes.

## When to Use Sub-Issues

Use sub-issues when:

- A feature or fix requires changes across multiple packages or components
- The work can be parallelized among multiple contributors
- Breaking down the work makes it easier to review and test incrementally
- The parent issue would take more than a few days to complete
- You need to track dependencies between different parts of the work

## Creating Sub-Issues

### Step 1: Create the Parent Issue

First, create a main issue that describes the overall goal or problem. In the issue description, include a section for tracking sub-issues:

```markdown
## Overview

[Describe the overall feature or problem]

## Sub-Issues

- [ ] #XXX - [Sub-issue title 1]
- [ ] #XXX - [Sub-issue title 2]
- [ ] #XXX - [Sub-issue title 3]

## Acceptance Criteria

- [ ] All sub-issues are completed
- [ ] Integration testing passes
- [ ] Documentation is updated
```

### Step 2: Create Individual Sub-Issues

For each sub-task:

1. Click "New Issue" in the repository
2. Select the "📋 Sub-Issue" template
3. Fill out all required fields:
   - **Parent Issue**: Reference the parent issue (e.g., `#3`)
   - **Sub-Issue Title**: Clear, specific title for this task
   - **Description**: What needs to be done and acceptance criteria
   - **Priority**: High, Medium, or Low
   - **Dependencies** (optional): Other sub-issues that must be completed first
   - **Technical Notes** (optional): Implementation details, files to modify
   - **Testing Strategy** (optional): How to test this specific component

4. Submit the issue
5. Update the parent issue's task list with the new sub-issue number

### Step 3: Work on Sub-Issues

When working on a sub-issue:

1. Assign yourself to the sub-issue
2. Create a branch referencing the sub-issue number (e.g., `fix/issue-123-auth`)
3. Make focused changes that address only this sub-issue
4. Write tests specific to this component
5. Submit a PR referencing the sub-issue (e.g., "Closes #123")
6. After merging, check off the sub-issue in the parent issue's task list

## Example Workflow

Let's say we want to add OAuth support to the Expo SDK:

**Parent Issue #100**: "Add OAuth support to Expo SDK"

```markdown
## Overview

Implement OAuth authentication support for the Expo SDK with providers
for Google, GitHub, and Apple.

## Sub-Issues

- [ ] #101 - Core OAuth module architecture
- [ ] #102 - Google OAuth provider
- [ ] #103 - GitHub OAuth provider
- [ ] #104 - Apple OAuth provider
- [ ] #105 - Example app demonstrating OAuth
- [ ] #106 - Documentation for OAuth setup

## Acceptance Criteria

- [ ] All sub-issues completed
- [ ] Works on iOS, Android, and Web
- [ ] E2E tests pass
- [ ] Documentation published
```

Each sub-issue would have:

**Sub-Issue #101**: "Core OAuth module architecture"

- Parent Issue: #100
- Priority: High
- Dependencies: None
- Technical Notes: Create packages/expo-oauth with base classes and interfaces
- Testing: Unit tests for core logic

**Sub-Issue #102**: "Google OAuth provider"

- Parent Issue: #100
- Priority: High
- Dependencies: Requires #101
- Technical Notes: Implement GoogleOAuthProvider extending BaseOAuthProvider
- Testing: Integration tests with Google's OAuth playground

## Best Practices

### Do's ✅

- Keep sub-issues focused on a single component or task
- Reference the parent issue in every sub-issue
- Update the parent issue's task list as sub-issues are created and closed
- Add the `sub-issue` label to sub-issues
- Note dependencies between sub-issues
- Close sub-issues promptly when work is complete
- Keep discussion in the sub-issue comments, summary in parent

### Don'ts ❌

- Don't create sub-issues for trivial tasks that could be checkboxes
- Don't work on dependent sub-issues before their dependencies are complete
- Don't forget to link PRs to their corresponding sub-issues
- Don't close the parent issue until all sub-issues are resolved
- Don't create overlapping sub-issues that modify the same code

## Labels

Common labels to use with sub-issues:

- `sub-issue` - Always add this to sub-issues
- Platform labels: `platform: ios`, `platform: android`, `platform: web`
- Package labels: `expo-auth`, `expo-modules-core`, etc.
- Priority labels: `priority: high`, `priority: medium`, `priority: low`

## Questions?

If you have questions about the sub-issue workflow, ask in:

- The parent issue's discussion thread
- The [Expo Discord](https://chat.expo.dev/) #contributing channel
- Tag `@expo/team` in a comment
