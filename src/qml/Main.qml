import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root

    width: 400
    height: 300

    title: "Hello World"

    pageStack.initialPage: Kirigami.Page {
        Controls.Label {
            anchors.centerIn: parent
            text: "Hello World!"
        }
    }
}
