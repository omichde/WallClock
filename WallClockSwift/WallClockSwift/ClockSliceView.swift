//
//  ClockSliceView.swift
//  WallClockSwift
//
//  Created by Oliver Michalak on 17.07.17.
//  Copyright © 2017 Oliver Michalak. All rights reserved.
//

import UIKit

class ClockSliceView: UIView {

	var date : Date? = nil {
		didSet {
			setNeedsDisplay()
		}
	}

	var startDate : Date? = nil {
		didSet {
			setNeedsDisplay()
		}
	}

	var endDate : Date? = nil {
		didSet {
			setNeedsDisplay()
		}
	}

	var isPlaying : Bool {
		guard let date = date,
					let endDate = endDate else { return false }
		let dateComp = Calendar.current.dateComponents([Calendar.Component.minute], from: date)
		let endComp = Calendar.current.dateComponents([Calendar.Component.minute], from: endDate)
		return dateComp.minute != endComp.minute && date.compare(endDate) == .orderedAscending
	}

	// move to VC if LED clock should get timer too, (together with idleTimerDisabled)
	public func togglePlayPause (gesture: UITapGestureRecognizer) {
		if (gesture.state == .ended) {
			if (isPlaying) {
				startDate = nil
				endDate = nil
			}
			else {
				startDate = Date()
				endDate = startDate?.addingTimeInterval(60*15)	// 15mins slices
			}
		}
	}

	override func draw(_ rect: CGRect) {
		if isPlaying {
			isHidden = false
			UIApplication.shared.isIdleTimerDisabled = true
			guard let date = date,
						let endDate = endDate,
						let startDate = startDate else { return }
			let dateComp = Calendar.current.dateComponents([Calendar.Component.minute], from: date)
			let endComp = Calendar.current.dateComponents([Calendar.Component.minute], from: endDate)

			// seconds precision preferred for coloring
			let diff = Float(fmax(0, fmin(1, (date.timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate) / (endDate.timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate))))
			// in RGB direct green->red creates ugly brown in the middle, just add blue in between
			let sliceColor = UIColor.init(colorLiteralRed: diff, green: 1-diff, blue: (2*diff >= 1 ? 2 - 2*diff : 2*diff), alpha: 1)
			ClockKit.drawClockSlice(frame: frame, resizing: .aspectFit, sliceColor: sliceColor, sliceStartValue: CGFloat(dateComp.minute!), sliceEndValue: CGFloat(endComp.minute!))
		}
		else {
			isHidden = true
			UIApplication.shared.isIdleTimerDisabled = false
			startDate = nil
			endDate = nil
		}
	}
}
