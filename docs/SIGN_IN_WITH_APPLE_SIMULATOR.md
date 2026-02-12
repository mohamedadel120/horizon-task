# Testing Sign in with Apple on the Simulator

Apple does **not** fully support Sign in with Apple in the iOS Simulator, so it often fails with error 1000. You can still try these options:

---

## Option 1: Sign in to the Simulator (sometimes works)

1. Open the **Simulator**.
2. Open **Settings** → tap **Sign in to your iPhone** (at the top).
3. Sign in with your **Apple ID** (or a **Sandbox tester** from App Store Connect).
4. Accept any terms and complete setup.
5. Run your app and tap **Sign in with Apple** again.

This works for some developers and iOS versions; if you still get error 1000, use Option 2 or 3.

---

## Option 2: Use Sandbox test accounts (recommended by Apple)

1. In [App Store Connect](https://appstoreconnect.apple.com) go to **Users and Access** → **Sandbox** → **Testers**.
2. Create a **Sandbox tester** Apple ID (use a real email you can access for verification).
3. On the **Simulator**, go to **Settings** → **Sign in to your iPhone** and sign in with that Sandbox account.
4. Run the app and try **Sign in with Apple** again.

---

## Option 3: Test the rest of the app with Email or Google

On the simulator, **Sign in with Apple** may never work. You can still test the app:

- Use **Email** or **Google** sign-in on the login/register screen.
- That exercises the same post-login flow (navigation, Firebase Auth, etc.).

For final verification of **Sign in with Apple**, use a **physical iPhone**.
