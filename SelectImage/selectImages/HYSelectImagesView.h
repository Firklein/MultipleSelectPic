//
//  HYSelectImagesView.h
//  HYSelectImages
//
//  Created by csj on 2019/1/9.
//  Copyright © 2019年 csj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^backImages)(NSMutableArray *images);

@interface HYSelectImagesView : UIView


@property (nonatomic, strong) UIViewController *imgViewController;

@property (nonatomic, copy) backImages imgHandler;

- (void)setImgHandler:(backImages)imgHandler;

@end

NS_ASSUME_NONNULL_END
