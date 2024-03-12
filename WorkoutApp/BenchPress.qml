import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import "Database.js" as JS

ApplicationWindow {
    visible: false
    width: 300
    height: 400
    color: "#ADD8E6"
    title: "Bench Press"

    Text {
            text: "This is a secondary window."
            anchors.centerIn: parent
        }
}
