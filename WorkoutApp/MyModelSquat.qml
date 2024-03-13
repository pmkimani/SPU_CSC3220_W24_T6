import QtQuick
import QtQuick.LocalStorage
import "Database.js" as JS

ListModel {
    id: listModelSquat
    Component.onCompleted: JS.dbReadSquat()
}

