import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root

    width: 400
    height: 300

    title: "Hello World"

	ListModel {
		id: kountdownModel

		ListElement {
			name: "Dog Birthday!"
			description: "Bug doggo birthday blowout."
			date: 100
		}
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

	Component {
		id: kountdownDelegate
		Kirigami.AbstractCard {
			contentItem: Item {
				implicitWidth: delegateLayout.implicitWidth
				implicitHeight: delegateLayout.implicitHeight

				GridLayout {
					id: delegateLayout
					anchors {
						left: parent.left
						top: parent.top
						right: parent.right
					}

					rowSpacing: Kirigami.Units.largeSpacing
					columnSpacing: Kirigami.Units.largeSpacing
					columns: root.wideScreen ? 4 : 2

					Kirigami.Heading {
						level: 1
						text: date
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
						Controls.Button {
							Layout.alignment: Qt.AlignRight
							Layout.columnSpan: 2
							text: "Edit"
							// onClicked: todo!
						}
					}
				}
			}
		}
	}

    pageStack.initialPage: Kirigami.ScrollablePage {
		actions: [
			Kirigami.Action {
				id: addAction
				icon.name: "list-add-symbolic"
				text: "Add kountdown"
				onTriggered: kountdownModel.append({
					name: "Kirigami Action added a card!",
					description: "Congratulations, your Kirigami Action works!",
					date: 1000
				})
			}
		]

		Kirigami.CardsListView {
			id: cardsView
			model: kountdownModel
			delegate: kountdownDelegate
		}
    }
}
