//
//  AhaLogViewController.m
//  AhaDebugDemo
//
//  Created by wei on 15/12/16.
//  Copyright © 2015年 livv. All rights reserved.
//

#import "AhaLogViewController.h"
#import "AhaLog.h"
#import "AhaLogCell.h"
#import "AhaDebugManager.h"

@interface AhaLogViewController ()
<UIActionSheetDelegate>

@property (nonatomic, strong) UITableView * mainTable;

@end


@implementation AhaLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"日志";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                              target:self
                                                                              action:@selector(actionNavRight:)];
    self.navigationItem.rightBarButtonItem = barItem;
    
    [self.view addSubview:self.mainTable];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.mainTable.frame = self.view.bounds;
}


- (void)actionNavRight:(id)sender {
    
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                          destructiveButtonTitle:@"Clear"
                                               otherButtonTitles:@"Send by Email", nil];
    [sheet showInView:self.view];
}


#pragma mark - UIActionSheetDelegate 

- (NSString *)URLEncodedString:(NSString *)string
{
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, CFSTR("!*'\"();:@&=+$,/?%#[]% "), kCFStringEncodingUTF8));
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        
        [AhaLog clear];
        [self.mainTable reloadData];
        
    } else if (buttonIndex == 1) {
        
        NSString *URLSafeName = [self URLEncodedString:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]];
        NSString *URLSafeLog = [self URLEncodedString:[AhaLog logStr]];
        NSMutableString *URLString = [NSMutableString stringWithFormat:@"mailto:%@?subject=%@%%20Console%%20Log&body=%@",
                                      [AhaDebugManager sharedInstance].logSubmissionEmail ?: @"", URLSafeName, URLSafeLog];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
    }
}


#pragma mark - getters

- (UITableView *)mainTable {
    if (!_mainTable) {
        _mainTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTable.delegate = [AhaLog sharedInstance];
        _mainTable.dataSource = [AhaLog sharedInstance];
        _mainTable.tableFooterView = [UIView new];
        [_mainTable registerNib:[AhaLogCell nib] forCellReuseIdentifier:[AhaLogCell cellIdentifier]];
    }
    return _mainTable;
}

@end
