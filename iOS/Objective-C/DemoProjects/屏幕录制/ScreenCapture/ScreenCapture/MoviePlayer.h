//
//  MoviePlayer.h
//  aurioTouch
//
//  Created by Dennis Cheng on 02/12/2011.
//  Copyright (c) 2011 Comtrad Trading Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@protocol MoviePlayerDelegate <NSObject>

-(void)myMovieFinishedCallback;
-(void)myMoviePreloadDidFinishCallback;

@end

@interface MoviePlayer : NSObject
{
    id ParentID;
    
    MPMoviePlayerController* myMovie;
    
    BOOL isMovieReady;
    BOOL isMoviePlaying;
    BOOL isReplay;
    
    //for control the movie bug
	BOOL isMovieEnd;
}

@property (nonatomic, assign) id ParentID;

-(void)readyGo;

-(BOOL)preloadMovie:(NSString *)movieName;
-(BOOL)preloadMovieWithFullPath:(NSString *)MediaPath;
-(void)setupMovie;
-(BOOL)playMovie;
-(BOOL)pauseMovie;
-(BOOL)stopMovie;
-(BOOL)removeMovie;
-(void)renewMovie:(NSString *)movieName;

@end
