# Lessons Learned — Home SOC Lab

Running notes, gotchas, and fixes discovered during deployment.

---

## 2026-05-02 — Initial Deployment

### WSL2 on D: Drive
- By default WSL installs to C: drive which wastes system drive space
- Solution: export to tar → unregister from C: → import to D:\WSL\Ubuntu
- Command sequence:
  ```powershell
  mkdir D:\WSL
  wsl --export Ubuntu D:\WSL\ubuntu.tar
  wsl --unregister Ubuntu
  wsl --import Ubuntu D:\WSL\Ubuntu D:\WSL\ubuntu.tar --version 2
  wsl --set-default Ubuntu
  ```

### Docker WSL Integration
- Must enable WSL integration for Ubuntu distro in Docker Desktop Settings → Resources → WSL Integration
- Without this, `docker` commands won't work inside WSL terminal

### OpenClaw Dockerfile — Non-Root User Path
- Bug: config path in Dockerfile had a typo (`openclawuser` instead of `openclaw-user`)
- Fixed line:
  ```dockerfile
  echo '{"gateway":{"mode":"local"}}' > /home/openclaw-user/.openclaw/openclaw.json
  ```

### GitHub Student Dev Pack — Model Selection
- Best model for SOC work: `github-copilot/claude-sonnet-4.6` (977k context, reasoning)
- Alternative: `github-copilot/gpt-5` for faster responses

### Memory in OpenClaw
- Memory tab shows "MISSING" until you explicitly create and save MEMORY.md
- Once saved, Defendrix reads it at the start of every session
- Always enable memory hooks during onboarding

### Agent Naming — SENTINEL vs Defendrix
- Initially named SENTINEL but changed to Defendrix during chat initialization
- The name the agent uses in chat takes priority over IDENTITY.md if locked via memory
- To rename: update both IDENTITY.md and MEMORY.md, then re-initialize

---

## Tips & Tricks

- Run `docker logs openclaw` in a new terminal to monitor gateway activity
- Use `docker exec -it openclaw openclaw tui` for terminal UI access
- The Control UI token can be retrieved with: `openclaw config get gateway.auth.token`
- Always back up workspace files before running `openclaw onboard --reset`
