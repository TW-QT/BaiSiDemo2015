//
//  TFTextField.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/31.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFTextField.h"
#import <objc/runtime.h>


@implementation TFTextField

//-(void)drawPlaceholderInRect:(CGRect)rect{
//
//    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width, 25) withAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],
//                                                       NSFontAttributeName:self.font,
//                                                        }];
//}
//属性,方法,代理,runtime,自己写
-(void)awakeFromNib{
    //设置占位文字的颜色
//    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self resignFirstResponder];
    //设置光标的颜色与文字颜色一致
    [self setTintColor:[UIColor whiteColor]];


}


/**
 *当前文本框聚焦时调用
 */
-(BOOL)becomeFirstResponder{
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}


/**
 *当前文本框失去焦点时调用
 */
-(BOOL)resignFirstResponder{

    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

//-(void)setHighlighted:(BOOL)highlighted{
//    
//    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
//
//
//}
//+(void)initialize{
//
//    unsigned int count=0;
//    //用运行时获取隐藏的成员变量名,拷贝出所有的成员变量的列表
//    Ivar *ivars= class_copyIvarList([UITextField class], &count);
//    
//    for(int i=0;i<count;i++){
//        //取出成员变量
//        Ivar ivar=*(ivars+i);
//      //Ivar ivar=ivars[i];
//        //打印成员变量的名字
//        TFLog(@"%s",ivar_getName(ivar));
//        
//        
//    }
//    //释放
//    free(ivars);
//
//}
@end
