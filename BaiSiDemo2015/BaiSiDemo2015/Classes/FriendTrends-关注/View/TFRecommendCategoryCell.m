//
//  TFRecommendCategoryCell.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/30.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFRecommendCategoryCell.h"
#import "TFRecommendCategory.h"

@interface TFRecommendCategoryCell()
/**选中时显示在左边的红色的指示器view*/
@property (weak, nonatomic) IBOutlet UIView *selectedIndicater;


@end


@implementation TFRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor=TFRGBColor(244, 244, 244);
    self.selectedIndicater.backgroundColor=TFRGBColor(219, 21, 26);
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor clearColor];
    self.selectedBackgroundView=bg;
}


-(void)setCategory:(TFRecommendCategory *)category{

    _category=category;
    
    
    self.textLabel.text=category.name;

}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    //设置自带的textLabel的高度,让其不要挡住自定义的白色分割线
    self.textLabel.y=2;
    self.textLabel.height=self.contentView.height-2*self.textLabel.y;


}

/**可以在这个方法中监听cell的选中情况,重写选中时的状态*/
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicater.hidden=!selected;
    self.textLabel.textColor=selected?TFRGBColor(219, 21, 26):TFRGBColor(78, 78, 78);

}
@end
