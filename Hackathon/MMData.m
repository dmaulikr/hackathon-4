//
//  MMData.m
//  Hackathon
//
//  Created by Roberto on 11/7/13.
//  Copyright (c) 2013 Medallia. All rights reserved.
//

#import "MMData.h"
#import <Parse/Parse.h>

@implementation MMData

+ (MMData *)sharedData {
	static MMData *data;
	if (!data) {
		data = [[super allocWithZone:nil] init];
		data.data = [NSMutableDictionary dictionary];
	}
	return data;
}

- (void) clear {
	self.data = [NSMutableDictionary dictionary];
}

- (void) submit {
	PFObject *testObject = [PFObject objectWithClassName:@"Response"];
	NSLog(@"Submitting");
	for (NSString *key in self.data) {
		NSObject *data = [self.data objectForKey:key];
		NSLog(@"Key: %@ - value: %@", key, data);
		[testObject setObject:data forKey:key];
	}
	[testObject save];
	[self clear];
}

- (void) sendDataByEmailFrom: (UIViewController *)controller {
	PFQuery *query = [PFQuery queryWithClassName:@"Response"];
	[query setLimit: 1000];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (!error) {
			// The find succeeded. Add the returned objects to allObjects
			[self sendData:objects from:controller];
		} else {
			// Log details of the failure
			NSLog(@"Error: %@ %@", error, [error userInfo]);
		}
	}];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
	[controller dismissViewControllerAnimated:YES completion:NO];
}

- (void) sendData: (NSArray *)data from: (UIViewController *)sourceController {
	if (![MFMailComposeViewController canSendMail]) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bad boy!"
															message:@"You don't have your email configured. If you don't configure your email I can't send an email."
														   delegate:self
												  cancelButtonTitle:@"I'm sorry I won't do it again"
												  otherButtonTitles: nil];
		[alertView show];
		return;
	}
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	if (controller == nil) {
		return;
	}
	controller.mailComposeDelegate = self;
	[controller setSubject:@"Hackathon results"];
	NSMutableString *body = [NSMutableString stringWithFormat:@"<h1>%lu Responses</h1>", (unsigned long)data.count];
	if (data.count > 0) {
		[body appendString:@"<style type='text/css'> #table-6 { width: 100%; border: 1px solid #B0B0B0; } #table-6 tbody { margin: 0; padding: 0; border: 0; outline: 0; font-size: 100%;"];
		[body appendString:@" vertical-align: baseline; background: transparent; } #table-6 thead { text-align: left; } #table-6 thead th {	background: -moz-linear-gradient(top, #F0F0F0 0, #DBDBDB 100%);"];
		[body appendString:@" background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #F0F0F0), color-stop(100%, #DBDBDB)); "];
		[body appendString:@" filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#F0F0F0', endColorstr='#DBDBDB', GradientType=0); border: 1px solid #B0B0B0;"];
		[body appendString:@" color: #444; font-size: 16px; font-weight: bold; padding: 3px 10px; } #table-6 td { padding: 3px 10px; } #table-6 tr:nth-child(even) { background: #F2F2F2;"];
		[body appendString:@" } </style>"];
		[body appendString:@"<table id='table-6'><thead><tr><th>Years of Experience</th><th>Score of the event</th><th>Challenge type</th></tr></thead>"];
		for (NSObject *datum in data) {
			PFObject *object = (PFObject *)datum;
			[body appendFormat:@"<tr><td>%@</td><td>%@</td><td>%@</td></tr>",
			 [object objectForKey:@"YearsOfExperience"],
			 [object objectForKey:@"OverallExperience"],
			 [object objectForKey:@"ChallengeType"]];
		}
		[body appendString:@"</table>"];
	}
	[controller setMessageBody:body isHTML:YES];
	[sourceController presentViewController:controller animated:YES completion:NO];
}

@end
