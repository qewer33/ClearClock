/*
    SPDX-FileCopyrightText: 2022 qewer33
    SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick 2.4
import QtQuick.Controls 2.12 as QtControls
import QtQuick.Layouts 1.12 as QtLayouts
import QtQuick.Dialogs

QtControls.Button {
    id: clockFontColorButton
    implicitWidth: 50

    property color value

    Rectangle {
        id: rect
        anchors.fill: parent
        anchors.margins: 5
        radius: 3
        color: value
        opacity: enabled ? 1 : 0.4
    }

    MouseArea {
        anchors.fill: parent
        onClicked: dialog.open()
    }

    ColorDialog {
        id: dialog
        title: "Select Background Color"
        selectedColor: value
        options: {
            ShowAlphaChannel: true
        }
        onAccepted: {
            value = selectedColor
        }
    }
}
