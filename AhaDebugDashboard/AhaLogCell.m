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

- (CGFloat)cellHeightWithInfo:(NSDictionary *)info {
    
    [self config:info];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    self.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight(self.bounds));
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    height += 1;
    
    return height;
}

@end
