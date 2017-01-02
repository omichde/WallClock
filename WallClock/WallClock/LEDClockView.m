//
//  LEDCLockView.m
//  WallClock
//
//  Created by Oliver Michalak on 02.01.17.
//  Copyright © 2017 Oliver Michalak. All rights reserved.
//

#import "LEDClockView.h"
#import "LEDDigitView.h"
#import "ClockKit.h"

@interface LEDClockView ()
@property (nonatomic) IBOutlet LEDDigitView *hour0;
@property (nonatomic) IBOutlet LEDDigitView *hour1;
@property (nonatomic) IBOutlet LEDDigitView *minute0;
@property (nonatomic) IBOutlet LEDDigitView *minute1;
@end

@implementation LEDClockView

- (void)setDate:(NSDate *)date {
	_date = date;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:self.date];
	self.hour0.value = floor((float)comp.hour / 10.);
	self.hour1.value = comp.hour % 10;
	[ClockKit drawLEDDotWithFrame:rect resizing:ClockKitResizingBehaviorCenter secondValue:comp.second];
	self.minute0.value = floor((float)comp.minute / 10.);
	self.minute1.value = comp.minute % 10;
}

@end
