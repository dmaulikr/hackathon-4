//
//  MMHorizontalSegue.m
//  Hackathon
//
//  Created by Roberto on 11/7/13.
//  Copyright (c) 2013 Medallia. All rights reserved.
//

#import "MMHorizontalSegue.h"
#import "QuartzCore/QuartzCore.h"

@implementation MMHorizontalSegue

- (void) perform
{
    UIViewController *desViewController = (UIViewController *)self.destinationViewController;
    
    UIView *srcView = [(UIViewController *)self.sourceViewController view];
    UIView *desView = [desViewController view];
    
    desView.transform = srcView.transform;
    desView.bounds = srcView.bounds;
    
    if(self.isLandscapeOrientation)
    {
        if(self.isDismiss)
        {
            desView.center = CGPointMake(srcView.center.x, srcView.center.y  - srcView.frame.size.height);
        }
        else
        {
            desView.center = CGPointMake(srcView.center.x, srcView.center.y  + srcView.frame.size.height);
        }
    }
    else
    {
        if(self.isDismiss)
        {
            desView.center = CGPointMake(srcView.center.x - srcView.frame.size.width, srcView.center.y);
        }
        else
        {
            desView.center = CGPointMake(srcView.center.x + srcView.frame.size.width, srcView.center.y);
        }
    }
    
    
    UIWindow *mainWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [mainWindow addSubview:desView];
    
    // slide newView over oldView, then remove oldView
    [UIView animateWithDuration:0.3
                     animations:^{
                         desView.center = CGPointMake(srcView.center.x, srcView.center.y);
                         
                         if(self.isLandscapeOrientation)
                         {
                             if(self.isDismiss)
                             {
                                 srcView.center = CGPointMake(srcView.center.x, srcView.center.y + srcView.frame.size.height);
                             }
                             else
                             {
                                 srcView.center = CGPointMake(srcView.center.x, srcView.center.y - srcView.frame.size.height);
                             }
                         }
                         else
                         {
                             if(self.isDismiss)
                             {
                                 srcView.center = CGPointMake(srcView.center.x + srcView.frame.size.width, srcView.center.y);
                             }
                             else
                             {
                                 srcView.center = CGPointMake(srcView.center.x - srcView.frame.size.width, srcView.center.y);
                             }
                         }
                     }
                     completion:^(BOOL finished){
						 [self.sourceViewController presentViewController:desViewController animated:NO completion:nil];
                     }];
}

@end
