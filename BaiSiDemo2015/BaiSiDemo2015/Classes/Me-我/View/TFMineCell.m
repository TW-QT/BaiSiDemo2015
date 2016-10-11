//
//  TFMineCell.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/8.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFMineCell.h"

@implementation TFMineCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie{

    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifie]){
    
        UIImageView *bgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        self.backgroundView=bgView;
    
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.textColor=[UIColor darkGrayColor];
        self.textLabel.font=[UIFont systemFontOfSize:16];
    }

    return self;
}



-(void)layoutSubviews{

    [super layoutSubviews];
    
    if(self.imageView.image==nil)
        return;
    
    self.imageView.width=30;
    self.imageView.height=30;
    self.imageView.centerY=self.contentView.height*0.5;
    self.textLabel.x=CGRectGetMaxX(self.imageView.frame)+10;


}
//
//-(void)setFrame:(CGRect)frame{
//    
//    frame.origin.y-=25;
//    [super setFrame:frame];
// 
//}

@end
