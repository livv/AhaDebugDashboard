//
//  AhaDebugManager.h
//  superText
//
//  Created by wei on 14-1-17.
//  Copyright (c) 2014年 wmloft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AhaDebugManager : NSObject

@property (nonatomic) BOOL hidden;
@property (nonatomic, strong) NSArray * debugArray;

// this is a singleton
+ (instancetype)sharedAhaDebugManager;
- (void)initDebugArray:(NSArray *)debugArray;
- (void)showDebugView;

- (void)actionSwitch:(id)sender;
@end

@interface DebugWindow : UIWindow

@end

@interface VUISwitch : UISwitch

@property (nonatomic) NSInteger row;

@end