//
//  ADToolCell.m
//  ADToolView
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 CHJ. All rights reserved.
//

#import "ADToolCell.h"

@interface ADToolCell ()

@end
@implementation ADToolCell


-(void)setAdtoolModel:(ADToolModel *)adtoolModel
{
    _adtoolModel = adtoolModel;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = self.bounds;
    //字体大小自动调整宽度。注意该属性只支持文字是一行
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    //按钮的文字向下偏移
    button.titleEdgeInsets = UIEdgeInsetsMake(self.frame.size.height/2, 0, 0, 0);
    //剪切按钮
//    button.layer.cornerRadius = self.frame.size.width/2;
//    button.clipsToBounds = YES;
    [self.contentView addSubview:button];
    
    [button setTitle:_adtoolModel.title forState:UIControlStateNormal];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_adtoolModel.picUrl]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [button setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
        });
    });
}

@end
