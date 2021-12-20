import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import ".."

Button {
	id: configColor

	property alias horizontalAlignment: label.horizontalAlignment

	property string configKey: ''
	property string configValue: configKey ? plasmoid.configuration[configKey] : ""
	property string defaultColor: ''
	readonly property color value: configValue || defaultColor

	onConfigValueChanged: {
		if (configKey) {
			plasmoid.configuration[configKey] = configValue
		}
	}

    onClicked: dialog.open()

    Rectangle {
        anchors.fill: parent
        color: configColor.value
        border.width: 2
        border.color: parent.containsMouse ? theme.highlightColor : "#BB000000"
    }

	ColorDialog {
		id: dialog
		visible: false
		modality: Qt.WindowModal
		title: configColor.label
		showAlphaChannel: true
		color: configColor.value

		onCurrentColorChanged: {
			if (visible && color != currentColor) {
				configColor.configValue = currentColor
			}
		}
	}
}
