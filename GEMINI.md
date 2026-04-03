# StackScan — Operational Investment Decision Engine

This is an AI skill plugin that runs a 15-step analytical pipeline to turn operations into investment decisions with measurable ROI.

## Entry Point

Use the StackScan command through a single entry point:

- **`/stackscan`** — Start a new project or resume an existing one
- **`/stackscan new`** — Force-start a new project
- **`/stackscan dashboard [project]`** — Generate an interactive HTML dashboard from a completed project

## Key Concepts

- **Investment framing:** Every operational change is framed as a capital allocation decision (cost, return, payback period)
- **Wave-based parallelism:** Steps run in 10 waves with parallel execution where possible
- **Data Resolution Protocol:** Mine data sources before asking the user
- **Assumption Confirmation Gates:** Steps 3, 6, 7 require user confirmation before proceeding
- **Math Transparency:** Every number shows its derivation: `result (= formula)`

## File Structure

All outputs go to `~/.stackscan/` in the user's home directory:
- `~/.stackscan/projects/{project}/` — Company profile, process, and analysis outputs
- Key output: `output/ROI.md` is the centerpiece financial case

## Notes for Gemini CLI

- Use `${extensionPath}` to reference files within this extension directory
- The user-facing entry point is `skills/stackscan/SKILL.md`
- Prompts, references, and intake templates live under `skills/stackscan/`
- Templates for intake are in `templates/`
- Shared reference files are in `references/`
