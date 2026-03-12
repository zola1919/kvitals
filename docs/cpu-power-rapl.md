# CPU Power Draw (RAPL)

## Overview

KVitals now includes CPU power consumption monitoring using Intel Running Average Power Limit (RAPL). This feature displays real-time CPU power draw in watts directly in the widget.

## How It Works

The feature reads energy data from the Intel RAPL interface (`/sys/class/powercap/intel-rapl:0/energy_uj`) and calculates power consumption by measuring the energy delta over time:

```
Power (W) = ΔEnergy (µJ) / ΔTime (µs)
```

This provides an accurate measurement of CPU power draw that includes all processor cores on the same power domain.

## System Requirements

- **Intel CPU** with RAPL support (most Intel processors from Sandy Bridge onwards)
- **AMD CPU** with the Zenergy DKMS module installed
- RAPL interface exposed at `/sys/class/powercap/intel-rapl:0/energy_uj`
- Sufficient read permissions to the RAPL energy file

## Permissions Setup

By default, the RAPL interface file is only readable by root. KVitals handles this automatically:

### Automatic One-Time Setup (Default)

When you first launch the widget with CPU Power enabled:

1. You'll be prompted for your sudo password **once**
2. The widget will make the RAPL file readable (`chmod 644`)
3. All subsequent reads work without any prompts
4. This setting persists until the next system reboot

This is the simplest approach and requires no manual configuration.

## Display Locations

When CPU Power is enabled, the power draw appears combined with CPU usage:

```
CPU: 45% (12.34W)
```

Shows both the usage percentage and power draw in watts.

## Configuration

### Enabling/Disabling

CPU power monitoring is **disabled by default**. To enable it:

1. Right-click the widget and select "Configure"
2. Under CPU, check the "Show power draw" option
3. Apply the changes
4. **On first run**: You'll be prompted for your sudo password to make the RAPL file readable
5. Enter your password and the feature will start working

After the first password prompt, all subsequent reads work without authentication.

### Update Interval

The power data is sampled at the same interval as other metrics (configurable, default 2000ms).

## Troubleshooting

### Password prompt appears multiple times

The widget prompts only **once** on first startup. If you see repeated prompts:
- The chmod may have failed - verify you have sudo access
- Check that your user can use `sudo` without a password prompt (contact your system admin if needed)

### Power draw not appearing

1. **Check RAPL support**: Verify your CPU supports RAPL
   ```bash
   test -f /sys/class/powercap/intel-rapl:0/energy_uj && echo "RAPL supported" || echo "RAPL not available"
   ```

2. **Check current permissions**: See if the file is readable
   ```bash
   cat /sys/class/powercap/intel-rapl:0/energy_uj
   ```
   - If readable, the feature should work
   - If "Permission denied", enable the feature in widget settings to trigger the one-time chmod

3. **Verify settings**: Make sure "Show power draw" is checked under CPU configuration

### High initial power readings

The first few measurements after startup may be inaccurate. This stabilizes within 2-3 update cycles (4-6 seconds with default settings).

## Performance Impact

The CPU power monitoring has minimal overhead:
- Single file read per update cycle (default every 2000ms)
- Simple arithmetic calculation
- One-time sudo prompt on first toggle

## See Also

- [Intel Running Average Power Limit (RAPL) Documentation](https://github.com/torvalds/linux/blob/master/drivers/powercap/intel_rapl.c)
- [Linux Power Management](https://www.kernel.org/doc/html/latest/power/index.html)
