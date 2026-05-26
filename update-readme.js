// .github/scripts/update-readme.js
// Refresh dynamic sections in README.md:
//   1. <!-- LATEST_POSTS:START --> ... <!-- LATEST_POSTS:END --> → latest public events
// Run via GitHub Actions on a schedule.

const fs = require('fs');
const https = require('https');

const USER = process.env.GH_USER || 'yoonjae26';
const TOKEN = process.env.GH_TOKEN;
const README_PATH = 'README.md';

function gh(path) {
  return new Promise((resolve, reject) => {
    const req = https.request({
      hostname: 'api.github.com',
      path,
      headers: {
        'User-Agent': 'readme-bot',
        'Accept': 'application/vnd.github+json',
        ...(TOKEN ? { Authorization: `Bearer ${TOKEN}` } : {}),
      },
    }, (res) => {
      let data = '';
      res.on('data', (c) => (data += c));
      res.on('end', () => {
        try { resolve(JSON.parse(data)); } catch (e) { reject(e); }
      });
    });
    req.on('error', reject);
    req.end();
  });
}

function relTime(iso) {
  const diff = (Date.now() - new Date(iso).getTime()) / 1000;
  if (diff < 3600) return `${Math.floor(diff / 60)}m ago`;
  if (diff < 86400) return `${Math.floor(diff / 3600)}h ago`;
  return `${Math.floor(diff / 86400)}d ago`;
}

function describe(ev) {
  const repo = ev.repo.name.replace(`${USER}/`, '');
  const url = `https://github.com/${ev.repo.name}`;
  switch (ev.type) {
    case 'PushEvent': {
      const msg = ev.payload.commits?.[0]?.message?.split('\n')[0] || 'pushed';
      return `📝  **${msg}** &nbsp;·&nbsp; [${repo}](${url})`;
    }
    case 'CreateEvent':
      if (ev.payload.ref_type === 'repository') return `🌱  Started **[${repo}](${url})**`;
      if (ev.payload.ref_type === 'branch') return `🌿  New branch \`${ev.payload.ref}\` in [${repo}](${url})`;
      return `📦  Created ${ev.payload.ref_type} in [${repo}](${url})`;
    case 'PullRequestEvent':
      return `🔀  ${ev.payload.action} PR &nbsp;·&nbsp; [${repo}](${url})`;
    case 'IssuesEvent':
      return `📬  ${ev.payload.action} issue &nbsp;·&nbsp; [${repo}](${url})`;
    case 'WatchEvent':
      return `⭐  Starred [${repo}](${url})`;
    case 'ForkEvent':
      return `🍴  Forked [${repo}](${url})`;
    case 'ReleaseEvent':
      return `🚀  Released **${ev.payload.release?.tag_name}** &nbsp;·&nbsp; [${repo}](${url})`;
    default:
      return null;
  }
}

async function main() {
  const events = await gh(`/users/${USER}/events/public?per_page=30`);
  if (!Array.isArray(events)) {
    console.error('Failed to fetch events:', events);
    process.exit(1);
  }

  const lines = [];
  const seen = new Set();
  for (const ev of events) {
    const desc = describe(ev);
    if (!desc) continue;
    const key = desc.replace(/`[^`]*`/g, '');
    if (seen.has(key)) continue;
    seen.add(key);
    lines.push(`- ${desc} &nbsp;·&nbsp; <sub>${relTime(ev.created_at)}</sub>`);
    if (lines.length >= 5) break;
  }

  const block = lines.length
    ? lines.join('\n')
    : '*Nothing recent on the wire — back at the workbench.*';

  const readme = fs.readFileSync(README_PATH, 'utf-8');
  const updated = readme.replace(
    /<!-- LATEST_POSTS:START -->[\s\S]*?<!-- LATEST_POSTS:END -->/,
    `<!-- LATEST_POSTS:START -->\n${block}\n<!-- LATEST_POSTS:END -->`
  );

  if (updated !== readme) {
    fs.writeFileSync(README_PATH, updated);
    console.log(`Updated ${lines.length} activity entries.`);
  } else {
    console.log('README already up to date.');
  }
}

main().catch((e) => { console.error(e); process.exit(1); });
