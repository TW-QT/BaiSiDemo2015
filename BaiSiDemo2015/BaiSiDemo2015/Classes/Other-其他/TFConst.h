

#import <UIKit/UIKit.h>



typedef enum{
    TFTopicTypeAll=1,
    TFTopicTypePicture=10,
    TFTopicTypeWord=29,
    TFTopicTypeVoice=31,
    TFTopicTypeVideo=41,
} TFTopicType;


/**精华---顶部标题的高度*/
UIKIT_EXTERN CGFloat const TFtitlesViewH;
/**精华---顶部标题的Y值*/
UIKIT_EXTERN CGFloat const TFtitlesViewY;

/**精华cell中的间距*/
UIKIT_EXTERN CGFloat const TFTopicCellMargin;
/**精华cell---底部工具条的高度*/
UIKIT_EXTERN CGFloat const TFTopicCellBottomBarH;

/**精华cell---文字的Y值*/
UIKIT_EXTERN CGFloat const TFTopicCellTextY;

/**精华cell---图片贴的最大高度*/
UIKIT_EXTERN CGFloat const TFTopicCellPictureMaxH;
/**精华cell---图片贴的图片超大时的固定高度*/
UIKIT_EXTERN CGFloat const TFTopicCellPictureBreakH;

/**TFUser模型的用户性别*/
UIKIT_EXTERN NSString * const TFUserSexMale;
UIKIT_EXTERN NSString * const TFUserSexFelmale;

/**tabBar通知中用到的常量*/
UIKIT_EXTERN NSString * const TFTabBarDidSelectedNotification;
UIKIT_EXTERN NSString * const TFSelectedControllerIndexKey;
UIKIT_EXTERN NSString * const TFSelectedControllerKey;

