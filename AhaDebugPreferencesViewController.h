//
//  AhaDebugPreferencesViewController.h
//  superText
//
//  Created by wei on 14-1-17.
//  Copyright (c) 2014年 wmloft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AhaDebugManager.h"

@interface AhaDebugPreferencesViewController : UITableViewController

@property (nonatomic) BOOL modalAnimated;

@property (nonatomic, retain) AhaDebugManager * debugManager;

- (id)init:(AhaDebugManager *)newDebugManager;


@end
