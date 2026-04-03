# Chat Mode (No Filesystem)

When the runtime has no filesystem access (Claude Desktop, web chat UIs, mobile apps).

## Detection
If the Write tool is NOT available in the allowed tools, activate chat mode.

## Behavior Changes

### Outputs
- All step outputs are presented inline in the conversation instead of written to files
- Each output is wrapped in clear delimiters:
  ```
  --- inefficiencies.md ---
  [content]
  --- END inefficiencies.md ---
  ```

### State
- progress.json is maintained in-memory (described in conversation) — not persisted
- sharedFacts are tracked verbally: "Shared facts updated: toolFitVerdict = POOR"
- Resume is not supported in chat mode (no persistence)

### Dashboard
- Skip HTML dashboard generation (no browser to open)
- Instead, present a text-based summary dashboard inline:
  - ROI summary in a table
  - Top investments ranked
  - Risk summary
  - Timeline as a text list

### File References
- Instead of "Write to ~/.stackscan/projects/{project}/output/ROI.md", present the content inline
- At the end, offer to export the full analysis as a single markdown artifact (if the platform supports artifacts/downloads)

### Intake
- Mine skill features that require file system (Glob, Read) are unavailable
- Rely entirely on conversation: ask questions, accept pasted content
- WebSearch/WebFetch may still be available for tool research

## Announcement
When chat mode is detected, tell the user:
"Running in chat mode — all outputs will be shown inline in our conversation. No files will be created. At the end, I can compile everything into a single document you can copy."
