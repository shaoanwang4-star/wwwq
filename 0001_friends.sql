-- 0001_friends
-- 好友申请：一行表示一个方向的申请。任一行 accepted 即视为两人是好友；
-- 反向行用于表达“谁发起的”，便于双方各自看到来源。
CREATE TABLE friend_requests (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  requester_id INTEGER NOT NULL,
  addressee_id INTEGER NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending',   -- pending | accepted | rejected
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now')),
  UNIQUE (requester_id, addressee_id),
  CHECK (status IN ('pending', 'accepted', 'rejected')),
  CHECK (requester_id <> addressee_id)
);

CREATE INDEX idx_fr_addressee ON friend_requests (addressee_id, status);
CREATE INDEX idx_fr_requester ON friend_requests (requester_id, status);
