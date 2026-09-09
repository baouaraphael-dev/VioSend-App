-- ===========================================
-- VioSend — schema de base de données
-- A coller dans Supabase > SQL Editor > Run
-- ===========================================

-- Profil utilisateur (lié au compte d'authentification Supabase)
create table if not exists public.profiles (
  id uuid references auth.users on delete cascade primary key,
  first_name text,
  last_name text,
  currency text default 'USD',
  created_at timestamp with time zone default now()
);

alter table public.profiles enable row level security;

create policy "Un utilisateur voit son propre profil"
  on public.profiles for select
  using (auth.uid() = id);

create policy "Un utilisateur modifie son propre profil"
  on public.profiles for update
  using (auth.uid() = id);

create policy "Un utilisateur crée son propre profil"
  on public.profiles for insert
  with check (auth.uid() = id);


-- Abonnement choisi à l'inscription
create table if not exists public.subscriptions (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users on delete cascade,
  plan text not null,           -- '1_mois' | '1_an' | '5_ans'
  currency text not null,       -- 'EUR' | 'USD'
  price numeric not null,
  status text default 'active',
  created_at timestamp with time zone default now()
);

alter table public.subscriptions enable row level security;

create policy "Un utilisateur voit ses propres abonnements"
  on public.subscriptions for select
  using (auth.uid() = user_id);

create policy "Un utilisateur crée son propre abonnement"
  on public.subscriptions for insert
  with check (auth.uid() = user_id);


-- Boutiques créées par les utilisateurs
create table if not exists public.boutiques (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users on delete cascade,
  nom text not null,
  lien_slug text unique not null,
  created_at timestamp with time zone default now()
);

alter table public.boutiques enable row level security;

create policy "Tout le monde peut voir les boutiques (liens publics)"
  on public.boutiques for select
  using (true);

create policy "Un utilisateur crée sa propre boutique"
  on public.boutiques for insert
  with check (auth.uid() = user_id);


-- Transactions (transferts, prêts, ventes de boutique)
create table if not exists public.transactions (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users on delete cascade,
  type text not null,           -- 'transfert' | 'pret' | 'vente'
  montant numeric not null,
  devise text default 'XOF',
  description text,
  created_at timestamp with time zone default now()
);

alter table public.transactions enable row level security;

create policy "Un utilisateur voit ses propres transactions"
  on public.transactions for select
  using (auth.uid() = user_id);

create policy "Un utilisateur crée ses propres transactions"
  on public.transactions for insert
  with check (auth.uid() = user_id);
