-- ===========================================
-- VioSend — extension boutique (à exécuter après schema.sql)
-- A coller dans Supabase > SQL Editor > Run
-- ===========================================

-- Compléter la table boutiques avec description et couleur
alter table public.boutiques add column if not exists description text;
alter table public.boutiques add column if not exists couleur text default 'violet';
-- Produits vendus dans une boutique
create table if not exists public.produits (
  id uuid default gen_random_uuid() primary key,
  boutique_id uuid references public.boutiques on delete cascade,
  titre text not null,
  prix numeric not null,
  description text,
  categorie text default 'fichier',
  lien_livraison text,       -- lien vers le fichier / accès envoyé après achat
  created_at timestamp with time zone default now()
);

alter table public.produits add column if not exists categorie text default 'fichier';

-- Moyen de paiement utilisé pour l'abonnement
alter table public.subscriptions add column if not exists payment_method text default 'carte';

alter table public.produits enable row level security;

create policy "Tout le monde peut voir les produits (boutiques publiques)"
  on public.produits for select
  using (true);

create policy "Le propriétaire de la boutique ajoute ses produits"
  on public.produits for insert
  with check (
    auth.uid() = (select user_id from public.boutiques where id = boutique_id)
  );
