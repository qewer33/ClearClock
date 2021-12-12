/*
    SPDX-FileCopyrightText: 2021 qewer33
    SPDX-License-Identifier: LGPL-2.1-or-later
*/

import QtQuick 2.12
import QtQuick.Layouts 1.12

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Item {
    id: root

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.ConfigurableBackground

    readonly property date currentDateTime: dataSource.data.Local ? dataSource.data.Local.DateTime : new Date()

    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 60000
        intervalAlignment: PlasmaCore.Types.AlignToMinute
    }

    FontLoader {
        id: fontOutfitBold
        source: "../fonts/Outfit-Bold.ttf"
    }

    FontLoader {
        id: fontOutfitRegular
        source: "../fonts/Outfit-Regular.ttf"
    }

    FontLoader {
        id: fontSmooch
        source: "../fonts/Smooch-Regular.ttf"
    }

    function max(a, b) {
        if (a > b)
            return a
        else
            return b
    }

    Plasmoid.fullRepresentation: ColumnLayout {
        anchors.fill: parent
        spacing: -20

        TextMetrics {
            id: textMetricsTimeLabel
            font.family: timeLabel.font.family
            font.pixelSize: timeLabel.font.pixelSize
            font.bold: timeLabel.font.bold
            text: " 99:99 "
        }

        TextMetrics {
            id: textMetricsDayLabel
            font.family: dayLabel.font.family
            font.pixelSize: dayLabel.font.pixelSize
            text: " Wednesday "
        }

        Item {
            width: max(textMetricsTimeLabel.width, textMetricsDayLabel.width)
            height: max(textMetricsTimeLabel.height, textMetricsDayLabel.height)
            Layout.alignment: Qt.AlignCenter

            PlasmaComponents.Label {
                id: timeLabel
                anchors.centerIn: parent

                text: Qt.formatTime(currentDateTime).replace(":", ".")

                color: plasmoid.configuration.clockFontColor
                font.family: if (plasmoid.configuration.clockFontFamily === "") fontOutfitBold.name
                             else plasmoid.configuration.clockFontFamily
                font.bold: plasmoid.configuration.clockBoldText
                font.italic: plasmoid.configuration.clockItalicText
                font.pixelSize: plasmoid.configuration.clockFontSize
            }

            PlasmaComponents.Label {
                id: dayLabel
                visible: plasmoid.configuration.showDayDisplay
                anchors.centerIn: parent

                text: Qt.formatDate(currentDateTime, "dddd")

                color: plasmoid.configuration.dayFontColor
                font.family: if (plasmoid.configuration.dayFontFamily === "") fontSmooch.name
                             else plasmoid.configuration.dayFontFamily
                font.bold: plasmoid.configuration.daykBoldText
                font.italic: plasmoid.configuration.dayItalicText
                font.pixelSize: plasmoid.configuration.dayFontSize
            }
        }

        PlasmaComponents.Label {
            id: dateLabel
            visible: plasmoid.configuration.showDateDisplay
            Layout.alignment: Qt.AlignCenter

            text: Qt.formatDate(currentDateTime, plasmoid.configuration.customDateFormat)

            color: plasmoid.configuration.dateFontColor
            font.family: if (plasmoid.configuration.dateFontFamily === "") fontOutfitRegular.name
                         else plasmoid.configuration.dateFontFamily
            font.bold: plasmoid.configuration.dateBoldText
            font.italic: plasmoid.configuration.dateItalicText
            font.pixelSize: plasmoid.configuration.dateFontSize
            font.capitalization: Font.AllUppercase
            font.letterSpacing: plasmoid.configuration.dateLetterSpacing
        }
    }
}
