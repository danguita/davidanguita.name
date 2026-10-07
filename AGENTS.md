# AGENTS.md

Personal site of David Anguita: a **Middleman 4.3.6** static site (Ruby 2.4.3,
HAML + SCSS, `middleman-blog`), built and hosted on **Netlify**. No application
runtime, database, or JS framework — a single vanilla `application.js` handles
the theme toggle and mobile nav.

## Build & run — always via Docker

There is **no local Ruby**. Every command runs in the prebuilt image
`danguita/davidanguita.name:latest` (Ruby 2.4.3-alpine, mirrors Netlify).

- Build the site (clear `build/` first):
  `docker run --rm -v "$(pwd)":/app danguita/davidanguita.name:latest sh -c 'rm -rf /app/build && bundle exec middleman build'`
- Dev server: `make server` → http://localhost:4567
- Rebuild the image (only after changing `Gemfile`/`Gemfile.lock`): `make build`
- Shell: `make shell`

Netlify runs `bundle exec middleman build` and publishes `build/`.

**Gotchas**
- Docker writes `build/` as **root**, so a later `rm -rf build` fails. Clean it
  through Docker:
  `docker run --rm -v "$(pwd)":/app danguita/davidanguita.name:latest sh -c 'rm -rf /app/build'`
- After editing `lib/*.rb` or `config.rb`, restart the dev-server container
  (`docker restart <container>`); the running server won't pick it up.

## Content model

- UI copy lives in `locales/en.yml` (`activate :i18n, mount_at_root: :en`).
- Structured content: `data/services.yml`, `data/clients.yml`,
  `data/settings.yml` (domain, social links, contact).
- Blog posts: `source/articles/{year}-{month}-{day}-{title}.html` (Markdown
  body), permalink `articles/{title}.html`; layouts in `source/layouts/`.
- `lib/*.rb` helpers load only because `config.rb` requires them — register new
  helpers there too.

## Build-time behavior that will surprise you

- `config.rb` `after_build` does two things:
  1. Rewrites article `<img>`/`<pre>` to add `loading`/`decoding`/`tabindex`.
  2. Recomputes SHA-256 hashes of every inline `<script>` and substitutes the
     `%SCRIPT_HASHES%` placeholder in `source/_headers`. Keep the placeholder and
     the block; never add `'unsafe-inline'` to `script-src`.
- `activate :asset_hash` fingerprints `/assets/*` and rewrites relative
  `url()`/`src`/`srcset` references — but **not absolute URLs**. Route absolute
  asset URLs through `image_path`/`asset_path`.
- `image_dimensions` reads the **PNG** client-logo fallbacks; don't delete the
  PNGs even though WebP is served.
- libsass can't evaluate **mixed units** in one declaration (e.g.
  `clamp(1rem, 1rem + 1vw, 2rem)` fails). Use vw-only middles, or put the
  expression in a CSS custom property.
- `page_classes` puts `articles` on `<body>`, so bare `.articles` selectors hit
  the body. Scope page rules to `section.articles`, `article.article`, etc.
- `sassc` is pinned to `2.4.0` (older libsass fails to compile on GCC 13 /
  Ubuntu 24.04). Do not downgrade.

## Verification (no test suite)

No automated tests, linters, or CI. Verify by building, then:

- Serve the real output on port 8099:
  `docker run -d --name static8099 -p 8099:8099 -v "$(pwd)/build":/site:ro -w /site python:3.11-slim python -m http.server 8099`
  (recreate after every rebuild — `rm -rf build` breaks the bind mount).
  `python -m http.server` does **not** apply `_headers`/CSP.
- Static checks (broken links, duplicate ids, heading order) and axe-core
  accessibility checks: full playbook in `plans/2026-10-02-agent-handoff.md` §7.

## Local context (gitignored)

`plans/` and `stuff/` are in `.gitignore`: absent from fresh clones but present
in this checkout. `plans/2026-10-02-agent-handoff.md` is the authoritative
state-of-the-repo doc. `plans/2026-10-01-content-and-style-refresh.md` is a
historical log whose later rounds were reverted — don't trust it.
