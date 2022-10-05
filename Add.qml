import QtQuick
import QtQuick.Controls

Page {
    width: 960
    height: 700
    Rectangle{
        id: addRectangle
        color: "#29272a"
        anchors.fill: parent

        Text {
            id: namet
            text: qsTr("SOMETHING WILL GO HERE")
            color: "white"
        }
    }


}


