	//
//  NormalClockView.swift
//  WallClockSwift
//
//  Created by Oliver Michalak on 17.07.17.
//  Copyright © 2017 Oliver Michalak. All rights reserved.
//

import UIKit

class NormalClockView: UIView {

	var date: Date? {
		didSet {
			setNeedsDisplay()
		}
	}

	override func draw(_ rect: CGRect) {
		for idx in 0..<60 {
			if (!(idx % 5 != 0)) {
				ClockKit.drawNormalClockFace(frame: rect, resizing: .aspectFit, minuteValue: 0, hourValue: CGFloat(idx), isHourDot:true)
			}
			else {
				ClockKit.drawNormalClockFace(frame: rect, resizing: .aspectFit, minuteValue: CGFloat(idx), hourValue: 0, isHourDot:false)
			}
		}

		if let date = date {
			let comp = Calendar.current.dateComponents([Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second], from: date)
			ClockKit.drawNormalClock(frame: rect, resizing: .aspectFit, secondValue: CGFloat(comp.second!), minuteValue: CGFloat(comp.minute!), hourValue: CGFloat(comp.hour! + comp.minute! / 60))
		}
	}
}
