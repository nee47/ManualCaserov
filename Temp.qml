import QtQuick
import QtQuick.Controls 2.5

Window {
    id: newTabWindow
    width: 800
    height: 600
    visible: true
    onClosing: {
        winld.active = false
        winld.source = ""
    }

    ScrollView{
        anchors.fill: parent
        Column{
            anchors.fill: parent
            id: clayout
            Component.onCompleted: {
                var component = Qt.createComponent("NewTabContent.qml");
                console.log(`property int tamn despues oncompleted ${lview.tam}`)
                /*
                for (var i=0; i<lview.tam; i++) {
                    backend.next()
                    var t = lview.modelContent
                    var object = component.createObject(clayout, {txt: t})

                }
                */
                wholeData.map(item => {
                              var object = component.createObject(clayout, {txt: item})
                              })

            }
        }
    }
}
