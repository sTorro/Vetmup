/*Carlos Martinez Perez - mpcarlos87@gmail.com - 20/09/2014*/
/*This class is for the buttons with image*/
import QtQuick 2.0
import QtQuick.Controls 1.2

Button {
    id: simpleButton
    height: Math.min(parent.height/1.4,parent.width/5)
    width: Math.min(parent.height/1.4,parent.width/5)
    anchors.verticalCenter: parent.verticalCenter
}
