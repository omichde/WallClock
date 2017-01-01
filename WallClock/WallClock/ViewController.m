//
//  ViewController.m
//  WallClock
//
//  Created by Oliver Michalak on 01.01.17.
//  Copyright © 2017 Oliver Michalak. All rights reserved.
//

#import "ViewController.h"
#import "NormalClockView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NormalClockView *clockView;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	NSDate *now = [NSDate date];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateStyle = NSDateFormatterLongStyle;
	formatter.timeStyle = NSDateFormatterNoStyle;
	self.clockLabel.text = [formatter stringFromDate:now];

	self.clockView.date = [NSDate date];
	[NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
		self.clockView.date = [NSDate date];
	}];
}

@end
