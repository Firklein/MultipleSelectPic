//
//  HYSelectImagesCell.m
//  LeBangAED
//
//  Created by csj on 2019/1/9.
//  Copyright © 2019年 HY. All rights reserved.
//

#import "HYSelectImagesCell.h"

@implementation HYSelectImagesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tipLabel.text = @"添加照片";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
