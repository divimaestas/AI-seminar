#!/usr/bin/env bash
# Shakespearean insult hook.
#   show   - (sync)  print the cached insult as a systemMessage, instantly
#   refill - (async) ask Haiku for the next insult and cache it
# The Haiku call takes several seconds, so it runs in the background and the
# insult you see on each prompt was generated after the previous one.

CACHE="$HOME/.claude/shakespeare-insult-cache.txt"

# Guard against recursion if the nested claude call ever loads this hook.
[ -n "$SHAKESPEARE_HOOK_ACTIVE" ] && exit 0

case "$1" in
show)
  cat >/dev/null  # drain hook input
  if [ -s "$CACHE" ]; then
    insult=$(head -c 400 "$CACHE")
  else
    fallbacks=(
      "Thou art a boil, a plague sore, an embossed carbuncle. (King Lear)"
      "Away, you starvelling, you elf-skin, you dried neat's-tongue! (Henry IV, Part 1)"
      "Thine face is not worth sunburning. (Henry V)"
      "More of your conversation would infect my brain. (Coriolanus)"
      "Thou art as fat as butter. (Henry IV, Part 1)"
    )
    insult=${fallbacks[$((RANDOM % ${#fallbacks[@]}))]}
  fi
  # Make JSON-safe: flatten newlines, drop backslashes, turn double quotes into single.
  insult=$(printf '%s' "$insult" | tr '\r\n\t' '   ' | tr -d '\134' | tr '"' "'")
  printf '{"systemMessage":"🎭 %s"}\n' "$insult"
  ;;

refill)
  cat >/dev/null
  CLAUDE_BIN=$(command -v claude 2>/dev/null)
  if [ -z "$CLAUDE_BIN" ]; then
    for c in "$LOCALAPPDATA"/Microsoft/WinGet/Packages/Anthropic.ClaudeCode_*/claude.exe \
             "$HOME"/AppData/Local/Microsoft/WinGet/Packages/Anthropic.ClaudeCode_*/claude.exe \
             "$HOME"/.local/bin/claude; do
      [ -x "$c" ] && CLAUDE_BIN=$c && break
    done
  fi
  [ -z "$CLAUDE_BIN" ] && exit 0

  themes=(wit looks smell cowardice laziness manners intellect voice cooking fashion "code quality" "git habits")
  theme=${themes[$((RANDOM % ${#themes[@]}))]}
  prompt="Write one original, playful Shakespearean-style insult about the reader's $theme, under 25 words, using Elizabethan words like thou, thy, knave, varlet. Output only the insult, no quotes or preamble."

  # Run from outside the repo with user settings only, so this project's
  # hooks don't fire inside the nested session.
  out=$(cd "${TMP:-/tmp}" && SHAKESPEARE_HOOK_ACTIVE=1 timeout 60 "$CLAUDE_BIN" -p \
        --model haiku --no-session-persistence --setting-sources user "$prompt" 2>/dev/null)
  out=$(printf '%s' "$out" | tr '\r\n' '  ' | sed 's/^ *//; s/ *$//')
  [ -n "$out" ] && printf '%s\n' "$out" > "$CACHE.tmp" && mv "$CACHE.tmp" "$CACHE"
  exit 0
  ;;
esac
