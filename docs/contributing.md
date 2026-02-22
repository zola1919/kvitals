# Contributing

Thanks for your interest in contributing to KVitals!

## Getting Started

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/<your-username>/kvitals.git
   cd kvitals
   ```
3. Install locally for development:
   ```bash
   bash install.sh
   ```

## Development Workflow

### Making Changes

1. Edit files in the project directory
2. Reinstall and test:
   ```bash
   bash install.sh
   kquitapp6 plasmashell && kstart plasmashell &
   ```
3. Check for QML errors:
   ```bash
   journalctl -b --no-pager | grep kvitals
   ```

!!! tip "Fast Iteration"
    You don't always need to restart plasmashell. For config-only changes, just reopen the settings dialog. For QML changes, a restart is required.

### Shell Script Changes

Always run ShellCheck before committing:

```bash
shellcheck contents/scripts/sys-stats.sh
```

!!! warning "CI Enforcement"
    ShellCheck is enforced in CI. PRs with ShellCheck warnings will fail the pipeline.

### Adding a New Metric

1. **Script** — Add a new function in `sys-stats.sh` that outputs the value
2. **JSON** — Include the new field in the JSON output
3. **Config** — Add `showNewMetric` (Bool) and optionally `newMetricIcon` (String) to `main.xml`
4. **Settings** — Add checkbox to `configMetrics.qml`, icon picker to `configIcons.qml`
5. **UI** — Add property bindings and model entry in `main.qml`

!!! note
    Don't forget to add a default icon name for the new metric in `configIcons.qml`'s reset button handler.

### Adding a New Setting

1. Add the entry to `contents/config/main.xml` with a default value
2. Add the UI control to the appropriate config tab (`configGeneral.qml`, `configMetrics.qml`, or `configIcons.qml`)
3. Bind the value in `main.qml` via `Plasmoid.configuration.<key>`

## Pull Requests

1. Create a feature branch: `git checkout -b feat/my-feature`
2. Make your changes and test locally
3. Ensure ShellCheck passes
4. Push and open a PR against `master`

!!! tip "Commit Messages"
    Use conventional commits for clear history:

    - `feat:` — New feature
    - `fix:` — Bug fix
    - `chore:` — Maintenance
    - `docs:` — Documentation

## Code Style

- **QML** — Follow KDE's QML conventions, use `Kirigami` components where possible
- **Bash** — Must pass ShellCheck with no warnings
- **Commits** — Use conventional commits: `feat:`, `fix:`, `chore:`, `docs:`

## Reporting Issues

When filing a bug report, please include:

- KDE Plasma version (`plasmashell --version`)
- Linux distribution and version
- Whether you're using Intel or AMD CPU
- Relevant journal output (`journalctl -b | grep kvitals`)

!!! note "Debugging Output"
    To capture detailed logs for a bug report:
    ```bash
    journalctl -b --no-pager | grep -i "kvitals\|sys-state" > kvitals-debug.log
    ```
