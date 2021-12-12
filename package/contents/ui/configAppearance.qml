/*
 *
 */

import QtQuick 2.12
import QtQuick.Controls 2.12 as QtControls
import QtQuick.Layouts 1.15 as QtLayouts
import QtQuick.Dialogs 1.2

import org.kde.kirigami 2.3 as Kirigami

Item {
    id: appearancePage
    width: childrenRect.width
    height: childrenRect.height

    signal configurationChanged

    property alias cfg_clockUse24hFormat: use24hFormat.checkState
    property string cfg_clockFontColor: clockFontColorRect.color
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
                         "text": i18nc("Use default font", "Default"),
                         "value": ""
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
            }

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
                    onAccepted: {
                        cfg_clockFontColor = clockFontColorDialog.color
                    }
                }

                QtControls.ComboBox {
                    id: clockFontFamilyComboBox
                    QtLayouts.Layout.fillWidth: true
                    // ComboBox's sizing is just utterly broken
                    QtLayouts.Layout.minimumWidth: units.gridUnit * 10
                    model: fontsModel
                    // doesn't autodeduce from model because we manually populate it
                    textRole: "text"

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

                QtControls.Button {
                    id: dayFontColorButton
                    text: i18n("  ")
                    Rectangle {
                        id: dayFontColorRect
                        anchors.fill: parent
                        border.color: "darkgray"
                        border.width: 1
                        radius: 4
                        color: cfg_dayFontColor
                        opacity: if (enabled) 1
                                 else 0.4
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: dayFontColorDialog.open()
                    }
                }

                ColorDialog {
                    id: dayFontColorDialog
                    title: "Select Background Color"
                    currentColor: cfg_dayFontColor
                    onAccepted: {
                        cfg_dayFontColor = dayFontColorDialog.color
                    }
                }

                QtControls.ComboBox {
                    id: dayFontFamilyComboBox
                    QtLayouts.Layout.fillWidth: true
                    // ComboBox's sizing is just utterly broken
                    QtLayouts.Layout.minimumWidth: units.gridUnit * 10
                    model: fontsModel
                    // doesn't autodeduce from model because we manually populate it
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
                    // ToolTip.text: i18n("Bold text")
                    icon.name: "format-text-bold"
                    checkable: true
                    // Accessible.name: ToolTip.text
                }

                QtControls.Button {
                    id: dayItalicCheckBox
                    // ToolTip.text: i18n("Italic text")
                    icon.name: "format-text-italic"
                    checkable: true
                    // Accessible.name: ToolTip.text
                }

                QtControls.SpinBox {
                    id: dayFontSizeSpinBox

                    from: 10
                    to: 350
                }

                QtControls.Label {
                    text: "px"
                    opacity: if (enabled) 1
                             else 0.4
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
                        // ToolTip.text: i18n("Time format documentation")
                        icon.name: "exifinfo"
                        // Accessible.name: ToolTip.text
                        onClicked: Qt.openUrlExternally(link)
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

                QtControls.Button {
                    id: dateFontColorButton
                    text: i18n("  ")
                    Rectangle {
                        id: dateFontColorRect
                        anchors.fill: parent
                        border.color: "darkgray"
                        border.width: 1
                        radius: 4
                        color: cfg_dateFontColor
                        opacity: if (enabled) 1
                                 else 0.4
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: dateFontColorDialog.open()
                    }
                }

                ColorDialog {
                    id: dateFontColorDialog
                    title: "Select Background Color"
                    currentColor: cfg_dateFontColor
                    onAccepted: {
                        cfg_dateFontColor = dateFontColorDialog.color
                    }
                }

                QtControls.ComboBox {
                    id: dateFontFamilyComboBox
                    QtLayouts.Layout.fillWidth: true
                    // ComboBox's sizing is just utterly broken
                    QtLayouts.Layout.minimumWidth: units.gridUnit * 10
                    model: fontsModel
                    // doesn't autodeduce from model because we manually populate it
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
                    // ToolTip.text: i18n("Bold text")
                    icon.name: "format-text-bold"
                    checkable: true
                    // Accessible.name: ToolTip.text
                }

                QtControls.Button {
                    id: dateItalicCheckBox
                    // ToolTip.text: i18n("Italic text")
                    icon.name: "format-text-italic"
                    checkable: true
                    // Accessible.name: ToolTip.text
                }

                QtControls.SpinBox {
                    id: dateFontSizeSpinBox

                    from: 10
                    to: 350
                }

                QtControls.Label {
                    text: "px"
                    opacity: if (enabled) 1
                             else 0.4
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

