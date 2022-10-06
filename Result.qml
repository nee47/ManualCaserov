import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ListView {
    width: 650
    height: 450

    Connections{
            target: backend
            function onSignalGetData(data){

                resultListModel.clear()
                data.map(sec => {
                             const data = {
                                 name: sec
                             }
                             resultListModel.append(data)
                })
                return
            }

            function onSignalNewTabData(data){
                console.log(data)
                return
            }

            function onSignalGetSize(s){
                console.log(`ENTRA CON SIZE:  ${s}`)
                console.log(typeof s)
                console.log(`property int tamn antes de ${tam}`)
                tam = s
                console.log(`property int tamn despues de ${tam}`)
                return
            }
    }

    ListModel {
        id: resultListModel

    }

    property int tam

    model: resultListModel

    delegate: Button {
        id: ldbutton
        width: parent.width
        height: 70
        text: name
        property int tamn: tam
        onClicked: {
            winld.active = true
            backend.setDataNewTab(text)
           }
        Loader {
            id: winld
            active: false
            sourceComponent: Window {
                id: newTabWindow
                width: 800
                height: 600
                visible: true
                onClosing: winld.active = false
                ScrollView{
                    anchors.fill: parent
                    Column{
                        anchors.fill: parent
                        id: clayout

                        Component.onCompleted: {
                            var component = Qt.createComponent("NewTabContent.qml");
                            console.log(`property int tamn despues oncompleted ${ldbutton.tamn}`)
                            for (var i=0; i<clayout.tamn; i++) {
                                var object = component.createObject(clayout);
                                backend.next()
                            }
                        }


                    }
              }


            }
        }
    }

}
