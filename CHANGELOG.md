# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/).

## [1.1.0] - 2026-03-27

### Changed
- Renamed from ops-analysis to stackscan
- Consolidated 6 skills (analyze, mine, status, compare, dashboard, test) into 3 user-facing skills (new, continue, dashboard)
- Moved storage from project-local `.ops-analysis/` to `~/.stackscan/projects/{project}/`
- Project-based organization: each client/project gets its own directory with company.md, process.md, progress.json, and output/

### Removed
- Separate `analyze`, `mine`, `status`, `compare` skills (functionality merged into `new` and `continue`)
- `.ops-analysis/` local directory and `config.json` / `runs/run-NNN/` structure

## [1.0.0] - 2026-03-27

### Added
- 15-step operational investment analysis pipeline
- 6 skills: analyze, mine, status, compare, dashboard, test (later consolidated in v1.1.0)
- 17 prompt templates (15 pipeline steps + 2 intake interviews)
- 7 shared reference files (helpers, pain taxonomy, search strategy, evaluation pipeline, etc.)
- 7 skill-specific reference files (execution model, communication protocol, etc.)
- Wave-based parallelism (10 waves, 3 parallel) -- ~17 min vs ~25 min sequential
- Hybrid execution model (agent teams + background subagents)
- Data Resolution Protocol (mine sources before asking)
- Assumption Confirmation Gates at steps 3, 6, 7
- Math Transparency Rule (every number shows derivation)
- Interactive HTML dashboard with ROI cards, risk heat map, timeline, tool budget comparison
- French/English localization support
- Chat mode for Claude Desktop and web UIs (no filesystem required)
- Cross-platform support: Claude Code, Cursor, Gemini CLI, Codex, Windsurf
- Lifecycle hooks (auto-resume incomplete runs)
- Agent memory (verified facts persist across runs)
- Test fixtures (TechFlow -- 8-person B2B SaaS) and smoke test suite
- 7-gate tool evaluation pipeline with funnel transparency
- Pain point taxonomy grounded in APQC Process Classification Framework
- Role agenda maps for realistic time bounds
- Automation ceiling rule (70% max savings)
- Marginal returns analysis with 1.5x threshold
- Delegation principle in action plans
- Cost tracking per step in progress.json
