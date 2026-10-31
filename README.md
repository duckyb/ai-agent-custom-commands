# AI agent custom commands

Skills shared by Claude Code and Codex. Each one lives once in
`skills/<name>/SKILL.md`; both tools read the same file.

## Install

```bash
./install.sh
```

This symlinks every skill into `~/.claude/skills` and `~/.codex/skills`.
After that, `git pull` updates both tools. Re-run `./install.sh` after adding
or removing a skill.

## Skills

| Skill | Purpose |
|---|---|
| `ask-apple` | Design, copy and UX review through an Apple design lens |
| `css-guidelines` | SCSS rules and audit checklist |
| `industry-standard` | One-line check against the stack's idiomatic patterns |
| `is-maintainable-audit` | Maintainability score and audit |
| `neff-flow` | NEFF (Net7 Frontend Framework) Angular reference |
| `tokenize-design` | Extract hardcoded SCSS values into design tokens |

`skills/ask-apple/agents/openai.yaml` is Codex-only metadata; Claude Code
ignores it.
