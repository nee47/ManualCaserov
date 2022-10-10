import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ListView {
    id: sectionListView
    width: 650
    height: 450

    Connections{
            target: backend
            //sets the the list view the sections of
            //a given article
            function onSignalGetSections(sections){
                if(sections.length === 0) return
                resultListModel.clear()
                sections.map(sec => {
                             const data = {
                                 name: sec
                             }
                             resultListModel.append(data)
                })
                const agregar = {
                    name: "+"
                }
                resultListModel.append(agregar)
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

        Dialog{
            anchors.centerIn: parent
            id: messageDialog
            width: 400
            height: 100
            modal: Qt.WindowModal
            title: "Ingresa nueva seccion"
            standardButtons: Dialog.Ok | Dialog.Cancel
            TextField{
                id:tfield
                anchors.centerIn: parent
                width: 300
                height: 30

            }

            onAccepted: {
                backend.insertNewSection(searchTextField.text, tfield.text)
                searchButton.loadSections()
                close()
            }
        }

        function loadContentView(){
            winld.active = true
            sectionClickedName = text
            backend.setDataNewTab(text)
            winld.source = ""
            winld.source = "ContentWindow.qml"
        }

        onClicked: {
            if(text === "+"){
                messageDialog.open()
            }
            else loadContentView()
        }

        Loader {
            id: winld
            active: false
        }
    }
}

