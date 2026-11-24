# Fayez & Sylvia wedding site: setup from an iPhone

Files:
- `index.html` the invitation
- `fayez-sylvia-admin.html` the private dashboard (opens at `/fayez-sylvia-admin.html`)
- `fayez-sylvia-config.js` the ONLY file you edit (keys + map links)
- `fayez-sylvia-supabase-setup.sql` creates the database and security rules

## Step 1: Create the database (Supabase, free)
1. In Safari open supabase.com, sign up, tap **New project**. Pick any name, a strong database password (save it), and the closest region. Wait ~2 minutes.
2. **Turn off public sign-ups:** Authentication > Sign In / Providers > Email > turn OFF "Allow new users to sign up". (Important for security.)
3. **Create your admin login:** Authentication > Users > Add user > Create new user. Enter your email and a strong password. Tick "Auto confirm user".
4. Open `supabase-setup.sql` in a text viewer, copy everything, and replace `OWNER_EMAIL_HERE` (2 places) with the exact admin email from step 3.
5. Supabase > **SQL Editor** > New query > paste > **Run**. It should say "Success".

## Step 2: Copy your keys into config.js
Supabase > Project Settings > **API** (or "Data API").
- Copy **Project URL** and paste it in `fayez-sylvia-config.js` in place of the existing project URL.
- Copy the **anon / public** key and paste it in place of the existing publishable key.
- NEVER paste the `service_role` key or your passwords anywhere in the website files.
- Also replace the two map links with the exact Google Maps links (open the place in Google Maps > Share > Copy link).

## Step 3: Publish (GitHub Pages, free, HTTPS)
1. In the Files app, tap the ZIP to unzip it. Edit `fayez-sylvia-config.js` there (tap > Quick Look > markup/edit) or edit it later on GitHub (open the file > pencil icon).
2. On github.com create an account > **New repository** (name e.g. `wedding`, Public) > Create.
3. Tap **uploading an existing file**, upload `index.html`, `fayez-sylvia-config.js`, `fayez-sylvia-supabase-setup.sql`, `fayez-sylvia-admin.html`, and `README-fayez-sylvia.md`. Commit.
4. The admin page is a separate file at `/fayez-sylvia-admin.html`; no `admin` folder is needed.
5. Repository > **Settings > Pages** > Source: Deploy from a branch > `main` / root > Save. After ~1 minute your link is `https://YOURNAME.github.io/wedding/` and admin is `.../wedding/fayez-sylvia-admin.html`.

## Step 4: Test before sharing
1. Open the site, send a test congratulation.
2. Open `/admin/`, log in, confirm it appears, then delete it.
3. Open the Supabase **Table Editor** and confirm the table is there.
4. Logged out, confirm nobody can read messages (the public page has no way to).

Notes: the site stays online as long as the GitHub repo and Supabase project exist. Supabase free projects pause after about a week of NO activity; open the dashboard to restore, and check the provider's current free-plan terms.
