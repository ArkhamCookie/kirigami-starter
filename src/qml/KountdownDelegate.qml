import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.AbstractCard {

    contentItem: Item {
        implicitWidth: delegateLayout.implicitWidth
        implicitHeight: delegateLayout.implicitHeight

        GridLayout {
            id: delegateLayout

            rowSpacing: Kirigami.Units.largeSpacing
            columnSpacing: Kirigami.Units.largeSpacing
            columns: root.wideScreen ? 4 : 2

            anchors {
                left: parent.left
                top: parent.top
                right: parent.right
            }

            Kirigami.Heading {
                level: 1
                text: "%1 days", Math.round((date - Date.now()) / 8.64e+07)
            }

            ColumnLayout {
                Kirigami.Heading {
                    Layout.fillWidth: true
                    level: 2
                    text: name
                }

                Kirigami.Separator {
                    Layout.fillWidth: true
                    visible: description.length > 0
                }

                Controls.Label {
                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap
                    text: description
                    visible: description.length > 0
                }

            }

            Controls.Button {
                Layout.alignment: Qt.AlignRight
                Layout.columnSpan: 2
                text: "Edit"
            }

        }

    }

}
