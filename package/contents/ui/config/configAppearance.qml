/*
    SPDX-FileCopyrightText: 2021 qewer33
    SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick 2.12
import QtQuick.Controls 2.12 as QtControls
import QtQuick.Layouts 1.15 as QtLayouts
import QtQuick.Dialogs 1.2

import org.kde.kirigami 2.3 as Kirigami

import "../lib"

Item {
    id: appearancePage
    width: childrenRect.width
    height: childrenRect.height

    signal configurationChanged

    property alias cfg_clockUse24hFormat: use24hFormat.checkState
    property string cfg_clockFontColor: clockFontColorButton.value
    property string cfg_clockFontFamily
    property alias cfg_clockBoldText: clockBoldCheckBox.checked
    property alias cfg_clockItalicText: clockItalicCheckBox.checked
    property alias cfg_clockFontSize: clockFontSizeSpinBox.value

    property alias cfg_showDayDisplay: showDayDisplayCheckBox.checked
    property string cfg_dayFontColor: dayFontColorRect.color
    property string cfg_dayFontFamily
    property alias cfg_dayBoldText: dayBoldCheckBox.checked
    property alias cfg_dayItalicText: dayItalicCheckBox.checked
    property alias cfg_dayFontSize: dayFontSizeSpinBox.value

    property alias cfg_showDateDisplay: showDateDisplayCheckBox.checked
    property alias cfg_dateCustomDateFormat: customDateFormat.text
    property string cfg_dateFontColor: dateFontColorRect.color
    property string cfg_dateFontFamily
    property alias cfg_dateBoldText: dateBoldCheckBox.checked
    property alias cfg_dateItalicText: dateItalicCheckBox.checked
    property alias cfg_dateFontSize: dateFontSizeSpinBox.value


    function fixFontFamilyChange(id, comboBox) {
        // HACK by the time we populate our model and/or the ComboBox is finished the value is still undefined
        if (id) {
            for (var i = 0, j = fontsModel.count; i < j; ++i) {
                if (fontsModel.get(i).value === id) {
                    comboBox.currentIndex = i
                    break
                }
            }
        }
    }

    onCfg_clockFontFamilyChanged: {
        fixFontFamilyChange(cfg_clockFontFamily, clockFontFamilyComboBox)
    }

    onCfg_dayFontFamilyChanged: {
        fixFontFamilyChange(cfg_dayFontFamily, dayFontFamilyComboBox)
    }

    onCfg_dateFontFamilyChanged: {
        fixFontFamilyChange(cfg_dateFontFamily, dateFontFamilyComboBox)
    }

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

    QtLayouts.ColumnLayout {
        id: layout
        anchors.fill: parent

        QtLayouts.ColumnLayout {
            QtLayouts.Layout.fillWidth: true
            spacing: 10

            QtControls.Label {
                text: i18n("Clock Display Settings")
                font.bold: true
                font.pixelSize: 17
            }

            QtControls.CheckBox {
                id: use24hFormat
                text: i18n("Use 24-hour clock")
                tristate: false
                checked: cfg_clockUse24hFormat
            }

            QtLayouts.RowLayout {

                QtControls.Label {
                    text: i18n("Font style:")
                }

                ColorButton {
                    id: clockFontColorButton
                    value: cfg_clockFontColor

                    onValueChanged: {
                        cfg_clockFontColor = value
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
            }
        }

        QtLayouts.ColumnLayout {
            QtLayouts.Layout.fillWidth: true
            spacing: 10

            QtControls.Label {
                text: i18n("Day Display Settings")
                font.bold: true
                font.pixelSize: 17
            }

            QtControls.CheckBox {
                id: showDayDisplayCheckBox
                text: i18n("Show day display")
            }

            QtLayouts.RowLayout {
                QtLayouts.Layout.fillWidth: true
                enabled: showDayDisplayCheckBox.checked

                QtControls.Label {
                    text: i18n("Font style:")
                    opacity: if (enabled) 1
                             else 0.4
                }

                ColorButton {
                    id: dayFontColorButton
                    value: cfg_dayFontColor

                    onValueChanged: {
                        cfg_dayFontColor = value
                    }
                }

                QtControls.ComboBox {
                    id: dayFontFamilyComboBox
                    QtLayouts.Layout.fillWidth: true
                    QtLayouts.Layout.minimumWidth: units.gridUnit * 10
                    model: fontsModel
                    textRole: "text"

                    onCurrentIndexChanged: {
                        var current = model.get(currentIndex)
                        if (current) {
                            cfg_dayFontFamily = current.value
                            appearancePage.configurationChanged()
                        }
                    }
                }

                QtControls.Button {
                    id: dayBoldCheckBox
                    icon.name: "format-text-bold"
                    checkable: true
                }

                QtControls.Button {
                    id: dayItalicCheckBox
                    icon.name: "format-text-italic"
                    checkable: true
                }

                QtControls.SpinBox {
                    id: dayFontSizeSpinBox
                    textFromValue: function(value, locale) {
                                      return qsTr("%1px").arg(value);
                                   }
                    from: 10
                    to: 350
                }
            }
        }

        QtLayouts.ColumnLayout {
            QtLayouts.Layout.fillWidth: true
            spacing: 10

            QtControls.Label {
                text: i18n("Date Display Settings")
                font.bold: true
                font.pixelSize: 17
            }

            QtControls.CheckBox {
                id: showDateDisplayCheckBox
                text: i18n("Show date display")
            }

            QtLayouts.RowLayout {
                enabled: showDateDisplayCheckBox.checked

                QtControls.Label {
                    text: i18n("Date format:")
                }

                QtLayouts.RowLayout {
                    QtControls.TextField {
                        id: customDateFormat
                        QtLayouts.Layout.fillWidth: true
                    }

                    QtControls.Button {
                        icon.name: "exifinfo"
                        onClicked: Qt.openUrlExternally("https://doc.qt.io/qt-5/qml-qtqml-qt.html#formatDateTime-method")
                    }
                }
            }

            QtLayouts.RowLayout {
                QtLayouts.Layout.fillWidth: true
                enabled: showDateDisplayCheckBox.checked

                QtControls.Label {
                    text: i18n("Font style:")
                    opacity: if (enabled) 1
                             else 0.4
                }

                ColorButton {
                    id: dateFontColorButton
                    value: cfg_dateFontColor

                    onValueChanged: {
                        cfg_dateFontColor = value
                    }
                }

                QtControls.ComboBox {
                    id: dateFontFamilyComboBox
                    QtLayouts.Layout.fillWidth: true
                    QtLayouts.Layout.minimumWidth: units.gridUnit * 10
                    model: fontsModel
                    textRole: "text"

                    onCurrentIndexChanged: {
                        var current = model.get(currentIndex)
                        if (current) {
                            cfg_dateFontFamily = current.value
                            appearancePage.configurationChanged()
                        }
                    }
                }

                QtControls.Button {
                    id: dateBoldCheckBox
                    icon.name: "format-text-bold"
                    checkable: true
                }

                QtControls.Button {
                    id: dateItalicCheckBox
                    icon.name: "format-text-italic"
                    checkable: true
                }

                QtControls.SpinBox {
                    id: dateFontSizeSpinBox
                    textFromValue: function(value, locale) {
                                      return qsTr("%1px").arg(value);
                                   }
                    from: 10
                    to: 350
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:3}D{i:2}
}
##^##*/

