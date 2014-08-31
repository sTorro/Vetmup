import QtQuick 2.2
import QtQuick.Window 2.1

Window {
    visible: true
    width: 360
    height: 360

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    Text {
        text: qsTr("This is Vetmup!")
        anchors.centerIn: parent
    }

    Image{
        source: "Icons/Contact"
        anchors.centerIn: parent

    }
}
