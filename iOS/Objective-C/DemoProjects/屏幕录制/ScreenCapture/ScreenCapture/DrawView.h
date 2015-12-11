//
//  DrawView.h
//  ScreenCapture
//
//  Created by Dennis Cheng on 24/7/13.
//  Copyright (c) 2013 Handsup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIImageView
{
    //for drawing curve
    CGPoint previousPoint2; //2 points behind
    CGPoint previousPoint1; //1 point behind
    CGPoint lastPoint;
	BOOL mouseSwiped;
	int mouseMoved;
}

@end
