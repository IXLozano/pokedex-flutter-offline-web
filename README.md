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

## Architecture And Scalability

### Chosen architecture
Feature-first + Clean Architecture layers:
- `presentation` (screens, cubits, states)
- `domain` (entities, use cases, repository contracts)
- `data` (remote/local datasources, DTOs, mappers, repository impl)
- `core` (network, errors, responsive, DI)

### Why this scales to real product (including web)
- Domain contracts isolate business rules from framework/infrastructure.
- Data layer can evolve independently (sync, retries, metrics, auth).
- Local + remote datasources allow progressive offline strategy without rewriting UI.
- Web constraints (worker/wasm/local persistence) are isolated in data/local setup.

---

## Timebox Trade-Offs (1 Day)

### What was prioritized
- Functional completeness (list, detail, pagination, offline cache)
- Stable architecture boundaries
- Web compatibility with local persistence
- Critical UX states and error handling

### What was deprioritized
- Deep UI polish/animations
- Large test suite
- Advanced cache invalidation policies (TTL/version migrations beyond base)
- Router declarative migration

---

## State Management And Side Effects

### Flow
`UI -> Cubit -> UseCase -> Repository -> DataSource (remote/local)`

### Decoupling approach
- Cubits depend on use cases, not infrastructure.
- Use cases depend on repository contracts.
- Repository maps data/exceptions into domain-friendly behavior.
- Side effects (network, DB writes) stay in data layer.

### List behavior
- Initial load: one-shot page load (cache-first fallback to remote), then UI state update.
- Pagination: one-shot page request per scroll threshold.
- Refresh indicator: controlled by Cubit `isRefreshing`.

### Detail behavior
- Reactive local stream + background revalidation pattern.

---

## Offline And Cache Strategy

### What is persisted
- Pokémon list pages (by `offset + position`)
- Pokémon detail by `id`
- `updatedAt` timestamp per row

### Strategy
- Cache-first for read path.
- Remote revalidation updates local cache.
- UI renders from cached data when available.
- Offline mode serves previously persisted content.

### Invalidation / versioning / conflict policy
- Current policy: replace page snapshot on fresh fetch, upsert detail by id.
- Conflict resolution: remote wins when revalidation succeeds.
- Versioning: DB schema version via Drift (`schemaVersion`), ready for migrations.

---

## Flutter Web Decisions

### Decisions taken
- Responsive split layout for desktop/tablet and push navigation on mobile
- Drift web setup with wasm + worker assets
- DB logic isolated from presentation for web/mobile parity
- Conservative image/loading strategy for smoother scrolling

### Limitations and mitigations
- Web requires correct worker/wasm file naming and paths.
- Browser storage behavior may differ by environment; app still relies on initial online fetch when cache is empty.
- Large image decode on mobile/web can affect smoothness; mitigated with cached image strategy.

---

## Code Quality (3 Concrete Decisions)

1. Exception -> Failure mapping boundary  
   Data exceptions (`NetworkException`, `ServerException`, etc.) are mapped into domain failures centrally in repository execution wrapper.

2. Layered contracts  
   Presentation and domain depend on abstractions, not concrete HTTP/DB implementations.

3. Single responsibility per layer  
   DTO parsing/mapping in data, state transitions in Cubit, and DB schema/query methods in local datasource/database classes.

---

## Testing

### What is currently tested
- (Fill with what is actually present in repo. If none, keep explicit.)

### If limited by time, first tests to add (priority)
1. `PokemonListCubit`
   - Initial success, empty, error
   - Pagination success and no duplicate fetch while loading
2. `PokemonRepository`
   - Cache hit behavior
   - Cache miss -> remote fetch -> local save
   - Remote failure handling
3. `PokemonDetailCubit`
   - Loading -> data
   - Loading -> error

These tests ensure correctness on the highest-risk flows (state transitions + offline cache path).

---

## Git Strategy

### Commit structure
- Small, focused commits by concern:
  - Architecture contract changes
  - Local persistence integration
  - Web compatibility fixes
  - UI/performance fixes
- Conventional messages (`feat(scope): ...`, `fix(scope): ...`) to simplify review and maintenance.

---

## Pending Work (Top 3-5)

1. Add full automated tests (Cubit + repository + critical widgets)
2. Define explicit TTL/refresh policy and optional manual refresh action
3. Improve detail/list consistency under no-network startup scenarios
4. Add richer error UX (retry actions, contextual messages)
5. Introduce telemetry/perf profiling for web and low-end mobile

---

## API
- Base URL: `https://pokeapi.co/api/v2/`
- Endpoints used:
  - `GET /pokemon?limit={n}&offset={m}`
  - `GET /pokemon/{id}`

---

## Notes
This implementation prioritizes architecture clarity and offline-ready foundations over visual polish, aligned with the one-day technical test timebox.
