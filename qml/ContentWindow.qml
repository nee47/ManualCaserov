import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window {
    id: contentWindow
    width: 800
    height: 600
    visible: true
    color: "#ADA7A7"
    //flags: Qt.Window | Qt.FramelessWindowHint

    onClosing: {
        winld.active = false
        winld.source = ""
    }

    Rectangle{
        id: topBar
        height: 45
        color: "#000000"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        Text {
            id: topBarTitleSection
            text: sectionListView.sectionClickedName
            color: "#ffffff"
            anchors.centerIn: parent
            font.pixelSize: 15
        }
        Button{
            id: addNewContentButton
            text: qsTr("+")
            background: Rectangle{
                    color: "#FF8300"
                }
            anchors.fill: parent
            anchors.leftMargin: parent.width *9.5/10
        }
    }

    ScrollView{
        id: scrollView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom
        ColumnLayout{
            id: clayout
            anchors.fill: parent
            Connections {
                        target: addNewContentButton
                        function onClicked(){
                            var component = Qt.createComponent("ContentTemplate.qml");
                            var object = component.createObject(clayout, {txt: "", f: function a(newDescription){
                                if(newDescription !==""){
                                    backend.insertNewContent(newDescription)
                                    ldbutton.loadContentView()
                                }
                            }});
                        }
                    }
            Component.onCompleted: {
                var component = Qt.createComponent("ContentTemplate.qml");
                contentData.map(item => {
                              var object = component.createObject(clayout, {txt: item[1], id_content: item[0]})
                              })
            }

        }
    }
}
