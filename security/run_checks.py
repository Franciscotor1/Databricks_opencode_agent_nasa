import os
import re

def scan_files():
    print("[*] Iniciando escaneo de seguridad (Simulación YARA / Agentic Guard)...")
    
    yara_rules = {
        "Agentic_Prompt_Injection_Patterns": [
            r"ignore previous instructions",
            r"disregard all prior directives",
            r"system prompt override",
            r"reveal your API key",
            r"print environment variables"
        ],
        "Agentic_Credential_Exfiltration": [
            r"dapi[a-zA-Z0-9]{32}",
            r"AIzaSy[a-zA-Z0-9_-]{33}"
        ]
    }
    
    matches_found = 0
    root_dir = "."
    
    for dirpath, _, filenames in os.walk(root_dir):
        if ".git" in dirpath or "security" in dirpath:
            continue
        for f in filenames:
            filepath = os.path.join(dirpath, f)
            try:
                with open(filepath, "r", encoding="utf-8", errors="ignore") as file:
                    content = file.read()
                    for rule_name, patterns in yara_rules.items():
                        for pattern in patterns:
                            if re.search(pattern, content, re.IGNORECASE):
                                print(f"[!] [ALERTA] Regla '{rule_name}' activada en archivo: {filepath} (Patrón: {pattern})")
                                matches_found += 1
            except Exception:
                pass
                
    if matches_found == 0:
        print("[+] Escaneo completado: No se detectaron amenazas agénticas ni inyecciones en el workspace.")
    else:
        print(f"[!] Escaneo completado: Se detectaron {matches_found} coincidencias.")

if __name__ == "__main__":
    scan_files()
