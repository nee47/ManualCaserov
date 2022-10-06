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
                tam = s
                return
            }

            function onSignalCurrentContent(data){
                modelContent = data
                return
            }


    }

    ListModel {
        id: resultListModel

    }

    property int tam
    property string modelContent

    model: resultListModel
    //aca esta el problema, muestra el contenido del estado anterior del click en section
    delegate: Button {
        id: ldbutton
        width: parent.width
        height: 70
        text: name
        property int tamn: tam
        onClicked: {
            winld.active = true
            console.log(`ACABO DE CLICKEAR ${text}`)
            backend.setDataNewTab(text)
            winld.source = "Temp.qml"
           }

        Loader {
            id: winld
            active: false
        }
    }

}
