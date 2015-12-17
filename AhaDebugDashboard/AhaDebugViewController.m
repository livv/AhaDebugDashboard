//
//  AhaDebugViewController.m
//  superText
//
//  Created by wei on 14-1-17.
//  Copyright (c) 2014年 wmloft. All rights reserved.
//

#import "AhaDebugViewController.h"
#import "AhaLogViewController.h"

@interface AhaDebugViewController () {
    
    
}

@property (nonatomic, strong) AhaDebugManager * debugManager;

@end

@implementation AhaDebugViewController

- (id)init:(AhaDebugManager *)newDebugManager {
    if ((self = [super initWithStyle:UITableViewStylePlain])) {
        self.debugManager = newDebugManager;
        self.title = @"Dashboard";
    }
    return self;
}

- (id)init {
    return [self init:[AhaDebugManager sharedInstance]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                          target:self
                                                                                          action:@selector(onAction:)];
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)onAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES
                             completion:^(void){
                                 self.debugManager.hidden = YES;
                             }];
    
}


#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.debugManager.debugArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"AhaCellDebug";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        AhaSwitch * switch_ = [[AhaSwitch alloc] init];
        switch_.tag = 99;
        [switch_ addTarget:self.debugManager action:@selector(actionSwitch:) forControlEvents:UIControlEventValueChanged];
        switch_.center = CGPointMake(self.view.frame.size.width - 50, 22);
        [cell addSubview:switch_];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    
    AhaSwitch * switch_ = (AhaSwitch *)[cell viewWithTag:99];
    switch_.row = indexPath.row;
    
    NSDictionary * dict = [self.debugManager.debugArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dict objectForKey:@"title"];
    
    NSString * key = [dict objectForKey:@"key"];
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if ([value isKindOfClass:[NSString class]]) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        switch_.hidden = YES;
        
    } else if ([value isKindOfClass:[NSNumber class]]) {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch_.hidden = NO;
        [switch_ setOn:[value boolValue]];
    }
    
    [switch_ setOn:[[NSUserDefaults standardUserDefaults] boolForKey:key]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary * dict = [self.debugManager.debugArray objectAtIndex:indexPath.row];
    NSString * key = [dict objectForKey:@"key"];
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if ([value isKindOfClass:[NSString class]]) {
        
        UIViewController * tempObj = [[NSClassFromString(value) alloc] init];
        if (tempObj) {
            [self.navigationController pushViewController:tempObj animated:YES];
        }
    }
    
}

@end
