import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle{
    width: 300
    height: 100
    Connections{
            target: backend
            function onSignalCurrentContent(data){
                wtext.text = data
                return
            }
    }
    Text {
        id: wtext
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Button{
        width: 100
        height: 50
        text:  qsTr("Botonazo")
        anchors.top: wtext.bottom
    }




}
