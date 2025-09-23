import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.Dialog {
    id: addDialog

    function requiredFieldsFilled() {
        return (nameField.text !== "" && dateField.acceptableInput);
    }

    function appendDataToModel() {
        kountdownModel.append({
            "name": nameField.text,
            "description": descriptionField.text,
            "date": new Date(dateField.text)
        });
    }

    function clearFieldsAndClose() {
        nameField.text = "";
        descriptionField.text = "";
        dateField.text = "";
        addDialog.close();
    }

    title: "Add kountdown"
    standardButtons: Kirigami.Dialog.Ok | Kirigami.Dialog.Cancel
    padding: Kirigami.Units.largeSpacing
    preferredWidth: Kirigami.Units.gridUnit * 20
    Component.onCompleted: {
        const button = standardButton(Kirigami.Dialog.Ok);
        button.enabled = Qt.binding(() => {
            return requiredFieldsFilled();
        });
    }
    onAccepted: {
        if (!addDialog.requiredFieldsFilled())
            return ;

        appendDataToModel();
        clearFieldsAndClose();
    }

    Kirigami.FormLayout {
        Controls.TextField {
            id: nameField

            Kirigami.FormData.label: "Name*:"
            onAccepted: descriptionField.forceActiveFocus()
        }

        Controls.TextField {
            id: descriptionField

            Kirigami.FormData.label: "Description:"
            onAccepted: dateField.forceActiveFocus()
        }

        Controls.TextField {
            id: dateField

            Kirigami.FormData.label: "ISO Date*:"
            inputMask: "D999-99-99"
            onAccepted: addDialog.accepted()
        }

        Controls.Label {
            text: "* = required fields"
        }

    }

}
