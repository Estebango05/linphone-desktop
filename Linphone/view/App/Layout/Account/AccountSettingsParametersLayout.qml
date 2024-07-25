import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Control
import QtQuick.Dialogs
import Linphone
import SettingsCpp 1.0
import UtilsCpp

AbstractDetailsLayout {
	id: mainItem
	component: main
	property alias account: mainItem.model
	Component {
		id: main
		ColumnLayout {
			width: parent.width
			spacing: 5 * DefaultStyle.dp
			RowLayout {
				Layout.topMargin: 16 * DefaultStyle.dp
				spacing: 5 * DefaultStyle.dp
				ColumnLayout {
					Layout.fillWidth: true
					spacing: 5 * DefaultStyle.dp
					ColumnLayout {
						Layout.preferredWidth: 341 * DefaultStyle.dp
						Layout.maximumWidth: 341 * DefaultStyle.dp
						Layout.minimumWidth: 341 * DefaultStyle.dp
						spacing: 5 * DefaultStyle.dp
						Text {
							Layout.fillWidth: true
							text: qsTr("Paramètres")
							font: Typography.h4
							wrapMode: Text.WordWrap
							color: DefaultStyle.main2_600
						}
					}
					Item {
						Layout.fillHeight: true
					}
				}
				ColumnLayout {
					id: column
					Layout.fillWidth: true
					spacing: 20 * DefaultStyle.dp
					Layout.rightMargin: 44 * DefaultStyle.dp
					Layout.leftMargin: 64 * DefaultStyle.dp
					Layout.topMargin: 20 * DefaultStyle.dp
					ValidatedTextField {
						propertyName: "mwiServerAddress"
						propertyOwner: account.core
						title: qsTr("URI du serveur de messagerie vocale")
						isValid: function(text) { return UtilsCpp.isValidSIPAddress(text); }
					}
					Item {
						Layout.fillHeight: true
						Layout.fillWidth: true
					}
				}
			}
			Rectangle {
				Layout.fillWidth: true
				Layout.topMargin: 16 * DefaultStyle.dp
				height: 1 * DefaultStyle.dp
				color: DefaultStyle.main2_500main
			}
			RowLayout {
				Layout.topMargin: 16 * DefaultStyle.dp
				spacing: 5 * DefaultStyle.dp
				ColumnLayout {
					Layout.fillWidth: true
					spacing: 5 * DefaultStyle.dp
					ColumnLayout {
						Layout.preferredWidth: 341 * DefaultStyle.dp
						Layout.maximumWidth: 341 * DefaultStyle.dp
						Layout.minimumWidth: 341 * DefaultStyle.dp
						spacing: 5 * DefaultStyle.dp
						Text {
							Layout.fillWidth: true
							text: qsTr("Paramètres avancés")
							font: Typography.h4
							wrapMode: Text.WordWrap
							color: DefaultStyle.main2_600
						}
					}
					Item {
						Layout.fillHeight: true
					}
				}
				ColumnLayout {
					Layout.fillWidth: true
					spacing: 20 * DefaultStyle.dp
					Layout.rightMargin: 44 * DefaultStyle.dp
					Layout.topMargin: 20 * DefaultStyle.dp
					Layout.leftMargin: 64 * DefaultStyle.dp
					Text {
						text: qsTr("Transport")
						color: DefaultStyle.main2_600
						font: Typography.p2l
					}
					ComboSetting {
						Layout.fillWidth: true
						Layout.topMargin: -15 * DefaultStyle.dp
						entries: account.core.transports
						propertyName: "transport"
						propertyOwner: account.core
					}
					ValidatedTextField {
						title: qsTr("URL du serveur mandataire")
						propertyName: "serverAddress"
						propertyOwner: account.core
						isValid: function(text) { return UtilsCpp.isValidSIPAddress(text); }
					}
					SwitchSetting {
						titleText: qsTr("Serveur mandataire sortant")
						propertyName: "outboundProxyEnabled"
						propertyOwner: account.core
					}
					ValidatedTextField {
						propertyName: "stunServer"
						propertyOwner: account.core
						title: qsTr("Adresse du serveur STUN")
						isValid: function(text) { return UtilsCpp.isValidIPAddress(text) || UtilsCpp.isValidHostname(text); }
					}
					SwitchSetting {
						titleText: qsTr("Activer ICE")
						propertyName: "iceEnabled"
						propertyOwner: account.core
					}
					SwitchSetting {
						titleText: qsTr("AVPF")
						propertyName: "avpfEnabled"
						propertyOwner: account.core
					}
					SwitchSetting {
						titleText: qsTr("Mode bundle")
						propertyName: "bundleModeEnabled"
						propertyOwner: account.core
					}
					ValidatedTextField {
						propertyName: "expire"
						propertyOwner: account.core
						title: qsTr("Expiration (en seconde)")
						isValid: function(text) { return !isNaN(Number(text)); }
					}
					ValidatedTextField {
						title: qsTr("URI de l’usine à conversations")
						propertyName: "conferenceFactoryAddress"
						propertyOwner: account.core
						isValid: function(text) { return UtilsCpp.isValidSIPAddress(text); }
					}
					ValidatedTextField {
						title: qsTr("URI de l’usine à réunions")
						propertyName: "audioVideoConferenceFactoryAddress"
						propertyOwner: account.core
						isValid: function(text) { return UtilsCpp.isValidSIPAddress(text); }
					}
					ValidatedTextField {
						title: qsTr("URL du serveur d’échange de clés de chiffrement")
						propertyName: "limeServerUrl"
						propertyOwner: account.core
						isValid: function(text) { return UtilsCpp.isValidURL(text); }
					}
					Item {
						Layout.fillHeight: true
					}
				}
			}
		}
	}
}
