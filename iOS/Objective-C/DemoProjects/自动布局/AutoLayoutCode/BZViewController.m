//
//  BZViewController.m
//  AutoLayoutCode
//
//  Created by Brightz on 14-2-10.
//  Copyright (c) 2014年 com.cn.fnst. All rights reserved.
//

#import "BZViewController.h"
#import "BZView.h"
@interface BZViewController ()

@end

@implementation BZViewController

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
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    BZView *view1 = [BZView new];
    view1.backgroundColor = [UIColor redColor];
    view1.frame = CGRectZero;
    BZView *view2 = [BZView new];
    view2.backgroundColor = [UIColor blueColor];
    view2.frame = CGRectZero;
    BZView *view3 = [BZView new];
    view3.backgroundColor = [UIColor grayColor];
    view3.frame = CGRectZero;
    [self.view addSubview:view1];
    view1.translatesAutoresizingMaskIntoConstraints = NO;
//    [view1 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view1(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view1)]];
//    [view1 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view1(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view1)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view1]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view1)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[view1]-100-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view1)]];
    
    

    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
