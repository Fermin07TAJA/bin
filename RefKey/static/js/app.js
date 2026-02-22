let cache = { updated_at: null, letters: {} };

async function loadData() {
  const res = await fetch('/data');
  const data = await res.json();
  cache = { updated_at: data.updated_at ?? null, letters: data.letters ?? {} };
  document.getElementById('status').textContent = cache.updated_at ? `Updated: ${cache.updated_at}` : 'Ready';
  markMappedLetters();
}

async function rerun() {
  setStatus('Re-analyzing…');
  const res = await fetch('/rerun', { method: 'POST' });
  const json = await res.json();
  cache.letters = json.letters || {};
  setStatus('Analysis complete');
  markMappedLetters();
}

function setStatus(msg) {
  document.getElementById('status').textContent = msg;
}

function markMappedLetters() {
  document.querySelectorAll('.key').forEach(el => {
    const key = (el.dataset.key || '').toUpperCase();
    if (!key) return;
    const has = !!cache.letters[key];
    el.classList.toggle('has-map', has);
  });
}

function openInfoForKey(key) {
  const panel = document.getElementById('infoPanel');
  const title = document.getElementById('infoTitle');
  const body = document.getElementById('infoBody');
  title.textContent = key;
  body.innerHTML = '';
  const letterData = cache.letters[key.toUpperCase()];
  if (!letterData || Object.keys(letterData).length === 0) {
    const p = document.createElement('p');
    p.className = 'empty';
    p.textContent = 'No entries for this key.';
    body.appendChild(p);
  } else {
    // letterData is: { FriendlyName: [comments...] }
    for (const [friendly, comments] of Object.entries(letterData)) {
      if (!Array.isArray(comments) || comments.length === 0) continue;
      for (const c of comments) {
        const div = document.createElement('div');
        div.className = 'info-item';
        div.innerHTML = `<b>${friendly}:</b> ${escapeHtml(c)}`;
        body.appendChild(div);
      }
    }
  }
  panel.classList.remove('hidden');
}

function escapeHtml(str) {
  return str.replace(/[&<>"]+/g, (m) => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[m]));
}

function init() {
  document.getElementById('rerunBtn').addEventListener('click', rerun);
  document.getElementById('closeInfo').addEventListener('click', () => {
    document.getElementById('infoPanel').classList.add('hidden');
  });
  document.querySelectorAll('.key').forEach(el => {
    el.addEventListener('click', () => {
      const k = el.dataset.key || el.textContent.trim();
      openInfoForKey(k);
    });
  });
  loadData();
}

window.addEventListener('DOMContentLoaded', init);