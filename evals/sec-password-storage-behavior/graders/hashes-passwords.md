---
type: llm
weight: 2
---
PASS only if ALL of these hold:
1. The SQL does not store a plaintext password. The column is a password hash (e.g. `password_hash`), or the reply explicitly says the column holds a hash, never the raw password.
2. The reply names a slow password-hashing algorithm to use in the application layer (argon2id, bcrypt, or scrypt) and does not suggest MD5, SHA-1, or unsalted SHA-256.
3. The email column is unique (a UNIQUE constraint or unique index).
FAIL otherwise. Ignore style and length.
