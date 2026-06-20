-- Agente Pick Pro — esquema de base de datos para Supabase
-- Cómo usar: Supabase Dashboard → SQL Editor → pega este archivo completo → Run

create table if not exists pick_history (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  sport text not null,
  matchup text not null,
  pick text not null,
  odds text not null,
  confidence int not null,
  bet numeric not null default 0,
  result text not null default 'P',
  note text not null default '',
  date date not null,
  created_at timestamptz not null default now()
);

create table if not exists futures (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  sport text not null,
  market text not null,
  team text not null,
  odds text not null,
  odds_now text,
  stake numeric not null,
  payout numeric not null,
  date_placed date,
  date_resolve date,
  notes text default '',
  status text not null default 'active',
  created_at timestamptz not null default now()
);

create table if not exists arb_checks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  ways int not null,
  odds jsonb not null,
  implied_sum numeric not null,
  profit numeric not null,
  stake numeric not null,
  is_arb boolean not null,
  checked_at timestamptz not null default now()
);

alter table pick_history enable row level security;
alter table futures enable row level security;
alter table arb_checks enable row level security;

create policy "pick_history: owner full access" on pick_history
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "futures: owner full access" on futures
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "arb_checks: owner full access" on arb_checks
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create index if not exists pick_history_user_idx on pick_history(user_id);
create index if not exists futures_user_idx on futures(user_id);
create index if not exists arb_checks_user_idx on arb_checks(user_id);
