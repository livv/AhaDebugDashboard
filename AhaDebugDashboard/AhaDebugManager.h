//
//  AhaDebugManager.h
//  superText
//
//  Created by wei on 14-1-17.
//  Copyright (c) 2014年 wmloft. All rights reserved.
//

@import UIKit;

@interface AhaDebugManager : NSObject

@property (nonatomic) BOOL hidden;
@property (nonatomic, strong) NSArray * debugArray;


+ (AhaDebugManager *)sharedInstance;

+ (void)show;

- (void)actionSwitch:(id)sender;

@end

@interface AhaDebugWindow : UIWindow

@end

@interface AhaSwitch : UISwitch

@property (nonatomic) NSInteger row;

@end