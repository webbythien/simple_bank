-- Create the "accounts" table
CREATE TABLE "accounts" (
  "id" bigserial PRIMARY KEY,
  "owner" varchar(255) NOT NULL,
  "balance" bigint NOT NULL,
  "currency" varchar(255) NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

-- Create the "entries" table
CREATE TABLE "entries" (
  "id" bigserial PRIMARY KEY,
  "account_id" bigint NOT NULL,
  "amount" bigint NOT NULL ,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);


CREATE TABLE "transfers" (
  "id" bigserial PRIMARY KEY,
  "from_account_id" bigint NOT NULL,
  "to_account_id" bigint NOT NULL,
  "amount" bigint NOT NULL ,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

-- Add foreign key constraints
ALTER TABLE "entries" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id");
ALTER TABLE "transfers" ADD FOREIGN KEY ("from_account_id") REFERENCES "accounts" ("id");
ALTER TABLE "transfers" ADD FOREIGN KEY ("to_account_id") REFERENCES "accounts" ("id");

-- Create indexes for optimization
CREATE INDEX "accounts_index_0" ON "accounts" ("owner");
CREATE INDEX "entries_index_1" ON "entries" ("account_id");
CREATE INDEX "transfers_index_2" ON "transfers" ("from_account_id");
CREATE INDEX "transfers_index_3" ON "transfers" ("to_account_id");
CREATE INDEX "transfers_index_4" ON "transfers" ("from_account_id", "to_account_id");

COMMENT ON COLUMN "entries"."amount" IS 'can be negative or positive';

COMMENT ON COLUMN "transfers"."amount" IS 'must be positive';