import QtQuick
import QtQuick.Controls

Page {
    width: 960
    height: 700
    Rectangle{
        id: addRectangle
        color: "#29272a"
        anchors.fill: parent

        Button {
            id: ldbutton
            width: 129
            height: 41
            onClicked: winld.active = true
            Loader {
                id: winld
                active: false
                sourceComponent: Window {
                    width: 100
                    height: 100
                    visible: true
                    onClosing: winld.active = false
                }
            }
        }
    }


}


