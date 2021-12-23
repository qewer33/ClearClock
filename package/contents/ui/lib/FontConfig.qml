import QtQuick 2.4
import QtQuick.Controls 2.12 as QtControls
import QtQuick.Layouts 1.15 as QtLayouts
import QtQuick.Dialogs 1.2

import "ColorButton.qml"

QtLayouts.RowLayout {

    property var fontModel

    property color colorValue
    property string fontValue
    property bool boldValue
    property bool italicValue
    property int pxSizeValue


    QtControls.Label {
        text: i18n("Font style:")
    }

    ColorButton {
        id: dayFontColorButton
        value: colorValue

        onValueChanged: {
            colorValue = value
        }
    }

    QtControls.ComboBox {
        id: clockFontFamilyComboBox
        QtLayouts.Layout.fillWidth: true
        QtLayouts.Layout.minimumWidth: units.gridUnit * 10
        model: fontModel
        textRole: "text"

        onCurrentIndexChanged: {
            var current = model.get(currentIndex)
            if (current) {
                fontValue = current.value
                appearancePage.configurationChanged()
            }
        }
    }

    QtControls.Button {
        id: clockBoldCheckBox
        icon.name: "format-text-bold"
        checkable: true
    }

    QtControls.Button {
        id: clockItalicCheckBox
        icon.name: "format-text-italic"
        checkable: true
    }

    QtControls.SpinBox {
        id: clockFontSizeSpinBox
        textFromValue: function(value, locale) {
                          return qsTr("%1px").arg(value);
                       }
        from: 10
        to: 350
    }

    QtControls.Label {
        text: "px"
    }
}
