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
+ (void)logInfo:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)logWarn:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)logError:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)logCrash:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

+ (void)log:(NSString *)format args:(va_list)argList;
+ (void)logInfo:(NSString *)format args:(va_list)argList;
+ (void)logWarn:(NSString *)format args:(va_list)argList;
+ (void)logError:(NSString *)format args:(va_list)argList;
+ (void)logCrash:(NSString *)format args:(va_list)argList;

+ (void)clear;

+ (NSString *)logStr;

@end
