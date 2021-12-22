import QtQuick 2.4
import QtQuick.Controls 2.12 as QtControls
import QtQuick.Layouts 1.15 as QtLayouts
import QtQuick.Dialogs 1.2


QtLayouts.RowLayout {

    QtControls.Label {
        text: i18n("Font style:")
    }

    QtControls.Button {
        id: clockFontColorButton
        text: i18n("  ")
        Rectangle {
            id: clockFontColorRect
            anchors.fill: parent
            border.color: "darkgray"
            border.width: 1
            radius: 4
            color: cfg_clockFontColor
            opacity: if (enabled) 1
                     else 0.4
        }
        MouseArea {
            anchors.fill: parent
            onClicked: clockFontColorDialog.open()
        }
    }

    ColorDialog {
        id: clockFontColorDialog
        title: "Select Background Color"
        currentColor: cfg_clockFontColor
        showAlphaChannel: true
        onAccepted: {
            cfg_clockFontColor = clockFontColorDialog.color
        }
    }

    QtControls.ComboBox {
        id: clockFontFamilyComboBox
        QtLayouts.Layout.fillWidth: true
        QtLayouts.Layout.minimumWidth: units.gridUnit * 10
        model: fontsModel
        textRole: "text"

        function loadComboBoxValue() {
            if (cgf_clockFontFamily === "ccdefault") {
                return 0
            } else {
                for (i = 0; i < fontsModel.count; i++) {
                    if (cgf_clockFontFamily === fontsModel.get(i).value) {
                        return i + 1
                    }
                }
            }
        }

        currentIndex: loadComboBoxValue()

        onCurrentIndexChanged: {
            var current = model.get(currentIndex)
            if (current) {
                cfg_clockFontFamily = current.value
                appearancePage.configurationChanged()
            }
        }
    }

    QtControls.Button {
        id: clockBoldCheckBox
        // ToolTip.text: i18n("Bold text")
        icon.name: "format-text-bold"
        checkable: true
        // Accessible.name: ToolTip.text
    }

    QtControls.Button {
        id: clockItalicCheckBox
        // ToolTip.text: i18n("Italic text")
        icon.name: "format-text-italic"
        checkable: true
        // Accessible.name: ToolTip.text
    }

    QtControls.SpinBox {
        id: clockFontSizeSpinBox

        from: 10
        to: 350
    }

    QtControls.Label {
        text: "px"
    }
}
}
