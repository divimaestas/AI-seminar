---
name: summarize-session
description: Append a bulleted summary of what was done in the current Claude Code session to session-history.md at the repo root. Use when the user runs /summarize-session or asks to log, record, or summarize this session's work.
---

# Summarize session

Record what was accomplished in this session as a new entry in `session-history.md` at the repository root.

## Steps

1. **Review the conversation** from the start of this session. Identify the concrete things that were done: files created or edited, commits and pushes, configuration changes, decisions made, and anything left unfinished.

2. **Check git for facts.** Run `git log --oneline` and `git status --short` so commit hashes and uncommitted changes in the summary are accurate. Do not invent work that did not happen.

3. **Read `session-history.md`** if it exists, so the new entry matches its format and does not duplicate an entry already written for this session. If an entry for this same session is already there, update that entry instead of adding a second one.

4. **Append a new entry** to the end of the file. Create the file with a `# Session History` heading first if it does not exist. Use this format:

   ```markdown
   ## YYYY-MM-DD: <short title of the session's main theme>

   - <one thing that was done, written in past tense>
   - <another thing>
   - **Left open:** <anything unfinished or uncommitted, if any>
   ```

   - Use today's date.
   - Write one bullet per meaningful outcome, not per tool call. Aim for 3 to 10 bullets.
   - Start each bullet with a past-tense verb, such as "Added", "Fixed", "Pushed", or "Configured".
   - Name files and branches where it helps a future reader find the work.
   - Include the "Left open" bullet only when something is actually unfinished.
   - Never overwrite or reorder earlier entries. Only append.

5. **Do not commit** the file unless the user asks. Tell the user the entry was added and show it.
