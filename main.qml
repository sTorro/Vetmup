import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import VetmupPlayerQML 1.0
import vetmup.style 1.0

Window {
    visible: true
    width: 360
    height: 360

    VetmupPlayer{
        id: myVetmupPlayer
    }

    Item{
    id: mainWindow
    anchors.fill: parent;
    MouseArea{
        anchors.fill: parent;
        onClicked: {if(myVetmupPlayer.HasSongs())
                        myVetmupPlayer.PlayPause();
                    else
                        fileDialog.open();
                    }

        }
    }

    Text {
        id: mainText
        text: qsTr("This is Vetmup!. Touch to Open or Play/Pause")
        anchors.centerIn: parent
    }

    VetmupFileDialog{
        id:fileDialog
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            myVetmupPlayer.OpenFiles(fileDialog.fileUrls)
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    VetmupFolderDialog{
        id:folderDialog
        onAccepted: {
            console.log("You chose the folder: " + folderDialog.fileUrl)
            myVetmupPlayer.OpenFolder(folderDialog.fileUrl)
        }
        onRejected: {
            console.log("Canceled")
        }

    }

    //Open files button
    VetmupButton{
        ///Definition and styles
        id: buttonOpenFiles
        anchors.left: mainWindow.left;
        style: ButtonStyle {
                background: Rectangle {
                    border.width: control.activeFocus ? 2 : 1
                    radius: 4
                    Image {
                        id: buttonOpenFilesImage
                        source: {if(!control.pressed) VetmupStyle.iconAdd;
                        else VetmupStyle.iconAdd;}
                        anchors.fill: parent
                    }
                }
            }
        ///Functions
        onClicked:{fileDialog.open(); }
    }

    //Open folder button
    VetmupButton{
        ///Definition and styles
        id: buttonOpenFolder
        anchors.left: buttonOpenFiles.right;
        style: ButtonStyle {
                background: Rectangle {
                    border.width: control.activeFocus ? 2 : 1
                    radius: 4
                    Image {
                        id: buttonOpenFolderImage
                        source: {if(!control.pressed) VetmupStyle.iconFolder;
                        else VetmupStyle.iconFolder;}
                        anchors.fill: parent
                    }
                }
            }
        ///Functions
        onClicked:{folderDialog.open(); }
    }

    //Delete Playlist button
    VetmupButton{
        ///Definition and styles
        id: buttonDeletePlaylist
        anchors.left: buttonOpenFolder.right;
        style: ButtonStyle {
                background: Rectangle {
                    border.width: control.activeFocus ? 2 : 1
                    radius: 4
                    Image {
                        id: buttonDeletePlaylistImage
                        source: {if(!control.pressed) VetmupStyle.iconThrash;
                        else VetmupStyle.iconThrash;}
                        anchors.fill: parent
                    }
                }
            }
        ///Functions
        onClicked:{myVetmupPlayer.DeletePlaylist(); }
    }


    //Button Settings
    VetmupButton{
        ///Definition and styles
        id: buttonExit
        anchors.right: parent.right;
        style: ButtonStyle {
                background: Rectangle {
                    border.width: control.activeFocus ? 2 : 1
                    radius: 4
                    Image {
                        id: buttonExitImage
                        source: {if(!control.pressed) VetmupStyle.iconClose;
                        else VetmupStyle.iconClose;}
                        anchors.fill: parent
                    }
                }
            }
        ///Functions
        onClicked:{Qt.quit()}
    }

    //Button Settings
    VetmupButton{
        ///Definition and styles
        id: buttonSettings
        anchors.right: buttonExit.left;
        style: ButtonStyle {
                background: Rectangle {
                    border.width: control.activeFocus ? 2 : 1
                    radius: 4
                    Image {
                        id: buttonSettingsImage
                        source: {if(!control.pressed) VetmupStyle.iconSettings;
                        else VetmupStyle.iconSettings;}
                        anchors.fill: parent
                    }
                }
            }
        ///Functions
        onClicked:{}
    }

}
