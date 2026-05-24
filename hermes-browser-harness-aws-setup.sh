# =============================================
# Hermes Agent + Browser Harness on Hostinger VPS
# Full setup — copy and paste line by line
# =============================================

# 1. Install Hermes Agent (Nous Research)
#    Docs: https://hermes-agent.nousresearch.com/docs/getting-started/installation/
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash

# 2. Reload shell so `hermes` command works
source ~/.bashrc

# 3. Configure Hermes interactively (provider, API key, model)
#    Choose OpenRouter, paste your key, pick: anthropic/claude-opus-4.7
hermes setup

# 4. Install uv (Python package manager by Astral)
#    Docs: https://docs.astral.sh/uv/getting-started/installation/
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.local/bin/env

# 5. Install Browser Harness
#    Docs: https://github.com/browser-use/browser-harness
cd ~
git clone https://github.com/browser-use/browser-harness
cd browser-harness
uv tool install -e .

# 6. Register Browser Harness as a Hermes skill (so Hermes can find and use it)
mkdir -p ~/.hermes/skills/browser-harness
ln -sf ~/browser-harness/SKILL.md ~/.hermes/skills/browser-harness/SKILL.md
ln -sf ~/browser-harness/interaction-skills ~/.hermes/skills/browser-harness/interaction-skills
ln -sf ~/browser-harness/domain-skills ~/.hermes/skills/browser-harness/domain-skills

# 7. Connect Browser Harness to Browser Use Cloud (free tier, no card)
#    Get a free API key at: https://cloud.browser-use.com/new-api-key
#    Docs: https://docs.browser-use.com/cloud/tutorials/integrations/hermes-agent
#    Replace YOUR_KEY with the key from the page above:
hermes config set BROWSER_USE_API_KEY YOUR_KEY

# 8. Launch Hermes and start chatting
hermes
