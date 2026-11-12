# Agentic Cybersecurity Rules

This directory contains defensive security rules (SIGMA and YARA) tailored for protecting AI agent environments (such as opencode and Databricks workspaces) against agentic attacks, prompt injection, and unauthorized data exfiltration.

## Contents

1. **SIGMA Rules (`sigma/agentic_attacks.yml`)**:
   - Detects abnormal tool executions (e.g. destructive SQL commands, unauthorized network transfers via `curl`/`wget`).
   - Detects attempts to access sensitive environment variables or credentials (`DATABRICKS_TOKEN`, `GEMINI_API_KEY`).

2. **YARA Rules (`yara/agentic_threats.yar`)**:
   - **`Agentic_Prompt_Injection_Patterns`**: Detects prompt injection strings and system prompt override attempts.
   - **`Agentic_Credential_Exfiltration`**: Detects pattern matching for leaked PAT tokens/API keys combined with exfiltration vectors.
