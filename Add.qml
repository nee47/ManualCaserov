import QtQuick
import QtQuick.Controls


Page {
    width: 960
    height: 700
    Rectangle{
        id: addRectangle
        color: "#29272a"
        anchors.fill: parent

        Column{

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            spacing: 10
            anchors.rightMargin: 150
            anchors.leftMargin: 150
            anchors.topMargin: 30
            id: cl1

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
                    regularExpression: {/(\w+[\s|\S])./g}
                }
            }

            TextField{
                id: addSectionTF
                height: 35
                width:  parent.width
                placeholderText: qsTr("Ingresar seccion")
                selectByMouse: true
                background: Rectangle {
                    radius: 4
                }
            }

            TextField{
                id: addDescriptionTF
                height: parent.height / 2
                width:  parent.width
                selectByMouse: true
                background: Rectangle { radius: 2 }
            }


        }


    }


}


