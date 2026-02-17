#!/usr/bin/env python3
import re, html, shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT  = ROOT / "docs"                 # publish folder
PAGES = ROOT / "src" / "pages"       # raw markdown pages
TPLS = ROOT / "templates"
CASES = ROOT / "case-studies"

NAV = [
  ("Home", "index.md"),
  ("Start Here", "start-here.md"),
  ("Doctrine", "doctrine.md"),
  ("Templates", "templates.md"),
  ("Case Studies", "case-studies.md"),
  ("Tools", "tools.md"),
  ("Disclaimer", "disclaimer.md"),
  ("Redaction", "redaction.md"),
  ("Packet spec", "packet-spec.md"),
]

def strip_front_matter(s: str) -> str:
  if s.startswith("---"):
    m = re.match(r"^---\s*\n[\s\S]*?\n---\s*\n", s)
    if m: return s[m.end():]
  return s

def fix_href(href: str) -> str:
  if href.startswith("../templates/") and href.endswith(".md"):
    return "templates/" + href[len("../templates/"):-3] + ".html"
  if href.startswith("../case-studies/") and href.endswith(".md"):
    return "case-studies/" + href[len("../case-studies/"):-3] + ".html"
  if href.endswith(".md"):
    return href[:-3] + ".html"
  return href

def inline(text: str, prefix: str) -> str:
  text = html.escape(text, quote=False)

  def repl(m):
    label = m.group(1)
    href = fix_href(m.group(2).strip())
    if not (href.startswith("http://") or href.startswith("https://") or href.startswith("#") or href.startswith("/")):
      href = prefix + href
    return f'<a href="{html.escape(href, quote=True)}">{label}</a>'

  text = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", repl, text)
  text = re.sub(r"`([^`]+)`", r"<code>\1</code>", text)
  return text

def md_to_html(md: str, prefix: str) -> str:
  md = strip_front_matter(md).replace("\r\n", "\n")
  lines = md.split("\n")
  out, para = [], []
  in_code, lang, code = False, "", []
  in_ul = False

  def flush_p():
    nonlocal para
    if para:
      out.append("<p>" + inline(" ".join(para).strip(), prefix) + "</p>")
      para = []

  for line in lines:
    if line.strip().startswith("```"):
      if not in_code:
        flush_p()
        if in_ul: out.append("</ul>"); in_ul = False
        in_code = True
        lang = line.strip()[3:].strip()
        code = []
      else:
        out.append(f'<pre><code class="language-{html.escape(lang)}">{html.escape("\\n".join(code))}</code></pre>')
        in_code, lang, code = False, "", []
      continue

    if in_code:
      code.append(line); continue

    if not line.strip():
      flush_p()
      if in_ul: out.append("</ul>"); in_ul = False
      continue

    m = re.match(r"^(#{1,6})\s+(.*)$", line)
    if m:
      flush_p()
      if in_ul: out.append("</ul>"); in_ul = False
      lvl = len(m.group(1))
      out.append(f"<h{lvl}>" + inline(m.group(2).strip(), prefix) + f"</h{lvl}>")
      continue

    m = re.match(r"^\s*-\s+(.*)$", line)
    if m:
      flush_p()
      if not in_ul: out.append("<ul>"); in_ul = True
      out.append("<li>" + inline(m.group(1).strip(), prefix) + "</li>")
      continue

    para.append(line.strip())

  flush_p()
  if in_ul: out.append("</ul>")
  return "\n".join(out)

def rel_prefix(path: Path) -> str:
  rel = path.parent.relative_to(OUT)
  n = 0 if str(rel) == "." else len(rel.parts)
  return "../" * n

def nav_html(prefix: str) -> str:
  return "\n".join([f'<a href="{prefix}{f.replace(".md",".html")}">{html.escape(t)}</a>' for t,f in NAV])

TEMPLATE = """<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>{title} — Diogenes Protocol</title>
  <link rel="stylesheet" href="{prefix}assets/css/custom.css">
</head>
<body>
  <a class="skip-link" href="#content">Skip to content</a>
  <img class="corner-art" src="{prefix}assets/img/diogenes-feather.png" alt="" aria-hidden="true">
  <section class="page-header">
    <h1 class="project-name">Diogenes Protocol</h1>
    <h2 class="project-tagline">Trust procedure, not promises.</h2>
  </section>
  <section class="main-content" id="content">
    <nav class="site-nav" aria-label="Primary">{nav}</nav>
    {content}
  </section>
</body>
</html>
"""

def write_page(out_path: Path, title: str, md_text: str):
  out_path.parent.mkdir(parents=True, exist_ok=True)
  prefix = rel_prefix(out_path)
  body = md_to_html(md_text, prefix)
  page = TEMPLATE.format(title=html.escape(title), prefix=prefix, nav=nav_html(prefix), content=body)
  out_path.write_text(page, encoding="utf-8")

def build():
  # Only clean generated HTML areas (leave docs/assets as your source of truth)
  for f in OUT.glob("*.html"):
    f.unlink()
  shutil.rmtree(OUT / "templates", ignore_errors=True)
  shutil.rmtree(OUT / "case-studies", ignore_errors=True)

  pages = {p.name: p for p in PAGES.glob("*.md")}

  for title, md_name in NAV:
    if md_name in pages:
      write_page(OUT / md_name.replace(".md",".html"), title, pages[md_name].read_text(encoding="utf-8"))

  # extra pages
  for p in PAGES.glob("*.md"):
    if p.name not in [f for _,f in NAV]:
      write_page(OUT / p.name.replace(".md",".html"), p.stem, p.read_text(encoding="utf-8"))

  # templates
  if TPLS.exists():
    for p in TPLS.rglob("*.md"):
      rel = p.relative_to(TPLS)
      write_page(OUT / "templates" / rel.with_suffix(".html"), f"Template: {p.stem}", p.read_text(encoding="utf-8"))

  # case-studies
  if CASES.exists():
    for p in CASES.rglob("*.md"):
      rel = p.relative_to(CASES)
      write_page(OUT / "case-studies" / rel.with_suffix(".html"), f"Case: {p.stem}", p.read_text(encoding="utf-8"))

  print(f"Built into: {OUT}")
  print(f"Open: file://{(OUT / 'index.html').resolve()}")

if __name__ == "__main__":
  build()
