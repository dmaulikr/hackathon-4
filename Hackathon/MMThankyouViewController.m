//
//  MMThankyouViewController.m
//  Hackathon
//
//  Created by Roberto on 11/7/13.
//  Copyright (c) 2013 Medallia. All rights reserved.
//

#import "MMThankyouViewController.h"
#import "MMData.h"

@interface MMThankyouViewController () {
	NSTimer *dismissTimer;
}

@end

@implementation MMThankyouViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[[MMData sharedData] submit];
}

- (void)viewWillAppear:(BOOL)animated {
	dismissTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
													target:self
												  selector:@selector(thankyouClicked:)
												  userInfo:nil
												   repeats:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)thankyouClicked:(id)sender {
	if (dismissTimer) {
		[dismissTimer invalidate];
		dismissTimer = nil;
	}
	UIViewController *controller = [self presentingViewController];
	UIViewController *parent = [controller presentingViewController];
	while (parent != nil && parent != controller) {
		controller = parent;
		parent = [controller presentingViewController];
	}

	[controller dismissViewControllerAnimated:YES completion:nil];
}

@end
