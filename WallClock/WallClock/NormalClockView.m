//
//  NormalClockView.m
//  WallClock
//
//  Created by Oliver Michalak on 01.01.17.
//  Copyright © 2017 Oliver Michalak. All rights reserved.
//

#import "NormalClockView.h"
#import "ClockKit.h"


@implementation NormalClockView

- (void)setDate:(NSDate *)date {
	_date = date;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	for (NSUInteger idx=0; idx < 60; idx++) {
		if (!(idx % 5))
			[ClockKit drawNormalClockFaceWithFrame:rect resizing:ClockKitResizingBehaviorAspectFit minuteValue:0 hourValue:idx isHourDot:YES];
		else
			[ClockKit drawNormalClockFaceWithFrame:rect resizing:ClockKitResizingBehaviorAspectFit minuteValue:idx hourValue:0 isHourDot:NO];
	}

	if (self.date) {
		NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:self.date];
		[ClockKit drawNormalClockWithFrame:rect resizing:ClockKitResizingBehaviorAspectFit secondValue:comp.second minuteValue:comp.minute hourValue:comp.hour + (float)comp.minute / 60.0];
	}
}

@end
