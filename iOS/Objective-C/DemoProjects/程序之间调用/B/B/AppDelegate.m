//
//  AppDelegate.m
//  B
//
//  Created by yangjw  on 13-9-12.
//  Copyright (c) 2013年 yangjw . All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "ThreeViewController.h"

@implementation AppDelegate

- (void)dealloc
{
	[_window release];
	[_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
	self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([[url host] isEqualToString:@"com.a.test"])
	{
/*
 外部调用程序发来的数据为
 test://com.a.test?viewId=letters
 注册的URL Types :   
				URL Scheme     ::test
				
				URL identifier :: com.a.test
  配置info.plist 文件
 
 
 */
		/*
		 【url host】 : URL identifier
		  [url  query]:  ?后面的数据 里面可以是接口等等
		 */
		NSLog(@"------%@----%@",[url host],[url query]);
        NSString *viewId = [[url query] substringFromIndex:[[url query] rangeOfString:@"viewId="].location + 7];
        if ([viewId isEqualToString:@"letters"]){
			ThreeViewController *three = [[ThreeViewController alloc] init];
			[self.viewController presentViewController:three animated:YES completion:nil];
        }
		else
		{

        }
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
