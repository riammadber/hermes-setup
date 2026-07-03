# MoA Hermes — Mixture of Agents Script

A simple setup guide for running the `moa_hermes.py` script (Mixture-of-Agents style pipeline).

## Requirements

- A Linux system (Ubuntu/Debian-based)
- `sudo` access
- Internet connection

## Step 1: Install Required Tools

Update your system and install Python, pip, and git:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip git -y
```

## Step 2: Create the Script

Create a new file:

```bash
nano moa_hermes.py
```

Paste the full contents of `free_moa.py` into the editor.

Save and exit:

- Press `Ctrl + O` (write out / save)
- Press `Enter` to confirm the filename
- Press `Ctrl + X` to exit nano

## Step 3: Run the Script

```bash
python3 moa_hermes.py
```


## env
```bash
export GROQ_API_KEY="your_groq_key_here"
export GEMINI_API_KEY="your_gemini_key_here"
export OPENROUTER_API_KEY="your_openrouter_key_here"
```
## Notes

- Make sure any required Python packages (e.g. `requests`, `openai`, etc.) are installed via `pip3 install <package>` before running, if the script imports them.
- If you get a `ModuleNotFoundError`, install the missing module with:
```bash
  pip3 install <module_name>
```
Install the missing library
```bash
pip3 install openai --break-system-packages
```