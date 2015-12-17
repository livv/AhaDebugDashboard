//
//  AhaDebugManager.m
//  superText
//
//  Created by wei on 14-1-17.
//  Copyright (c) 2014年 wmloft. All rights reserved.
//

#import "AhaDebugManager.h"
#import "AhaDebugViewController.h"

@interface AhaDebugManager () {

}

@property (nonatomic, strong) UINavigationController * navController;


@end

@implementation AhaDebugManager


+ (AhaDebugManager *)sharedInstance {
    
    static AhaDebugManager * sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [AhaDebugManager alloc];
        sharedInstance = [sharedInstance init];
    });
    
    return sharedInstance;
}

+ (void)show {
    [[AhaDebugManager sharedInstance] showDebugView];
}

#pragma mark -

- (id)init {
    self = [super init];
    if (self) {
        _hidden = YES;
    }
    return self;
}

- (void)setDebugArray:(NSArray *)debugArray {
    _debugArray = debugArray;
    for (NSDictionary * dict in _debugArray) {
        id value = [dict objectForKey:@"value"];
        NSString * key = [dict objectForKey:@"key"];
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{key: value}];
    }
}


- (void)showDebugView {
    if (!_hidden) {
        return;
    }
    _hidden = NO;
    
    UIViewController * parentViewController = nil;
    
    UIWindow * visibleWindow = [self findVisibleWindow];
    
    if (parentViewController == nil && [UIWindow instancesRespondToSelector:@selector(rootViewController)]) {
        parentViewController = [visibleWindow rootViewController];
    }
    
    // use topmost modal view
    while (parentViewController.presentedViewController) {
        parentViewController = parentViewController.presentedViewController;
    }

    self.navController = nil;

    
    AhaDebugViewController * debugVC = [[AhaDebugViewController alloc] init:self];
    self.navController = [[UINavigationController alloc] initWithRootViewController:debugVC];
    
    if (parentViewController) {
//        if ([navController_ respondsToSelector:@selector(setModalTransitionStyle:)]) {
//            navController_.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        }
//        
//        // page sheet for the iPad
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && [navController_ respondsToSelector:@selector(setModalPresentationStyle:)]) {
//            navController_.modalPresentationStyle = UIModalPresentationFormSheet;
//        }
        [parentViewController presentViewController:self.navController
                                           animated:YES
                                         completion:^(void){
                                         }];
    } else {
        NSLog(@"No rootViewController found, using UIWindow-approach: %@", visibleWindow);
        [visibleWindow addSubview:self.navController.view];
	}
}

- (UIWindow *)findVisibleWindow {
    UIWindow *visibleWindow = nil;
    
    // if the rootViewController property (available >= iOS 4.0) of the main window is set, we present the modal view controller on top of the rootViewController
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (!window.hidden && !visibleWindow) {
            visibleWindow = window;
        }
        if ([UIWindow instancesRespondToSelector:@selector(rootViewController)]) {
            if ([window rootViewController]) {
                visibleWindow = window;
                NSLog(@"UIWindow with rootViewController found: %@", visibleWindow);
                break;
            }
        }
	}
    
    return visibleWindow;
}

- (void)actionSwitch:(id)sender {
    
    AhaSwitch * vSwitch = (AhaSwitch *)sender;
    NSString * key = [[self.debugArray objectAtIndex:vSwitch.row] valueForKey:@"key"];
    
    [[NSUserDefaults standardUserDefaults] setBool:vSwitch.isOn forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end


@implementation AhaDebugWindow

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	
    [[AhaDebugManager sharedInstance] showDebugView];
	[super motionEnded:motion withEvent:event];
}

@end

@implementation AhaSwitch



@end
