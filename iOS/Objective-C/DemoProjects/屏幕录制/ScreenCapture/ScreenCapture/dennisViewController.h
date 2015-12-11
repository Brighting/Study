//
//  dennisViewController.h
//  ScreenCapture
//
//  Created by Dennis Cheng on 24/7/13.
//  Copyright (c) 2013 Handsup. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrawView;
@class ScreenRecorder;
@class MoviePlayer;

@interface dennisViewController : UIViewController
{
    DrawView *myDrawView;
    ScreenRecorder *myScreenRecorder;
    MoviePlayer *myMoviePlayer;
    BOOL isMovieLoaded;
    
	BOOL isReload;
}

@end
