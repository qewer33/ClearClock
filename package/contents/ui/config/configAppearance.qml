/*
    SPDX-FileCopyrightText: 2022 qewer33
    SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick 2.12
import QtQuick.Controls 2.12 as QtControls
import QtQuick.Layouts 1.12 as QtLayouts
import QtQuick.Dialogs

import org.kde.kirigami 2.3 as Kirigami
import org.kde.kcmutils as KCM

import "../lib"

KCM.SimpleKCM {
    id: appearancePage
    width: childrenRect.width
    height: childrenRect.height

    signal configurationChanged

    property alias cfg_clockUse24hFormat: use24hFormat.checkState
    property alias cfg_clockShowSeconds: showSeconds.checkState
    property alias cfg_clockSeparator: clockSeparatorTextField.text
    property string cfg_clockFontColor
    property string cfg_clockFontFamily
    property bool cfg_clockBoldText
    property bool cfg_clockItalicText
    property int cfg_clockFontSize
    property alias cfg_clockShadowEnabled: clockShadowCheckBox.checked
    property color cfg_clockShadowColor
    property int cfg_clockShadowRadius
    property int cfg_clockShadowXOffset
    property int cfg_clockShadowYOffset

    property alias cfg_showDayDisplay: showDayDisplayCheckBox.checked
    property string cfg_dayFontColor
    property string cfg_dayFontFamily
    property bool cfg_dayBoldText
    property bool cfg_dayItalicText
    property int cfg_dayFontSize
    property alias cfg_dayShadowEnabled: dayShadowCheckBox.checked
    property color cfg_dayShadowColor
    property int cfg_dayShadowRadius
    property int cfg_dayShadowXOffset
    property int cfg_dayShadowYOffset

    property alias cfg_showDateDisplay: showDateDisplayCheckBox.checked
    property alias cfg_dateCustomDateFormat: customDateFormat.text
    property string cfg_dateFontColor
    property string cfg_dateFontFamily
    property bool cfg_dateBoldText
    property bool cfg_dateItalicText
    property int cfg_dateFontSize
    property alias cfg_dateShadowEnabled: dateShadowCheckBox.checked
    property color cfg_dateShadowColor
    property int cfg_dateShadowRadius
    property int cfg_dateShadowXOffset
    property int cfg_dateShadowYOffset

    ListModel {
        id: fontsModel
        Component.onCompleted: {
            var arr = [] // use temp array to avoid constant binding stuff
            arr.push({
                         "text": "ClearClock Default",
                         "value": "ccdefault"
                     })

            var fonts = Qt.fontFamilies()
            var foundIndex = 0
            for (var i = 0, j = fonts.length; i < j; ++i) {
                arr.push({
                             "text": fonts[i],
                             "value": fonts[i]
                         })
            }
            append(arr)
        }
    }

    Kirigami.FormLayout {
        id: layout
        anchors.fill: parent


        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Clock Display Settings"
        }

        QtControls.CheckBox {
            Kirigami.FormData.label: "Use 24-hour clock"
            id: use24hFormat
            tristate: false
            checked: cfg_clockUse24hFormat
        }

        QtControls.CheckBox {
            Kirigami.FormData.label: "Show seconds"
            id: showSeconds
            tristate: false
            checked: cfg_clockShowSeconds
        }

        QtControls.TextField {
            Kirigami.FormData.label: "Separator"
            id: clockSeparatorTextField
            maximumLength: 1
        }

        ColorButton {
            Kirigami.FormData.label: "Color"

            onValueChanged: {
                cfg_clockFontColor = value
            }
        }

        FontConfig {
            Kirigami.FormData.label: "Font"
            fontModel: fontsModel

            fontValue: cfg_clockFontFamily
            onFontValueChanged: {
                cfg_clockFontFamily = fontValue
            }

            boldValue: cfg_clockBoldText
            onBoldValueChanged: {
                cfg_clockBoldText = boldValue
            }

            italicValue: cfg_clockItalicText
            onItalicValueChanged: {
                cfg_clockItalicText = italicValue
            }

            pxSizeValue: cfg_clockFontSize
            onPxSizeValueChanged: {
                cfg_clockFontSize = pxSizeValue
            }
        }

        QtControls.CheckBox {
            id: clockShadowCheckBox
            text: i18n("Enable shadow")
            tristate: false
            checked: cfg_clockShadowEnabled
        }

        ShadowConfig {
            Kirigami.FormData.label: "Shadow"
            enabled: clockShadowCheckBox.checked

            colorValue: cfg_clockShadowColor
            onColorValueChanged: {
                cfg_clockShadowColor = colorValue
            }

            radiusValue: cfg_clockShadowRadius
            onRadiusValueChanged: {
                cfg_clockShadowRadius = radiusValue
            }

            offsetXValue: cfg_clockShadowXOffset
            onOffsetXValueChanged: {
                cfg_clockShadowXOffset = offsetXValue
            }

            offsetYValue: cfg_clockShadowYOffset
            onOffsetYValueChanged: {
                cfg_clockShadowYOffset = offsetYValue
            }
        }


        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Day Display Settings"
        }

        QtControls.CheckBox {
            Kirigami.FormData.label: "Show day display"
            id: showDayDisplayCheckBox
        }

        ColorButton {
            Kirigami.FormData.label: "Color"

            onValueChanged: {
                cfg_dayFontColor = value
            }
        }

        FontConfig {
            Kirigami.FormData.label: "Font"
            fontModel: fontsModel
            enabled: showDayDisplayCheckBox.checked

            fontValue: cfg_dayFontFamily
            onFontValueChanged: {
                cfg_dayFontFamily = fontValue
            }

            boldValue: cfg_dayBoldText
            onBoldValueChanged: {
                cfg_dayBoldText = boldValue
            }

            italicValue: cfg_dayItalicText
            onItalicValueChanged: {
                cfg_dayItalicText = italicValue
            }

            pxSizeValue: cfg_dayFontSize
            onPxSizeValueChanged: {
                cfg_dayFontSize = pxSizeValue
            }
        }

        QtControls.CheckBox {
            id: dayShadowCheckBox
            text: i18n("Enable shadow")
            tristate: false
            checked: cfg_dayShadowEnabled
        }

        ShadowConfig {
            Kirigami.FormData.label: "Shadow"
            enabled: dayShadowCheckBox.checked

            colorValue: cfg_dayShadowColor
            onColorValueChanged: {
                cfg_dayShadowColor = colorValue
            }

            radiusValue: cfg_dayShadowRadius
            onRadiusValueChanged: {
                cfg_dayShadowRadius = radiusValue
            }

            offsetXValue: cfg_dayShadowXOffset
            onOffsetXValueChanged: {
                cfg_dayShadowXOffset = offsetXValue
            }

            offsetYValue: cfg_clockShadowYOffset
            onOffsetYValueChanged: {
                cfg_dayShadowYOffset = offsetYValue
            }
        }


        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Date Display Settings"
        }

        QtControls.CheckBox {
            Kirigami.FormData.label: "Show date display"
            id: showDateDisplayCheckBox
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: "Date format"
            enabled: showDateDisplayCheckBox.checked

            QtControls.TextField {
                id: customDateFormat
                QtLayouts.Layout.fillWidth: true
            }

            QtControls.Button {
                icon.name: "exifinfo"
                onClicked: Qt.openUrlExternally("https://doc.qt.io/qt-5/qml-qtqml-qt.html#formatDateTime-method")
            }
        }

        ColorButton {
            Kirigami.FormData.label: "Color"

            onValueChanged: {
                cfg_dateFontColor = value
            }
        }

        FontConfig {
            Kirigami.FormData.label: "Font"
            fontModel: fontsModel
            enabled: showDateDisplayCheckBox.checked

            fontValue: cfg_dateFontFamily
            onFontValueChanged: {
                cfg_dateFontFamily = fontValue
            }

            boldValue: cfg_dateBoldText
            onBoldValueChanged: {
                cfg_dateBoldText = boldValue
            }

            italicValue: cfg_dateItalicText
            onItalicValueChanged: {
                cfg_dateItalicText = italicValue
            }

            pxSizeValue: cfg_dateFontSize
            onPxSizeValueChanged: {
                cfg_dateFontSize = pxSizeValue
            }
        }

        QtControls.CheckBox {
            id: dateShadowCheckBox
            text: i18n("Enable shadow")
            tristate: false
            checked: cfg_dateShadowEnabled
        }

        ShadowConfig {
            Kirigami.FormData.label: "Shadow"
            enabled: dateShadowCheckBox.checked

            colorValue: cfg_dateShadowColor
            onColorValueChanged: {
                cfg_dateShadowColor = colorValue
            }

            radiusValue: cfg_dateShadowRadius
            onRadiusValueChanged: {
                cfg_dateShadowRadius = radiusValue
            }

            offsetXValue: cfg_dateShadowXOffset
            onOffsetXValueChanged: {
                cfg_dateShadowXOffset = offsetXValue
            }

            offsetYValue: cfg_dateShadowYOffset
            onOffsetYValueChanged: {
                cfg_dateShadowYOffset = offsetYValue
            }
        }
    }
}

