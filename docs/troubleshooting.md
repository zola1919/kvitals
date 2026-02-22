# Troubleshooting

## Temperature Shows "--"

**Cause:** The widget couldn't find a temperature source on your system.

**Fix:** Check which thermal sources are available:

```bash
# Check thermal zones
cat /sys/class/thermal/thermal_zone*/type 2>/dev/null

# Check hwmon
for d in /sys/class/hwmon/hwmon*/; do
    echo "$(cat "$d/name" 2>/dev/null): $d"
done

# Check lm-sensors
sensors 2>/dev/null | head -20
```

!!! tip "AMD Systems"
    If you're on AMD, make sure `k10temp` or `zenpower` kernel module is loaded:
    ```bash
    sudo modprobe k10temp
    ```
    To load it automatically on boot, add `k10temp` to `/etc/modules-load.d/k10temp.conf`.

## Battery/Power Shows Nothing

**Cause:** No battery detected (desktop systems without a battery).

!!! note
    This is expected behavior on desktop systems. Disable battery and power metrics in **Settings → Metrics** tab to hide the empty entries.

## Network Speed Shows 0

**Cause:** Wrong network interface selected.

**Fix:**

1. Check your active interface: `ip route | grep default`
2. Open **Settings → Metrics** and set the correct interface, or set to `auto`

!!! tip
    If you use multiple connections (WiFi + Ethernet), set the interface manually to the one you want to monitor.

## Widget Shows "KVitals" or "..."

**Cause:** The stats script hasn't returned data yet or failed to execute.

**Fix:**

1. Test the script directly:
   ```bash
   bash ~/.local/share/plasma/plasmoids/org.kde.plasma.kvitals/contents/scripts/sys-stats.sh
   ```
2. Check for script errors:
   ```bash
   journalctl -b --no-pager | grep "sys-state parse error"
   ```

!!! warning
    If the script outputs nothing or errors, check that `free`, `awk`, and `bc` are installed on your system.

## Icons Not Visible on Panel

**Cause:** Icons are rendered with `isMask: true` (monochrome). If your panel background is the same color as the text color, icons may be invisible.

!!! tip
    Try switching to a different Plasma theme, or adjust the panel opacity. You can also switch to **Text** display mode if icons aren't working well with your theme.

## Settings Dialog Shows Warnings in Journal

!!! note "Harmless Warnings"
    You may see `cfg_*Default` warnings in the journal. These are harmless Plasma 6 KCM warnings about default property injection and **do not affect functionality**.

## Widget Not Appearing After Install

**Fix:**

1. Restart plasmashell:
   ```bash
   kquitapp6 plasmashell && kstart plasmashell &
   ```
2. If still missing, check the install path:
   ```bash
   ls ~/.local/share/plasma/plasmoids/org.kde.plasma.kvitals/
   ```

!!! warning
    If the directory doesn't exist, the install failed. Re-run `bash install.sh` from the project directory.

## Custom Font Not Applying

**Cause:** The font name might not match exactly.

**Fix:**

1. Check available fonts: `fc-list | grep -i "font-name"`
2. In settings, use the exact family name from the dropdown
3. Font size `0` means "use system default" — set a specific value if needed

!!! tip
    The font dropdown is searchable — start typing the font name to filter the list. You can also type a custom font name directly.
