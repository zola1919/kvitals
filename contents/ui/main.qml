import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    preferredRepresentation: compactRepresentation

    property bool showCpu: Plasmoid.configuration.showCpu
    property bool showRam: Plasmoid.configuration.showRam
    property bool showTemp: Plasmoid.configuration.showTemp
    property bool showBattery: Plasmoid.configuration.showBattery
    property bool showPower: Plasmoid.configuration.showPower
    property bool showNetwork: Plasmoid.configuration.showNetwork
    property string networkInterface: Plasmoid.configuration.networkInterface
    property string displayMode: Plasmoid.configuration.displayMode
    property int iconSize: Plasmoid.configuration.iconSize
    property string cpuIcon: Plasmoid.configuration.cpuIcon
    property string ramIcon: Plasmoid.configuration.ramIcon
    property string tempIcon: Plasmoid.configuration.tempIcon
    property string batteryIcon: Plasmoid.configuration.batteryIcon
    property string powerIcon: Plasmoid.configuration.powerIcon
    property string networkIcon: Plasmoid.configuration.networkIcon
    property string fontFamily: Plasmoid.configuration.fontFamily
    property int fontSize: Plasmoid.configuration.fontSize
    property int effectiveFontSize: fontSize > 0 ? fontSize : Kirigami.Theme.smallFont.pixelSize

    property bool useIcons: displayMode === "icons" || displayMode === "icons+text"
    property bool useText:  displayMode === "text"  || displayMode === "icons+text"

    property string cpuValue: "..."
    property string ramValue: "..."
    property string tempValue: "..."
    property string batValue: "..."
    property string batIcon: ""
    property string powerValue: "..."
    property string powerSign: ""
    property string netDownValue: "..."
    property string netUpValue: "..."

    Plasma5Support.DataSource {
        id: statsSource
        engine: "executable"

        property string scriptPath: Qt.resolvedUrl("../scripts/sys-stats.sh").toString().replace("file://", "")

        connectedSources: ["bash " + scriptPath + " " + root.networkInterface]

        interval: Plasmoid.configuration.updateInterval

        onNewData: function(source, data) {
            if (data["exit code"] !== 0) return;

            var stdout = data["stdout"].trim();
            if (stdout.length === 0) return;

            try {
                var stats = JSON.parse(stdout);

                root.cpuValue = stats.cpu + "%";
                root.ramValue = stats.ram_used + "/" + stats.ram_total + "G";
                root.tempValue = stats.temp !== "N/A" ? stats.temp + "°C" : "--";

                if (stats.bat !== "N/A") {
                    root.batIcon = stats.bat_icon || "";
                    root.batValue = stats.bat + "%";
                } else {
                    root.batValue = "";
                }

                if (stats.power !== "N/A") {
                    root.powerSign = stats.power_sign || "";
                    root.powerValue = root.powerSign + stats.power + "W";
                } else {
                    root.powerValue = "";
                }

                root.netDownValue = stats.net_down;
                root.netUpValue = stats.net_up;
            } catch (e) {
                console.log("sys-state parse error: " + e + " | raw: " + stdout);
            }
        }
    }

    compactRepresentation: RowLayout {
        id: compactRow
        spacing: Kirigami.Units.smallSpacing

        property var metricsModel: {
            var items = [];
            if (root.showCpu && root.cpuValue)
                items.push({ icon: root.cpuIcon, label: "CPU:", value: root.cpuValue });
            if (root.showRam && root.ramValue)
                items.push({ icon: root.ramIcon, label: "RAM:", value: root.ramValue });
            if (root.showTemp && root.tempValue)
                items.push({ icon: root.tempIcon, label: "TEMP:", value: root.tempValue });
            if (root.showBattery && root.batValue)
                items.push({ icon: root.batteryIcon, label: "BAT:", value: root.batValue });
            if (root.showPower && root.powerValue)
                items.push({ icon: root.powerIcon, label: "PWR:", value: root.powerValue });
            if (root.showNetwork) {
                items.push({ icon: root.networkIcon, label: "NET:", value: "↓" + root.netDownValue + " ↑" + root.netUpValue });
            }
            return items;
        }

        Repeater {
            model: compactRow.metricsModel

            delegate: RowLayout {
                spacing: 2
                Layout.fillHeight: true

                // Separator
                PlasmaComponents.Label {
                    visible: index > 0
                    text: "|"
                    font.pixelSize: root.effectiveFontSize
                    font.family: root.fontFamily
                    color: Kirigami.Theme.textColor
                    opacity: 0.4
                    Layout.alignment: Qt.AlignVCenter
                }

                // Icon
                Kirigami.Icon {
                    visible: root.useIcons
                    source: modelData.icon
                    isMask: true
                    Layout.preferredWidth: root.iconSize
                    Layout.preferredHeight: root.iconSize
                    Layout.alignment: Qt.AlignVCenter
                }

                // Text label
                PlasmaComponents.Label {
                    visible: root.useText
                    text: modelData.label
                    font.pixelSize: root.effectiveFontSize
                    font.family: root.fontFamily
                    color: Kirigami.Theme.textColor
                    Layout.alignment: Qt.AlignVCenter
                }

                // Value
                PlasmaComponents.Label {
                    text: modelData.value
                    font.pixelSize: root.effectiveFontSize
                    font.family: root.fontFamily
                    color: Kirigami.Theme.textColor
                    Layout.alignment: Qt.AlignVCenter
                }
            }
        }
    }

    fullRepresentation: ColumnLayout {
        spacing: Kirigami.Units.smallSpacing
        Layout.preferredWidth: Kirigami.Units.gridUnit * 18
        Layout.preferredHeight: Kirigami.Units.gridUnit * 12

        PlasmaComponents.Label {
            text: "KVitals"
            font.bold: true
            font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.2
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: Kirigami.Units.smallSpacing
        }

        Repeater {
            model: {
                var items = [];
                if (root.showCpu) items.push({ label: "CPU Usage", value: root.cpuValue });
                if (root.showRam) items.push({ label: "Memory", value: root.ramValue });
                if (root.showTemp) items.push({ label: "CPU Temp", value: root.tempValue });
                if (root.showBattery && root.batValue) items.push({ label: "Battery", value: root.batValue });
                if (root.showPower && root.powerValue) items.push({ label: "Power", value: root.powerValue });
                if (root.showNetwork) {
                    items.push({ label: "Network ↓", value: root.netDownValue });
                    items.push({ label: "Network ↑", value: root.netUpValue });
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

    toolTipMainText: "KVitals"
    toolTipSubText: {
        var parts = [];
        if (root.showCpu && root.cpuValue) parts.push("CPU: " + root.cpuValue);
        if (root.showRam && root.ramValue) parts.push("RAM: " + root.ramValue);
        if (root.showTemp && root.tempValue) parts.push("TEMP: " + root.tempValue);
        if (root.showBattery && root.batValue) parts.push("BAT: " + root.batValue);
        if (root.showPower && root.powerValue) parts.push("PWR: " + root.powerValue);
        if (root.showNetwork) parts.push("NET: ↓" + root.netDownValue + " ↑" + root.netUpValue);
        return parts.join("\n");
    }
}
