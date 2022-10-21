import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle{
    id: templateItem
    property string txt
    property int id_content
    Layout.preferredWidth: contentWindow.width *0.95
    Layout.fillHeight: true
    Layout.preferredHeight: 60
    property var btmargin
    property var f
    Layout.bottomMargin: btmargin
    color: "transparent"

    TextArea {
        id: txtid
        text: txt
        wrapMode: "Wrap"
        readOnly: true
        selectByMouse: true
        property string previousTextStatus: txt
        background: Rectangle{
            color: "#ffffff"
            radius: 2
        }
        font.pointSize: 8
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 20
        anchors.rightMargin: 10
        anchors.topMargin: 5
        onImplicitHeightChanged: {templateItem.btmargin = implicitHeight-50}

        function reverseTextArea(){
            text = previousTextStatus
        }

        Button{
            id: editButton
            height: 15
            width: 45
            text: qsTr("editar")
            flat: true
            property string     bgColor: "Transparent"
            background: Rectangle{
                color: editButton.bgColor
                border.color: "#000000"
                radius: 1
            }

            function terminateEdition(){
                bgColor = "Transparent"
                txtid.readOnly = true
                text = qsTr("editar")
            }

            onClicked:{
                if(txtid.readOnly){
                    bgColor = "#18A558"
                    txtid.readOnly = false
                    text = qsTr("ok")
                    cancelButton.activateCancelButton()
                }
                else{
                    terminateEdition()
                    cancelButton.deactivateCancelButton()
                    if(templateItem.f){
                        templateItem.f(txtid.text)
                    }
                    else {// ACA SE HACE EL UPDATE A LA DB
                        backend.updateContent(txtid.text, id_content)
                    }
                }

            }
            anchors.right: cancelButton.left
            anchors.bottom: parent.bottom
        }

        Button{
            id: cancelButton
            height: 15
            width: 0
            visible: false
            text: qsTr("x")
            flat: true
            background: Rectangle{
                color: "#FF1919"
                radius: 1
            }

            function activateCancelButton(){
                width = 45
                visible = true
            }
            function deactivateCancelButton(){
                width = 0
                visible = false
            }

            onClicked:{
                //txtid.readOnly = true
                deactivateCancelButton()
                editButton.terminateEdition()
                txtid.reverseTextArea()
            }
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }
    }
}
