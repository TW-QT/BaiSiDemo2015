//
//  TFRecommendUserCell.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/30.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFRecommendUserCell.h"
#import "TFRecommendUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+TFExtension.h"

@interface TFRecommendUserCell()

/**用户头像*/
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
/**用户昵称*/
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
/**粉丝数*/
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation TFRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUser:(TFRecommendUser *)user{
    _user=user;

    self.screenNameLabel.text=self.user.screen_name;
    
    NSString *fans_count=nil;
    if(self.user.fans_count<10000){
        //小于1万
        fans_count=[NSString stringWithFormat:@"%zd人关注",self.user.fans_count];
    }else{
        //大于等于1万
        fans_count=[NSString stringWithFormat:@"%.1f万人关注",self.user.fans_count/10000.0];
    }
    self.fansCountLabel.text=fans_count;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.headerImageView.image=image?[image circleImage]:[[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    }];
    



}

@end
