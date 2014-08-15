//
//  MMData.h
//  Hackathon
//
//  Created by Roberto on 11/7/13.
//  Copyright (c) 2013 Medallia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MMData : UIStoryboardSegue <MFMailComposeViewControllerDelegate>
@property (nonatomic) NSMutableDictionary *data;
+ (MMData *)sharedData;
- (void) submit;
- (void) sendDataByEmailFrom: (UIViewController *)controller;
@end
