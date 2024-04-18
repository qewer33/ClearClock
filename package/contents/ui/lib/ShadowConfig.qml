/*
    SPDX-FileCopyrightText: 2022 qewer33
    SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick 2.4
import QtQuick.Controls 2.12 as QtControls
import QtQuick.Layouts 1.12 as QtLayouts
import QtQuick.Dialogs

import "."

QtLayouts.RowLayout {

    property color colorValue
    property int radiusValue
    property int offsetXValue
    property int offsetYValue


    ColorButton {
        id: shadowColorButton
        value: colorValue

        onValueChanged: {
            colorValue = value
        }
    }

    QtControls.Label {
        text: i18n("Radius")
        opacity: enabled ? 1 : 0.4
    }

    QtControls.SpinBox {
        id: radiusSpinBox
        from: 0
        to: 50
        value: radiusValue

        onValueChanged: {
            radiusValue = value
        }
    }

    QtControls.Label {
        text: i18n("Offset")
        opacity: enabled ? 1 : 0.4
    }

    QtControls.SpinBox {
        id: offsetXSpinBox
        from: 0
        to: 100
        value: offsetXValue

        onValueChanged: {
            offsetXValue = value
        }
    }

    QtControls.SpinBox {
        id: offsetYSpinBox
        from: 0
        to: 100
        value: offsetYValue

        onValueChanged: {
            offsetYValue = value
        }
    }

}
