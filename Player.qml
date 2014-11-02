import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import vetmup.style 1.0
import VetmupPlayerQML 1.0


Rectangle{
    anchors.fill: parent;
    Rectangle{
                id: tabPlayerTopBar
                color: VetmupStyle.colorNormal;
                height: parent.height/8;
                width: parent.width;
                anchors.top: parent.top

                //Open files button
                VetmupButton{
                    ///Definition and styles
                    id: buttonOpenFiles
                    anchors.right: buttonOpenFolder.left;
                    style: ButtonStyle {
                            background: Rectangle {
                                radius: 4
                                color:{if(buttonOpenFiles.pressed)VetmupStyle.colorHighlight;
                                else color:VetmupStyle.colorButtons;}
                                Image {
                                    id: buttonOpenFilesImage
                                    source: {if(!buttonOpenFiles.pressed)VetmupStyle.iconAdd;
                                        else VetmupStyle.iconAddPressed;}
                                    anchors.fill: parent;
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
                    anchors.horizontalCenter: parent.horizontalCenter;
                    style: ButtonStyle {
                        background: Rectangle {
                            radius: 4
                            color:{if(buttonOpenFolder.pressed)VetmupStyle.colorHighlight;
                            else color:VetmupStyle.colorButtons;}
                            Image {
                                id: buttonOpenFolderImage
                                source: {if(!buttonOpenFolder.pressed)VetmupStyle.iconFolder;
                                    else VetmupStyle.iconFolderPressed;}
                                anchors.fill: parent;
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
                            radius: 4
                            color:{if(buttonDeletePlaylist.pressed)VetmupStyle.colorHighlight;
                            else color:VetmupStyle.colorButtons;}
                            Image {
                                id: buttonDeletePlaylistImage
                                source: {if(!buttonDeletePlaylist.pressed)VetmupStyle.iconThrash;
                                    else VetmupStyle.iconThrashPressed;}
                                anchors.fill: parent;
                            }
                        }
                    }
                    ///Functions
                    onClicked:{myVetmupPlayer.DeletePlaylist(); }
                }

            }
    Rectangle{

                id: tabPlayerMainWindow
                height: parent.height*7/8
                width: parent.width
                anchors.bottom: parent.bottom
                color:VetmupStyle.colorNormal

                //Volume slider
                Slider {
                    id: volumeSlider
                    width: parent.width/2
                    height: parent.height/10
                    anchors.top: parent.top
                    maximumValue: 100.0;
                    minimumValue: 0.0;
                    value:99.9
                    updateValueWhileDragging: true;
                    orientation: Qt.Horizontal;
                    anchors.horizontalCenter: parent.horizontalCenter
                    onValueChanged:
                    {
                        myVetmupPlayer.SetVolume(volumeSlider.value);
                    }
                }

                RowLayout {
                        id: mainRow
                        height: parent.height*8/10;
                        width: parent.width
                        anchors.left: parent.left
                        anchors.right:parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 5

                        //Region to previous song
                        Rectangle{
                                id: previousSongWindow
                                Layout.fillWidth: true;
                                Layout.minimumWidth: parent.width/4;
                                Layout.minimumHeight: parent.height;
                                color: VetmupStyle.colorNormal;
                                Image{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: parent.width/2;
                                    height: parent.width/2;
                                    source:  {if(!previousSongMouse.pressed)VetmupStyle.iconPrevious;
                                        else VetmupStyle.iconPreviousPressed;}
                                }

                                MouseArea{
                                    id: previousSongMouse
                                    anchors.fill: parent
                                    onClicked:{ myVetmupPlayer.PreviousSong();}
                                    onPressed: {
                                        parent.color= VetmupStyle.colorHighlight;
                                    }
                                    onReleased: {
                                        parent.color= VetmupStyle.colorNormal;
                                    }
                                }
                        }

                        //Region to play/pause
                        Rectangle{
                                id: playPauseWindow
                                Layout.fillWidth: true;
                                Layout.minimumWidth: parent.width/2;
                                Layout.minimumHeight: parent.height;
                                color:VetmupStyle.colorNormal
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        if(myVetmupPlayer.HasSongs())
                                                   myVetmupPlayer.PlayPause();
                                                else
                                                   fileDialog.open();
                                                }
                                    onPressed: {
                                        parent.color= VetmupStyle.colorHighlight;
                                    }
                                    onReleased: {
                                        parent.color= VetmupStyle.colorNormal;
                                    }
                                }

                                //Main Text
                                Text {
                                    id: mainText
                                    width: parent.width
                                    height: parent.height
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: mainFont.name;
                                    font.pixelSize: parent.height/15;
                                    maximumLineCount: 6
                                    wrapMode: Text.Wrap
                                    text: tabPlayer.mainTextString
                                    anchors.centerIn: parent
                                    color: VetmupStyle.colorText
                                }
                        }

                        //Region to next song
                        Rectangle{
                               id: nextSongWindow
                               Layout.fillWidth: true
                               Layout.minimumWidth: parent.width/4;
                               Layout.minimumHeight: parent.height;
                               color:VetmupStyle.colorNormal

                               Image{
                                   anchors.horizontalCenter: parent.horizontalCenter
                                   anchors.verticalCenter: parent.verticalCenter
                                   width: parent.width/2;
                                   height: parent.width/2;
                                   source:  {if(!nextSongMouse.pressed)VetmupStyle.iconNext;
                                       else VetmupStyle.iconNextPressed;}
                               }

                               MouseArea{
                                   id: nextSongMouse
                                   anchors.fill: parent
                                   onClicked:{ myVetmupPlayer.NextSong();}

                                   onPressed: {
                                       parent.color= VetmupStyle.colorHighlight;
                                   }
                                   onReleased: {
                                       parent.color= VetmupStyle.colorNormal;
                                   }
                               }
                        }
                }


                RowLayout {
                        id: bottomRow
                        height: parent.height/10;
                        width: parent.width
                        anchors.left: parent.left
                        anchors.top: mainRow.bottom
                        anchors.right:parent.right
                        anchors.bottom: parent.bottom
                        Text{
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: timeSlider.left
                            anchors.rightMargin: 10
                            font.family: mainFont.name;
                            font.pixelSize: parent.height/2;
                            color: VetmupStyle.colorText
                            text: tabPlayer.textTimeSliderCurrent
                        }
                        Slider {
                            id: timeSlider
                            height: parent.height
                            Layout.minimumWidth: parent.width/1.5;
                            Layout.minimumHeight: parent.height;
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            value:tabPlayer.timeSliderValue
                            minimumValue: tabPlayer.timeSliderMinimumValue;
                            maximumValue: tabPlayer.timeSliderMaximumValue;
                            updateValueWhileDragging: false;
                            onPressedChanged:{
                                     if (!pressed){
                                         myVetmupPlayer.SetSongTime(timeSlider.value);
                                     }
                            }
                        }
                        Text{
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: timeSlider.right
                            anchors.leftMargin: 10
                            font.family: mainFont.name;
                            font.pixelSize: parent.height/2;
                            color: VetmupStyle.colorText
                            text: tabPlayer.textTimeSliderTotal
                        }
                }
            }

}