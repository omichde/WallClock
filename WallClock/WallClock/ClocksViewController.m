//
//  ViewController.m
//  WallClock
//
//  Created by Oliver Michalak on 01.01.17.
//  Copyright © 2017 Oliver Michalak. All rights reserved.
//

#import "ClocksViewController.h"
#import "NormalClockView.h"
#import "LEDClockView.h"

@interface ClocksViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NormalClockView *normalClockView;
@property (weak, nonatomic) IBOutlet LEDClockView *ledClockView;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel;
@property (nonatomic) NSDateFormatter *formatter;
@end

@implementation ClocksViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.scrollView.panGestureRecognizer.allowedTouchTypes = @[@(UITouchTypeIndirect)];

	self.formatter = [[NSDateFormatter alloc] init];
	self.formatter.dateStyle = NSDateFormatterLongStyle;
	self.formatter.timeStyle = NSDateFormatterNoStyle;

	NSDate *now = [NSDate date];
	self.clockLabel.text = [self.formatter stringFromDate:now];
	self.normalClockView.date = self.ledClockView.date = now;

	[NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
		NSDate *now = [NSDate date];
		self.clockLabel.text = [self.formatter stringFromDate:now];
		self.normalClockView.date = self.ledClockView.date = now;
	}];

	[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
		NSUInteger index = (int)round(self.scrollView.contentOffset.x / CGRectGetWidth(self.view.frame));
		[[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"index"];
	}];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	NSUInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:@"index"];
	self.scrollView.contentOffset = CGPointMake(index * CGRectGetWidth(self.view.frame), 0);
}

@end
