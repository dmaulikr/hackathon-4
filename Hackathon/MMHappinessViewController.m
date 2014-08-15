//
//  MMHappinessViewController.m
//  Hackathon
//
//  Created by Roberto on 11/7/13.
//  Copyright (c) 2013 Medallia. All rights reserved.
//

#import "MMHappinessViewController.h"
#import "MMHorizontalSegue.h"
#import "MMData.h"

#define SELECTED_ZOOM 1.5
#define TOTAL_WIDTH (203 * 3)
#define NORMAL_HEIGHT 203

@interface MMHappinessViewController () {
	UIImageView *buttons[3];
	CGFloat yCenter;
	int selectedButton;
}

@end

@implementation MMHappinessViewController

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
	for (int i = 0; i < 3; i++) {
		buttons[i] = (UIImageView *)[self.view viewWithTag:i + 1];
		yCenter = buttons[i].frame.origin.y + (buttons[i].frame.size.height / 2);
	}
}

- (void)viewWillAppear:(BOOL)animated {
	NSNumber *value = [[MMData sharedData].data objectForKey:@"OverallExperienceValue"];
	selectedButton = (value != nil ? [value intValue] : -1);
	[self layoutButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)optionClicked:(id)sender {
	selectedButton = ((UIButton *)sender).tag - 1;
	[[MMData sharedData].data setObject:[self selectionToType] forKey:@"OverallExperience"];
	[[MMData sharedData].data setObject:[NSNumber numberWithInt:selectedButton] forKey:@"OverallExperienceValue"];

	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[self layoutButtons];
	[UIView commitAnimations];
}

- (NSString *)selectionToType {
	switch (selectedButton) {
		case -1: return @"No selection";
		case 0: return @"Unhappy";
		case 1: return @"Neutral";
		case 2: return @"Happy";
		default: return @"Unknown";
	}
}

- (void)layoutButtons {
	CGFloat normalWidth = TOTAL_WIDTH / 3;
	CGFloat highlightedWidth = normalWidth * SELECTED_ZOOM;
	CGFloat highlightedHeight = NORMAL_HEIGHT * SELECTED_ZOOM;
	CGFloat remainingWidth = (TOTAL_WIDTH - highlightedWidth) / 2;
	CGFloat remainingHeight = NORMAL_HEIGHT / normalWidth * remainingWidth;
	CGRect screenRect = [[UIScreen mainScreen] bounds];

	CGFloat x = (screenRect.size.width - TOTAL_WIDTH) / 2;
	for (int i = 0; i < 3; i++) {
		CGFloat currentWidth = selectedButton == -1 ? normalWidth : (selectedButton == i ? highlightedWidth : remainingWidth);
		CGFloat currentHeight = selectedButton == -1 ? NORMAL_HEIGHT : (selectedButton == i ? highlightedHeight : remainingHeight);
		CGRect newFrame = CGRectMake(x, yCenter - (currentHeight / 2), currentWidth, currentHeight);
		buttons[i].frame = newFrame;
		buttons[i].alpha = selectedButton == -1 ? 1.0 : (selectedButton == i ? 1.0 : 0.5);
		[buttons[i] setNeedsDisplay];
		x += currentWidth;
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
