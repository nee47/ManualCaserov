import QtQuick
import QtQuick.Controls


Page {
    width: 960
    height: 700
    Rectangle{
        id: addRectangle
        color: "#29272a"
        anchors.fill: parent

        Dialog{
            anchors.centerIn: parent
            id: errorDialog
            width: 400
            height: 100
            modal: Qt.WindowModal
            title: "Error de campos"
            standardButtons: Dialog.Ok
            Text{
                id:tfield
                anchors.centerIn: parent
                text: qsTr("Los 2 primeros campos no pueden ser vacios")
                width: 300
                height: 30
            }
        }

        Column{
            id: inputsContainer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            spacing: 10
            anchors.rightMargin: 150
            anchors.leftMargin: 150
            anchors.topMargin: 30
            function cleanFields(){
                addNameTF.text = ""
                addSectionTF.text = ""
                addSectionTF.enabled = false
                addDescriptionTF.text = ""
                addDescriptionTF.enabled = false
            }

            TextField{
                id: addNameTF
                height: 35
                width:  parent.width
                placeholderText: qsTr("Ingresar titulo")
                selectByMouse: true
                background: Rectangle {
                    radius: 4
                }
                validator: RegularExpressionValidator{
                    regularExpression: {/(\w+[\s|\S])+/g}
                }
                onTextChanged: (text === "") ? addSectionTF.enabled = false : addSectionTF.enabled = true;
            }

            TextField{
                id: addSectionTF
                height: 35
                width:  parent.width
                enabled: false
                placeholderText: qsTr("Ingresar seccion")
                selectByMouse: true
                background: Rectangle {
                    radius: 4
                }
                validator: RegularExpressionValidator{
                    regularExpression: {/(\w+[\s|\S])+/g}
                }
                onTextChanged: (text === "") ? addDescriptionTF.enabled = false : addDescriptionTF.enabled = true;
            }

            Text {
                id: contentText
                text: qsTr("Ingresa el contenido")
                color: "orange"
            }
            TextArea{
                id: addDescriptionTF
                height: parent.height / 2
                width:  parent.width
                selectByMouse: true
                background: Rectangle { radius: 2 }
                enabled: false
                wrapMode: "Wrap"
            }

            Button{
                id:saveDataButton
                height: 50
                width: 100
                text: qsTr("Guardar")
                background: Rectangle { radius: 2 }
                onClicked: {
                    if(addNameTF.text !== "" & addSectionTF.text !== ""){
                        backend.insertNewItems([addNameTF.text, addSectionTF.text, addDescriptionTF.text])
                        inputsContainer.cleanFields()
                    }
                    else errorDialog.open()
                }
            }
        }
    }
}


