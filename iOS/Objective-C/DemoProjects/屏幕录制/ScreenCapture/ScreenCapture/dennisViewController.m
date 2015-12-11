//
//  dennisViewController.m
//  ScreenCapture
//
//  Created by Dennis Cheng on 24/7/13.
//  Copyright (c) 2013 Handsup. All rights reserved.
//

#import "dennisViewController.h"
#import "DrawView.h"
#import "ScreenRecorder.h"
#import "MoviePlayer.h"

#define MainFrame [[UIScreen mainScreen] applicationFrame]
#define MainFrameLandscape CGRectMake(0.0f, 0.0f, MainFrame.size.height, MainFrame.size.width)
#define DOCSFOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"]
#define VideoPath [DOCSFOLDER stringByAppendingPathComponent:@"test.mp4"]


@interface dennisViewController ()

-(void)readyInit;

@end

@implementation dennisViewController

//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - For ScreenRecorderDelegate
//////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)recordCompleted
{
    printf("ScreenRecorderDelegate recordCompleted\n");
    /*
    [self.view addSubview:movieShow];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:VideoPath]];
    [movieShow loadRequest:request];
    */
    [myMoviePlayer preloadMovieWithFullPath:VideoPath];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - For MoviePlayerDelegate
//////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)myMovieFinishedCallback
{
    printf("MoviePlayerDelegate myMovieFinishedCallback\n");
    [myMoviePlayer removeMovie];
}

-(void)myMoviePreloadDidFinishCallback
{
    printf("MoviePlayerDelegate myMoviePreloadDidFinishCallback\n");
    if (!isMovieLoaded)
    {
        isMovieLoaded = YES;
        [myMoviePlayer playMovie];
    }
}

-(void)delayStop
{
    printf("delayStop\n");
    dispatch_async(dispatch_get_main_queue(), ^{
        [myScreenRecorder performSelectorOnMainThread:@selector(stopRecord) withObject:nil waitUntilDone:YES];
    });
}

-(void)readyGo
{
	if (!isReload)
	{
        NSLog(@"MainFrame %@", NSStringFromCGRect(MainFrame));
        NSLog(@"self.view.frame %@", NSStringFromCGRect(self.view.frame));
        NSLog(@"myDrawView.frame %@", NSStringFromCGRect(myDrawView.frame));
        
        //for myScreenRecorder setup
        myScreenRecorder.ParentID = self;
        [myScreenRecorder readyGo:self.view];
        [myScreenRecorder startRecord:VideoPath];
        
        [self performSelector:@selector(delayStop) withObject:nil afterDelay:10.0f];
        
        //for myMoviePlayer setup
        myMoviePlayer.ParentID = self;
        [myMoviePlayer readyGo];
	}
    [self.view addSubview:myDrawView];
}

-(void)readyInit
{
    myDrawView = [[DrawView alloc] initWithFrame:self.view.bounds];
    myScreenRecorder = [[ScreenRecorder alloc] init];
    myMoviePlayer = [[MoviePlayer alloc] init];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	// Add a background
	UIImageView *imgView = [[[UIImageView alloc] initWithFrame:MainFrame] autorelease];
	imgView.image = [UIImage imageNamed:@"bg.png"]; //The image is no here, it doesn't matter.
	imgView.userInteractionEnabled = YES;
    imgView.backgroundColor = [UIColor whiteColor];
	self.view = imgView;
    [self readyInit];
	[self readyGo];
	isReload = YES;
}

/*
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
 */

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	printf("view will app in %s\n", [[[self class] description] UTF8String]);
}

-(void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	printf("view will disapp in %s\n", [[[self class] description] UTF8String]);
}

-(void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	printf("view did app in %s\n", [[[self class] description] UTF8String]);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
	printf("view did disapp in %s\n", [[[self class] description] UTF8String]);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	printf("dealloc in %s\n", [[[self class] description] UTF8String]);
    [myDrawView release];
    myScreenRecorder.ParentID = nil;
    [myScreenRecorder release];
    [myMoviePlayer release];
    [super dealloc];
}


@end
