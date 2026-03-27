# AI Product Team — Agent System

15 specialized agents for Claude Code that cover the full product development lifecycle. Copy them into any project and Claude orchestrates them automatically.

---

## Setup (once per machine)

### 1. Add your GitHub token to Claude Code

Go to **Settings → Environment Variables** and add:

```
GITHUB_TOKEN = your_personal_access_token
```

Create a token at GitHub → Settings → Developer settings → Personal access tokens → Fine-grained tokens. Needs **Contents: read** on this repo.

### 2. Install agents in a project

In your project root, run:

```bash
curl -sf -H "Authorization: Bearer $GITHUB_TOKEN" \
  https://api.github.com/repos/mad-marc/agents/contents/install.sh \
  | jq -r '.content' | base64 -d | bash
```

Or clone this repo and run:

```bash
bash ~/agents/install.sh
```

That's it. Claude Code auto-discovers agents in `.claude/agents/` and invokes them.

### 3. Optional: auto-sync on session start

Add this to your project's `.claude/settings.json` to always have the latest agents:

```json
{
  "hooks": {
    "SessionStart": [{
      "hooks": [{
        "type": "command",
        "command": "[ -d .claude/agents ] || bash -c \"curl -sf -H 'Authorization: Bearer $GITHUB_TOKEN' https://api.github.com/repos/mad-marc/agents/contents/install.sh | jq -r '.content' | base64 -d | bash\""
      }]
    }]
  }
}
```

This installs agents automatically the first time you open a session in a new project.

---

## Agents

### Discovery & Strategy
| Agent | Role | Produces |
|-------|------|----------|
| `brand-guidelines` | Brand positioning, personality, visual identity, voice & tone | `BRAND.md` |
| `ux-researcher` | User interviews, usability tests, insight synthesis | `RESEARCH.md` |

### Planning
| Agent | Role | Produces |
|-------|------|----------|
| `product-manager` | PRDs, user stories, backlog, OKRs, prioritization | `BACKLOG.md`, `ROADMAP.md` |
| `architect` | Tech stack, system architecture, infrastructure, security | `ARCHITECTURE.md` |
| `analytics` | North Star metric, KPI tree, tracking plan, dashboards | `ANALYTICS.md`, `TRACKING.md` |

### Design
| Agent | Role | Produces |
|-------|------|----------|
| `ux-agent` | UX flows, design persona, screen-by-screen specs | `DESIGN-PERSONA.md`, `STYLE.md`, `SCREENS.md` |
| `product-designer` | Component library, design tokens, screen redlines | `COMPONENTS.md` |

### Content
| Agent | Role | Produces |
|-------|------|----------|
| `copy-agent` | App voice, all UI text, error messages, empty states | `COPY.md` |
| `content-writer` | Blog posts, onboarding guides, docs, email sequences | `CONTENT.md` |
| `product-marketing` | GTM strategy, positioning, messaging, launch plan | `GTM.md` |

### Engineering
| Agent | Role | Produces |
|-------|------|----------|
| `engineer` | Data models, business logic, REST/GraphQL APIs | `DATA-MODEL.md`, `API.md` |
| `dev-agent` | Frontend: HTML, CSS, JS — built from all specs | Code files |

### Quality
| Agent | Role | Produces |
|-------|------|----------|
| `qa` | Test plans, test cases, edge cases, bug reports | `TEST-PLAN.md`, `BUG-REPORT.md` |
| `critic-agent` | Full project review across business, UX, copy, code | Review report |

---

## Flows

### New project from scratch

```
brand-guidelines → ux-researcher → product-manager
    → architect → ux-agent → product-designer
    → copy-agent → engineer → dev-agent
    → analytics → qa → critic-agent → product-marketing
```

### Add a feature to an existing project

```
product-manager (PRD) → ux-agent (screen specs)
    → product-designer (components) → copy-agent (UI text)
    → engineer (API) + dev-agent (frontend)
    → qa (test plan) → critic-agent (review)
```

### Quick review of existing code

```
critic-agent
```

---

## How it works

Each agent has a `description` in its frontmatter that Claude reads to decide when to invoke it. You don't need to name agents explicitly — describe the task and Claude picks the right one.

```
"Necesito definir la arquitectura para este proyecto"
→ Claude invokes architect automatically
```

Or invoke explicitly:

```
use the product-manager agent to write a PRD for the search feature
```

Agents produce `.md` files that other agents read. The output files accumulate in your project and become the shared context for the whole team.

---

## Output files reference

```
BIZ-BRIEF.md        ← brand-guidelines / product-manager
RESEARCH.md         ← ux-researcher
BRAND.md            ← brand-guidelines
BACKLOG.md          ← product-manager
ROADMAP.md          ← product-manager
ARCHITECTURE.md     ← architect
ANALYTICS.md        ← analytics
TRACKING.md         ← analytics
DESIGN-PERSONA.md   ← ux-agent
STYLE.md            ← ux-agent
SCREENS.md          ← ux-agent
COMPONENTS.md       ← product-designer
COPY.md             ← copy-agent
CONTENT.md          ← content-writer
GTM.md              ← product-marketing
DATA-MODEL.md       ← engineer
API.md              ← engineer
TEST-PLAN.md        ← qa
BUG-REPORT.md       ← qa
```

All agents communicate with the user in Spanish.
