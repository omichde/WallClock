//
//  ClockSliceView.h
//  WallClock
//
//  Created by Oliver Michalak on 16.07.17.
//  Copyright © 2017 Oliver Michalak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClockSliceView : UIView

@property (nonatomic) NSDate *date;
@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSDate *endDate;
@property (readonly, nonatomic) BOOL isPlaying;

- (void)togglePlayPause:(UITapGestureRecognizer *)gesture;

@end
