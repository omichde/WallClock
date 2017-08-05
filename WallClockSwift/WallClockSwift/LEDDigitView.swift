//
//  LEDDigitView.swift
//  WallClockSwift
//
//  Created by Oliver Michalak on 17.07.17.
//  Copyright © 2017 Oliver Michalak. All rights reserved.
//

import UIKit

class LEDDigitView: UIView {

	let map: [[Int]] = [[1,1,1,0,1,1,1],	// 0
											[0,0,1,0,0,1,0],	// 1
											[1,0,1,1,1,0,1],	// 2
											[1,0,1,1,0,1,1],	// 3
											[0,1,1,1,0,1,0],	// 4
											[1,1,0,1,0,1,1],	// 5
											[1,1,0,1,1,1,1],	// 6
											[1,0,1,0,0,1,0],	// 7
											[1,1,1,1,1,1,1],	// 8
											[1,1,1,1,0,1,1]]	// 9

	var value: Int? {
		didSet {
			setNeedsDisplay()
		}
	}

	override func draw(_ rect: CGRect) {
		guard let value = value else { return }
		let leds = map[value % 10]

		ClockKit.drawLEDClock(frame: rect, resizing: .aspectFit, led0:leds[0] != 0, led1:leds[1] != 0, led2:leds[2] != 0, led3:leds[3] != 0, led4:leds[4] != 0, led5:leds[5] != 0, led6:leds[6] != 0)

	}
}
