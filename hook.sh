#!/bin/bash

# commit-msg hook entry point
COMMIT_MSG_FILE=$1
ORIGINAL_MSG=$(cat "$COMMIT_MSG_FILE")
STYLE="${BARD_STYLE:-Shakespeare}"
echo "Using style: $STYLE"

# Check for Gemini API key
if [ -z "$GEMINI_API_KEY" ]; then
  echo "❌ GEMINI_API_KEY is not set. Please export it in your shell."
  exit 1
fi

# Gemini API endpoint
ENDPOINT="https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$GEMINI_API_KEY"

#JSON payload
JSON_DATA=$(jq -n \
  --arg style "$STYLE" \
  --arg msg "$ORIGINAL_MSG" \
  '{contents: [{parts: [{text: "Rewrite this Git commit message in \($style) style. Respond with exactly one short sentence, not a poem or multiple lines."}]}]}')



# Call Gemini API
REWRITTEN_MSG=$(curl -s -X POST "$ENDPOINT" \
  -H "Content-Type: application/json" \
  -d "$JSON_DATA" | jq -r '.candidates[0].content.parts[0].text')

# Fallback if API fails
if [ -z "$REWRITTEN_MSG" ] || [ "$REWRITTEN_MSG" == "null" ]; then
  echo "⚠️ Failed to fetch rewritten message. Keeping original."
  exit 0
fi

# Overwrite the commit message
echo "$REWRITTEN_MSG" > "$COMMIT_MSG_FILE"
echo "✅ Commit message bardified!"
