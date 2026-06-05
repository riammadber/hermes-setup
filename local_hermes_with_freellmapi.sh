#Local development
#Prerequisites: Node.js 20+, npm.
git clone https://github.com/tashfeenahmed/freellmapi.git
cd freellmapi
npm install
cp .env.example .env
ENCRYPTION_KEY="$(node -e 'console.log(require("crypto").randomBytes(32).toString("hex"))')"
printf "ENCRYPTION_KEY=%s\nPORT=3001\n" "$ENCRYPTION_KEY" > .env
npm run dev


# ============================================================
# Hermes Agent Setup with FreeLLM API
# STEP 1: Download & extract the project
# ------------------------------------------------------------
# Go to: https://github.com/NousResearch/hermes-agent
# Download as ZIP, extract, and open in VS Code

# STEP 2: Replace base URLs (OpenAI -> FreeLLM API)

Standard OpenAI API base URL: https://api.openai.com/v1
# File 1: hermes_cli/auth.py (line 187)
# File 2: agent/auxiliary_client.py (line 4585)
#
# OLD: https://api.openai.com/v1
# NEW: http://localhost:3001/v1
# STEP 3: Update API key regex in agent/redact.py (line 70)
# ------------------------------------------------------------
# OLD pattern: sk-[A-Za-z0-9_-]{10,}
# NEW pattern: freellmapi-[a-f0-9]{40,64}
#powershell
cd "D:\Ai\product\own\hermes agent with freellmapi\hermes-agent-main\hermes-agent-main codex"
#Use Python 3.11 if possible.
#but this project’s pyproject.toml wants <3.14
conda create -n hermes-agent python=3.11 -y
conda activate hermes-agent
python -m pip install -U pip
pip install -e ".[all]"

#Then configure
hermes setup
#run
hermes
