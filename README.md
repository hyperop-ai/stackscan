# StackScan

**Spending too much on tools? Not sure what's working?**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.1.0-green.svg)](CHANGELOG.md)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-plugin-8A2BE2)](https://docs.anthropic.com/en/docs/claude-code)
[![Cursor](https://img.shields.io/badge/Cursor-compatible-blue)]()
[![Gemini CLI](https://img.shields.io/badge/Gemini%20CLI-compatible-orange)]()

StackScan runs a 15-step analysis on your operations and gives you a financial breakdown of every tool, every hour wasted, and exactly what to change, with the math shown. ~20 minutes, ~$2 in LLM costs.

```
$ /stackscan

  Weekly time saved:     4.7 hours
  Monthly tool cost:     +€49/mo
  Monthly net return:    €159/mo (= €208 savings - €49 tools)
  Payback period:        1.6 months

  17 deliverables written to ~/.stackscan/projects/techflow/output/
  Dashboard opened in browser.
```

---

## Built For

- **Agency founders:** 8 people, 14 tools, nobody knows which Slack channel to post in
- **E-commerce operators:** Orders, fulfillment, returns, all copy-pasted between tabs
- **Solo consultants:** Produce investment-grade analysis for clients, fast
- **Bootstrapped SaaS founders:** Spending €2K/mo on tools with no idea what's working

---

## What Makes It Different

- **Every number shows its math.** `109 min/wk (= 35 min x 2 artworks/wk + 15 min x 3 invoices/wk + ...)`
- **You control every assumption.** Edit any input at 3 checkpoints. The analysis recalculates from there.
- **Web-verified tool pricing.** Real prices from live web search, not training data.
- **Investment framing, not tool lists.** Every recommendation tied to ROI and payback period.
- **Automated consistency check.** A quality gate cross-checks all numbers, prices, and names before delivery.
- **No vendor bias.** Open source, MIT licensed. You see every prompt.

---

## Install

```bash
npx skills add hyperop-ai/stackscan
```

Works with any SKILL.md-compatible agent (Claude Code, Cursor, Gemini CLI, Codex, OpenCode, Windsurf, Cline).

---

## Usage

```bash
/stackscan              # Start new project or resume existing one
/stackscan new          # Force-start a new project
/stackscan dashboard    # Generate interactive HTML dashboard
```

### How it works

**Phase 1: Intake** (~5 min): Answer questions about your company, tools, and the process you want to optimize. StackScan mines your codebase, connected tools (Notion, GitHub, Slack via MCP), and the web before asking you anything.

**Phase 2: Analyze** (~12 min): 15-step pipeline runs across 10 waves with parallel execution. Tool discovery, inefficiency mapping, ROI calculation, risk assessment, adoption planning. Each step builds on prior findings. You confirm key assumptions at 3 checkpoints.

**Phase 3: Deliver** (~3 min): 17 deliverable files, an executive investment brief, and an interactive HTML dashboard.

---

## What You Get

```
~/.stackscan/projects/acme-agency/output/
├── ROI.md                  ← Full financial case with per-change payback
├── plan.md                    Research and analysis plan
├── research-findings.md       Tool and market research (web-verified)
├── inefficiencies.md          Operational waste quantification
├── tool-fit.md                Current stack ROI evaluation
├── tool-discovery.md          Alternative tools (if needed)
├── new-process.md             Optimized process design
├── setup.md                   Implementation instructions
├── tool-budget.md             Investment cost breakdown
├── risks.md                   Risk matrix with mitigations
├── diff.md                    Before/after comparison
├── adoption-plan.md           Phased rollout with milestones
├── role-guides/               Per-role transition guides
├── integration-checklist.md   Technical checklist per tool
├── consistency-report.md      Quality gate results
├── action-plan.md             Ranked investments by payback
├── adoption-summary.md        Executive investment brief
└── dashboard.html             Interactive visualization
```

### Sample output

```markdown
## Executive Summary

Your agency currently operates with significant process redundancy across project
management, client communication, and resource allocation. Our analysis identified
12 optimization opportunities with a combined potential savings of $3,200/month.

| Area                 | Current Cost | Optimized  | Savings    |
|----------------------|-------------|------------|------------|
| Project Management   | $840/mo     | $340/mo    | $500/mo    |
| Client Reporting     | 6h/week     | 1.5h/week  | $1,200/mo  |
| Tool Consolidation   | $620/mo     | $280/mo    | $340/mo    |
| Process Automation   | 11h/week    | 3h/week    | $1,160/mo  |
```

---

## The 15-Step Pipeline

Each step builds the investment case across 10 waves (~17 min with parallel execution):

| # | Step | What it does |
|---|------|-------------|
| 1 | Create plan | Define analysis strategy from company profile |
| 2 | Research tools | Web-search pricing, features, and alternatives |
| 3 | **Analyze inefficiencies** | Quantify every time sink with atomic breakdowns |
| 4 | Evaluate tool fit | Rate current tools: GOOD / ADEQUATE / POOR |
| 5 | Discover tools | Find alternatives for poor-rated tools *(conditional)* |
| 6 | **Design process** | Architect the target state with setup + budget |
| 7 | **Calculate ROI** | The core financial engine: savings, costs, payback |
| 8 | Assess risks | Likelihood/impact matrix with mitigations |
| 9 | Generate diff | Side-by-side before/after comparison |
| 10 | Adoption plan | Phased rollout with rollback triggers |
| 11 | Role guides | One personalized guide per role |
| 12 | Integration checklist | Technical checklist per tool integration |
| 13 | Check consistency | Quality gate: cross-checks all numbers |
| 14 | Action plan | Prioritized investments: quick wins first |
| 15 | Executive summary | Investment brief with headline ROI numbers |

**Bold** = assumption confirmation gate (pipeline pauses for your input).

---

## Requirements

- An AI coding assistant that supports SKILL.md (Claude Code, Cursor, Gemini CLI, Codex)
- A web search API key (Tavily) for tool research
- Your data is processed by whichever LLM your AI assistant uses (Anthropic, OpenAI, etc.). StackScan itself collects nothing: no telemetry, no servers.

---

## Project Structure

```
├── skills/
│   └── stackscan/        # Single skill: routing, intake, pipeline, dashboard
│       ├── SKILL.md
│       ├── prompts/      # 15 step prompt templates + intake prompts
│       ├── references/   # Execution model, protocols, step definitions
│       └── templates/    # Intake templates
├── .agents/skills/       # Codex-native mirror for local skill discovery
├── references/           # Shared rules, frameworks, taxonomies
├── templates/            # Intake templates (company.md, process.md)
├── hooks/                # Lifecycle hooks (auto-resume)
└── .claude-plugin/       # Plugin manifest
```

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). The most impactful contribution: **add industry templates** so users can skip intake for common business types.

---

## FAQ

**How is this different from asking ChatGPT?**
ChatGPT gives generic advice from a single prompt. StackScan runs a 15-step pipeline with live web research, quantified ROI per change, and an automated consistency check. You get 17 deliverable files with shown math.

**Is my data safe?**
Your company profile and analysis outputs are stored as local files on your machine. The analysis runs through your AI coding assistant's LLM API (Anthropic, OpenAI, etc.), so your data is sent to that provider under their privacy policy.

**How accurate are the ROI calculations?**
Every number traces back to your inputs: hours x rate = cost. Every assumption is visible and editable. An automated consistency check catches contradictions before delivery.

**Can I run this for multiple clients?**
Yes. Each project is stored in its own directory under `~/.stackscan/projects/{project}/`.

**How much does an analysis cost?**
The tool is free. You pay only for LLM tokens: ~$1.50-$3 per full run depending on model choice.

---

## License

[MIT](LICENSE). Fork it, modify it, use it commercially, contribute back.
