-- Paste this whole file into Supabase > SQL Editor > Run.
-- BEFORE running: replace OWNER_EMAIL_HERE (appears once, near the bottom) with YOUR admin email.

create table if not exists public.congratulations (
  id uuid primary key default gen_random_uuid(),
  guest_name text not null check (char_length(btrim(guest_name)) between 1 and 80),
  message text not null check (char_length(btrim(message)) between 1 and 1000),
  created_at timestamptz not null default now()
);

alter table public.congratulations enable row level security;

-- Start from zero permissions, then grant only what is needed
revoke all on public.congratulations from anon, authenticated;
grant insert on public.congratulations to anon;
grant select, delete on public.congratulations to authenticated;

-- Anyone may SUBMIT (no read access)
drop policy if exists "guests can submit" on public.congratulations;
create policy "guests can submit" on public.congratulations
  for insert to anon with check (true);

-- Only the owner's login may READ or DELETE
drop policy if exists "owner can read" on public.congratulations;
create policy "owner can read" on public.congratulations
  for select to authenticated using ((auth.jwt() ->> 'email') = 'OWNER_EMAIL_HERE');

drop policy if exists "owner can delete" on public.congratulations;
create policy "owner can delete" on public.congratulations
  for delete to authenticated using ((auth.jwt() ->> 'email') = 'OWNER_EMAIL_HERE');

-- Global flood brake: reject inserts if more than 20 arrived in the last minute
create or replace function public.limit_congrats_rate() returns trigger
language plpgsql security definer set search_path = public as $$
begin
  if (select count(*) from public.congratulations where created_at > now() - interval '1 minute') >= 20 then
    raise exception 'too many submissions';
  end if;
  return new;
end $$;

drop trigger if exists congrats_rate on public.congratulations;
create trigger congrats_rate before insert on public.congratulations
  for each row execute function public.limit_congrats_rate();
