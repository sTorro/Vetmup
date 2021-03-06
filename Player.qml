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
                    anchors.right: buttonOpenFolder.left
                    style: ButtonStyle {
                            background: Rectangle {
                                radius: 4
                                color:VetmupStyle.colorButtons;
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
                    anchors.right: buttonSavePlaylist.left
                    style: ButtonStyle {
                        background: Rectangle {
                            radius: 4
                            color:VetmupStyle.colorButtons;
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

                //Save Playlist button
                VetmupButton{
                    ///Definition and styles
                    id: buttonSavePlaylist
                    anchors.horizontalCenter: parent.horizontalCenter
                    style: ButtonStyle {
                        background: Rectangle {
                            radius: 4
                            color:VetmupStyle.colorButtons;
                            Image {
                                id: buttonSavePlaylistImage
                                source: {if(!buttonSavePlaylist.pressed)VetmupStyle.iconSave;
                                    else VetmupStyle.iconSavePressed;}
                                anchors.fill: parent;
                            }
                        }
                    }
                    ///Functions
                    onClicked:{if(myVetmupPlayer.HasSongs())saveDialog.open();}
                }

                //Delete Playlist button
                VetmupButton{
                    ///Definition and styles
                    id: buttonDeletePlaylist
                    anchors.left: buttonSavePlaylist.right
                    style: ButtonStyle {
                        background: Rectangle {
                            radius: 4
                            color:VetmupStyle.colorButtons;
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

                //Shuffle Playlist button
                VetmupButton{
                    ///Definition and styles
                    id: buttonShuffle
                    anchors.left: buttonDeletePlaylist.right
                    checkable: true
                    checked: false
                    style: ButtonStyle {
                        background: Rectangle {
                            radius: 4
                            color:VetmupStyle.colorButtons;
                            Image {
                                id: buttonShuffleImage
                                source: {if(!buttonShuffle.checked)VetmupStyle.iconShuffle;
                                else VetmupStyle.iconShufflePressed;}
                                anchors.fill: parent;
                            }
                        }
                    }
                    ///Functions
                    onCheckedChanged: {
                        if(checked){
                            myVetmupPlayer.ShufflePlaylist(true);
                        }
                        else
                            myVetmupPlayer.ShufflePlaylist(false);
                    }
                }
            }
    Rectangle{
                id: tabPlayerMainWindow
                height: parent.height*7/8
                width: parent.width
                anchors.top: tabPlayerTopBar.bottom
                anchors.bottom: parent.bottom
                color:VetmupStyle.colorNormal
                //Top Row of the MainWindow of the Player
                Rectangle {
                        id: topRow
                        height: parent.height/8;
                        width: parent.width
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.right:parent.right
                        color:VetmupStyle.colorNormal
                        //Volume Low Image
                        Rectangle{
                            width: parent.height/1.5
                            height: parent.height/1.5
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: volumeSlider.left
                            anchors.rightMargin: 10
                            color: "transparent"
                            Image{
                                anchors.fill: parent
                                fillMode: Image.Stretch
                                sourceSize.height: parent.height
                                sourceSize.width: parent.width
                                source:VetmupStyle.iconVolumeLow
                            }
                        }
                        //Volume Slider
                        Slider {
                            id: volumeSlider
                            height: parent.height
                            width: parent.width/2.5
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            maximumValue: 100.0;
                            minimumValue: 0.0;
                            value:99.9
                            updateValueWhileDragging: true;
                            orientation: Qt.Horizontal;
                            onValueChanged:
                            {
                                myVetmupPlayer.SetVolume(volumeSlider.value);
                            }
                        }
                        //Volume High Image
                        Rectangle{
                            width: parent.height/1.5
                            height: parent.height/1.5
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: volumeSlider.right
                            anchors.leftMargin: 10
                            color: "transparent"
                            Image{
                                anchors.fill: parent
                                fillMode: Image.Stretch
                                sourceSize.height: parent.height
                                sourceSize.width: parent.width
                                source:VetmupStyle.iconVolumeHigh
                            }
                        }
                }

                Rectangle {
                        id: middleRow
                        height: parent.height*6/8;
                        width: parent.width
                        anchors.left: parent.left
                        anchors.right:parent.right
                        anchors.top: topRow.bottom
                        color:VetmupStyle.colorNormal

                        //Region to previous song
                        Rectangle{
                                id: previousSongWindow
                                width: parent.width/6
                                height: parent.height
                                anchors.left: parent.left
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
                                    onReleased: {
                                        parent.color= VetmupStyle.colorNormal;
                                    }
                                }
                        }

                        //Region to play/pause
                        Rectangle{
                                id: playPauseWindow
                                height:parent.height
                                width: parent.width*4/6
                                anchors.horizontalCenter: parent.horizontalCenter
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
                                        mainText.color= VetmupStyle.colorTextSelected;
                                    }
                                    onReleased: {
                                        parent.color= VetmupStyle.colorNormal;
                                        mainText.color= VetmupStyle.colorText;
                                    }
                                }

                                Rectangle{
                                    id: mainImageRectangle
                                    width: parent.width
                                    height: parent.height*2/3
                                    anchors.top: parent.top
                                    color: "transparent"
                                    Image{
                                        id: mainImage
                                        anchors.fill: parent
                                        source: songImageSource
                                        visible: true
                                    }

                                }

                                Rectangle{
                                    id: mainTextRectangle
                                    width: parent.width
                                    height : parent.height /3
                                    anchors.top: mainImageRectangle.bottom
                                    anchors.bottom: parent.botom
                                    color: "transparent"
                                //Main Text
                                    Text {
                                        id: mainText
                                        anchors.fill: parent
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.family: mainFont.name;
                                        font.pixelSize: parent.height/5;
                                        maximumLineCount: 4
                                        wrapMode: Text.Wrap
                                        text: tabPlayer.mainTextString
                                        anchors.centerIn: parent
                                        color: VetmupStyle.colorText
                                    }
                                }
                        }

                        //Region to next song
                        Rectangle{
                               id: nextSongWindow
                               height: parent.height
                               width: parent.width/6;
                               anchors.right: parent.right
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
                                   onReleased: {
                                       parent.color= VetmupStyle.colorNormal;
                                   }
                               }
                        }
                }

                Rectangle {
                        id: bottomRow
                        height: parent.height/8;
                        width: parent.width
                        anchors.left: parent.left
                        anchors.top: middleRow.bottom
                        anchors.right:parent.right
                        anchors.bottom: parent.bottom
                        color:VetmupStyle.colorNormal
                        Text{
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: timeSlider.left
                            anchors.rightMargin: 10
                            font.family: mainFont.name;
                            font.pixelSize: parent.height/3;
                            color: VetmupStyle.colorText
                            text: tabPlayer.textTimeSliderCurrent
                        }
                        Slider {
                            id: timeSlider
                            height: parent.height
                            width: parent.width/1.8;
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
                            font.pixelSize: parent.height/3;
                            color: VetmupStyle.colorText
                            text: tabPlayer.textTimeSliderTotal
                        }
                }
            }
}
