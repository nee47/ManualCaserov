import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Page{
    width: 960
    height: 700

    Connections{
            target: backend
    }

    Rectangle {
        id: rectangle
        color: "#29272a"
        anchors.fill: parent

        RowLayout{
            id: columnLayout
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 150
            anchors.rightMargin: 150
            anchors.topMargin: 10

            function loadSections(){
                if(searchTextField.text === "") return
                loader.source = ""
                loader.source = "Result.qml"
                backend.getSections(searchTextField.text)
            }

            TextField {
                id: searchTextField
                color: "white"
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                placeholderText: qsTr("Buscar")
                selectByMouse: true
                onAccepted: {
                    parent.loadSections()
                }

            }

            Button {
                id: searchButton
                text: qsTr("Buscar")
                Layout.preferredHeight: 40
                Layout.preferredWidth: 95

                onClicked: parent.loadSections()
            }
        }

        Loader{
            id: loader
            anchors.top: columnLayout.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }

    }
}
