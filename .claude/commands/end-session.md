---
description: Trigger the session-recap-writer agent for a named project. Updates projects/<slug>/state.md and decisions.md, then commits on a feature branch and pushes.
argument-hint: <project-slug e.g. competitor-sales>
---

Invoke the `session-recap-writer` agent for project `$ARGUMENTS`.

Pass it:
- Project slug: `$ARGUMENTS`
- Session summary: ask me for a brief summary of what was completed this session before proceeding, unless I have already provided one in this message.

The agent handles all file updates and the branch commit. Do not write or commit anything yourself — delegate entirely to the agent.
