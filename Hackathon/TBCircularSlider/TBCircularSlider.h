//
//  TBCircularSlider.h
//  TB_CircularSlider
//
//  Created by Yari Dareglia on 1/12/13.
//  Copyright (c) 2013 Yari Dareglia. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Parameters **/
#define TB_SLIDER_SIZE 420                          //The width and the heigth of the slider
#define TB_BACKGROUND_WIDTH 40                      //The width of the dark background
#define TB_LINE_WIDTH 50                            //The width of the active area (the gradient) and the width of the handle
#define TB_FONTSIZE 120                              //The size of the textfield font
#define TB_SUBFONTSIZE 40
#define TB_FONTFAMILY @"HelveticaNeue-Bold"  //The font family of the textfield font
#define TB_SUBFONTFAMILY @"HelveticaNeue-Bold"
#define TB_LINE_COLOR [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]

@interface TBCircularSlider : UIControl
@property (nonatomic,assign) int angle;
@property (nonatomic,assign) int value;
@end
