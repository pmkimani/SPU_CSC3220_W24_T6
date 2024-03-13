import QtQuick
import QtQuick.LocalStorage
import "Database.js" as JS

ListModel {
    id: listModelDeadlift
    Component.onCompleted: JS.dbReadDeadlift()
}

