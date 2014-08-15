//
//  MMAppDelegate.m
//  Hackathon
//
//  Created by Roberto on 11/7/13.
//  Copyright (c) 2013 Medallia. All rights reserved.
//

#import "MMAppDelegate.h"
#import <Parse/Parse.h>

@implementation MMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[Parse setApplicationId:@"PLEASE UPDATE"
				  clientKey:@"PLEASE UPDATE"];
	[PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    return YES;
}

@end
