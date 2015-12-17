//
//  AhaLogCell.m
//  AhaDebugDemo
//
//  Created by wei on 15/12/17.
//  Copyright © 2015年 livv. All rights reserved.
//

#import "AhaLogCell.h"

@interface AhaLogCell ()

@property (nonatomic, weak) IBOutlet UILabel * contentLabel;

@end

@implementation AhaLogCell

- (void)awakeFromNib {

    self.contentLabel.font = [AhaLogCell cellFont];
    self.contentLabel.textColor = [UIColor darkGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+ (UIFont *)cellFont {
    
//    return [UIFont systemFontOfSize:14.0f];
    return [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
}

#pragma mark - public

+ (UINib *)nib {
    
    return [UINib nibWithNibName:@"AhaLogCell" bundle:nil];
}

+ (NSString *)cellIdentifier {
    
    return NSStringFromClass([AhaLogCell class]);
}

- (void)config:(NSDictionary *)dict {

    self.contentLabel.text = dict[@"content"];
}

+ (CGFloat)cellHeightWithtDict:(NSDictionary *)dict {
    
    NSString * logStr = [dict objectForKey:@"content"];
    
    NSInteger options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    return [logStr boundingRectWithSize:CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - 30, CGFLOAT_MAX)
                                options:options
                             attributes:@{NSFontAttributeName : [AhaLogCell cellFont]}
                                context:nil].size.height + 20;
    
}
@end
