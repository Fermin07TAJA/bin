
from __future__ import annotations
import re
import json
from datetime import datetime
from pathlib import Path
from typing import Dict, List
from flask import Flask, jsonify, render_template, request

BASE_DIR = Path(__file__).parent.resolve()
DATA_FILE = BASE_DIR / 'data' / 'hotkeys.json'

# Single app instance
app = Flask(__name__, static_folder='static', static_url_path='/static')

# Hardcoded mapping
AHK_SOURCES: Dict[str, Path] = {
    'General': Path(r'C:\RootApps\bin\laos_Main.ahk'),
    'CapsMaster': Path(r'C:\RootApps\bin\laos_CapsMaster.ahk'),
    'CopyKo': Path(r'C:\RootApps\bin\halong_CopyKo.ahk'),
    'Insomniac': Path(r'C:\RootApps\bin\halong_Insomniac.ahk'),
    'OS Permanents': Path(r'C:\RootApps\bin\halong_OS.ahk'),
    'FootPedals': Path(r'C:\RootApps\bin\laos_Footpedals.ahk'),
    'PrtSc': Path(r'C:\RootApps\bin\laos_PrtSc.ahk'),
    'NumPad': Path(r'C:\RootApps\bin\laos_NumPad.ahk'),
}

# Regexes
# P_DIRECT = re.compile(r'^\s*[\^\!\+\#\*\~\$]*([^\s:]+?)(?:\s+up)?\s*::')
# P_COMBO  = re.compile(r'^\s*\w+\s*&\s*([A-Za-z0-9])(?:\s+up)?\s*::')
P_DIRECT = re.compile(r'^\s*[\^\!\+\#\*\~\$]*([^\s:]+?)(?:\s+up)?\s*::')
P_COMBO  = re.compile(r'^\s*\w+\s*&\s*([A-Za-z0-9])(?:\s+up)?\s*::')  # literal &

def normalize_token_to_datakey(tok: str) -> str | None:
    """
    Map an AHK v2 hotkey token (before '::') to the UI's data-key value.
    Returns the normalized key string, or None if we don't show it in the UI.
    """
    t = tok.strip()
    if not t:
        return None

    # Single-character letters/digits/symbols (main block)
    if len(t) == 1:
        ch = t.upper()
        if ch.isalpha() or ch.isdigit():
            return ch
        sym_map = {
            '`': '`', '-': '-', '=': '=',
            ';': ';', "'": "'", ',': ',', '.': '.', '/': '/',
            '\\': '\\', '[': '[', ']': ']',
        }
        return sym_map.get(t, None)

    u = t.upper()

    # --- Function keys ---
    if re.fullmatch(r'F([1-9]|1[0-9]|2[0-4])', u):
        return u  # e.g., F1 -> F1

    # --- Numpad ---
    if u.startswith('NUMPAD'):
        tail = u[6:]  # text after 'NUMPAD'
        digit_map = {
            '0': 'NUM0', '1': 'NUM1', '2': 'NUM2', '3': 'NUM3', '4': 'NUM4',
            '5': 'NUM5', '6': 'NUM6', '7': 'NUM7', '8': 'NUM8', '9': 'NUM9',
            'INS': 'NUM0', 'END': 'NUM1', 'DOWN': 'NUM2', 'PGDN': 'NUM3',
            'LEFT': 'NUM4', 'CLEAR': 'NUM5', 'RIGHT': 'NUM6',
            'HOME': 'NUM7', 'UP': 'NUM8', 'PGUP': 'NUM9',
        }
        op_map = {
            'ADD': 'NUM+',
            'SUB': 'NUM-', 'SUBTRACT': 'NUM-',
            'MULT': 'NUM*', 'MULTIPLY': 'NUM*',
            'DIV': 'NUM/',  'DIVIDE': 'NUM/',
            'DOT': 'NUM.',  'DECIMAL': 'NUM.', 'DEL': 'NUM.',
            'ENTER': 'ENTER', 'RETURN': 'ENTER',
        }
        if tail in digit_map:
            return digit_map[tail]
        if tail in op_map:
            return op_map[tail]
        m = re.fullmatch(r'(\d)', tail)
        if m:
            return f'NUM{m.group(1)}'
        # extra shorthand sometimes seen
        alt_map = { 'DEL': 'NUM.', 'DIV': 'NUM/', 'MULT': 'NUM*', 'SUB': 'NUM-' }
        return alt_map.get(tail, None)

    # --- Navigation / control keys ---
    nav_map = {
        'INSERT': 'INSERT', 'INS': 'INSERT',
        'DELETE': 'DELETE', 'DEL': 'DELETE',
        'HOME': 'HOME', 'END': 'END',
        'PGUP': 'PGUP', 'PAGEUP': 'PGUP', 'PRIOR': 'PGUP',
        'PGDN': 'PGDN', 'PAGEDOWN': 'PGDN', 'NEXT': 'PGDN',
        'UP': 'UP', 'DOWN': 'DOWN', 'LEFT': 'LEFT', 'RIGHT': 'RIGHT',
        'PRINTSCREEN': 'PRTSC', 'PRTSC': 'PRTSC', 'PRTSCN': 'PRTSC',
        'SCROLLLOCK': 'SCRLK', 'SCRLK': 'SCRLK',
        'PAUSE': 'PAUSE', 'BREAK': 'PAUSE',
        'ESC': 'ESC', 'ESCAPE': 'ESC',
        'TAB': 'TAB',
        'BACKSPACE': 'BACKSPACE', 'BS': 'BACKSPACE',
        'CAPSLOCK': 'CAPS', 'CAPS': 'CAPS',
        'ENTER': 'ENTER', 'RETURN': 'ENTER',
        'SPACE': 'SPACE', 'SPACEBAR': 'SPACE',
        'APPSKEY': 'MENU', 'MENU': 'MENU',
        'LWIN': 'LWIN', 'RWIN': 'RWIN',
        'LCONTROL': 'LCTRL', 'LCTRL': 'LCTRL',
        'RCONTROL': 'RCTRL', 'RCTRL': 'RCTRL',
        'LSHIFT': 'LSHIFT', 'RSHIFT': 'RSHIFT',
        'LALT': 'LALT', 'RALT': 'RALT',
    }
    return nav_map.get(u, None)


def scrape_files() -> Dict[str, Dict[str, List[str]]]:
    """
    Collect comments for hotkeys.
    - Matches symbolic-modifier and named-combo forms.
    - Ignores modifiers; normalizes the base key token to UI data-key.
    - Requires the immediately-previous line to be a full-line comment starting with ';'.
    - Aggregates per normalized key, per friendly script name.
    """
    result: Dict[str, Dict[str, List[str]]] = {}

    for friendly, path in AHK_SOURCES.items():
        try:
            text = path.read_text(encoding='utf-8', errors='ignore').splitlines()
        except FileNotFoundError:
            continue

        for i, line in enumerate(text):
            m = P_DIRECT.match(line) or P_COMBO.match(line)
            if not m:
                continue

            raw_tok = m.group(1)
            key = normalize_token_to_datakey(raw_tok)
            if not key:
                print(f"[scrape] NOTE: Unmapped token: {raw_tok!r}")
                continue  # We don't have a UI key for this token

            # Require comment on previous line
            if i == 0:
                continue
            prev = text[i - 1].strip()
            if not prev.startswith(';'):
                continue

            comment = prev.lstrip(';').strip()
            if not comment:
                continue

            result.setdefault(key, {}).setdefault(friendly, []).append(comment)

    return result


def write_data(payload: Dict) -> None:
    DATA_FILE.parent.mkdir(parents=True, exist_ok=True)
    with open(DATA_FILE, 'w', encoding='utf-8') as f:
        json.dump(payload, f, ensure_ascii=False, indent=2)


def load_data() -> Dict:
    if DATA_FILE.exists():
        try:
            with open(DATA_FILE, 'r', encoding='utf-8') as f:
                return json.load(f)
        except Exception:
            return {}
    return {}

# --- Routes -----------------------------------------------------------------

@app.route('/')
def index():
    return render_template('index.html')

@app.get('/data')
def get_data():
    data = load_data()
    return jsonify(data)

@app.post('/rerun')
def rerun():
    scraped = scrape_files()
    payload = {
        'updated_at': datetime.utcnow().isoformat() + 'Z',
        'letters': scraped  # dict[str, dict[friendly, list[str]]]
    }
    write_data(payload)
    return jsonify({'status': 'ok', 'letters': scraped})

if __name__ == '__main__':
    import os
    # Initial scrape on first run, so /data is not empty
    if not DATA_FILE.exists():
        initial = {
            'updated_at': None,
            'letters': scrape_files()
        }
        write_data(initial)

    host = os.environ.get('HOST', '127.0.0.1')  # or '0.0.0.0' if you need LAN access
    port = int(os.environ.get('PORT', '5173'))  # default to 5173 instead of 5000
    debug = os.environ.get('FLASK_DEBUG', '1') == '1'
    app.run(host=host, port=port, debug=debug)
