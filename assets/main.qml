import bb.cascades 1.4
import bb.multimedia 1.4
import bb.system 1.2

NavigationPane {
    id: navigationPane
    
    Menu.definition: MenuDefinition {
        settingsAction: SettingsActionItem {
            title: qsTr("Settings")
            onTriggered: {
                navigationPane.push(settingsPageDefinition.createObject());
            }
        }
        helpAction: HelpActionItem {
            title: qsTr("Info")
            imageSource: "asset:///images/icons/info.png"
            attachedObjects: [
                SystemToast {
                    id: aboutToast
                    body: "Digitally Imported for BB10 \n Author: Slobodan Mišković"
                }
            ]
            onTriggered: {
                aboutToast.show();
            }
        }
    }
    
    Page {
        id: mainPage
        Container {            
            // Create a ListView that uses an XML data model
            ListView {
                id: stationList
                dataModel: XmlDataModel {
                    source: "stations.xml"
                }
                
                // Use a ListItemComponent to determine which property in the
                // data model is displayed for each list item
                listItemComponents: [
                    ListItemComponent {
                        type: "station"
                        
                        // Use a predefined StandardListItem
                        // to represent "listItem" items
                        StandardListItem {
                            title: ListItemData.title
                            description: ListItemData.description
                            // status: ListItemData.status
                            imageSource: "asset:///images/stations/" + ListItemData.id + ".jpg"
                            imageSpaceReserved: true
                        }
                    }
                ]
                
                onTriggered: {
                    clearSelection()
                    select(indexPath)
                    // Play Station
                    player.setSourceUrl("http://prem1.di.fm:80/" + dataModel.data(indexPath).id + "?" + settings.value("listen_key"));
                    player.play();
                }
                accessibility.name: "Station List"
            }
            
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                horizontalAlignment: HorizontalAlignment.Fill
                topPadding: 10
                bottomPadding: 10
                leftPadding: 10
                rightPadding: 10
//                background: Color.create('#EEEEEE')

                ActivityIndicator {
                    id: loadingIndicator
                    accessibility.name: "Loading Status"
                    
                }
                
                Button {
                    id: stopButton
                    text: qsTr("Stop")
                    accessibility.name: "Stop Playback"
                    imageSource: "asset:///images/icons/stop.png"
                    enabled: false
                    preferredWidth: 50
                    appearance: ControlAppearance.Primary
                    topMargin: 10
                    onClicked: {
                        player.stop();
                    }
                }

                Label {
                    id: trackTitle
                    text: "Select a station to play"
                    verticalAlignment: VerticalAlignment.Center
                }

            }
                  
        } // end of top-level Container
        
    }// end of Page
    
    attachedObjects: [
        SystemToast {
            id: statusToast
        },
        MediaPlayer {
            id: player
            onError: {
               statusToast.body = "Error Playing " + mediaError
               statusToast.show();
            }
            onMediaStateChanged: {
                console.log("mediaStateChanged:", mediaState)
                if (mediaState == MediaState.Stopped) {
                    stopButton.enabled = false;
                    trackTitle.text = "";
                    trackDuration.text = "";
                } else if (mediaState == MediaState.Started) {
                    stopButton.enabled = true;
                }
            }
            onBufferStatusChanged: {
                if (bufferStatus === BufferStatus.Buffering) {
                    statusToast.body = "Loading " + player.sourceUrl
                    statusToast.show()
                } 
//                else if (bufferStatus === BufferStatus.Playing ){
//                    statusToast.body = "Playing " + player.sourceUrl;
//                    statusToast.show();
//                } 
                else {
                    statusToast.cancel()
                }
            }
            onMetaDataChanged: {
//                var text = ""
//                for (var prop in metaData) {   
//                  text += prop + "=" + metaData[prop] + "\n"
//                }
//                statusToast.body = text
////                statusToast.body = metaData.title
//                statusToast.show();
                trackTitle.text = metaData.title
            }
//            onDurationChanged: {
//                trackDuration.text = "[ " + duration + " s]";
//            }
        },
        ComponentDefinition {
            id: settingsPageDefinition
            source: "Settings.qml"
        }
    ] // end of attachedObjects list
}