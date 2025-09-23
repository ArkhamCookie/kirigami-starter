import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.ac.starter

Kirigami.ApplicationWindow {
    id: root

    width: 600
    height: 400
    title: "Day Kountdown"

    ListModel {
        id: kountdownModel
    }

    AddDialog {
        id: addDialog
    }

    globalDrawer: Kirigami.GlobalDrawer {
        isMenu: true
        actions: [
            Kirigami.Action {
                text: "Quit"
                icon.name: "application-exit-symbolic"
                shortcut: StandardKey.Quit
                onTriggered: Qt.quit()
            }
        ]
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: "Kountdown"
        actions: [
            Kirigami.Action {
                id: addAction

                icon.name: "list-add-symbolic"
                text: "Add kountdown"
                onTriggered: addDialog.open()
            }
        ]

        Kirigami.CardsListView {
            id: cardsView

            model: kountdownModel

            delegate: KountdownDelegate {
            }

        }

    }

}
