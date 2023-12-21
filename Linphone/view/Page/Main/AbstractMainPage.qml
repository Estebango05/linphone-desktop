/**
* Qml template used for overview pages : Calls, Contacts, Conversations, Meetings
**/

import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls as Control

import Linphone


Item {
	id: mainItem
	property string noItemButtonText
	property string newItemIconSource
	property string emptyListText
	property alias leftPanelContent: leftPanel.children
	property var rightPanelContent: rightPanelItem.children
	property bool showDefaultItem: true
	// onShowDefaultItemChanged: stackView.replace(showDefaultItem ? defaultItem : rightPanelItem)
	signal noItemButtonPressed()

	Control.SplitView {
		id: splitView
		anchors.fill: parent

		handle: Rectangle {
			implicitWidth: 8 * DefaultStyle.dp
			color: Control.SplitHandle.hovered ? DefaultStyle.grey_200 : DefaultStyle.grey_100
		}

		ColumnLayout {
			id: leftPanel
			Control.SplitView.preferredWidth: 280 * DefaultStyle.dp
		}
		Rectangle {
			id: rightPanel
			clip: true
			color: DefaultStyle.grey_100
			StackLayout {
				currentIndex: mainItem.showDefaultItem ? 0 : 1
				anchors.fill: parent
				ColumnLayout {
					id: defaultItem
					Layout.fillWidth: true
					Layout.fillHeight: true
					RowLayout {
						Layout.fillHeight: true
						Layout.fillWidth: true
						Layout.alignment: Qt.AlignHCenter
						Item {
							Layout.fillWidth: true
						}
						ColumnLayout {
							spacing: 30 * DefaultStyle.dp
							Item {
								Layout.fillHeight: true
							}
							Image {
								Layout.alignment: Qt.AlignHCenter
								source: AppIcons.noItemImage
								Layout.preferredWidth: 359 * DefaultStyle.dp
								Layout.preferredHeight: 314 * DefaultStyle.dp
								fillMode: Image.PreserveAspectFit
							}
							Text {
								text: mainItem.emptyListText
								Layout.alignment: Qt.AlignHCenter
								font {
									pixelSize: 22 * DefaultStyle.dp
									weight: 800 * DefaultStyle.dp
								}
							}
							Button {
								Layout.alignment: Qt.AlignHCenter
								contentItem: RowLayout {
									Layout.alignment: Qt.AlignVCenter
									EffectImage {
										colorizationColor: DefaultStyle.grey_0
										image.source: mainItem.newItemIconSource
										image.width: 24 * DefaultStyle.dp
										image.height: 24 * DefaultStyle.dp
										image.fillMode: Image.PreserveAspectFit
									}
									Text {
										text: mainItem.noItemButtonText
										wrapMode: Text.WordWrap
										color: DefaultStyle.grey_0
										font {
											weight: 600 * DefaultStyle.dp
											pixelSize: 18 * DefaultStyle.dp
											family: DefaultStyle.defaultFont
										}
									}
								}
								onPressed: mainItem.noItemButtonPressed()
							}
							Item {
								Layout.fillHeight: true
							}
						}
						Item {
							Layout.fillWidth: true
						}
					}
					
				}
				Item {
					id: rightPanelItem
					Layout.fillWidth: true
					Layout.fillHeight: true
				}
			}
		}
	}
}
				