-- 0000_init
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  pass_hash TEXT NOT NULL,
  pass_salt TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE sessions (
  token TEXT PRIMARY KEY,
  user_id INTEGER NOT NULL,
  expires_at INTEGER NOT NULL
);

CREATE TABLE comics (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  owner_id INTEGER NOT NULL,
  title TEXT NOT NULL,
  description TEXT DEFAULT '',
  cover_key TEXT,
  price_cents INTEGER NOT NULL DEFAULT 0,
  published INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE chapters (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  comic_id INTEGER NOT NULL,
  num INTEGER NOT NULL,
  title TEXT DEFAULT '',
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE pages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  chapter_id INTEGER NOT NULL,
  idx INTEGER NOT NULL,
  r2_key TEXT NOT NULL
);

CREATE TABLE danmaku (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  chapter_id INTEGER NOT NULL,
  page_idx INTEGER NOT NULL,
  t_ms INTEGER NOT NULL DEFAULT 0,
  user_id INTEGER,
  text TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE orders (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  comic_id INTEGER NOT NULL,
  amount_cents INTEGER NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending',
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  paid_at TEXT
);

CREATE TABLE unlocks (
  user_id INTEGER NOT NULL,
  comic_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, comic_id)
);

CREATE INDEX idx_chapters_comic ON chapters(comic_id);
CREATE INDEX idx_pages_chapter ON pages(chapter_id, idx);
CREATE INDEX idx_danmaku_page ON danmaku(chapter_id, page_idx);
CREATE INDEX idx_sessions_user ON sessions(user_id);
