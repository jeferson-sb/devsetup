#!/bin/bash
# Claude Code statusline: directory, Git state, model, and context usage.

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
dir="$(basename "$cwd")"

BLUE=$'\033[2;34m'
GREY=$'\033[2;37m'
MAGENTA=$'\033[2;35m'
CYAN=$'\033[2;36m'
GREEN=$'\033[2;32m'
YELLOW=$'\033[2;33m'
RED=$'\033[2;31m'
RESET=$'\033[0m'

git_info=""
if git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  dirty=""
  [ -n "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)" ] && dirty="*"
  ahead=$(git -C "$cwd" --no-optional-locks rev-list --count '@{u}..HEAD' 2>/dev/null)
  behind=$(git -C "$cwd" --no-optional-locks rev-list --count 'HEAD..@{u}' 2>/dev/null)
  arrows=""
  [ -n "$behind" ] && [ "$behind" -gt 0 ] 2>/dev/null && arrows="${arrows}⇣"
  [ -n "$ahead" ] && [ "$ahead" -gt 0 ] 2>/dev/null && arrows="${arrows}⇡"
  git_info=" ${GREY}${branch}${dirty}${arrows}${RESET}"
fi

model=$(echo "$input" | jq -r '.model.display_name // .model.id // empty')

used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -z "$used_pct" ]; then
  # Fall back to computing manually if the pre-calculated field is absent
  # (e.g. no assistant response yet this session).
  used_pct=$(echo "$input" | jq -r '
    (.context_window.total_input_tokens // 0) as $used |
    (.context_window.context_window_size // 0) as $size |
    if $size > 0 then ($used / $size * 100) else empty end
  ')
fi

context_info=""
if [ -n "$used_pct" ]; then
  pct=$(awk -v p="$used_pct" 'BEGIN{printf "%d", p + 0.5}')
  [ "$pct" -gt 100 ] 2>/dev/null && pct=100
  [ "$pct" -lt 0 ] 2>/dev/null && pct=0

  ctx_color="$GREEN"
  [ "$pct" -ge 50 ] 2>/dev/null && ctx_color="$YELLOW"
  [ "$pct" -ge 80 ] 2>/dev/null && ctx_color="$RED"

  filled=$((pct / 10))
  empty=$((10 - filled))
  bar=$(printf '%*s' "$filled" '' | tr ' ' '█')
  bar="${bar}$(printf '%*s' "$empty" '' | tr ' ' '-')"

  context_info=" ${ctx_color}[${bar}] ${pct}%${RESET}"
fi

model_info=""
[ -n "$model" ] && model_info=" ${CYAN}${model}${RESET}"

dir_info="📁 ${BLUE}${dir}${RESET}"

printf '%s%s%s%s %s❯%s' "$dir_info" "$git_info" "$model_info" "$context_info" "$MAGENTA" "$RESET"
