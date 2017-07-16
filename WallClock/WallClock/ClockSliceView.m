//
//  ClockSliceView.m
//  WallClock
//
//  Created by Oliver Michalak on 16.07.17.
//  Copyright © 2017 Oliver Michalak. All rights reserved.
//

#import "ClockSliceView.h"
#import "ClockKit.h"

@implementation ClockSliceView

- (void)setDate:(NSDate *)date {
	_date = date;
	[self setNeedsDisplay];
}

- (void)setStartDate:(NSDate *)date {
	_startDate = date;
	[self setNeedsDisplay];
}

- (void)setEndDate:(NSDate *)date {
	_endDate = date;
	[self setNeedsDisplay];
}

- (BOOL)isPlaying {
	if (self.date && self.startDate && self.endDate) {
		// expensive but exiting out when minutes are same already
		NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self.date];
		NSDateComponents *endComp = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self.endDate];
		return (dateComp.minute != endComp.minute && [self.date compare:self.endDate] == NSOrderedAscending);
	}
	return NO;
}

// move to VC if LED clock should get timer too, (together with idleTimerDisabled)
- (void)togglePlayPause:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateEnded) {
		if (self.isPlaying) {
			self.startDate = self.endDate = nil;
		}
		else {
			self.startDate = [NSDate date];
			self.endDate = [self.startDate dateByAddingTimeInterval:60*15];	// 15mins slices
		}
	}
}

- (void)drawRect:(CGRect)rect {
	if (self.isPlaying) {
		self.hidden = NO;
		[UIApplication sharedApplication].idleTimerDisabled = YES;
		NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self.date];
		NSDateComponents *endComp = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self.endDate];

		// seconds precision preferred for coloring
		float diff = MAX(0, MIN(1, ([self.date timeIntervalSinceReferenceDate] - [self.startDate timeIntervalSinceReferenceDate]) / ([self.endDate timeIntervalSinceReferenceDate] - [self.startDate timeIntervalSinceReferenceDate])));
		// in RGB direct green->red creates ugly brown in the middle, just add blue in between
		UIColor *sliceColor = [UIColor colorWithRed:diff green:1-diff blue:(2*diff >= 1 ? 2 - 2*diff : 2*diff) alpha:1];

		[ClockKit drawClockSliceWithFrame:self.frame resizing:ClockKitResizingBehaviorAspectFit sliceColor:sliceColor sliceStartValue:dateComp.minute sliceEndValue:endComp.minute];
	}
	else {
		self.hidden = YES;
		[UIApplication sharedApplication].idleTimerDisabled = NO;
		self.startDate = self.endDate = nil;
	}
}

@end
