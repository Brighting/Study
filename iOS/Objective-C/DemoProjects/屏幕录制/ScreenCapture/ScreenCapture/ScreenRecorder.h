//
//  ScreenRecorder.h
//  ScreenCapture
//
//  Created by Dennis Cheng on 24/7/13.
//  Copyright (c) 2013 Handsup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol ScreenRecorderDelegate <NSObject>

-(void)recordCompleted;

@end

@interface ScreenRecorder : NSObject
{
    id ParentID;
    UIView *targetView;
    NSMutableArray *imageArr;
    BOOL isVideo;
    CFAbsoluteTime startTime;
    
    //for speeding up the process
    NSDictionary *options;
}

@property (nonatomic, assign) id ParentID;

//passing a view that it needs to be captured
-(void)readyGo:(UIView *)aView;

-(void)startRecord:(NSString *)moviePath;
-(void)stopRecord;

@end
