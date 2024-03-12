import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import "Database.js" as JS

Item {
    id: root
    required property ListView listView
    signal statusMessage(string msg)

    width: Screen.width / 2
    height: Screen.height / 7
    enabled: false

    function insertrec(workoutType) {
        if (workoutType === squat) {
            const rowid = parseInt(JS.dbInsertSquat(currentWeightInput.text, goalWeightInput.text, goalRepsInput.text), 10)
        } else if (workoutType === deadlift) {
             const rowid = parseInt(JS.dbInsertDeadlift(currentWeightInput.text, goalWeightInput.text, goalRepsInput.text), 10)
        } else if (workoutType === benchpress) {
            const rowid = parseInt(JS.dbInsertBench(currentWeightInput.text, goalWeightInput.text, goalRepsInput.text), 10)
        }


        if (rowid) {
            listView.model.setProperty(listView.currentIndex, "id", rowid)
            listView.forceLayout()
        }
        return rowid;
    }

    function editrec(PcurrentWeight, PgoalWeightInput, PgoalRepsInput, Prowid) {
        currentWeightInput.text = PcurrentWeight
        goalWeightInput.text = PgoalWeightInput
        goalRepsInput.text = PgoalRepsInput
    }

    function initrec_new() {
        currentWeightInput.clear()
        goalWeightInput.clear()
        goalRepsInput.clear()
        listView.model.insert(0, {
                                  currentWeight: "",
                                  goalWeight: "",
                                  goalReps: ""
                              })
        listView.currentIndex = 0
        currentWeightInput.forceActiveFocus()
    }

    function initrec() {
        currentWeightInput.clear()
        goalWeightInput.clear()
        goalRepsInput.clear()
    }

    function setlistview() {
        listView.model.setProperty(listView.currentIndex, "currentWeight",
                                   currentWeightInput.text)
        listView.model.setProperty(listView.currentIndex, "goalWeight",
                                   goalWeightInput.text)
        listView.model.setProperty(listView.currentIndex, "goalReps",
                                   (goalRepsInput.text))
    }

    Rectangle {
        id: rootrect
        border.width: 10
        color: "#161616"

        ColumnLayout {
            id: mainLayout
            anchors.fill: parent

            Rectangle {
                id: gridBox
                Layout.fillWidth: true

                GridLayout {
                    id: gridLayout
                    rows: 3
                    flow: GridLayout.TopToBottom
                    anchors.fill: parent

                    Label {
                        text: qsTr("Current Weight")
                        font.pixelSize: 22
                        rightPadding: 10
                    }

                    Label {
                        text: qsTr("Goal Weight")
                        font.pixelSize: 22
                        rightPadding: 10
                    }

                    Label {
                        text: qsTr("Goal Reps")
                        font.pixelSize: 22
                    }

                    TextField {
                        id: currentWeightInput
                        font.pixelSize: 22
                        activeFocusOnPress: true
                        activeFocusOnTab: true

                        ToolTip {
                            x: parent.width + 3
                            y: (parent.height - height) / 2
                            text: qsTr("pounds")
                            visible: currentWeightInput.enabled && currentWeightInput.hovered
                            delay: 1000
                        }

                        // validator: RegularExpressionValidator {
                        //     regularExpression: /\d{4}[,.:/-]\d\d?[,.:/-]\d\d?/
                        // }

                        onFocusChanged: function() {
                            if (!currentWeightInput.focus && !acceptableInput && root.enabled)
                                root.statusMessage(qsTr("Please fill in the weight"));
                        }

                        // onEditingFinished: function() {
                        //     const regex = /(\d+)[,.:/-](\d+)[,.:/-](\d+)/
                        //     if (dateInput.text.match(regex))
                        //         dateInput.text = dateInput.text.replace(regex, '$1-$2-$3')
                        // }
                    }

                    TextField {
                        id: goalWeightInput
                        property string oldString
                        font.pixelSize: 22
                        activeFocusOnPress: true
                        activeFocusOnTab: true
                        onFocusChanged: if (focus) oldString = goalWeightInput.text
                        onEditingFinished: function() {
                            if (goalWeightInput.text.length < 8 && goalWeightInput.text !== goalWeightInput.oldString && root.enabled)
                                root.statusMessage(qsTr("pounds"))
                        }
                    }

                    TextField {
                        id: goalRepsInput
                        property string oldString
                        font.pixelSize: 22
                        activeFocusOnPress: true
                        activeFocusOnTab: true
                        // validator: RegularExpressionValidator {
                        //     regularExpression: /\d{1,3}/
                        // }
                        onFocusChanged: if (focus) oldString = goalRepsInput.text
                        onEditingFinished: function() {
                            if (goalRepsInput.text === "" && goalRepsInput.text !== goalRepsInput.oldString && root.enabled)
                                root.statusMessage(qsTr("reps"))
                        }
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: currentWeightInput.forceActiveFocus()
    }
}
