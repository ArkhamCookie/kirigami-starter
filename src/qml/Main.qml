import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.ac.tutorial.components

Kirigami.ApplicationWindow {
    id: root

    width: 600
    height: 400
    title: i18nc("@title:window", "Day Kountdown")

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
                text: i18n("Quit")
                icon.name: "application-exit-symbolic"
                shortcut: StandardKey.Quit
                onTriggered: Qt.quit()
            }
        ]
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: i18nc("@title", "Kountdown")
        actions: [
            Kirigami.Action {
                id: addAction

                icon.name: "list-add-symbolic"
                text: i18nc("@action:button", "Add kountdown")
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
