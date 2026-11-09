-- Run in Supabase SQL Editor. Keep the allowed email addresses private.
create table if not exists public.expenses (
 id uuid primary key default gen_random_uuid(),
 date date not null,
 note text not null check (char_length(note) between 1 and 200),
 amount numeric(12,2) not null check (amount > 0),
 category text not null check (category in ('食','衣','住','行','育','樂')),
 payer text not null check (payer in ('Jesper','Vivi')),
 owner text not null check (owner in ('shared','Jesper','Vivi')),
 split integer not null default 50 check (split between 0 and 100),
 created_by uuid not null default auth.uid(),
 created_at timestamptz not null default now()
);
create table if not exists public.members (
 user_id uuid primary key references auth.users(id) on delete cascade,
 display_name text not null check (display_name in ('Jesper','Vivi'))
);
alter table public.expenses enable row level security;
alter table public.members enable row level security;
revoke all on public.expenses from anon;
revoke all on public.members from anon;
grant select,insert,delete on public.expenses to authenticated;
grant select on public.members to authenticated;
create policy "members can read expenses" on public.expenses for select to authenticated using (exists(select 1 from public.members where user_id=auth.uid()));
create policy "members can add expenses" on public.expenses for insert to authenticated with check (created_by=auth.uid() and exists(select 1 from public.members where user_id=auth.uid()));
create policy "members can delete expenses" on public.expenses for delete to authenticated using (exists(select 1 from public.members where user_id=auth.uid()));
create policy "members can view members" on public.members for select to authenticated using (user_id=auth.uid());
-- In Supabase Auth: disable public signups; invite exactly two users.
-- After both have accepted invites, find their UUIDs under Authentication > Users.
-- Then run (as database administrator):
-- insert into public.members(user_id,display_name) values ('JESPER_USER_UUID','Jesper'),('VIVI_USER_UUID','Vivi');
-- Never put the service_role key or private credentials in frontend files.
