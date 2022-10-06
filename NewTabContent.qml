import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle{
    width: 300
    height: 100
    property string txt

    Text {
        id: txtid
        text: txt
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Button{
        height: 80
        width: 200
        text: txt
        anchors.top: txtid.bottom

    }
}
