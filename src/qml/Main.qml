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

	Kirigami.Dialog {
		id: addDialog
		title: "Add kountdown"
		standardButtons: Kirigami.Dialog.Ok | Kirigami.Dialog.Cancel
		padding: Kirigami.Units.largeSpacing
		preferredWidth: Kirigami.Units.gridUnit * 20

		Kirigami.FormLayout {
			Controls.TextField {
				id: nameField
				Kirigami.FormData.label: "Name*:"
				onAccepted: descriptionField.forceActiveFocus()
			}
			Controls.TextField {
				id: descriptionField
				Kirigami.FormData.label: "Description:"
				placeholderText: "Optional"
				onAccepted: dataField.forceActiveFocus()
			}
			Controls.TextField {
				id: dataField
				Kirigami.FormData.label: "ISO Date*:"
				inputMask: "D999-99-99"
				onAccepted: addDialog.onAccepted()
			}
			Controls.Label {
				text: "* = required fields"
			}
		}

		Component.onCompleted: {
			const button = standardButton(Kirigami.Dialog.Ok);
			button.enabled = Qt.binding( () => requiredFieldFilled() );
		}

		onAccepted: {
			if (!addDialog.requiredFieldFilled()) return;
			appendDataToModel();
			clearFieldsAndClose();
		}

		function requiredFieldFilled() {
			return (nameField.text !== "" && dataField.acceptableInput);
		}

		function appendDataToModel() {
			kountdownModel.append({
				name: nameField.text,
				description: descriptionField.text,
				date: new Date(dataField.text)
			});
		}

		function clearFieldsAndClose() {
			nameField.text = ""
			descriptionField.text = ""
			dataField.text = ""
			addDialog.close();
		}
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
						text: "%1 days", Math.round((date-Date.now())/86400000)
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
				onTriggered: addDialog.open()
			}
		]

		Kirigami.CardsListView {
			id: cardsView
			model: kountdownModel
			delegate: kountdownDelegate
		}
    }
}
