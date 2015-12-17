//
//  AhaLog.m
//  AhaDebugDemo
//
//  Created by wei on 15/12/16.
//  Copyright © 2015年 livv. All rights reserved.
//

#import "AhaLog.h"
#import "AhaLogCell.h"

@interface AhaLog ()

@property (nonatomic, strong) NSMutableArray *logs;

@end

@implementation AhaLog

+ (void)load {
    
    [AhaLog performSelectorOnMainThread:@selector(sharedInstance) withObject:nil waitUntilDone:NO];
}

#pragma mark Public methods

+ (AhaLog *)sharedInstance {
    
    static AhaLog * instance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        instance = [[AhaLog alloc] init];
    });
    
    return instance;
}


+ (void)log:(NSString *)format, ... {
    
    va_list argList;
    va_start(argList, format);
    [self log:format args:argList];
    va_end(argList);
}

+ (void)info:(NSString *)format, ... {
    
    va_list argList;
    va_start(argList, format);
    [self info:format args:argList];
    va_end(argList);
}

+ (void)warn:(NSString *)format, ... {
    
    va_list argList;
    va_start(argList, format);
    [self warn:format args:argList];
    va_end(argList);
}

+ (void)error:(NSString *)format, ... {
    
    va_list argList;
    va_start(argList, format);
    [self error:format args:argList];
    va_end(argList);
}

+ (void)crash:(NSString *)format, ... {
    
    va_list argList;
    va_start(argList, format);
    [self crash:format args:argList];
    va_end(argList);
}

+ (void)log:(NSString *)format args:(va_list)argList {
    
    if ([self sharedInstance].logLevel > AhaLogLevelNone)
    {
        NSString *message = [(NSString *)[NSString alloc] initWithFormat:format arguments:argList];
#ifdef DEBUG
        NSLog(@"%@", message);
#endif
        if ([self sharedInstance].enabled)
        {
            if ([NSThread currentThread] == [NSThread mainThread])
            {
                [[self sharedInstance] logOnMainThread:message];
            }
            else
            {
                [[self sharedInstance] performSelectorOnMainThread:@selector(logOnMainThread:)
                                                       withObject:message
                                                     waitUntilDone:NO];
            }
        }
    }
}

+ (void)info:(NSString *)format args:(va_list)argList {
    
    if ([self sharedInstance].logLevel >= AhaLogLevelInfo) {
        
        [self log:[@"INFO: " stringByAppendingString:format] args:argList];
    }
}

+ (void)warn:(NSString *)format args:(va_list)argList {
    
    if ([self sharedInstance].logLevel >= AhaLogLevelWarning) {
        
        [self log:[@"WARNING: " stringByAppendingString:format] args:argList];
    }
}

+ (void)error:(NSString *)format args:(va_list)argList {
    
    if ([self sharedInstance].logLevel >= AhaLogLevelError)
    {
        [self log:[@"ERROR: " stringByAppendingString:format] args:argList];
    }
}

+ (void)crash:(NSString *)format args:(va_list)argList {
    
    if ([self sharedInstance].logLevel >= AhaLogLevelCrash) {
        
        [self log:[@"CRASH: " stringByAppendingString:format] args:argList];
    }
}

+ (void)clear {
    
    [[AhaLog sharedInstance] resetLog];
}

+ (NSString *)logStr {
    
    return [[self sharedInstance].logs componentsJoinedByString:@"\n"];
}

#pragma mark - private

- (id)init {
    
    if ((self = [super init])) {
        _enabled = YES;
        _logLevel = AhaLogLevelDefalut;
        _saveLogToDisk = YES;
        _maxLogCount = 1000;
        _delegate = nil;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(saveSettings)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(saveSettings)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
    return self;
}

- (void)resetLog {
    
    [self.logs removeAllObjects];
}

- (void)saveSettings {
    
    if (_saveLogToDisk) {
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)logOnMainThread:(NSString *)message {
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[NSDate date] forKey:@"createDate"];
    
    if ([message hasPrefix:@"CRASH: "]) {
        [dict setObject:@(AhaLogLevelCrash) forKey:@"logLevel"];
        [dict setObject:[message stringByReplacingOccurrencesOfString:@"CRASH: " withString:@""] forKey:@"content"];
    } else if ([message hasPrefix:@"ERROR: "]) {
        [dict setObject:@(AhaLogLevelError) forKey:@"logLevel"];
        [dict setObject:[message stringByReplacingOccurrencesOfString:@"ERROR: " withString:@""] forKey:@"content"];
    } else if ([message hasPrefix:@"WARNING: "]) {
        [dict setObject:@(AhaLogLevelWarning) forKey:@"logLevel"];
        [dict setObject:[message stringByReplacingOccurrencesOfString:@"WARNING: " withString:@""] forKey:@"content"];
    } else if ([message hasPrefix:@"INFO: "]) {
        [dict setObject:@(AhaLogLevelInfo) forKey:@"logLevel"];
        [dict setObject:[message stringByReplacingOccurrencesOfString:@"INFO: " withString:@""] forKey:@"content"];
    } else {
        [dict setObject:@(AhaLogLevelDefalut) forKey:@"logLevel"];
        [dict setObject:message forKey:@"content"];
    }
    
    [self.logs insertObject:dict atIndex:0];
    
    
    if ([self.logs count] > _maxLogCount) {
        
        [self.logs lastObject];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:self.logs forKey:@"AhaLogs"];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.logs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AhaLogCell * cell = [tableView dequeueReusableCellWithIdentifier:[AhaLogCell cellIdentifier] forIndexPath:indexPath];
    [cell config:self.logs[indexPath.row]];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [AhaLogCell cellHeightWithtDict:self.logs[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIPasteboard * pastedBoard = [UIPasteboard generalPasteboard];
    
    NSDictionary * item = self.logs[indexPath.row];
    pastedBoard.string = [item objectForKey:@"content"];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil
                                                     message:@"复制到剪贴板"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark - getters

- (NSMutableArray *)logs {
    if (!_logs) {
        _logs = [[NSMutableArray alloc] initWithCapacity:_maxLogCount];
        [_logs addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"AhaLogs"]];
    }
    return _logs;
}

@end
