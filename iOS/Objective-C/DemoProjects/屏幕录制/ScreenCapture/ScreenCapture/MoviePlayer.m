//
//  MoviePlayer.m
//  aurioTouch
//
//  Created by Dennis Cheng on 02/12/2011.
//  Copyright (c) 2011 Comtrad Trading Ltd. All rights reserved.
//

#import "MoviePlayer.h"

#define MainFrame [[UIScreen mainScreen] applicationFrame]
#define MainFrameLandscape CGRectMake(0.0f, 0.0f, MainFrame.size.height, MainFrame.size.width)

#define PI 3.14159265

@interface MoviePlayer ()

-(void)readyInit;

@end

@implementation MoviePlayer

@synthesize ParentID;

- (id)init
{
	if (self = [super init])
	{
        isMovieReady = NO;
        isMoviePlaying = NO;
        isReplay = NO;
        isMovieEnd = NO;
		[self readyInit];
	}
	return self;
}

-(BOOL)preloadMovie:(NSString *)movieName
{
    BOOL isSuccess = NO;
    if (!isMovieReady)
    {
        isMovieReady = YES;
        NSArray *array = [movieName componentsSeparatedByString:@"."];
        if ([array count]==2)
        {
            
            NSString *MediaPath = [[NSBundle mainBundle] pathForResource:[array objectAtIndex:0] ofType:[array objectAtIndex:1]];
            
            if([[NSFileManager defaultManager] fileExistsAtPath:MediaPath])
            {
                printf("MediaPath is exist!\n");
                isSuccess = YES;
            }
            else
            {
                NSLog(@"MediaPath (%@)is not exist !!!\n", MediaPath);
            }
            
            if (isSuccess)
            {
                myMovie = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:MediaPath]];
                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:@selector(myMovieFinishedCallback:)
                                                             name:MPMoviePlayerPlaybackDidFinishNotification
                                                           object:myMovie];
                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:@selector(myMoviePreloadDidFinishCallback:)
                                                             name:MPMoviePlayerLoadStateDidChangeNotification
                                                           object:myMovie];
                [myMovie prepareToPlay];
            }
        }
    }
    return isSuccess;
}

-(BOOL)preloadMovieWithFullPath:(NSString *)MediaPath
{
    BOOL isSuccess = NO;
    if (!isMovieReady)
    {
        isMovieReady = YES;
        if([[NSFileManager defaultManager] fileExistsAtPath:MediaPath])
        {
            printf("MediaPath is exist!\n");
            isSuccess = YES;
        }
        else
        {
            NSLog(@"MediaPath (%@)is not exist !!!\n", MediaPath);
        }
        
        if (isSuccess)
        {
            myMovie = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:MediaPath]];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(myMovieFinishedCallback:)
                                                         name:MPMoviePlayerPlaybackDidFinishNotification
                                                       object:myMovie];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(myMoviePreloadDidFinishCallback:)
                                                         name:MPMoviePlayerLoadStateDidChangeNotification
                                                       object:myMovie];
            [myMovie prepareToPlay];
        }
    }
    return isSuccess;
}


-(void)setupMovie
{
    if (!isReplay)
    {
        isReplay = YES;
        myMovie.controlStyle = MPMovieControlStyleDefault;
        myMovie.view.frame = MainFrame;
        /*
        myMovie.view.frame = MainFrameLandscape;
        myMovie.view.center = CGPointMake(MainFrame.size.width/2, MainFrame.size.height/2);
        CGAffineTransform transform = CGAffineTransformMakeRotation(PI/2);
        [myMovie.view setTransform:transform];
         */
        [[[[UIApplication sharedApplication] delegate] window] addSubview:myMovie.view];
    }
}

-(BOOL)playMovie
{
    BOOL isSuccess = NO;
    if (isMovieReady)
    {
        if (!isMoviePlaying)
        {
            isSuccess = YES;
            isMoviePlaying = YES;
            [self setupMovie];
            [myMovie play];
            isMovieEnd = NO;
        }
    }
    return isSuccess;
}

-(BOOL)pauseMovie
{
    BOOL isSuccess = NO;
    if (isMoviePlaying)
    {
        isSuccess = YES;
        [myMovie pause];
    }
    return isSuccess;
}

-(BOOL)stopMovie
{
    BOOL isSuccess = NO;
    if (isMoviePlaying)
    {
        isSuccess = YES;
        isMoviePlaying = NO;
        [myMovie stop];
    }
    return isSuccess;
}

-(BOOL)removeMovie
{
    BOOL isSuccess = NO;
    if (isMovieReady)
    {
        isSuccess = YES;
        [self stopMovie];
        isMovieReady = NO;
        isReplay = NO;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:myMovie];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:myMovie];
        [myMovie.view removeFromSuperview];
        [myMovie release];
        myMovie = nil;
    }
    return isSuccess;
}

-(void)renewMovie:(NSString *)movieName
{
    [self removeMovie];
    [self preloadMovie:movieName];
}

/////////////////////////////////////////////////////////////////////
#pragma mark - For MPMoviePlayer Notification
/////////////////////////////////////////////////////////////////////
-(void)myMovieFinishedCallback:(NSNotification*)aNotification
{
    isMoviePlaying = NO;
	isMovieEnd = YES;
    if ([ParentID respondsToSelector:@selector(myMovieFinishedCallback)])
    {
        [ParentID myMovieFinishedCallback];
    }
}

-(void)myMoviePreloadDidFinishCallback:(NSNotification*)aNotification
{
    printf("myMoviePreloadDidFinishCallback\n");
    
    if (!isMoviePlaying)
    {
        [myMovie pause];
    }
	if (isMovieEnd)
	{
		[myMovie stop];
	}
    if ([ParentID respondsToSelector:@selector(myMoviePreloadDidFinishCallback)])
    {
        [ParentID myMoviePreloadDidFinishCallback];
    }
}


-(void)readyGo
{
}

-(void)readyInit
{
}

-(void)dealloc
{
	printf("dealloc in %s\n", [[[self class] description] UTF8String]);
	[super dealloc];
}

@end
