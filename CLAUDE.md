# CLAUDE.md — AI Assistant Guide for `portfolio`

This file provides context for AI assistants (Claude Code and others) working in this repository.

---

## Project Overview

A **static portfolio website** for a product manager, built with [Astro](https://astro.build/). The site includes a homepage, blog, projects showcase, resume, and contact page. It is designed for performance — no client-side JavaScript framework, just Astro + Tailwind CSS + minimal vanilla JS for animations.

**Live deployment:** Vercel (config not committed; `.vercel/` is gitignored)

---

## Tech Stack

| Tool | Version | Purpose |
|---|---|---|
| [Astro](https://astro.build/) | ^4.16.0 | Static site generator, file-based routing |
| [Tailwind CSS](https://tailwindcss.com/) | ^3.4.0 | Utility-first styling |
| [@astrojs/tailwind](https://docs.astro.build/en/guides/integrations-guide/tailwind/) | ^5.1.0 | Astro-Tailwind integration |
| TypeScript | via Astro strict config | Type safety |
| npm | — | Package manager |

**No React, Vue, or other component framework.** All components are `.astro` files with server-side rendering only.

---

## Repository Structure

```
portfolio/
├── public/                  # Static assets served as-is
│   ├── favicon.svg
│   └── profile.jpeg
├── src/
│   ├── layouts/             # Shared page wrappers
│   │   ├── BaseLayout.astro # Main layout: nav, header, footer, animations
│   │   └── BlogLayout.astro # Blog post wrapper (extends BaseLayout)
│   ├── pages/               # File-based routing (each file = a route)
│   │   ├── index.astro      # / — Homepage
│   │   ├── projects.astro   # /projects
│   │   ├── blog/
│   │   │   ├── index.astro  # /blog — Post listing
│   │   │   └── *.md         # /blog/<slug> — Individual posts
│   │   ├── resume.astro     # /resume
│   │   └── contact.astro    # /contact
│   ├── styles/
│   │   └── global.css       # Tailwind directives + Google Fonts import
│   └── env.d.ts             # Astro TypeScript type reference
├── astro.config.mjs         # Astro config (Tailwind integration only)
├── tailwind.config.mjs      # Custom theme: fonts, colors
├── tsconfig.json            # Extends astro/tsconfigs/strict
├── package.json
└── package-lock.json
```

---

## Development Commands

```bash
npm run dev       # Start local dev server (http://localhost:4321)
npm run build     # Build for production (output: dist/)
npm run preview   # Preview the production build locally
```

> There is no test runner configured. No linting config (ESLint/Prettier) is present — the project relies on Astro and TypeScript defaults.

---

## Design System & Styling

All styling uses **Tailwind utility classes** — no custom CSS class names or component styles (except animation helpers in BaseLayout).

### Custom Tailwind Theme (`tailwind.config.mjs`)

| Token | Value | Usage |
|---|---|---|
| `font-sans` | DM Sans | Body text, UI |
| `font-serif` | DM Serif Display | Headlines |
| `accent` | `#C4654A` | Links, highlights, brand color (terracotta) |
| `page` | `#FAFAF8` | Page background (off-white/cream) |
| `text-primary` | `#1a1a1a` | Main body text |
| `text-muted` | `#6B7280` | Secondary/subdued text |

### Animation Classes (defined inline in `BaseLayout.astro`)

- `.reveal` — Elements hidden by default, animated in on scroll via `IntersectionObserver`
- `.reveal-delay-1` through `.reveal-delay-4` — Staggered animation delays (100ms increments)
- Logo animation uses SVG path manipulation + `requestAnimationFrame`
- Profile image has scroll-based parallax via `window.scrollY`

---

## Component & Page Conventions

### Astro Components (`.astro` files)

- Props are destructured from `Astro.props` in the component frontmatter (fenced by `---`)
- Layouts wrap pages using `<BaseLayout>` or `<BlogLayout>` components
- No hydration directives (`client:*`) — everything is static/server-rendered

**Typical page structure:**
```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
---
<BaseLayout title="Page Title">
  <section>...</section>
</BaseLayout>
```

### Blog Posts (`.md` files in `src/pages/blog/`)

All posts use YAML frontmatter:
```yaml
---
layout: ../../layouts/BlogLayout.astro
title: "Post Title"
date: "YYYY-MM-DD"
excerpt: "Short summary shown in blog listing"
---
```

Blog index uses `Astro.glob()` to discover and sort posts by date (newest first).

### Projects Data

Projects are defined as an **inline array** in `src/pages/projects.astro`. Each object has:
```ts
{ title: string, description: string, tags: string[], link?: string }
```

To add a project, add an entry to that array.

---

## Key Files to Know

| File | What it does |
|---|---|
| `src/layouts/BaseLayout.astro` | Defines the entire site shell: nav, animations, fonts, footer. Edit here for site-wide layout changes. |
| `src/pages/index.astro` | Homepage content: hero, recent posts, featured projects, "Now" section |
| `tailwind.config.mjs` | Brand colors and fonts — edit here for design system changes |
| `src/styles/global.css` | Google Fonts import and Tailwind base setup |

---

## Git Workflow

- **Main branch:** `master`
- **Feature branches:** `claude/<description>` for AI-assisted work
- Commits are small and descriptive
- No pre-commit hooks or CI pipelines are configured

---

## Adding Content

### New blog post
1. Create `src/pages/blog/<slug>.md`
2. Add required frontmatter (`layout`, `title`, `date`, `excerpt`)
3. Write content in Markdown below the frontmatter

### New project
1. Open `src/pages/projects.astro`
2. Add an object to the `projects` array with `title`, `description`, `tags`, and optionally `link`

### New page
1. Create `src/pages/<name>.astro`
2. Wrap content with `<BaseLayout title="...">`
3. Add a nav link in `src/layouts/BaseLayout.astro` if needed

---

## What to Avoid

- **Do not introduce JavaScript frameworks** (React, Vue, Svelte, etc.) unless explicitly requested — the project intentionally avoids them
- **Do not add CSS class names** outside of Tailwind utilities — keep all styling in utility classes
- **Do not add a test framework** unless asked — no tests currently exist
- **Do not use `client:*` hydration directives** without a clear need — this site is fully static
- **Do not create CMS integrations** — content is file-based by design
