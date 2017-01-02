//
//  LEDDigitView.m
//  WallClock
//
//  Created by Oliver Michalak on 02.01.17.
//  Copyright © 2017 Oliver Michalak. All rights reserved.
//

#import "LEDDigitView.h"
#import "ClockKit.h"

static int map[10][7] = {{1,1,1,0,1,1,1},	// 0
	{0,0,1,0,0,1,0},	// 1
	{1,0,1,1,1,0,1},	// 2
	{1,0,1,1,0,1,1},	// 3
	{0,1,1,1,0,1,0},	// 4
	{1,1,0,1,0,1,1},	// 5
	{1,1,0,1,1,1,1},	// 6
	{1,0,1,0,0,1,0},	// 7
	{1,1,1,1,1,1,1},	// 8
	{1,1,1,1,0,1,1},	// 9
};

@implementation LEDDigitView

- (void)setValue:(NSUInteger)value {
	_value = value;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	int *leds = map[self.value % 10];
	[ClockKit drawLEDClockWithFrame:rect resizing:ClockKitResizingBehaviorAspectFit led0:leds[0] led1:leds[1] led2:leds[2] led3:leds[3] led4:leds[4] led5:leds[5] led6:leds[6]];
}

@end
