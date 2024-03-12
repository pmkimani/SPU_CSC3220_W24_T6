import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import "Database.js" as JS

ApplicationWindow {
    id: root
    width: 480
    height: 640
    visible: true
    color: "#ADD8E6"
    title:"MAIN PAGE"


    Button {
        id: benchPress
        text: "Bench Press"
        width: 200
        height: 100
        anchors {
            bottom: squat.top
            // margins: 20
            left: squat.left
            }
        onClicked: {
            console.log("Button 1 clicked")
            benchpresspage.visible = true
            }
        }

    Button {
        id: squat
        text: "Squat"
        width: 200
        height: 100
        anchors.centerIn: parent
        onClicked: {
            console.log("Button 2 clicked")
            squatpage.visible = true
        }
            }

    Button {
        id: deadlift
        text: "Deadlift"
        width: 200
        height: 100
        anchors {
            top: squat.bottom
            // margins: 20
            left: squat.left
        }
        onClicked: {
            console.log("Button 3 clicked")
            deadliftpage.visible = true
        }
    }
    BenchPress {
        id: benchpresspage
    }
    Squat {
        id: squatpage
    }
    Deadlift {
        id: deadliftpage
    }
    Component.onCompleted: {
        JS.dbInit()
    }
}

