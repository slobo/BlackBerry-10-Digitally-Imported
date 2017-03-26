import bb.cascades 1.4

Page {
    id: settingsPage
    
    titleBar: TitleBar {
        title: qsTr("Settings")
    }
    
    content: Container {
        
        Container {
            topPadding: 10
            leftPadding: 10

            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            
            }
            Label {
                verticalAlignment: VerticalAlignment.Center
                text: qsTr("DI Premium Listen Key")
            }
            TextField {
                text: settings.value('listen_key')
                onTextChanged: {
                    settings.setValue('listen_key', text)
                }
            }
        }
        Container {
            topPadding: 10
            leftPadding: 10
            
            Label {
                leftPadding: 10
                
                text: "<html>You can find your Premium key at <a href='http://di.fm/settings'>DI.fm Settings</a></html>"
            }            
        }
        
        Container {
            topPadding: 100
            leftPadding: 10
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            
            }
            Label {
                id: darkUiLabel
                verticalAlignment: VerticalAlignment.Center
                text: qsTr("Dark User Interface")
            }
            ToggleButton {
                horizontalAlignment: HorizontalAlignment.Right
                checked: settings.value("dark_ui", false)
                onCheckedChanged: {
                    settings.setValue("dark_ui", checked)
                    if (checked) {
                        Application.themeSupport.setVisualStyle(VisualStyle.Dark);
                    } else {
                        Application.themeSupport.setVisualStyle(VisualStyle.Bright);
                    }
                }
                accessibility.labelledBy: darkUiLabel
            }
        
        }
    
    }
}