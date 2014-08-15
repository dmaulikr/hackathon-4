//
//  MMViewController.m
//  Hackathon
//
//  Created by Roberto on 11/7/13.
//  Copyright (c) 2013 Medallia. All rights reserved.
//

#import "MMViewController.h"
#import "TBCircularSlider.h"
#import "MMHorizontalSegue.h"
#import "MMData.h"
#import "MMResultsViewController.h"

@interface MMViewController () {
	TBCircularSlider *_slider;
	int _counter;
	UINavigationController *_navigationController;
}
@property (weak, nonatomic) IBOutlet UIButton *selectionButton;
@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	   
    //Create the Circular Slider
	CGRect screenRect = [[UIScreen mainScreen] bounds];
    _slider = [[TBCircularSlider alloc] initWithFrame:CGRectMake(
		(screenRect.size.width - TB_SLIDER_SIZE) / 2,
		(screenRect.size.height - TB_SLIDER_SIZE) / 2 + 50,
		TB_SLIDER_SIZE, TB_SLIDER_SIZE)];
    //Define Target-Action behaviour
    [_slider addTarget:self action:@selector(newValue:) forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:_slider];
}

- (void)viewWillAppear:(BOOL)animated {
	_slider.value = [((NSString *)[[MMData sharedData].data objectForKey:@"YearsOfExperience"]) intValue];
	_counter = 0;
}

- (void)newValue:(TBCircularSlider *)value {
	[[MMData sharedData].data setObject:[NSNumber numberWithInt:value.value] forKey:@"YearsOfExperience"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)medalliaClicked:(id)sender {
	if (++_counter == 4) {
		MMResultsViewController *resultsViewController = [[MMResultsViewController alloc] initWithStyle:UITableViewStylePlain];
		resultsViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
		resultsViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(send)];
		resultsViewController.navigationItem.title = @"Results";
		_navigationController = [[UINavigationController alloc] initWithRootViewController:resultsViewController];
		[self presentViewController:_navigationController animated:YES completion:NO];
		_counter = 0;
	}
}

- (void) dismiss {
	[_navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) send {
	[[MMData sharedData] sendDataByEmailFrom:_navigationController];
}

@end
