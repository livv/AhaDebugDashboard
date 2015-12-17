//
//  DemoViewController.m
//  AhaDebugDemo
//
//  Created by wei on 15/12/16.
//  Copyright © 2015年 livv. All rights reserved.
//

#import "DemoViewController.h"
#import "AhaLog.h"
#import "AhaDebugManager.h"

@interface DemoViewController ()
@property (nonatomic, weak) IBOutlet UITextField * tf;
@property (nonatomic, weak) IBOutlet UITextView * tv;


@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)actionShowDebug:(id)sender {
    [AhaDebugManager show];
}

- (IBAction)actionSay:(id)sender {
    
    
    NSString *text = self.tf.text;
    if ([text isEqualToString:@""]) {
        text = @"World";
    }
    NSString * msg = [NSString stringWithFormat:@"Hello %@", text];
    [AhaLog logInfo:@"Said %@", msg];
    
    NSString * msg2 = [NSString stringWithFormat:@"%@\n%@", self.tv.text, msg];
    self.tv.text = msg2;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
