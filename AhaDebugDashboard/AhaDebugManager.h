//
//  AhaDebugManager.h
//  superText
//
//  Created by wei on 14-1-17.
//  Copyright (c) 2014年 wmloft. All rights reserved.
//

#import <UIKit/UIKit.h>


UIKIT_EXTERN NSString *const AhaNotificationNavRightBtnTap;

@interface AhaDebugManager : NSObject

@property (nonatomic) BOOL hidden;
@property (nonatomic, strong) NSArray * debugArray;
@property (nonatomic, copy) NSString * logSubmissionEmail;
@property (nonatomic, copy) NSString * navRightTitle;



+ (AhaDebugManager *)sharedInstance;

+ (void)show;

- (void)actionSwitch:(id)sender;

@end


@interface AhaDebugWindow : UIWindow

@end

@interface AhaSwitch : UISwitch

@property (nonatomic) NSInteger row;

@end