//
//  TFCommentHeaderView.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/7.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFCommentHeaderView.h"


@interface TFCommentHeaderView()

/** 内部文字标签 */
@property (nonatomic,weak) UILabel *label;


@end

@implementation TFCommentHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self=[super initWithReuseIdentifier:reuseIdentifier]){
        
        self.contentView.backgroundColor=TFGlobalBg;
        
        //创建label
        UILabel *label=[[UILabel alloc]init];
        self.label=label;
        label.textColor=TFRGBColor(67, 67, 67);
        label.width=200;
        label.x=20;
        label.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        
        
        
        
    }
    
    return self;

}

@end
