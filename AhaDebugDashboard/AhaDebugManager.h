//
//  AhaDebugManager.h
//  superText
//
//  Created by wei on 14-1-17.
//  Copyright (c) 2014年 wmloft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AhaDebugManager : NSObject

@property (nonatomic) BOOL hidden;
@property (nonatomic, strong) NSArray * debugArray;
@property (nonatomic, copy) NSString * logSubmissionEmail;


+ (AhaDebugManager *)sharedInstance;

+ (void)show;

- (void)actionSwitch:(id)sender;

@end


@interface AhaDebugWindow : UIWindow

@end

@interface AhaSwitch : UISwitch

@property (nonatomic) NSInteger row;

@end