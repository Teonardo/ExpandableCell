//
//  NSAttributedString+YYTextExtension.h
//  PartyConstruction
//
//  Created by Teonardo on 2019/6/11.
//  Copyright © 2019 huajie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYTextAttribute.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (YYTextExtension)

/**
 通过设置YYLabel的truncationToken属性,在文本显示不下时,结尾显示"更多按钮".

 @param text      "更多按钮"标题
 @param font      "更多按钮"字体
 @param color     "更多按钮"文字
 @param tapAction "更多按钮"点击事件
 @return           富文本对象, 将其设置为YYLabel的truncationToken属性的值
 */
+ (NSAttributedString *)tyy_truncationTokenWithText:(NSString *)text
                                               font:(UIFont *)font
                                              color:(UIColor *)color
                                          tapAction:(YYTextAction)tapAction;

#pragma mark - <布局计算>
/**
 富文本布局计算, 限定范围

 @param size 限制范围
 @param line 限定文本行数
 @return     在限制范围内文本的实际size
 */
- (CGSize)tyy_boundingRectWithSize:(CGSize)size line:(NSInteger)line;

/**
 富文本布局计算, 限定宽度

 @param width 限制宽度
 @param line  限定文本行数
 @return      在限定宽度下文本的实际size
 */
- (CGSize)tyy_boundingRectWithWidth:(CGFloat)width line:(NSInteger)line;

/**
 富文本高度计算, 限定宽度和行数

 @param width 限制宽度
 @param line  限制文本行数
 @return      在限定宽度和行数下, 文本的实际高度
 */
- (CGFloat)tyy_heightWithWidth:(CGFloat)width line:(NSInteger)line;

/**
 富文本高度计算, 限定宽度, 行数不限

 @param width 限制宽度
 @return      在限定宽度(行数不限)下, 文本的实际高度
 */
- (CGFloat)tyy_heightWithWidth:(CGFloat)width;
#pragma mark - </布局计算>

@end

@interface NSMutableAttributedString (YYTextExtension)

/**
 通过一个给定字符串,创建一个指定字体,文字颜色,行间距的富文本

 @param string      给定的字符串
 @param font        字体
 @param color       文字颜色
 @param lineSpacing 行间距
 @return            可变属性字符串
 */
+ (NSMutableAttributedString *)tyy_attributedStringWithString:(NSString *)string
                                                         font:(nullable UIFont *)font
                                                        color:(nullable UIColor *)color
                                                  lineSpacing:(CGFloat)lineSpacing;

/**
 通过一个字符串和一个后缀(字符串), 创建一个带"后缀按钮"的富文本

 @param string       给定的字符串
 @param font         字体
 @param color        文字颜色
 @param lineSpacing  行间距
 @param suffix      "后缀按钮"标题
 @param suffixColor "后缀按钮"文字颜色
 @return             带"后缀按钮"的富文本
 */
+ (NSMutableAttributedString *)tyy_attributedStringWithString:(NSString *)string
                                                         font:(nullable UIFont *)font
                                                        color:(nullable UIColor *)color
                                                  lineSpacing:(CGFloat)lineSpacing
                                                       suffix:(nullable NSString *)suffix
                                                  suffixColor:(nullable UIColor *)suffixColor;

/**
 为富文的的某段文字设置高亮, 可添加点击事件

 @param string          要高亮的文本
 @param color           高亮颜色
 @param backgroundColor 背景色
 @param tapAction       点击事件
 */
- (void)tyy_setTextHighlightOfString:(NSString *)string
                              color:(nullable UIColor *)color
                    backgroundColor:(nullable UIColor *)backgroundColor
                          tapAction:(nullable YYTextAction)tapAction;
@end

NS_ASSUME_NONNULL_END
