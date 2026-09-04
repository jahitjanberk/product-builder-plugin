# Product Builder

A Claude Code plugin that bundles four skills covering the full build cycle of a product:

| Skill | Covers |
|---|---|
| `mobile-web-design` | UI/UX design — visual direction, layout, interaction, platform adaptation |
| `product-management` | Product goals, target audience (JTBD), market analysis, pricing strategy, stakeholder analysis, KPIs |
| `developer` | Clean/structured code, stack selection, deployment |
| `security-engineer` | Continuous security hardening — CIA triad, NIST CSF, IAM/least privilege, secure coding — applied throughout, not just on request |

Each skill loads on demand based on what the conversation touches, so writing a component pulls in `developer` and `security-engineer` together, choosing a stack pulls in `developer`, pricing a product pulls in `product-management`, and so on.

## Test it locally first (no install)

Claude Code has a flag built exactly for this — it loads the plugin for the current session only, no marketplace or install step:

```bash
claude --plugin-dir /path/to/product-builder
```

While testing, edit any `SKILL.md` and run `/reload-plugins` inside the session to pick up the change without restarting. You can load it alongside other plugins by repeating the flag: `claude --plugin-dir ./product-builder --plugin-dir ./another-plugin`.

## Install permanently, once you're happy with it

Plugins install through a marketplace — even a local one. Two options:

**A. Local marketplace (personal, no GitHub needed):**

```bash
mkdir -p my-marketplace/.claude-plugin
mv product-builder my-marketplace/
cat > my-marketplace/.claude-plugin/marketplace.json << 'EOF'
{
  "name": "jahit-plugins",
  "owner": { "name": "Jahit Janberk" },
  "plugins": [
    { "name": "product-builder", "source": "./product-builder", "description": "UI/UX, product management, developer, and security-engineer skills" }
  ]
}
EOF
```

Then from the parent directory:

```bash
claude
/plugin marketplace add ./my-marketplace
/plugin install product-builder@jahit-plugins
```

**B. GitHub marketplace (shareable with a team, or across your own repos):**

Push the same `my-marketplace` structure to a repo, then anyone (including future-you on another machine) installs with:

```bash
/plugin marketplace add <your-github-repo>
/plugin install product-builder@jahit-plugins
```

## Notes

- `security-engineer` is written to be always-on: its description asks Claude to apply it any time code, infrastructure, or access decisions come up, not just when security is explicitly mentioned.
- `mobile-web-design` is the design skill as already published — dropped in here as-is so it participates in the same plugin bundle.
- Extend this by adding more skill folders under `skills/`, each with its own `SKILL.md`. No manifest changes are needed — new folders under `skills/` are auto-discovered.
