//
//  TFRecommendTagCell.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/31.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFRecommendTagCell.h"
#import "TFRecommendTag.h"
#import "UIImageView+WebCache.h"
#import "UIImage+TFExtension.h"

@interface TFRecommendTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;


@end

@implementation TFRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    

}



-(void)setRecommendTag:(TFRecommendTag *)recommendTag{
//    _recommendTag=recommendTag;
//    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//        self.imageListImageView.image=image?[image circleImage]:[[UIImage imageNamed:@"defaultUserIcon"] circleImage];
//    }];
    
    [self.imageListImageView setCircleHeader:recommendTag.image_list];
    self.themeNameLabel.text=recommendTag.theme_name;
    
    NSString *subNumber=nil;
    if(recommendTag.sub_number<10000){
        //小于1万
        subNumber=[NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }else{
        //大于等于1万
        subNumber=[NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number/10000.0];
    }
    
    self.subNumberLabel.text=subNumber;

}
/**
 *重写frame
 */
-(void)setFrame:(CGRect)frame{
    
    
    frame.origin.x=5;
    frame.size.width-=frame.origin.x*2;
    frame.size.height-=1;
    [super setFrame:frame];


}

@end
