# 🛡️ Home SOC Lab — OpenClaw Deployment

> **An open-source Security Operations Center built on Wazuh + OpenCTI + OpenClaw agent orchestration**  
> Replacing n8n with AI-powered agents for SOC automation.

**Author:** Malaika Umbreen  
**Date:** May 2026  
**Status:** 🟢 Active — Defendrix (Main Agent) Online

---

## 📌 What Is This?

This repository documents the complete deployment of a **personal Home SOC Lab** using fully open-source tools. Instead of traditional workflow automation (n8n), this lab uses **OpenClaw AI agents** to orchestrate SOC tasks — from alert triage to threat intel enrichment and incident reporting.

The main agent, **Defendrix**, acts as the SOC Orchestrator, managing four specialized sub-agents and maintaining persistent memory across sessions.

---

## 🏗️ Architecture



<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/4bafc5d7-03fc-473c-b49f-daadce271b1f" />


### 🧠 Agent Command Structure

| Agent | Role | Status |
|-------|------|--------|
| **Defendrix** | Main SOC Orchestrator — manages all agents, holds memory | 🟢 Online |
| **SCOUT** | Log ingestion & Wazuh alert monitoring | 🟢 Online |
| **ORACLE** | Threat Intel lookups via OpenCTI | 🟢 Online |
| **RESPONDER** | Automated incident response & playbooks | 🟢 Online |
| **SCRIBE** | Incident documentation & audit trail | 🟢 Online |

### 🔁 Default Triage Workflow

```
SCOUT → ORACLE → DEFENDRIX (correlate) → RESPONDER → SCRIBE
```

---

## 🛠️ Tech Stack

| Component | Purpose | Host |
|-----------|---------|------|
| **Wazuh** | Endpoint Detection & Log Analysis | Ubuntu-Wazu-Server (VMware) |
| **OpenCTI** | Threat Intelligence Platform | TBD |
| **OpenClaw** | AI Agent Orchestration (replaces n8n) | Docker / WSL2 |
| **Docker Desktop** | Container runtime | Windows Host |
| **WSL2 (Ubuntu)** | Linux environment on Windows | D:\WSL |
| **GitHub Copilot** | LLM backend (Student Dev Pack) | Cloud |

---

## 📁 Repository Structure

```
home-soc-lab/
│
├── README.md                          # This file
│
├── deployment/
│   ├── Part1-WSL-Setup.md             # WSL2 installation & D: drive migration
│   ├── Part2-Docker-Setup.md          # Docker Desktop + WSL integration
│   ├── Part3-OpenClaw-Install.md      # Dockerfile + docker-compose setup
│   ├── Part4-Onboarding.md            # OpenClaw onboarding & model config
│   └── Part5-Agent-Config.md          # Defendrix identity, memory, USER setup
│
├── openclaw/
│   ├── Dockerfile                     # OpenClaw container definition
│   ├── docker-compose.yml             # Service orchestration
│   └── workspace/
│       ├── IDENTITY.md                # Defendrix identity configuration
│       ├── MEMORY.md                  # Long-term memory & standing orders
│       ├── USER.md                    # Analyst profile (Malaika Umbreen)
│       └── SOUL.md                    # Agent personality & behavior rules
│
├── agents/
│   ├── defendrix/                     # Main orchestrator agent
│   │   └── README.md
│   ├── scout/                         # Wazuh log monitoring agent
│   │   └── README.md
│   ├── oracle/                        # OpenCTI threat intel agent
│   │   └── README.md
│   ├── responder/                     # Incident response agent
│   │   └── README.md
│   └── scribe/                        # Documentation agent
│       └── README.md
│
├── configs/
│   ├── wazuh/
│   │   └── ossec.conf.example         # Wazuh config template
│   └── opencti/
│       └── config.yml.example         # OpenCTI config template
│
├── prompts/
│   ├── defendrix-init.md              # Initial briefing prompt for Defendrix
│   ├── memory-lock.md                 # Standing orders commit prompt
│   └── sub-agent-spawn.md            # Template for spawning mini agents
│
├── docs/
│   ├── OpenClaw_deployment.pdf        # Original deployment report
│   ├── architecture-diagram.md        # SOC architecture overview
│   └── lessons-learned.md             # Running notes & gotchas
│
└── scripts/
    ├── daily-startup.sh               # Start Docker + OpenClaw + verify
    ├── security-audit.sh              # Run openclaw security audit
    └── backup-workspace.sh            # Backup agent workspace files
```

---

## 🚀 Quick Start

### Prerequisites
- Windows 10/11 with WSL2
- Docker Desktop (WSL integration enabled)
- GitHub Student Developer Pack (for free model access)
- Node.js v22+ and npm v11+

### Step 1 — Clone the repo
```bash
git clone https://github.com/YOUR_USERNAME/home-soc-lab.git
cd home-soc-lab
```

### Step 2 — Build and start OpenClaw
```bash
cd openclaw
docker compose up --build -d
```

### Step 3 — Enter the container and onboard
```bash
docker exec -it openclaw bash
openclaw onboard
```

### Step 4 — Access the Control UI
```
http://127.0.0.1:18789/
```

### Step 5 — Initialize Defendrix
Paste the initialization prompt from `prompts/defendrix-init.md` into the Chat tab.

---

##  Security Notes

> ⚠️ **Important:** OpenClaw runs as a local agent with tool execution capability. Follow these practices:

- Run daily security audits:
  ```bash
  openclaw security audit --deep
  openclaw security audit --fix
  ```
- Restart Docker container daily:
  ```bash
  docker restart openclaw
  ```
- Never expose port `18789` to the public internet without authentication
- Keep your API keys out of this repo — use `.env` files or Docker secrets
- Read: https://docs.openclaw.ai/gateway/security

---

## 🧩 Agent Configuration Files

### IDENTITY.md — Who is Defendrix?
Defines the agent's name, creature type, vibe, emoji, and avatar. Filled during first conversation.

### MEMORY.md — Long-Term Memory
Contains standing orders, triage workflow, lab environment map, incident log index, and lessons learned. Updated by SCRIBE after each incident.

### USER.md — About the Analyst
Tells Defendrix about Malaika Umbreen — her role, how she operates, and report conventions.

### SOUL.md — Personality & Behavior
Controls tone, decision-making style, and operational boundaries.

---

## 📋 Configurations

- [ ] Wazuh API URL + auth credentials
- [ ] Wazuh alert delivery method (webhook / polling / log forward)
- [ ] OpenCTI API URL + token
- [ ] Spawn SCOUT sub-agent
- [ ] Spawn ORACLE sub-agent
- [ ] Spawn RESPONDER sub-agent
- [ ] Spawn SCRIBE sub-agent
- [ ] Configure Telegram alerts channel
- [ ] Add web search provider to OpenClaw

---

## 📊 Lab Environment Status

| Component | Host | Status |
|-----------|------|--------|
| Wazuh | Ubuntu-Wazu-Server (VMware) | 🟡 Endpoint TBD |
| OpenCTI | TBD | 🟡 Endpoint TBD |
| OpenClaw / Defendrix | Docker (localhost:18789) | 🟢 Online |
| Kali Linux | VMware | 🟡 Suspended |
| Windows 10 (Target) | VMware | 🟡 Lab Target |
| Pfsense | VMware | 🟡 Network FW |

---

## 📝 Incident Report Format

All reports generated by Defendrix follow this format:

```
Reported by: Defendrix
Reviewed by: Malaika Umbreen (SOC Analyst)
🔵 Defendrix | SOC Orchestrator
```

---

## 📚 Resources

- [OpenClaw Documentation](https://docs.openclaw.ai)
- [OpenClaw Security Hardening](https://docs.openclaw.ai/gateway/security)
- [Wazuh Documentation](https://documentation.wazuh.com)
- [OpenCTI Documentation](https://docs.opencti.io)
- [GitHub Student Developer Pack](https://education.github.com/pack)

---

## 🗺️ Roadmap

- [x] Deploy WSL2 + Docker
- [x] Install and configure OpenClaw
- [x] Initialize Defendrix (main agent)
- [x] Configure IDENTITY.md, MEMORY.md, USER.md
- [x] Deploy Wazuh on Ubuntu-Wazu-Server
- [x] Deploy OpenCTI
- [x] Connect Wazuh → Defendrix pipeline
- [x] Connect OpenCTI → ORACLE pipeline
- [x] Spawn and configure SCOUT
- [x] Spawn and configure ORACLE
- [x] Spawn and configure RESPONDER
- [x] Spawn and configure SCRIBE
- [x] Set up Telegram alert notifications
- [x] Write first automated incident response playbook
- [x] Document first real alert triage

---

*Built by Malaika Umbreen — Home SOC Lab Project, 2026*
