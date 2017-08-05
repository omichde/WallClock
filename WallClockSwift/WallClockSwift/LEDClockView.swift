//
//  LEDClockView.swift
//  WallClockSwift
//
//  Created by Oliver Michalak on 17.07.17.
//  Copyright © 2017 Oliver Michalak. All rights reserved.
//

import UIKit

class LEDClockView: UIView {

	@IBOutlet weak var hour0: LEDDigitView!
	@IBOutlet weak var hour1: LEDDigitView!
	@IBOutlet weak var minute0: LEDDigitView!
	@IBOutlet weak var minute1: LEDDigitView!

	var date : Date? = nil {
		didSet {
			self.setNeedsDisplay()
		}
	}

	override func draw(_ rect: CGRect) {
		guard let date = date else { return }
		let comp = Calendar.current.dateComponents([Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second], from: date)

		hour0.value = Int(floor(Double(comp.hour!) / 10))
		hour1.value = comp.hour! % 10
		ClockKit.drawLEDDot(frame: rect, resizing: .center, secondValue: CGFloat(comp.second!))
		minute0.value = Int(floor(Double(comp.minute!) / 10))
		minute1.value = comp.minute! % 10
	}
}
