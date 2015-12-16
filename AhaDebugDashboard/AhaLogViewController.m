//
//  AhaLogViewController.m
//  AhaDebugDemo
//
//  Created by wei on 15/12/16.
//  Copyright © 2015年 livv. All rights reserved.
//

#import "AhaLogViewController.h"
#import "AhaLog.h"

@interface AhaLogViewController ()
<UIActionSheetDelegate>

@property (nonatomic, strong) UITableView * mainTable;

@end


@implementation AhaLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Logs";
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
                                               otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate 

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        [AhaLog clear];
        [self.mainTable reloadData];
    }
}


#pragma mark - getters

- (UITableView *)mainTable {
    if (!_mainTable) {
        _mainTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTable.delegate = [AhaLog sharedInstance];
        _mainTable.dataSource = [AhaLog sharedInstance];
        _mainTable.tableFooterView = [UIView new];
    }
    return _mainTable;
}

@end
