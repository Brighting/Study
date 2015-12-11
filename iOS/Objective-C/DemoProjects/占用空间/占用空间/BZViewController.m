//
//  BZViewController.m
//  占用空间
//
//  Created by ZBright on 14-2-28.
//  Copyright (c) 2014年 fnst. All rights reserved.
//

#import "BZViewController.h"
#import <sys/sysctl.h>
#import <mach/mach.h>
#include <stdio.h>

#define ONEFILESIZE         10 * 1024 * 1024
@interface BZViewController ()

@end

@implementation BZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    isExcuting = NO;
    _mUsableMemLabel.text = [NSString stringWithFormat:@"%lld",[self systemFreeSize]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(UIButton *)sender {
    isExcuting = YES;
    mExpectLeaveSize =  [_mLeavesMem.text longLongValue];
    [self writeFile];
}

- (IBAction)stop:(UIButton *)sender {
    isExcuting = NO;
}

- (IBAction)startRelease:(UIButton *)sender {
    
    [self deleteFile];
}
-(BOOL)deleteFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docDir = [paths objectAtIndex:0];
    NSString *fileDirectory = [docDir stringByAppendingPathComponent:@"tempFile"];
    if (![fileManager removeItemAtPath:fileDirectory error:nil]) {
        return NO;
    }
    _mUsableMemLabel.text = [NSString stringWithFormat:@"%lld",[self systemFreeSize]];
    return YES;
}
-(BOOL)writeFile
{
    char *fileContents = malloc(ONEFILESIZE);
    NSData *data = [NSData dataWithBytes:fileContents length:ONEFILESIZE];
    free(fileContents);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docDir = [paths objectAtIndex:0];
    NSString *fileDirectory = [docDir stringByAppendingPathComponent:@"tempFile"];
    if (![fileManager createDirectoryAtPath:fileDirectory withIntermediateDirectories:YES attributes:nil error:nil]) {
        return NO;
    }
    int count = 1;
    long long freeSize = [self systemFreeSize];
    while (freeSize - mExpectLeaveSize > mExpectLeaveSize && isExcuting) {
        NSString *filePrefix = [NSString stringWithFormat:@"%d",count];
        if (![self writeToDirectory:fileDirectory withData:data filePrefix:filePrefix]) {
            return NO;
        }
        count ++;
        freeSize = [self systemFreeSize];
        _mUsableMemLabel.text = [NSString stringWithFormat:@"%lld",freeSize];
    }
    if (!isExcuting && (freeSize > mExpectLeaveSize)) {
        return YES;
    }
    NSUInteger lastFreeSize = (NSUInteger) (freeSize - mExpectLeaveSize);
    char *fileContentsLast = malloc(lastFreeSize);
    NSData *dataLast = [NSData dataWithBytes:fileContents length:lastFreeSize];
    free(fileContentsLast);
    NSString *filePrefix = [NSString stringWithFormat:@"%d",count];
    if (![self writeToDirectory:fileDirectory withData:dataLast filePrefix:filePrefix]) {
        return NO;
    }
    freeSize = [self systemFreeSize];
    _mUsableMemLabel.text = [NSString stringWithFormat:@"%lld",freeSize];
    return YES;
}
-(BOOL)writeToDirectory:(NSString *)_directory  withData:(NSData *)_data filePrefix:(NSString *)_filePrefix
{
    time_t curTime ;
    curTime = time(&curTime);
    struct tm * date = localtime(&curTime);
    NSString * fileName = [NSString stringWithFormat:@"tempFile%@_%04d%02d%02d%02d%02d%02d",_filePrefix,
                           (date->tm_year + 1900)
                           ,(date->tm_mon + 1)
                           ,date->tm_mday
                           ,date->tm_hour
                           ,date->tm_min
                           ,date->tm_sec];
    NSString * filePath = [_directory stringByAppendingPathComponent:fileName];
    if (![self writeToFile:filePath contents:_data]) {
        return NO;
    }
    return YES;
}
+ (BOOL)isMemoryUsePossible:(double)needSize
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS)
    {
        return NO;
    }
    
    // when memory avivable is less than 20*1024*1024， application may receive memory warning.
    return (vm_page_size *vmStats.free_count) - 20*1024*1024 > needSize;
}
-(long long)systemFreeSize
{
    long long  totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if(error)
    {
        return NO;
    }
    NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
    totalFreeSpace = [freeFileSystemSizeInBytes longLongValue];
    return totalFreeSpace;
}
-(BOOL)writeToFile:(NSString *)filePath contents:(NSData *)data
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager createFileAtPath:filePath contents:data attributes:nil]) {
        return NO;
    }
    return YES;
}
@end
