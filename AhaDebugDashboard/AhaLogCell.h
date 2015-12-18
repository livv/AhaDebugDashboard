//
//  AhaLogCell.h
//  AhaDebugDemo
//
//  Created by wei on 15/12/17.
//  Copyright © 2015年 livv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AhaLogCell : UITableViewCell

+ (UINib *)nib;
+ (NSString *)cellIdentifier;


- (void)config:(NSDictionary *)dict;
- (CGFloat)cellHeightWithInfo:(NSDictionary *)info;

@end
