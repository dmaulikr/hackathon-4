//
//  MMDucksVsHorsesViewController.m
//  Hackathon
//
//  Created by Roberto on 11/7/13.
//  Copyright (c) 2013 Medallia. All rights reserved.
//

#import "MMDucksVsHorsesViewController.h"
#import "MMHorizontalSegue.h"
#import "MMData.h"

#define BUTTON_SIZE 240
#define BUTTON_HIGHLIGHTED 280
#define BUTTON_DIMISSED 150

@interface MMDucksVsHorsesViewController () {
	UIButton *buttons[2];
	int selectedButton;
}

@end

@implementation MMDucksVsHorsesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		selectedButton = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	for (int i = 0; i < 2; i++) {
		buttons[i] = (UIButton *)[self.view viewWithTag:i + 1];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
	NSNumber *value = [[MMData sharedData].data objectForKey:@"ChallengeTypeValue"];
	selectedButton = (value != nil ? [value intValue] : -1);
	[self layoutButtons];
}


- (IBAction)optionClicked:(id)sender {
	selectedButton = (int)((UIButton *)sender).tag - 1;
	[[MMData sharedData].data setObject:[self selectionToType] forKey:@"ChallengeType"];
	[[MMData sharedData].data setObject:[NSNumber numberWithInt:selectedButton] forKey:@"ChallengeTypeValue"];
	
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[self layoutButtons];
	[UIView commitAnimations];
}

- (void)layoutButtons {
	for (int i = 0; i < 2; i++) {
		UIButton *button = buttons[i];
		CGRect frame = button.frame;
		CGPoint center = CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height / 2);
		CGRect newFrame;
		CGFloat alpha;
		if (selectedButton == i) {
			newFrame = CGRectMake(center.x - BUTTON_HIGHLIGHTED / 2, center.y - BUTTON_HIGHLIGHTED / 2, BUTTON_HIGHLIGHTED, BUTTON_HIGHLIGHTED);
			alpha = 1.0;
		} else if (selectedButton != -1) {
			newFrame = CGRectMake(center.x - BUTTON_DIMISSED / 2, center.y - BUTTON_DIMISSED / 2, BUTTON_DIMISSED, BUTTON_DIMISSED);
			alpha = 0.4;
		} else {
			newFrame = CGRectMake(center.x - BUTTON_SIZE / 2, center.y - BUTTON_SIZE / 2, BUTTON_SIZE, BUTTON_SIZE);
			alpha = 1.0;
		}
		[button setFrame: newFrame];
		button.alpha = alpha;
		[button setNeedsDisplay];
	}
}

- (NSString *)selectionToType {
	switch (selectedButton) {
		case -1: return @"No selection";
		case 0: return @"100 Horses";
		case 1: return @"1 Duck";
		default: return @"Unknown";
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MMHorizontalSegue *s = (MMHorizontalSegue *)segue;
	if ([s.identifier isEqualToString:@"forward"]) {
		s.isDismiss = NO;
	} else {
		s.isDismiss = YES;
	}
    s.isLandscapeOrientation = NO;
}

@end
