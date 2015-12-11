//
//  BZViewController.h
//  占用空间
//
//  Created by ZBright on 14-2-28.
//  Copyright (c) 2014年 fnst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BZViewController : UIViewController
{
    long long  mExpectLeaveSize;
    BOOL       isExcuting;
}
@property (strong, nonatomic) IBOutlet UILabel *mUsableMemLabel;
@property (strong, nonatomic) IBOutlet UITextField *mLeavesMem;
- (IBAction)start:(UIButton *)sender;
- (IBAction)stop:(UIButton *)sender;
- (IBAction)startRelease:(UIButton *)sender;

@end
