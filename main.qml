import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls 6.3
import QtQuick.Controls.Material 2.3

Window {
    width: 960
    height: 700
    visible: true
    color: "#6b6c6c"
    title: qsTr("Manual Caserov")

    Material.theme: Material.Dark
    Material.accent: Material.DeepOrange

    StackLayout {
        id: stacklayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: tabBar.bottom
        currentIndex: tabBar.currentIndex

        Inicio{

        }
        Add{

        }

    }

    TabBar {
        id: tabBar
        currentIndex: stacklayout.currentIndex
        anchors{
            top: parent.top
            left: parent.left
            right:  parent.right
        }

        TabButton{
            text: qsTr("Inicio")
        }

        TabButton{
            text: qsTr("Añadir")
        }
    }
}
