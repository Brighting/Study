//
//  ViewController.m
//  B
//
//  Created by yangjw  on 13-9-12.
//  Copyright (c) 2013年 yangjw . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)A:(id)sender
{
	NSString *str = @"nav://com.b.nav?viewId=%@";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:str, @"letters"]];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)B:(id)sender
{
	NSString *str = @"nav://com.b.nav?viewId=%@";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:str, @"numbers"]];
    [[UIApplication sharedApplication] openURL:url];
}
@end
