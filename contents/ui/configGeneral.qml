import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.5 as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    id: configPage

    property alias cfg_updateInterval: intervalSlider.value
    property alias cfg_iconSize: iconSizeSlider.value
    property alias cfg_fontSize: fontSizeSlider.value
    property alias cfg_compactSpacing: spacingSlider.value
    property string cfg_displayMode: "text"
    property string cfg_fontFamily: "monospace"
    property string cfg_compactLayout: "row"
    property bool cfg_iconsMask: true
    property bool cfg_iconMonochrome: false

    readonly property var displayModes: ["text", "icons", "icons+text"]
    readonly property var displayModeLabels: [i18n("Text"), i18n("Icons"), i18n("Icons + Text")]
    readonly property bool iconsEnabled: cfg_displayMode !== "text"
    
    readonly property var layoutOptions: ["row", "column"]
    readonly property var layoutLabels: [i18n("Row"), i18n("Column")]

    Kirigami.FormLayout {

        ComboBox {
            id: displayModeCombo
            Kirigami.FormData.label: i18n("Display mode:")
            model: configPage.displayModeLabels
            currentIndex: {
                var idx = configPage.displayModes.indexOf(cfg_displayMode);
                return idx >= 0 ? idx : 0;
            }
            onActivated: {
                cfg_displayMode = configPage.displayModes[currentIndex];
            }
        }

        Slider {
            id: iconSizeSlider
            Kirigami.FormData.label: i18n("Icon size:")
            from: 8
            to: 24
            stepSize: 2
            value: 12
            visible: configPage.iconsEnabled
        }

        Label {
            text: iconSizeSlider.value + " px"
            opacity: 0.7
            visible: configPage.iconsEnabled
        }

        ComboBox {
            id: fontFamilyCombo
            Kirigami.FormData.label: i18n("Font:")
            model: Qt.fontFamilies()
            editable: true
            currentIndex: {
                var families = Qt.fontFamilies();
                var idx = families.indexOf(cfg_fontFamily);
                return idx >= 0 ? idx : 0;
            }
            onActivated: {
                cfg_fontFamily = currentText;
            }
            onAccepted: {
                cfg_fontFamily = editText;
            }
            popup.height: 300
        }

        Slider {
            id: fontSizeSlider
            Kirigami.FormData.label: i18n("Font size:")
            from: 0
            to: 24
            stepSize: 1
            value: 0
        }

        Label {
            text: fontSizeSlider.value === 0 ? i18n("System default") : fontSizeSlider.value + " px"
            opacity: 0.7
        }

        Slider {
            id: intervalSlider
            Kirigami.FormData.label: i18n("Update interval:")
            from: 1000
            to: 10000
            stepSize: 500
            value: 2000
        }

        Label {
            text: (intervalSlider.value / 1000).toFixed(1) + " " + i18n("seconds")
            opacity: 0.7
        }

        ColumnLayout {
            Kirigami.FormData.label: i18n("Compact layout:")
            spacing: Kirigami.Units.smallSpacing

            RadioButton {
                text: i18n("Row")
                checked: cfg_compactLayout === "row"
                onClicked: {
                    cfg_compactLayout = "row";
                }
            }

            RadioButton {
                text: i18n("Column")
                checked: cfg_compactLayout === "column"
                onClicked: {
                    cfg_compactLayout = "column";
                }
            }
        }

        Slider {
            id: spacingSlider
            Kirigami.FormData.label: i18n("Compact spacing:")
            from: 0
            to: 10
            stepSize: 1
            value: 1
        }

        Label {
            text: spacingSlider.value + " " + i18n("units")
            opacity: 0.7
        }

        CheckBox {
            id: iconsMaskCheckbox
            Kirigami.FormData.label: i18n("Icons:")
            text: i18n("Use transparent mask (rounded icons)")
            checked: cfg_iconsMask
            onToggled: {
                cfg_iconsMask = checked;
            }
        }

        CheckBox {
            id: monochromeCheckbox
            Kirigami.FormData.label: i18n("Icons style:")
            text: i18n("Monochrome icons")
            checked: cfg_iconMonochrome
            onToggled: {
                cfg_iconMonochrome = checked;
            }
        }
    }
}
