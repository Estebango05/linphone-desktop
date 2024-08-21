import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Control
import Linphone
import ConstantsCpp
import SettingsCpp

LoginLayout {
	id: mainItem
	signal goBack()
	signal goToRegister()
	signal connectionSucceed()
	
	titleContent: [
		RowLayout {
			Layout.leftMargin: 119 * DefaultStyle.dp
			visible: !SettingsCpp.assistantHideThirdPartyAccount
			spacing: 21 * DefaultStyle.dp
			Button {
				Layout.preferredHeight: 24 * DefaultStyle.dp
				Layout.preferredWidth: 24 * DefaultStyle.dp
				icon.source: AppIcons.leftArrow
				icon.width: 24 * DefaultStyle.dp
				icon.height: 24 * DefaultStyle.dp
				background: Item {
					anchors.fill: parent
				}
				onClicked: {
					console.debug("[SIPLoginPage] User: return")
					mainItem.goBack()
				}
			}
			Image {
				fillMode: Image.PreserveAspectFit
				source: AppIcons.profile
				Layout.preferredHeight: 34 * DefaultStyle.dp
				Layout.preferredWidth: 34 * DefaultStyle.dp
				sourceSize.width: 34 * DefaultStyle.dp
				sourceSize.height: 34 * DefaultStyle.dp
			}
			Text {
				text: qsTr("Compte SIP tiers")
				font {
					pixelSize: 36 * DefaultStyle.dp
					weight: 800 * DefaultStyle.dp
				}
				scaleLettersFactor: 1.1
			}
		},
		Item {
			Layout.fillWidth: true
		},
		RowLayout {
			visible: !SettingsCpp.assistantHideCreateAccount
			Layout.rightMargin: 51 * DefaultStyle.dp
			spacing: 20 * DefaultStyle.dp
			Text {
				Layout.rightMargin: 15 * DefaultStyle.dp
				text: qsTr("Pas encore de compte ?")
				font {
					pixelSize: 14 * DefaultStyle.dp
					weight: 400 * DefaultStyle.dp
				}
			}
			Button {
				Layout.alignment: Qt.AlignRight
				text: qsTr("S'inscrire")
				leftPadding: 20 * DefaultStyle.dp
				rightPadding: 20 * DefaultStyle.dp
				topPadding: 11 * DefaultStyle.dp
				bottomPadding: 11 * DefaultStyle.dp
				onClicked: {
					console.debug("[SIPLoginPage] User: go to register page")
					mainItem.goToRegister()
				}
			}
		}
	]
	
	Component {
		id: firstItem
		ColumnLayout {
			spacing: 0
			Text {
				Layout.fillWidth: true
				Layout.preferredWidth: rootStackView.width
				wrapMode: Text.WordWrap
				color: DefaultStyle.main2_600
				font {
					pixelSize: 14 * DefaultStyle.dp
					weight: 400* DefaultStyle.dp
				}
				text: "<p>Some features require a Linphone account, such as group messaging, video conferences...</p> 
				<p>These features are hidden when you register with a third party SIP account.</p>
				<p>To enable it in a commercial projet, please contact us. </p>"
			}
			Button {
				Layout.alignment: Qt.AlignCenter
				Layout.topMargin: 18 * DefaultStyle.dp
				text: "linphone.org/contact"
				textSize: 13 * DefaultStyle.dp
				inversedColors: true
				leftPadding: 12 * DefaultStyle.dp
				rightPadding: 12 * DefaultStyle.dp
				topPadding: 6 * DefaultStyle.dp
				bottomPadding: 6 * DefaultStyle.dp
				onClicked: {
					Qt.openUrlExternally(ConstantsCpp.ContactUrl)
				}
			}
			Button {
				Layout.topMargin: 85 * DefaultStyle.dp
				Layout.fillWidth: true
				inversedColors: true
				text: qsTr("I prefer creating an account")
				leftPadding: 20 * DefaultStyle.dp
				rightPadding: 20 * DefaultStyle.dp
				topPadding: 11 * DefaultStyle.dp
				bottomPadding: 11 * DefaultStyle.dp
				onClicked: {
					console.debug("[SIPLoginPage] User: click register")
					mainItem.goToRegister()
				}
			}
			Button {
				Layout.topMargin: 20 * DefaultStyle.dp
				Layout.fillWidth: true
				text: qsTr("I understand")
				leftPadding: 20 * DefaultStyle.dp
				rightPadding: 20 * DefaultStyle.dp
				topPadding: 11 * DefaultStyle.dp
				bottomPadding: 11 * DefaultStyle.dp
				onClicked: {
					rootStackView.replace(secondItem)
				}
			}
			Item {
				Layout.fillHeight: true
			}
		}
	}
	Component {
		id: secondItem
		ColumnLayout {
			spacing: 2 * DefaultStyle.dp
			ColumnLayout {
				spacing: 16 * DefaultStyle.dp
				FormItemLayout {
					id: username
					label: qsTr("Nom d'utilisateur")
					mandatory: true
					enableErrorText: true
					contentItem: TextField {
						id: usernameEdit
						isError: username.errorTextVisible
						Layout.preferredWidth: 360 * DefaultStyle.dp
					}
				}
				FormItemLayout {
					id: password
					label: qsTr("Mot de passe")
					mandatory: true
					enableErrorText: true
					contentItem: TextField {
						id: passwordEdit
						isError: password.errorTextVisible
						hidden: true
						Layout.preferredWidth: 360 * DefaultStyle.dp
					}
				}
				FormItemLayout {
					id: domain
					label: qsTr("Domaine")
					mandatory: true
					enableErrorText: true
					contentItem: TextField {
						id: domainEdit
						isError: domain.errorTextVisible
						Layout.preferredWidth: 360 * DefaultStyle.dp
					}
				}
				FormItemLayout {
					label: qsTr("Nom d'affichage")
					contentItem: TextField {
						id: displayName
						Layout.preferredWidth: 360 * DefaultStyle.dp
					}
				}
				FormItemLayout {
					label: qsTr("Transport")
					contentItem: ComboBox {
						id: transportCbox
						height: 49 * DefaultStyle.dp
						width: 360 * DefaultStyle.dp
						textRole: "text"
						valueRole: "value"
						model: [
							{text: "TCP", value: LinphoneEnums.TransportType.Tcp},
							{text: "UDP", value: LinphoneEnums.TransportType.Udp},
							{text: "TLS", value: LinphoneEnums.TransportType.Tls},
							{text: "DTLS", value: LinphoneEnums.TransportType.Dtls}
						]
					}
				}
			}

			ErrorText {
				id: errorText
				Connections {
					target: LoginPageCpp
					function onErrorMessageChanged() {
						errorText.text = LoginPageCpp.errorMessage
					}
					function onRegistrationStateChanged() {
						if (LoginPageCpp.registrationState === LinphoneEnums.RegistrationState.Ok) {
							mainItem.connectionSucceed()
						}
					}
				}
			}

			Button {
				id: connectionButton
				Layout.topMargin: 32 * DefaultStyle.dp
				leftPadding: 20 * DefaultStyle.dp
				rightPadding: 20 * DefaultStyle.dp
				topPadding: 11 * DefaultStyle.dp
				bottomPadding: 11 * DefaultStyle.dp
				contentItem: StackLayout {
					id: connectionButtonContent
					currentIndex: 0
					Text {
						text: qsTr("Connexion")
						horizontalAlignment: Text.AlignHCenter
						verticalAlignment: Text.AlignVCenter

						font {
							pixelSize: 18 * DefaultStyle.dp
							weight: 600 * DefaultStyle.dp
						}
						color: DefaultStyle.grey_0
					}
					BusyIndicator {
						implicitWidth: parent.height
						implicitHeight: parent.height
						Layout.alignment: Qt.AlignCenter
						indicatorColor: DefaultStyle.grey_0
					}
					Connections {
						target: LoginPageCpp
						function onRegistrationStateChanged() {
							if (LoginPageCpp.registrationState != LinphoneEnums.RegistrationState.Progress) {
								connectionButton.enabled = true
								connectionButtonContent.currentIndex = 0
							}
						}
						function onErrorMessageChanged() {
							connectionButton.enabled = true
							connectionButtonContent.currentIndex = 0
						}
					}
				}

				function trigger() {
					username.errorMessage = ""
					password.errorMessage = ""
					domain.errorMessage = ""
					errorText.text = ""

					if (usernameEdit.text.length == 0 || passwordEdit.text.length == 0 || domainEdit.text.length == 0) {
						if (usernameEdit.text.length == 0)
							username.errorMessage = qsTr("Veuillez saisir un nom d'utilisateur")
						if (passwordEdit.text.length == 0)
							password.errorMessage = qsTr("Veuillez saisir un mot de passe")
						if (domainEdit.text.length == 0)
							domain.errorMessage = qsTr("Veuillez saisir un nom de domaine")
						return
					}
					console.debug("[SIPLoginPage] User: Log in")
					LoginPageCpp.login(usernameEdit.text, passwordEdit.text, displayName.text, domainEdit.text, transportCbox.currentValue);
					connectionButton.enabled = false
					connectionButtonContent.currentIndex = 1
				}

				Shortcut {
					sequences: ["Return", "Enter"]
					onActivated: if(domain.activeFocus) connectionButton.trigger()
								else if(username.activeFocus) password.forceActiveFocus()
								else if(password.activeFocus) domain.forceActiveFocus()
				}
				onPressed: connectionButton.trigger()
			}
			Item {
				Layout.fillHeight: true
			}
		}
	
	}

	centerContent: [
		Control.StackView {
			id: rootStackView
			initialItem: firstItem
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.bottom: parent.bottom
			anchors.topMargin: 70 * DefaultStyle.dp
			anchors.leftMargin: 127 * DefaultStyle.dp
			width: 361 * DefaultStyle.dp
		},
		Image {
			z: -1
			anchors.top: parent.top
			anchors.right: parent.right
			anchors.topMargin: 129 * DefaultStyle.dp
			anchors.rightMargin: 127 * DefaultStyle.dp
			width: 395 * DefaultStyle.dp
			height: 350 * DefaultStyle.dp
			fillMode: Image.PreserveAspectFit
			source: AppIcons.loginImage
		}
	]
}
