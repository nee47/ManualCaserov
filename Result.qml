import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ListView {
    id: sectionListView
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

            function onSignalNewTabData(data, id){
                contentData = data
                sectionClickedId = id
                return
            }

    }

    ListModel {
        id: resultListModel
    }

    property int sectionClickedId
    property string sectionClickedName
    property var contentData

    model: resultListModel
    delegate: Button {
        id: ldbutton
        width: parent.width
        height: 70
        text: name
        onClicked: {
            winld.active = true
            sectionClickedName = text
            backend.setDataNewTab(text)
            winld.source = "ContentWindow.qml"
           }

        Loader {
            id: winld
            active: false
        }
    }
}

