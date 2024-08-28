import QtQuick
import QtQuick.Controls as Control
import QtQuick.Layouts 1.0
import QtQuick.Effects
import Linphone

Text {
	id: mainItem
	color: DefaultStyle.danger_500main
	function clear() {
		autoHideErrorMessage.stop()
		text = ""
	}
	function setText(text) {
		mainItem.text = text
	}
	font {
		pixelSize: 12 * DefaultStyle.dp
		weight: 300 * DefaultStyle.dp
	}
	Timer {
		id: autoHideErrorMessage
		interval: 5000
		onTriggered: mainItem.text = ""
	}

	onTextChanged: if (mainItem.text.length > 0) autoHideErrorMessage.restart()
}