//
//  ClockKit.h
//  WallClock
//
//  Created by Oliver on 02.01.17.
//  Copyright © 2017 CompanyName. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//

#import <UIKit/UIKit.h>



typedef enum : NSInteger
{
    ClockKitResizingBehaviorAspectFit, //!< The content is proportionally resized to fit into the target rectangle.
    ClockKitResizingBehaviorAspectFill, //!< The content is proportionally resized to completely fill the target rectangle.
    ClockKitResizingBehaviorStretch, //!< The content is stretched to match the entire target rectangle.
    ClockKitResizingBehaviorCenter, //!< The content is centered in the target rectangle, but it is NOT resized.

} ClockKitResizingBehavior;

extern CGRect ClockKitResizingBehaviorApply(ClockKitResizingBehavior behavior, CGRect rect, CGRect target);


@interface ClockKit : NSObject

// Drawing Methods
+ (void)drawNormalClockWithSecondValue: (CGFloat)secondValue minuteValue: (CGFloat)minuteValue hourValue: (CGFloat)hourValue;
+ (void)drawNormalClockWithFrame: (CGRect)targetFrame resizing: (ClockKitResizingBehavior)resizing secondValue: (CGFloat)secondValue minuteValue: (CGFloat)minuteValue hourValue: (CGFloat)hourValue;
+ (void)drawNormalClockFaceWithMinuteValue: (CGFloat)minuteValue hourValue: (CGFloat)hourValue isHourDot: (BOOL)isHourDot;
+ (void)drawNormalClockFaceWithFrame: (CGRect)targetFrame resizing: (ClockKitResizingBehavior)resizing minuteValue: (CGFloat)minuteValue hourValue: (CGFloat)hourValue isHourDot: (BOOL)isHourDot;
+ (void)drawLEDClockWithLed0: (BOOL)led0 led1: (BOOL)led1 led2: (BOOL)led2 led3: (BOOL)led3 led4: (BOOL)led4 led5: (BOOL)led5 led6: (BOOL)led6;
+ (void)drawLEDClockWithFrame: (CGRect)targetFrame resizing: (ClockKitResizingBehavior)resizing led0: (BOOL)led0 led1: (BOOL)led1 led2: (BOOL)led2 led3: (BOOL)led3 led4: (BOOL)led4 led5: (BOOL)led5 led6: (BOOL)led6;
+ (void)drawLEDDotWithSecondValue: (CGFloat)secondValue;
+ (void)drawLEDDotWithFrame: (CGRect)targetFrame resizing: (ClockKitResizingBehavior)resizing secondValue: (CGFloat)secondValue;

@end
