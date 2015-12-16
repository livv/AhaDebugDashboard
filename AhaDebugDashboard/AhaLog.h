//
//  AhaLog.h
//  AhaDebugDemo
//
//  Created by wei on 15/12/16.
//  Copyright © 2015年 livv. All rights reserved.
//

@import UIKit;


typedef NS_ENUM(NSInteger, AhaLogLevel) {
    AhaLogLevelNone = 0,
    AhaLogLevelCrash,
    AhaLogLevelError,
    AhaLogLevelWarning,
    AhaLogLevelInfo,
    AhaLogLevelDefalut
};

@protocol AhaLogDelegate <NSObject>

- (void)handleAhaLogCommand:(NSString *)command;

@end



@interface AhaLog : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL saveLogToDisk;
@property (nonatomic, assign) AhaLogLevel logLevel;
@property (nonatomic, assign) NSUInteger maxLogCount;

@property (nonatomic, weak) id <AhaLogDelegate> delegate;



+ (AhaLog *)sharedInstance;

+ (void)log:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)info:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)warn:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)error:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)crash:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

+ (void)log:(NSString *)format args:(va_list)argList;
+ (void)info:(NSString *)format args:(va_list)argList;
+ (void)warn:(NSString *)format args:(va_list)argList;
+ (void)error:(NSString *)format args:(va_list)argList;
+ (void)crash:(NSString *)format args:(va_list)argList;

+ (void)clear;

@end
