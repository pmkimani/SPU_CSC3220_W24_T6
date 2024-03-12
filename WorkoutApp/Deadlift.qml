import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import "Database.js" as JS

ApplicationWindow {
    id: window
    visible: false
    width: 500
    height: 500
    color: "#ADD8E6"
    title: "Deadlift"

    property bool creatingNewEntry: false
    property bool editingEntry: false

    ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10

                Header {
                    id: input
                    Layout.fillWidth: true
                    listView: listView
                    enabled: window.creatingNewEntry || window.editingEntry
                }
    RowLayout {
                    Button {
                        text: qsTr("New")
                        onClicked: {
                            input.initrec_new()
                            window.creatingNewEntry = true
                            listView.model.setProperty(listView.currentIndex, "id", 0)
                        }
                    }
                    Button {
                                        id: saveButton
                                        enabled: (window.creatingNewEntry || window.editingEntry) && listView.currentIndex !== -1
                                        text: qsTr("Save")
                                        onClicked: {
                                            let insertedRow = false;
                                            if (listView.model.get(listView.currentIndex).id < 1) {
                                                //insert mode
                                                if (input.insertrec()) {
                                                    // Successfully inserted a row.
                                                    input.setlistview()
                                                    insertedRow = true
                                                } else {
                                                    // Failed to insert a row; display an error message.
                                                    statustext.displayWarning(qsTr("Failed to insert row"))
                                                }
                                            }
                                            if (insertedRow) {
                                                input.initrec()
                                                window.creatingNewEntry = false
                                                window.editingEntry = false
                                                listView.forceLayout()
                                            }
                                        }
                                    }
                }
    ListView {
                   id: listView
                   Layout.fillWidth: true
                   Layout.fillHeight: true
                   model: MyModel {}
                   delegate: MyDelegate {
                       width: listView.width
                       onClicked: ()=> listView.currentIndex = index
                   }
                   // Don't allow changing the currentIndex while the user is creating/editing values.
                   enabled: !window.creatingNewEntry && !window.editingEntry

                   highlight: highlightBar
                   highlightFollowsCurrentItem: true
                   focus: true
                   clip: true

                   header: Component {
                       RowLayout {
                           width: ListView.view.width
                           Repeater {
                               model: [qsTr("Goal Weight"), qsTr("Goal Reps"), qsTr("Distance")]
                               delegate: Label {
                                   id: headerTitleDelegate

                                   required property string modelData

                                   Layout.fillWidth: true
                                   Layout.fillHeight: true
                                   Layout.preferredWidth: 1
                                   text: modelData
                                   font {
                                       pointSize: 15
                                       bold: true
                                       underline: true
                                   }
                                   padding: 12
                                   horizontalAlignment: Label.AlignHCenter
                               }
                           }
                       }
                   }
               }
    }
}
