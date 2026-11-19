# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository state

Final-project repo for **CMP177 – Lập trình trên thiết bị di động**. Topic: **"Chi Tiêu AI"** — personal expense manager with AI receipt scanning. Team of 3: A = platform/auth/settings, B = transactions/budget, C = AI scan/stats. Flutter app lives at the repo root (package `expense_ai`, Android + iOS).

- `TÀI LIỆU MÔN LẬP TRÌNH TRÊN THIẾT BỊ DI ĐỘNG/`: course PDFs (gitignored — instructor material, not published).
- `.remember/`: local tooling state (self-ignored).

## Commands

```bash
flutter pub get
flutter run
flutter analyze          # must be clean
flutter test             # all tests
flutter test test/features/auth/auth_controller_test.dart   # single file
```

## Architecture

- Feature-first: `lib/features/<feature>/{domain,data,presentation}`; shared code in `lib/core` (router, theme, constants, formatters) and `lib/shared/widgets`.
- State: `provider` + `ChangeNotifier` controllers. Data access only through repository interfaces (e.g. `AuthRepository`); implementations are swappable (`FakeAuthRepository` now, Firebase later), chosen in `main.dart` and injected into `ExpenseApp`.
- Navigation: `go_router` in `lib/core/router/app_router.dart`. `refreshListenable: AuthController` + `redirect` gate everything behind login; `StatefulShellRoute.indexedStack` drives the 4-tab `HomeShell` (Giao dịch, Quét, Thống kê, Cài đặt).
- Models are immutable. UI strings are Vietnamese.
- Firebase project `chitieuai-99447` (Auth: Email/Password). `main.dart` tries `Firebase.initializeApp()` (native config, no firebase_options import) and falls back to `FakeAuthRepository` on failure. Config files (`firebase_options.dart`, `google-services.json`, `GoogleService-Info.plist`) are gitignored and generated per machine via `flutterfire configure`. The google-services Gradle plugin is applied conditionally at the bottom of `android/app/build.gradle.kts`; after re-running flutterfire, remove the unconditional `id("com.google.gms.google-services")` it adds to `plugins {}`.

## Hard constraints from the course

- **Flutter/Dart is the mandatory frontend.** Backend and database are free choice (examples given: Firebase, Supabase, Spring Boot, .NET, MySQL).
- **Git history is graded (1 of 7 points).** The repo must be public, or the instructor must have access. It needs at least 3 weeks of history counted from the last class session, and visible commits from every team member. Keep commits real and attributable. Don't squash or rewrite shared history.
- **No secrets in the repo** (passwords, API keys, tokens, `google-services.json` with live keys, etc.). Provide safe setup instructions (for example `.env.example`) instead. The guidelines state this explicitly.
- **The README must let the grader run and recognize the project:** how to run it, the folder structure, and required config.
- Deliverables (in the team's shared folder): a demo video of at most 10 minutes (5 pts), the Git link (1 pt), and a PDF/Word report (1 pt). There is also a separate 3-point offline oral exam.
- The report focuses on implemented features. Use a tech table (component → library → purpose), a feature table with an honest status column ("Hoàn thành" / "Chưa hoàn thiện"), and for each feature a screenshot followed by a description. No theory, DB design, or source-code walkthroughs. Never present an unfinished feature as complete.

## Working with the PDFs

Filenames are Vietnamese and stored NFD-normalized on this filesystem, so typed (NFC) paths often fail with "No such file". Use globs instead:

```bash
cd "TÀI LIỆU MÔN LẬP TRÌNH TRÊN THIẾT BỊ DI ĐỘNG"
pdftotext -layout Y*.pdf -        # YÊU CẦU NỘP BÁO CÁO ĐỒ ÁN CUỐI KỲ (report requirements)
pdftotext -layout H*.pdf -        # HƯỚNG DẪN QUAY VIDEO BÁO CÁO ĐỒ ÁN (video/Git/report grading guide)
pdftotext -layout "Bai 7"*.pdf -  # a specific lecture
```

The `[THUYẾT TRÌNH] Đề tài Thư viện Flutter.pdf` file lists the 12 Flutter-package presentation topics (animations, calendars, images, files, system, media, notifications/permissions, push/payment, maps, camera/scanning, security, AI). It is a useful reference when picking packages for the app.

## Language

Course materials, and probably the report and UI text, are in Vietnamese. Match the language the user writes in.
