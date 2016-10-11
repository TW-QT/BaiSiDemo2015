//
//  TFVerticalButton.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/31.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFVerticalButton.h"

@implementation TFVerticalButton


-(void)awakeFromNib{
    
    [self setupButton];

}

/**
 *调整按钮内部的位置
 */
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //调整图片位置与大小
    self.imageView.x=0;
    self.imageView.y=0;
    self.imageView.width=self.width;
    self.imageView.height=self.width;
    
    //调整文字位置与大小
    self.titleLabel.x=0;
    self.titleLabel.y=self.imageView.height;
    self.titleLabel.width=self.width;
    self.titleLabel.height=self.height-self.imageView.height;

}



-(instancetype)initWithFrame:(CGRect)frame{

    if(self=[super initWithFrame:frame]){
        [self setupButton];
    }
    return self;

}


-(void)setupButton{

    self.titleLabel.textAlignment=NSTextAlignmentCenter;

}


@end
