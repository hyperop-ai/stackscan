# Contributing to StackScan

Thanks for your interest in contributing. This guide covers the main ways to help.

## Ways to Contribute

### Add industry templates

The most impactful contribution. Templates let users skip the intake interview for common business types.

1. Create a new template following the format of `templates/company.md` and `templates/process.md`
2. Include realistic team sizes, tools, pain points, and process steps for the industry
3. Run an analysis with your template to verify it produces good output
4. Submit a PR with the template and a brief description of the industry it covers

### Improve prompt templates

The 15 step prompts in `skills/stackscan/prompts/` drive the analysis quality. If you find a step producing weak output:

1. Run an analysis and note which step underperformed
2. Read the prompt template and identify what's missing or unclear
3. Edit the prompt -- keep the existing structure (Context, Task, Rules, Output sections)
4. Test by re-running that step against test fixtures

### Add or improve reference files

Reference files in `references/` contain shared rules and frameworks. To add a new one:

1. Create the file in `references/` (shared) or `skills/stackscan/references/` (skill-only)
2. Reference it from the relevant prompt template's `## Context` section
3. Update any existing validation or fixture coverage if the reference is critical

### Report issues

Open an issue with:
- What you were analyzing (industry, team size, process type)
- Which step produced the problem
- The actual vs expected output
- Your platform (Claude Code, Cursor, Gemini CLI)

## Development Setup

```bash
git clone https://github.com/hyperop-ai/stackscan.git
cd stackscan
```

## Code Standards

### SKILL.md files
- Must stay under 300 lines. Extract details to reference files.
- Must have frontmatter: name, description, allowed-tools, user-invocable, disable-model-invocation.

### Prompt templates
- Numbered prompts (01-15) must have: `## Context`, `## Task`, `## Output` sections
- Every number must show its derivation (Math Transparency Rule)
- Source and confidence columns are required on all estimate tables

### Investment framing
- Use investment language: allocate, invest, return, payback, portfolio, capital
- Frame recommendations as capital allocation decisions, not just process improvements

### Localization
- The dashboard and outputs must respect the user's locale (French/English)
- Number formatting must match locale (1 250,00 EUR vs EUR 1,250.00)

## Before Submitting

1. If you changed a prompt template, verify it still has the required sections
2. If you added a reference file, verify it's referenced from at least one prompt
3. If you changed the SKILL.md, verify it's under 300 lines

## Pull Request Process

1. Fork the repo and create a branch from `main`
2. Make your changes following the standards above
3. Run the available validation for the area you changed
4. Open a PR with a clear description of what changed and why
5. Link any related issues
