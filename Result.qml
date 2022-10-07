import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ListView {
    id: lview
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

            function onSignalNewTabData(data, s){
                wholeData = data
                console.log(wholeData)
                tam = s
                return
            }

    }

    ListModel {
        id: resultListModel

    }


    property int tam
    property var wholeData

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
            winld.source = "Temp.qml"
           }

        Loader {
            id: winld
            active: false
        }
    }

}
