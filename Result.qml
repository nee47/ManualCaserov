import QtQuick
import QtQuick.Controls 2.5


ListView {
    width: 650
    height: 450

    Text {
        id: namesd
        text: qsTr("RESULT QML")
    }

    ListModel {
        id: fruitModel

        ListElement {
            name: "Apple"
            cost: 2.45
        }
        ListElement {
            name: "Orange"
            cost: 3.25
        }
        ListElement {
            name: "Banana"
            cost: 1.95
        }
    }

    model: fruitModel
    delegate: Button {
        id: ldbutton
        width: parent.width
        height: 70
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
