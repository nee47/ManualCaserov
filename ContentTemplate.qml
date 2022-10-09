import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle{
    id: templateItem
    property string txt
    Layout.preferredWidth: contentWindow.width *0.95
    Layout.fillHeight: true
    Layout.preferredHeight: 60
    property var btmargin
    Layout.bottomMargin: btmargin
    color: "transparent"

    TextArea {
        id: txtid
        text: txt
        wrapMode: "Wrap"
        readOnly: true
        selectByMouse: true
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

        Button{
            id: editButton
            height: 15
            width: 45
            text: qsTr("editar")
            flat: true
            property string bgColor: "Transparent"
            background: Rectangle{
                color: editButton.bgColor
                border.color: "#000000"
                radius: 1
            }

            onClicked: {
                if(txtid.readOnly){
                    bgColor = "#18A558"
                    txtid.readOnly = false
                    text = qsTr("ok")
                }
                else{
                    bgColor = "Transparent"
                    txtid.readOnly = true
                    text = qsTr("editar")
                }
            }

            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }
    }



}
