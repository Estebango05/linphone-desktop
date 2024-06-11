import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls as Control
import Linphone

Control.Slider {
    id: mainItem

    background: Rectangle {
        x: mainItem.leftPadding
        y: mainItem.topPadding + mainItem.availableHeight / 2 - height / 2
        implicitWidth: 200 * DefaultStyle.dp
        implicitHeight: 4 * DefaultStyle.dp
        width: mainItem.availableWidth
        height: implicitHeight
        radius: 30 * DefaultStyle.dp
		// TODO : change the colors when mockup indicates their names
        color: DefaultStyle.grey_850

        Rectangle {
            width: mainItem.visualPosition * parent.width
            height: parent.height
			gradient: Gradient {
				orientation: Gradient.Horizontal
				GradientStop { position: 0.0; color: "#FF9E79" }
				GradientStop { position: 1.0; color: "#FE5E00" }
			}
            radius: 40 * DefaultStyle.dp
        }
    }

    handle: Item {
		x: mainItem.leftPadding + mainItem.visualPosition * (mainItem.availableWidth - width)
		y: mainItem.topPadding + mainItem.availableHeight / 2 - height / 2
		implicitWidth: 16 * DefaultStyle.dp
		implicitHeight: 16 * DefaultStyle.dp
		Rectangle {
			id: handleRect
			anchors.fill: parent
			radius: 30 * DefaultStyle.dp
			color: DefaultStyle.grey_0
		}
		MultiEffect {
			source: handleRect
			anchors.fill: handleRect
			shadowEnabled: true
			shadowColor: DefaultStyle.grey_1000
			shadowBlur: 1
			shadowOpacity: 0.1
		}
	}
}
