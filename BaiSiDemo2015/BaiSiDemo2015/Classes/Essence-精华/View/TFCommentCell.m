//
//  TFCommentCell.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/7.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFCommentCell.h"
#import "TFComment.h"
#import "UIImageView+WebCache.h"
#import "TFUser.h"
#import "UIImage+TFExtension.h"

@interface TFCommentCell()

@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIImageView *genderView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end




@implementation TFCommentCell

-(void)setComment:(TFComment *)comment{

    _comment=comment;
    
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"] circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        //设置圆形图片
//        self.profileImageView.image=[image circleImage];
//    }];
    
    [self.profileImageView setCircleHeader:comment.user.profile_image];
    
    self.genderView.image=[comment.user.sex isEqualToString:TFUserSexMale]?[UIImage imageNamed:@"Profile_manIcon"]:[UIImage imageNamed:@"Profile_womanIcon"];

    
    self.contentLabel.text=comment.content;
    self.userNameLabel.text=comment.user.username;
    self.likeCountLabel.text=[NSString stringWithFormat:@"%zd",comment.like_count];
//
//    comment.voicetime=10;
//    comment.voiceurl=@"www.baidu.com";
//    
    
    if(comment.voiceurl.length){
    
        self.voiceButton.hidden=NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    }else{
    
        self.voiceButton.hidden=YES;
    
    }


}



-(void)setFrame:(CGRect)frame{

    frame.origin.x=TFTopicCellMargin;
    frame.size.width-=2*TFTopicCellMargin;
    
    [super setFrame:frame];


}


- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.backgroundView=bgView;
    //设置圆角
//    self.profileImageView.layer.cornerRadius=self.profileImageView.width*0.5;
//    self.profileImageView.layer.masksToBounds=YES;

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
