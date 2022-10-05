import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "component_create.js" as CreateScript

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
    }

    ListModel {
        id: resultListModel

    }

    model: resultListModel

    delegate: Button {
        id: ldbutton
        width: parent.width
        height: 70
        text: name
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
                            for (var i=0; i<12; i++) {
                                var object = component.createObject(clayout);
                            }
                        }
                    }
                }


            }
        }
    }

}
