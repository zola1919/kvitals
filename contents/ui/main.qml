import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.extras as PlasmaExtras
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.kirigami as Kirigami
import org.kde.ksysguard.sensors as Sensors

PlasmoidItem {
    id: root

    property string compactLayout: Plasmoid.configuration.compactLayout || "column"
    property int compactSpacing: Plasmoid.configuration.compactSpacing || 1
    property bool iconsMask: Plasmoid.configuration.iconsMask !== false
    property bool iconMonochrome: Plasmoid.configuration.iconMonochrome

    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    preferredRepresentation: compactRepresentation

    property bool showCpu: Plasmoid.configuration.showCpu
    property bool showRam: Plasmoid.configuration.showRam
    property bool showTemp: Plasmoid.configuration.showTemp
    property bool showGpu: Plasmoid.configuration.showGpu
    property bool showBattery: Plasmoid.configuration.showBattery
    property bool showPower: Plasmoid.configuration.showPower
    property bool showNetwork: Plasmoid.configuration.showNetwork
    property bool showDisk: Plasmoid.configuration.showDisk
    property bool showCpuPower: Plasmoid.configuration.showCpuPower
    property bool showCpuFrequency: Plasmoid.configuration.showCpuFrequency
    property string networkInterface: Plasmoid.configuration.networkInterface
    property string diskDevice: Plasmoid.configuration.diskDevice
    property string batteryDevice: Plasmoid.configuration.batteryDevice
    property string displayMode: Plasmoid.configuration.displayMode
    property int iconSize: Plasmoid.configuration.iconSize
    property string cpuIcon: Plasmoid.configuration.cpuIcon
    property string ramIcon: Plasmoid.configuration.ramIcon
    property string tempIcon: Plasmoid.configuration.tempIcon
    property string gpuIcon: Plasmoid.configuration.gpuIcon
    property string batteryIcon: Plasmoid.configuration.batteryIcon
    property string powerIcon: Plasmoid.configuration.powerIcon
    property string networkIcon: Plasmoid.configuration.networkIcon
    property string diskIcon: Plasmoid.configuration.diskIcon
    property string fontFamily: Plasmoid.configuration.fontFamily
    property int fontSize: Plasmoid.configuration.fontSize
    property int effectiveFontSize: fontSize > 0 ? fontSize : Kirigami.Theme.smallFont.pixelSize

    property bool useIcons: displayMode === "icons" || displayMode === "icons+text"
    property bool useText:  displayMode === "text"  || displayMode === "icons+text"

    property string metricOrder: Plasmoid.configuration.metricOrder || "cpu,ram,temp,gpu,bat,pwr,net,disk"
    property var orderedKeys: metricOrder.split(",").map(function(k) { return k.trim(); })

    // KSysGuard Sensors

    property int updateInterval: Plasmoid.configuration.updateInterval || 2000

    readonly property string netIfacePath: {
        if (networkInterface === "" || networkInterface === "auto")
            return "all";
        return networkInterface;
    }

    readonly property string diskDevicePath: {
        if (diskDevice === "" || diskDevice === "auto")
            return "all";
        return diskDevice;
    }

    Sensors.Sensor {
        id: cpuSensor
        sensorId: "cpu/all/usage"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: ramUsedSensor
        sensorId: "memory/physical/used"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: ramTotalSensor
        sensorId: "memory/physical/total"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: tempSensor
        sensorId: "cpu/all/averageTemperature"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuUsageAllSensor
        sensorId: "gpu/all/usage"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuUsage0Sensor
        sensorId: "gpu/gpu0/usage"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuUsage1Sensor
        sensorId: "gpu/gpu1/usage"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuUsage2Sensor
        sensorId: "gpu/gpu2/usage"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuUsage3Sensor
        sensorId: "gpu/gpu3/usage"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuVramUsedAllSensor
        sensorId: "gpu/all/usedVram"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuVramTotalAllSensor
        sensorId: "gpu/all/totalVram"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuVramUsedLegacySensor
        sensorId: "gpu/all/memory/used"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuVramTotalLegacySensor
        sensorId: "gpu/all/memory/total"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuVramUsed0Sensor
        sensorId: "gpu/gpu0/usedVram"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuVramTotal0Sensor
        sensorId: "gpu/gpu0/totalVram"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuVramUsed1Sensor
        sensorId: "gpu/gpu1/usedVram"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuVramTotal1Sensor
        sensorId: "gpu/gpu1/totalVram"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuVramUsed2Sensor
        sensorId: "gpu/gpu2/usedVram"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuVramTotal2Sensor
        sensorId: "gpu/gpu2/totalVram"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuVramUsed3Sensor
        sensorId: "gpu/gpu3/usedVram"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuVramTotal3Sensor
        sensorId: "gpu/gpu3/totalVram"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuTempAllSensor
        sensorId: "gpu/all/temperature"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuTemp0Sensor
        sensorId: "gpu/gpu0/temperature"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuTemp1Sensor
        sensorId: "gpu/gpu1/temperature"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuTemp2Sensor
        sensorId: "gpu/gpu2/temperature"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: gpuTemp3Sensor
        sensorId: "gpu/gpu3/temperature"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: netDownSensor
        sensorId: "network/" + root.netIfacePath + "/download"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: netUpSensor
        sensorId: "network/" + root.netIfacePath + "/upload"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: diskReadSensor
        sensorId: "disk/" + root.diskDevicePath + "/read"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
        id: diskWriteSensor
        sensorId: "disk/" + root.diskDevicePath + "/write"
        updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
      id: diskUsedSensor
      sensorId: "disk/" + root.diskDevicePath + "/used"
      updateRateLimit: root.updateInterval
    }

    Sensors.Sensor {
      id: diskTotalSensor
      sensorId: "disk/" + root.diskDevicePath + "/total"
      updateRateLimit: root.updateInterval
    }

    // --- CPU Power consumption (RAPL) ---

    property real cpuEnergyUJoules: -1
    property real previousCpuEnergyUJoules: -1
    property real cpuPowerWatts: 0
    property real previousTimestampUSec: 0
    property bool cpuPowerSupported: false

    Plasma5Support.DataSource {
        id: cpuPowerSource
        engine: "executable"

        onNewData: function(sourceName, data) {
            disconnectSource(sourceName);
            if (data["exit code"] !== 0) return;
            
            var energyStr = (data["stdout"] || "").trim();
            if (energyStr.length === 0) return;
            
            var currentEnergy = parseInt(energyStr);
            if (isNaN(currentEnergy) || currentEnergy < 0) return;

            var currentTimestamp = new Date().getTime() * 1000; // Convert to microseconds

            if (previousCpuEnergyUJoules <= 0) {
                // First reading: initialize and return 0
                previousCpuEnergyUJoules = currentEnergy;
                previousTimestampUSec = currentTimestamp;
                cpuEnergyUJoules = currentEnergy;
                cpuPowerSupported = true;
                cpuPowerWatts = 0;
            } else {
                // Calculate power: watts = microjoules / microseconds
                var energyDelta = currentEnergy - previousCpuEnergyUJoules;
                var timeDelta = currentTimestamp - previousTimestampUSec;

                if (timeDelta > 0) {
                    cpuPowerWatts = energyDelta / timeDelta;
                    cpuEnergyUJoules = currentEnergy;
                    previousCpuEnergyUJoules = currentEnergy;
                    previousTimestampUSec = currentTimestamp;
                }
            }
        }

        function run() {
            var cmd = "cat /sys/class/powercap/intel-rapl:0/energy_uj 2>/dev/null || echo -1";
            connectSource(cmd);
        }
    }



    Timer {
        id: cpuPowerTimer
        interval: root.updateInterval
        repeat: true
        running: root.showCpuPower
        onTriggered: {
            cpuPowerSource.run();
        }
    }

    // --- CPU Frequency ---

    property real cpuFrequencyMHz: -1
    property bool cpuFrequencySupported: false

    Plasma5Support.DataSource {
        id: cpuFrequencySource
        engine: "executable"

        onNewData: function(sourceName, data) {
            disconnectSource(sourceName);
            if (data["exit code"] !== 0) return;
            
            var freqStr = (data["stdout"] || "").trim();
            if (freqStr.length === 0) return;
            
            var freqKHz = parseInt(freqStr);
            if (isNaN(freqKHz) || freqKHz <= 0) return;

            cpuFrequencyMHz = freqKHz / 1000.0;
            cpuFrequencySupported = true;
        }

        function run() {
            // Try to read from scaling_cur_freq (in kHz)
            var cmd = "cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq 2>/dev/null || echo -1";
            connectSource(cmd);
        }
    }

    Timer {
        id: cpuFrequencyTimer
        interval: root.updateInterval
        repeat: true
        running: root.showCpuFrequency
        onTriggered: {
            cpuFrequencySource.run();
        }
    }

    // --- Partition usage for disk metrics ---

    property string selectedDiskDevice: ""
    property real summedPartitionUsed: 0
    property real summedPartitionTotal: 0

    onDiskDeviceChanged: {
        if (diskDevice === "auto") {
            selectedDiskDevice = "";
            summedPartitionUsed = 0;
            summedPartitionTotal = 0;
        } else {
            selectedDiskDevice = diskDevice;
            partitionUsageSource.run(diskDevice);
        }
    }

    Timer {
        id: partitionUpdateTimer
        interval: root.updateInterval
        repeat: true
        running: selectedDiskDevice && selectedDiskDevice.length > 0
        onTriggered: {
            if (selectedDiskDevice && selectedDiskDevice.length > 0) {
                partitionUsageSource.run(selectedDiskDevice);
            }
        }
    }

    Plasma5Support.DataSource {
        id: partitionUsageSource
        engine: "executable"

        onNewData: function(sourceName, data) {
            disconnectSource(sourceName);
            if (data["exit code"] !== 0) return;
            
            // Call the parse function to extract and sum partition data
            parsePartitionUsage(data["stdout"] || "");
        }

        function run(device) {
            // Combine lsblk (for sizes) and df (for used space) to get total and used
            var cmd = "lsblk -b -J /dev/" + device + " 2>/dev/null && df -B1 /dev/" + device + "* 2>/dev/null";
            connectSource(cmd);
        }
    }

    function parsePartitionUsage(output) {
        // Parse lsblk JSON to get partition sizes
        var totalSize = 0;
        try {
            // Extract JSON part (after lsblk output)
            var jsonMatch = output.match(/\{[\s\S]*\}/);
            if (jsonMatch) {
                var lsblkOutput = JSON.parse(jsonMatch[0]);
                if (lsblkOutput.blockdevices && lsblkOutput.blockdevices[0]) {
                    var device = lsblkOutput.blockdevices[0];
                    // Sum all partition sizes
                    if (device.children) {
                        for (var i = 0; i < device.children.length; i++) {
                            var child = device.children[i];
                            if (child.size) {
                                totalSize += parseInt(child.size) || 0;
                            }
                        }
                    }
                }
            }
        } catch(e) {
            // If JSON parsing fails, try df parsing
            console.warn("lsblk JSON parse failed, using df fallback");
        }

        // Parse df output for used space
        var usedSpace = 0;
        var lines = output.split("\n");
        for (var i = 1; i < lines.length; i++) { // Skip header
            var line = lines[i].trim();
            if (line.length === 0) continue;
            var parts = line.split(/\s+/);
            // df output: Filesystem Size Used Available Use% Mounted
            if (parts.length >= 3) {
                var used = parseInt(parts[2]) || 0;
                if (!isNaN(used)) {
                    usedSpace += used;
                }
                // If totalSize wasn't parsed from lsblk, try to get it from df
                if (totalSize === 0 && parts[1]) {
                    var size = parseInt(parts[1]) || 0;
                    if (!isNaN(size)) {
                        totalSize += size;
                    }
                }
            }
        }

        summedPartitionUsed = usedSpace;
        summedPartitionTotal = totalSize;
    }

    // --- Dynamic battery sensor discovery ---

    property string discoveredBatId: ""
    
    property var batteryCandidates: [
        "battery_BAT0",
        "battery_BAT1",
        "battery_BAT2",
        "battery_BATT",
        "battery_BATT0"
    ]
    property var stage1Probes: []
    property var batteryChoices: []
    property bool showBatteryPicker: false
    property bool showManualBatteryInput: false

    Component.onCompleted: {
        // Partition usage for selected disk
        if (diskDevice && diskDevice !== "auto") {
            selectedDiskDevice = diskDevice;
            partitionUsageSource.run(diskDevice);
        }
        
        // Battery probe setup
        if (!batteryDevice || batteryDevice === "auto") {
            for (var i = 0; i < batteryCandidates.length; i++) {
                var pre = "power/" + batteryCandidates[i] + "/chargePercentage";
                var code = 'import org.kde.ksysguard.sensors as Sensors; Sensors.Sensor { sensorId: "' + pre + '"; updateRateLimit: 0 }';
                try {
                    var probe = Qt.createQmlObject(code, root, "probe_" + i);
                    stage1Probes.push({ candidate: batteryCandidates[i], probe: probe });
                } catch(e) {
                }
            }
        }
        
        // Initialize CPU power if already enabled in config
        if (root.showCpuPower) {
            cpuPowerSource.run();
        }
        
        // Initialize CPU frequency reading if enabled
        if (root.showCpuFrequency) {
            cpuFrequencySource.run();
        }
    }

    property string batChargeSensorId: {
        var base = (batteryDevice && batteryDevice !== "auto") ? batteryDevice : discoveredBatId;
        return base ? ("power/" + base + "/chargePercentage") : "";
    }

    property string batRateSensorId: {
        var base = (batteryDevice && batteryDevice !== "auto") ? batteryDevice : discoveredBatId;
        return base ? ("power/" + base + "/chargeRate") : "";
    }

    Timer {
        id: stage1Timer
        interval: 500
        repeat: true
        running: (!batteryDevice || batteryDevice === "auto") && !discoveredBatId
        property int attempts: 0
        onTriggered: {
            attempts++;
            for (var i = 0; i < stage1Probes.length; i++) {
                if (stage1Probes[i].probe && stage1Probes[i].probe.status === Sensors.Sensor.Ready) {
                    persistDetectedBattery(stage1Probes[i].candidate);
                    running = false;
                    cleanupProbes();
                    return;
                }
            }
            if (attempts >= 6) { // 3 seconds timeout
                running = false;
                cleanupProbes();
                // Stage 2: qdbus fallback
                tryNextQdbus();
            }
        }
    }

    function cleanupProbes() {
        for (var i = 0; i < stage1Probes.length; i++) {
            if (stage1Probes[i].probe)
                stage1Probes[i].probe.destroy();
        }
        stage1Probes = [];
    }

    function persistDetectedBattery(deviceId) {
        discoveredBatId = deviceId;
        if (typeof Plasmoid !== "undefined" && Plasmoid.configuration)
            Plasmoid.configuration.batteryDevice = deviceId;
    }

    function extractBatteryIds(stdout) {
        if (!stdout)
            return [];
        var matches = stdout.match(/power\/[^\/"\s]+\/chargePercentage/g);
        if (!matches)
            return [];

        var ids = [];
        for (var i = 0; i < matches.length; i++) {
            var parts = matches[i].split("/");
            if (parts.length < 3)
                continue;
            if (ids.indexOf(parts[1]) === -1)
                ids.push(parts[1]);
        }
        return ids;
    }

    // Stage 2: qdbus fallback
    property var qdbusVariants: ["qdbus", "qdbus6", "qdbus-qt6", "qdbus-qt5"]
    property int qdbusIndex: 0

    Plasma5Support.DataSource {
        id: qdbusDetector
        engine: "executable"
        property bool active: false

        onNewData: function(sourceName, data) {
            if (!active) return;
            active = false;
            disconnectSource(sourceName);

            if (data["exit code"] === 0) {
                var ids = extractBatteryIds(data["stdout"] ? data["stdout"].toString() : "");
                if (ids.length === 1) {
                    persistDetectedBattery(ids[0]);
                    return;
                }
                if (ids.length > 1) {
                    batteryChoices = ids;
                    showBatteryPicker = true;
                    return;
                }
            }
            tryNextQdbus();
        }

        function run(variant) {
            var cmd = variant + " --literal org.kde.ksystemstats1" +
                      " /org/kde/ksystemstats1" +
                      " org.kde.ksystemstats1.allSensors";
            active = true;
            connectSource(cmd);
        }
    }

    function tryNextQdbus() {
        if (qdbusIndex >= qdbusVariants.length) {
            showManualBatteryInput = true;
            return;
        }
        var variant = qdbusVariants[qdbusIndex];
        qdbusIndex++;
        qdbusDetector.run(variant);
    }

    Sensors.Sensor {
        id: batChargeSensor
        sensorId: root.batChargeSensorId
        updateRateLimit: root.updateInterval > 5000 ? root.updateInterval : 5000
    }

    Sensors.Sensor {
        id: batRateSensor
        sensorId: root.batRateSensorId
        updateRateLimit: root.updateInterval > 5000 ? root.updateInterval : 5000
    }

    // --- Formatting helpers ---

    function formatBytes(bytes) {
        if (typeof bytes !== "number" || isNaN(bytes))
            return "...";
        var gb = bytes / (1024 * 1024 * 1024);
        return gb.toFixed(1);
    }

    function formatRate(bytesPerSec) {
        if (typeof bytesPerSec !== "number" || isNaN(bytesPerSec))
            return "...";
        var kbps = bytesPerSec / 1024;
        if (kbps >= 1024) {
            return (kbps / 1024).toFixed(1) + "M";
        }
        return Math.max(0, kbps).toFixed(1) + "K";
    }

    function formatFrequency(mhz) {
        if (typeof mhz !== "number" || isNaN(mhz) || mhz < 0)
            return "";
        if (mhz >= 1000) {
            return (mhz / 1000).toFixed(1) + " GHz";
        }
        return Math.round(mhz) + " MHz";
    }

    function sensorValueOrNaN(sensor) {
        if (!sensor || sensor.status !== Sensors.Sensor.Ready)
            return NaN;
        if (typeof sensor.value !== "number" || isNaN(sensor.value))
            return NaN;
        return sensor.value;
    }

    function firstReadyNumber(sensors, requirePositive) {
        for (var i = 0; i < sensors.length; i++) {
            var value = sensorValueOrNaN(sensors[i]);
            if (isNaN(value))
                continue;
            if (requirePositive && value <= 0)
                continue;
            return value;
        }
        return NaN;
    }

    function maxReadyNumber(sensors, requirePositive) {
        var maxValue = NaN;
        for (var i = 0; i < sensors.length; i++) {
            var value = sensorValueOrNaN(sensors[i]);
            if (isNaN(value))
                continue;
            if (requirePositive && value <= 0)
                continue;
            if (isNaN(maxValue) || value > maxValue)
                maxValue = value;
        }
        return maxValue;
    }

    function firstReadyVramPair(pairs) {
        for (var i = 0; i < pairs.length; i++) {
            var used = sensorValueOrNaN(pairs[i].used);
            var total = sensorValueOrNaN(pairs[i].total);
            if (isNaN(used) || isNaN(total))
                continue;
            if (total <= 0 || used < 0)
                continue;
            return { used: used, total: total };
        }
        return null;
    }

    // --- Derived display values ---

    property string cpuValue: {
        if (cpuSensor.status !== Sensors.Sensor.Ready) return "...";
        var usage = Math.round(cpuSensor.value) + "%";
        if (root.showCpuPower && root.cpuPowerSupported && cpuPowerWatts >= 0) {
            usage += " (" + cpuPowerWatts.toFixed(2) + "W)";
        }
        if (root.showCpuFrequency && root.cpuFrequencySupported && cpuFrequencyMHz > 0) {
            usage += " " + formatFrequency(cpuFrequencyMHz);
        }
        return usage;
    }

    property string ramValue: {
        if (ramUsedSensor.status !== Sensors.Sensor.Ready || ramTotalSensor.status !== Sensors.Sensor.Ready)
            return "...";
        return formatBytes(ramUsedSensor.value) + "/" + formatBytes(ramTotalSensor.value) + "G";
    }

    property string tempValue: {
        if (tempSensor.status !== Sensors.Sensor.Ready) return "--";
        return Math.round(tempSensor.value) + "°C";
    }

    property real gpuUsageNumber: {
        var aggregateUsage = firstReadyNumber([gpuUsageAllSensor], false);
        if (!isNaN(aggregateUsage))
            return aggregateUsage;
        return maxReadyNumber([gpuUsage0Sensor, gpuUsage1Sensor, gpuUsage2Sensor, gpuUsage3Sensor], false);
    }

    property var gpuVramPair: {
        return firstReadyVramPair([
            { used: gpuVramUsedAllSensor, total: gpuVramTotalAllSensor },
            { used: gpuVramUsedLegacySensor, total: gpuVramTotalLegacySensor },
            { used: gpuVramUsed0Sensor, total: gpuVramTotal0Sensor },
            { used: gpuVramUsed1Sensor, total: gpuVramTotal1Sensor },
            { used: gpuVramUsed2Sensor, total: gpuVramTotal2Sensor },
            { used: gpuVramUsed3Sensor, total: gpuVramTotal3Sensor }
        ]);
    }

    property real gpuTempNumber: {
        var aggregateTemp = firstReadyNumber([gpuTempAllSensor], true);
        if (!isNaN(aggregateTemp))
            return aggregateTemp;
        return maxReadyNumber([gpuTemp0Sensor, gpuTemp1Sensor, gpuTemp2Sensor, gpuTemp3Sensor], true);
    }

    property string gpuValue: {
        if (isNaN(gpuUsageNumber))
            return "";
        return Math.round(gpuUsageNumber) + "%";
    }

    property string gpuRamValue: {
        if (!gpuVramPair)
            return "";
        return formatBytes(gpuVramPair.used) + "/" + formatBytes(gpuVramPair.total) + "G";
    }

    property string gpuTempValue: {
        if (isNaN(gpuTempNumber))
            return "";
        return Math.round(gpuTempNumber) + "°C";
    }

    property string gpuDisplayValue: {
        var parts = [];
        if (gpuValue)
            parts.push(gpuValue);
        if (gpuRamValue)
            parts.push(gpuRamValue);
        if (gpuTempValue)
            parts.push(gpuTempValue);
        return parts.join(" ");
    }

    property bool hasGpuData: gpuDisplayValue.length > 0

    property bool hasGpuUsageData: gpuValue.length > 0
    property bool hasGpuVramData: gpuRamValue.length > 0
    property bool hasGpuTempData: gpuTempValue.length > 0

    property string batValue: {
        if (batChargeSensor.status !== Sensors.Sensor.Ready) return "";
        return Math.round(batChargeSensor.value) + "%";
    }

    property string batIcon: {
        if (batRateSensor.status !== Sensors.Sensor.Ready) return "";
        return batRateSensor.value > 0 ? "⚡" : "🔋";
    }

    property string powerValue: {
        if (batRateSensor.status !== Sensors.Sensor.Ready) return "";
        var watts = Math.abs(batRateSensor.value);
        if (watts < 0.01) return "0.0W";
        var sign = batRateSensor.value > 0 ? "+" : "-";
        return sign + watts.toFixed(1) + "W";
    }

    property string netDownValue: {
        if (netDownSensor.status !== Sensors.Sensor.Ready) return "...";
        return formatRate(netDownSensor.value);
    }

    property string netUpValue: {
        if (netUpSensor.status !== Sensors.Sensor.Ready) return "...";
        return formatRate(netUpSensor.value);
    }

    property string diskReadValue: {
        if (diskReadSensor.status !== Sensors.Sensor.Ready) return "...";
        return formatRate(diskReadSensor.value);
    }

    property string diskWriteValue: {
        if (diskWriteSensor.status !== Sensors.Sensor.Ready) return "...";
        return formatRate(diskWriteSensor.value);
    }

    property string diskUsedValue: {
        // Use summed partition values if a specific device is selected
        if (selectedDiskDevice && selectedDiskDevice.length > 0 && summedPartitionUsed > 0) {
            return formatBytes(summedPartitionUsed) + "G";
        }
        // Fallback to sensor (handles "all" and devices without partitions)
        if (diskUsedSensor.status !== Sensors.Sensor.Ready) return "...";
        return formatBytes(diskUsedSensor.value) + "G";
    }

    property string diskTotalValue: {
        // Use summed partition values if a specific device is selected
        if (selectedDiskDevice && selectedDiskDevice.length > 0 && summedPartitionTotal > 0) {
            return formatBytes(summedPartitionTotal) + "G";
        }
        // Fallback to sensor (handles "all" and devices without partitions)
        if (diskTotalSensor.status !== Sensors.Sensor.Ready) return "...";
        return formatBytes(diskTotalSensor.value) + "G";
    }

    property string diskDisplayValue: {
        var parts = [];
        if (diskUsedValue && diskTotalValue)
            parts.push(diskUsedValue + "/" + diskTotalValue);
        if (diskReadValue && diskWriteValue)
            parts.push("R:" + diskReadValue + " W:" + diskWriteValue);
        return parts.join(" ");
    }

    compactRepresentation: Item {
        id: compactContainer
        implicitWidth: root.compactLayout === "column" ? columnLayout.implicitWidth : rowLayout.implicitWidth
        implicitHeight: root.compactLayout === "column" ? columnLayout.implicitHeight : rowLayout.implicitHeight

        Column {
            id: columnLayout
            visible: root.compactLayout === "column"
            anchors.fill: parent
            spacing: root.compactSpacing

            TapHandler {
                onTapped: root.expanded = !root.expanded
            }

            property var metricsModel: {
                var items = [];
                for (var i = 0; i < root.orderedKeys.length; i++) {
                    var key = root.orderedKeys[i];
                    if (key === "cpu" && root.showCpu && root.cpuValue)
                        items.push({ icon: root.cpuIcon, label: "CPU:", value: root.cpuValue, iconColor: "#3daee9" });
                    else if (key === "ram" && root.showRam && root.ramValue)
                        items.push({ icon: root.ramIcon, label: "RAM:", value: root.ramValue, iconColor: "#9b59b6" });
                    else if (key === "temp" && root.showTemp && root.tempValue && root.tempValue !== "--")
                        items.push({ icon: root.tempIcon, label: "TEMP:", value: root.tempValue, iconColor: "#e74c3c" });
                    else if (key === "gpu" && root.showGpu && root.hasGpuData)
                        items.push({ icon: root.gpuIcon, label: "GPU:", value: root.gpuDisplayValue, iconColor: "#2ecc71" });
                    else if (key === "bat" && root.showBattery && root.batValue)
                        items.push({ icon: root.batteryIcon, label: "BAT:", value: root.batValue, iconColor: "#f1c40f" });
                    else if (key === "pwr" && root.showPower && root.powerValue)
                        items.push({ icon: root.powerIcon, label: "PWR:", value: root.powerValue, iconColor: "#e67e22" });
                    else if (key === "net" && root.showNetwork)
                        items.push({ icon: root.networkIcon, label: "NET:", value: "↓" + root.netDownValue + " ↑" + root.netUpValue, iconColor: "#1abc9c" });
                    else if (key === "disk" && root.showDisk && root.diskDisplayValue)
                        items.push({ icon: root.diskIcon, label: "DISK:", value: root.diskDisplayValue, iconColor: "#34495e" });
                }
                return items;
            }

            Repeater {
                model: columnLayout.metricsModel

                delegate: Row {
                    spacing: 2
                    width: parent.width

                    // Icon
                    Kirigami.Icon {
                        visible: root.useIcons
                        source: modelData.icon
                        isMask: root.iconsMask
                        color: root.iconMonochrome ? Kirigami.Theme.textColor : modelData.iconColor
                        width: root.iconSize
                        height: root.iconSize
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    // Text label
                    PlasmaComponents.Label {
                        visible: root.useText
                        text: modelData.label
                        font.pixelSize: root.effectiveFontSize
                        font.family: root.fontFamily
                        color: Kirigami.Theme.textColor
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    // Value
                    PlasmaComponents.Label {
                        text: modelData.value
                        font.pixelSize: root.effectiveFontSize
                        font.family: root.fontFamily
                        color: Kirigami.Theme.textColor
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

        Row {
            id: rowLayout
            visible: root.compactLayout === "row"
            anchors.fill: parent
            spacing: root.compactSpacing

            TapHandler {
                onTapped: root.expanded = !root.expanded
            }

            property var metricsModel: {
                var items = [];
                for (var i = 0; i < root.orderedKeys.length; i++) {
                    var key = root.orderedKeys[i];
                    if (key === "cpu" && root.showCpu && root.cpuValue)
                        items.push({ icon: root.cpuIcon, label: "CPU:", value: root.cpuValue, iconColor: "#3daee9" });
                    else if (key === "ram" && root.showRam && root.ramValue)
                        items.push({ icon: root.ramIcon, label: "RAM:", value: root.ramValue, iconColor: "#9b59b6" });
                    else if (key === "temp" && root.showTemp && root.tempValue && root.tempValue !== "--")
                        items.push({ icon: root.tempIcon, label: "TEMP:", value: root.tempValue, iconColor: "#e74c3c" });
                    else if (key === "gpu" && root.showGpu && root.hasGpuData)
                        items.push({ icon: root.gpuIcon, label: "GPU:", value: root.gpuDisplayValue, iconColor: "#2ecc71" });
                    else if (key === "bat" && root.showBattery && root.batValue)
                        items.push({ icon: root.batteryIcon, label: "BAT:", value: root.batValue, iconColor: "#f1c40f" });
                    else if (key === "pwr" && root.showPower && root.powerValue)
                        items.push({ icon: root.powerIcon, label: "PWR:", value: root.powerValue, iconColor: "#e67e22" });
                    else if (key === "net" && root.showNetwork)
                        items.push({ icon: root.networkIcon, label: "NET:", value: "↓" + root.netDownValue + " ↑" + root.netUpValue, iconColor: "#1abc9c" });
                    else if (key === "disk" && root.showDisk && root.diskDisplayValue)
                        items.push({ icon: root.diskIcon, label: "DISK:", value: root.diskDisplayValue, iconColor: "#34495e" });
                }
                return items;
            }

            Repeater {
                model: rowLayout.metricsModel

                delegate: Row {
                    spacing: 2
                    height: parent.height

                    // Icon
                    Kirigami.Icon {
                        visible: root.useIcons
                        source: modelData.icon
                        isMask: root.iconsMask
                        color: root.iconMonochrome ? Kirigami.Theme.textColor : modelData.iconColor
                        width: root.iconSize
                        height: root.iconSize
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    // Text label
                    PlasmaComponents.Label {
                        visible: root.useText
                        text: modelData.label
                        font.pixelSize: root.effectiveFontSize
                        font.family: root.fontFamily
                        color: Kirigami.Theme.textColor
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    // Value
                    PlasmaComponents.Label {
                        text: modelData.value
                        font.pixelSize: root.effectiveFontSize
                        font.family: root.fontFamily
                        color: Kirigami.Theme.textColor
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }

    fullRepresentation: PlasmaExtras.Representation {
        Layout.preferredWidth: Kirigami.Units.gridUnit * 18
        Layout.preferredHeight: Kirigami.Units.gridUnit * 12

        ColumnLayout {
            anchors.fill: parent
            spacing: Kirigami.Units.smallSpacing

            Repeater {
                model: {
                    var items = [];
                    for (var i = 0; i < root.orderedKeys.length; i++) {
                        var key = root.orderedKeys[i];
                        if (key === "cpu" && root.showCpu) {
                            items.push({ label: "CPU Usage", value: root.cpuValue });
                        }
                        else if (key === "ram" && root.showRam)
                            items.push({ label: "Memory", value: root.ramValue });
                        else if (key === "temp" && root.showTemp && root.tempValue !== "--")
                            items.push({ label: "CPU Temp", value: root.tempValue });
                        else if (key === "gpu" && root.showGpu) {
                            if (root.hasGpuUsageData) items.push({ label: "GPU Usage", value: root.gpuValue });
                            if (root.hasGpuVramData) items.push({ label: "GPU VRAM", value: root.gpuRamValue });
                            if (root.hasGpuTempData) items.push({ label: "GPU Temp", value: root.gpuTempValue });
                        }
                        else if (key === "bat" && root.showBattery && root.batValue)
                            items.push({ label: "Battery", value: root.batValue });
                        else if (key === "pwr" && root.showPower && root.powerValue)
                            items.push({ label: "Power", value: root.powerValue });
                        else if (key === "net" && root.showNetwork) {
                            items.push({ label: "Network ↓", value: root.netDownValue });
                            items.push({ label: "Network ↑", value: root.netUpValue });
                        }
                        else if (key === "disk" && root.showDisk && root.diskDisplayValue)
                            items.push({ label: "Disk", value: root.diskDisplayValue });
                    }
                    return items;
                }

                delegate: RowLayout {
                    Layout.fillWidth: true
                    Layout.leftMargin: Kirigami.Units.largeSpacing
                    Layout.rightMargin: Kirigami.Units.largeSpacing

                    PlasmaComponents.Label {
                        text: modelData.label
                        opacity: 0.7
                        Layout.fillWidth: true
                    }
                    PlasmaComponents.Label {
                        text: modelData.value
                        font.bold: true
                        horizontalAlignment: Text.AlignRight
                    }
                }
            }
        }
    }

    toolTipMainText: "KVitals"
    toolTipSubText: {
        var parts = [];
        for (var i = 0; i < root.orderedKeys.length; i++) {
            var key = root.orderedKeys[i];
            if (key === "cpu" && root.showCpu && root.cpuValue) {
                parts.push("CPU: " + root.cpuValue);
            }
            else if (key === "ram" && root.showRam && root.ramValue)
                parts.push("RAM: " + root.ramValue);
            else if (key === "temp" && root.showTemp && root.tempValue && root.tempValue !== "--")
                parts.push("TEMP: " + root.tempValue);
            else if (key === "gpu" && root.showGpu && root.hasGpuData) {
                if (root.hasGpuUsageData) parts.push("GPU: " + root.gpuValue);
                if (root.hasGpuVramData) parts.push("VRAM: " + root.gpuRamValue);
                if (root.hasGpuTempData) parts.push("GPU TEMP: " + root.gpuTempValue);
            }
            else if (key === "bat" && root.showBattery && root.batValue)
                parts.push("BAT: " + root.batValue);
            else if (key === "pwr" && root.showPower && root.powerValue)
                parts.push("PWR: " + root.powerValue);
            else if (key === "net" && root.showNetwork)
                parts.push("NET: ↓" + root.netDownValue + " ↑" + root.netUpValue);
            else if (key === "disk" && root.showDisk && root.diskDisplayValue)
                parts.push("DISK: " + root.diskDisplayValue);
        }
        return parts.join("\n");
    }
}
