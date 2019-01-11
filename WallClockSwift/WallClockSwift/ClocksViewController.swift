//
//  CLocksViewController.swift
//  WallClockSwift
//
//  Created by Oliver Michalak on 17.07.17.
//  Copyright © 2017 Oliver Michalak. All rights reserved.
//

import UIKit

class ClocksViewController: UIViewController {
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var normalClockView: NormalClockView!
	@IBOutlet weak var clockSliceView: ClockSliceView!
	@IBOutlet weak var ledClockView: LEDClockView!
	@IBOutlet weak var clockLabel: UILabel!

	let formatter: DateFormatter = DateFormatter()

	override func viewDidLoad() {
		super.viewDidLoad()

		scrollView.panGestureRecognizer.allowedTouchTypes = [NSNumber(value:UITouch.TouchType.indirect.rawValue)]
		
		let tapGestureRecognizer = UITapGestureRecognizer.init(target: self.clockSliceView, action: #selector(self.clockSliceView.togglePlayPause))
		tapGestureRecognizer.allowedPressTypes = [NSNumber(value:UIPress.PressType.playPause.rawValue)]
		view.addGestureRecognizer(tapGestureRecognizer)
		
		formatter.dateStyle = .long
		formatter.timeStyle = .none

		let now = Date()
		clockLabel.text = formatter.string(from: now)
		normalClockView.date = now
		ledClockView.date = now
		clockSliceView.startDate = nil
		clockSliceView.endDate = nil

		Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
			let now = Date()
			self.clockLabel.text = self.formatter.string(from: now)
			self.normalClockView.date = now
			self.ledClockView.date = now
			self.clockSliceView.date = now
		}
		
		NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: nil) { _ in
			let index = self.scrollView.contentOffset.x / self.view.frame.size.width
			UserDefaults.standard.set(index, forKey: "index")
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		let index = UserDefaults.standard.integer(forKey: "index")
		scrollView.contentOffset = CGPoint(x: index * Int(view.frame.size.width), y: 0)
	}
}
