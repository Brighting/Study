//
//  OneViewController.m
//  A
//
//  Created by yangjw  on 13-9-12.
//  Copyright (c) 2013年 yangjw . All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
	NSString *str = @"test://com.a.test?viewId=%@";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:str, @"letters"]];
    [[UIApplication sharedApplication] openURL:url];
}
- (void)dealloc {
	[_testLabel release];
	[super dealloc];
}
@end
