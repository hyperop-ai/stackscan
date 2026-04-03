#!/bin/bash
# Validates that a StackScan output file has content and expected sections
# Called by PostToolUse hook on Write operations within ~/.stackscan/

FILE="$1"

# Only validate StackScan project output files
if [[ "$FILE" != *"/.stackscan/projects/"* ]]; then
  exit 0
fi

# Check file has content
if [ ! -s "$FILE" ]; then
  echo "WARNING: StackScan output file is empty: $FILE"
  exit 1
fi

# Check for common issues
if grep -q "As an AI" "$FILE" 2>/dev/null; then
  echo "WARNING: Output contains AI self-reference: $FILE"
fi

if grep -q "significant savings" "$FILE" 2>/dev/null; then
  echo "WARNING: Output contains vague language: $FILE"
fi

SIZE=$(wc -c < "$FILE")
if [ "$SIZE" -lt 100 ]; then
  echo "WARNING: Output suspiciously short ($SIZE bytes): $FILE"
fi

exit 0
