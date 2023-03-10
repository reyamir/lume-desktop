-- Add migration script here
-- create relays
CREATE TABLE
  relays (
    id INTEGER PRIMARY KEY,
    relay_url TEXT NOT NULL,
    relay_status INTEGER NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
  );

INSERT INTO
  relays (relay_url, relay_status)
VALUES
  ("wss://relay.damus.io", "1"),
  ("wss://relay.uselume.xyz", "0"),
  ("wss://nostr-pub.wellorder.net", "1"),
  ("wss://nostr.bongbong.com", "1"),
  ("wss://nostr.zebedee.cloud", "1"),
  ("wss://nostr.fmt.wiz.biz", "1"),
  ("wss://nostr.walletofsatoshi.com", "1"),
  ("wss://relay.snort.social", "1"),
  ("wss://offchain.pub", "1"),
  ("wss://nos.lol", "1");

-- create accounts
CREATE TABLE
  accounts (
    id TEXT PRIMARY KEY,
    privkey TEXT NOT NULL,
    npub TEXT NOT NULL,
    nsec TEXT NOT NULL,
    is_active INTEGER NOT NULL DEFAULT 0,
    metadata JSON
  );

-- create follows
CREATE TABLE
  follows (
    id INTEGER PRIMARY KEY,
    pubkey TEXT NOT NULL,
    account TEXT NOT NULL,
    kind INTEGER NOT NULL DEFAULT 0,
    metadata JSON
  );

-- create index for pubkey in follows
CREATE UNIQUE INDEX index_pubkey ON follows (pubkey);

-- create cache profiles
CREATE TABLE
  cache_profiles (
    id TEXT PRIMARY KEY,
    metadata JSON,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
  );

-- create cache notes
CREATE TABLE
  cache_notes (
    id TEXT PRIMARY KEY,
    pubkey TEXT NOT NULL,
    created_at TEXT,
    kind INTEGER NOT NULL DEFAULT 1,
    tags TEXT NOT NULL,
    content TEXT NOT NULL,
    relay TEXT,
    is_multi BOOLEAN DEFAULT 0
  );