import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: delegate

    required property int index
    required property int currentWeight
    required property int goalWeight
    required property int goalReps

    signal clicked()

    width: ListView.view.width
    implicitHeight: rDate.implicitHeight * 1.5

    Rectangle {
        id: baseRec
        anchors. fill: parent
        opacity: 0.8
        color: delegate.index % 2 ? "lightgrey" : "grey"
        border {
            width: 2
            color: Qt.lighter(color)
        }
        radius: 5

        MouseArea {
            anchors.fill: parent
            onClicked: delegate.clicked()
        }

        RowLayout {
            anchors.fill: parent

            Label {
                id: rDate
                Layout.preferredWidth: 42
                Layout.alignment: Qt.AlignCenter
                horizontalAlignment: Text.AlignHCenter
                text: delegate.currentWeight
                font.pixelSize: 22
                color: "black"
            }

            Label {
                Layout.preferredWidth: 42
                Layout.alignment: Qt.AlignCenter
                horizontalAlignment: Text.AlignHCenter
                text: delegate.goalWeight
                font.pixelSize: 22
                color: "black"
            }

            Label {
                Layout.preferredWidth: 42
                Layout.alignment: Qt.AlignCenter
                horizontalAlignment: Text.AlignHCenter
                text: delegate.goalReps
                font.pixelSize: 22
                color: "black"
            }
        }
    }
}
