# Offline-First Pokédex (Flutter Mobile + Web)

Cross-platform Pokédex built as a technical exercise focused on architecture, responsiveness, and offline behavior.

## Demo Scope
- Platforms: iOS, Android, Flutter Web (Chrome)
- State management: `Cubit` (`flutter_bloc`)
- Data source: PokéAPI v2 (`/pokemon` list + `/pokemon/{id}`)
- Persistence: Drift (local cache)
- UI: responsive layouts (mobile vs desktop/tablet), infinite scroll, detail screen

---

## Run Instructions

### 1. Requirements
- Flutter `3.41.1` (or compatible with this repo)
- Dart SDK compatible with project constraints
- Chrome installed (for web run)

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Generate Drift files
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run mobile
```bash
flutter run
```

### 5. Run web
```bash
flutter run -d chrome
```

### 6. Web assets required for Drift
Ensure these files exist in `web/`:
- `sqlite3.wasm`
- `drift_worker.js` (or `drift_worker.dart.js`, matching the URI configured in DB connection)

---

## Mandatory Questionnaire (Required by the technical test)

### 1) What architecture or pattern did you use, and why does it scale to a real product (including Web)?
Feature-first + Clean Architecture:
- `presentation` (screens, cubits, states)
- `domain` (entities, use cases, repository contracts)
- `data` (remote/local datasources, DTOs, mappers, repository impl)
- `core` (network, errors, responsive, DI)

Why it scales:
- Domain contracts isolate business rules from framework/infrastructure.
- Data layer can evolve independently (sync, retries, auth, telemetry).
- Local + remote datasources support progressive offline improvements.
- Web-specific constraints (worker/wasm/persistence) are isolated in local data setup.

### 2) What trade-offs did you make within the 48-72 hour delivery window?
Prioritized:
- End-to-end functional scope: list, detail, pagination, responsive web/mobile, and offline cache behavior.
- Solid architecture boundaries (presentation/domain/data) and maintainable layering.
- Reliable user experience for network failures (non-blocking pagination errors, cached data continuity).
- Practical offline-first behavior with local persistence and TTL-based revalidation.

Deprioritized:
- Advanced visual polish (custom animations, richer transitions, premium UI details).
- Full test coverage (current tests focus on highest-risk repository/cubit paths).
- Complex cache policies (manual conflict resolution, fine-grained invalidation rules per resource).
- Advanced web navigation patterns (declarative router and deep-linking refinements).


### 3) How did you handle state management and side effects (UI -> state -> data), and how did you avoid coupling?
Flow:
`UI -> Cubit -> UseCase -> Repository -> DataSource (remote/local)`

Decoupling decisions:
- Cubits depend on use cases, not infrastructure.
- Use cases depend on repository abstractions.
- Repository maps data exceptions to domain failures.
- Side effects (HTTP/DB writes) stay in the data layer.

### 4) What is your offline/cache strategy: what do you persist, how do you invalidate/version, and how do you resolve conflicts?
Persisted:
- Pokémon list pages (`offset + position`)
- Pokémon detail by `id`
- `updatedAt` per row

Strategy:
- Cache-first reads.
- Remote revalidation writes back to local.
- UI renders cached content when available.
- Offline serves latest persisted data.

Invalidation/versioning/conflict:
- TTL: 1 hour for list and detail revalidation.
- Offline: never hard-invalidates cached data by TTL.
- Conflict resolution: remote wins when revalidation succeeds.
- Versioning/migrations: Drift schema version (`schemaVersion`).

### 5) What decisions did you make for Flutter Web UX (responsive, desktop-like interaction, performance), and what are the limitations/mitigations?
Decisions:
- Responsive split layout on desktop/tablet; push navigation on mobile.
- Drift web setup with `sqlite3.wasm` + worker asset.
- Same business/data flow across mobile and web.
- `cached_network_image` and lightweight placeholders to reduce jank.

Limitations and mitigations:
- Web requires correct worker/wasm file naming and URI configuration.
- Browser storage support can vary by environment.
- With empty cache and no internet, app cannot bootstrap new data (expected); empty/error states are shown.

### 6) Which 3 clean-code decisions did you apply? (include concrete examples)
1. Exception -> Failure mapping boundary  
   `PokemonRepositoryImpl._execute` maps `NetworkException`, `ServerException`, etc. into domain `Failure`.

2. Layered contracts  
   Presentation/domain depend on abstractions (`PokemonRepository`), not concrete Dio/Drift classes.

3. Single responsibility per layer  
   DTO parsing/mapping in data mappers, UI state transitions in Cubits, SQL/cache operations in local datasource/database.

### 7) What did you test and why? If incomplete, which tests would you add first and what would they guarantee?
Currently tested:
1. `PokemonListCubit`
   - Keeps previous data on pagination failure
   - Emits non-blocking UI event for pagination errors
   - Avoids replacing list screen with full error during pagination
2. `PokemonRepositoryImpl`
   - `getPokemonPageOnce` cache miss -> remote fetch -> local save -> expected result
   - `watchPokemonDetail` cache miss + remote failure -> propagates mapped failure

Next tests by priority:
1. `PokemonListCubit` initial success/empty/error and no duplicated pagination requests
2. `PokemonRepository` cache hit/stale/revalidation scenarios
3. `PokemonDetailCubit` loading/data/error transitions and subscription lifecycle

### 8) How did you structure commits (granularity, messages, convention) to ease review and maintenance?
- Small, focused commits by concern (cache, web setup, state handling, UI behavior, tests).
- Conventional commit style: `feat(scope): ...`, `fix(scope): ...`, `test(scope): ...`, `docs(scope): ...`.
- Avoided mixing unrelated refactors in the same commit.

### 9) What is still pending (top 3-5), and how would you implement it?
1. Expand automated coverage (repository + cubits + key widget tests).
2. Add explicit pull-to-refresh action with user-visible freshness feedback.
3. Improve retry UX in detail/list errors with contextual actions.
4. Add lightweight telemetry/perf metrics for web and low-end devices.
5. Prepare optional router declarative migration for web-style navigation flows.

---

## API
- Base URL: `https://pokeapi.co/api/v2/`
- Endpoints used:
  - `GET /pokemon?limit={n}&offset={m}`
  - `GET /pokemon/{id}`

---

## Notes
This implementation prioritizes architecture clarity and offline-ready foundations over visual polish, aligned with the one-day technical test timebox.
