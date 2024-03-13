import QtQuick
import QtQuick.LocalStorage
import "Database.js" as JS

ListModel {
    id: listModelBench
    Component.onCompleted: JS.dbReadBench()
}

