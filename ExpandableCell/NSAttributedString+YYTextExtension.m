//
//  NSAttributedString+YYTextExtension.m
//  PartyConstruction
//
//  Created by Teonardo on 2019/6/11.
//  Copyright © 2019 huajie. All rights reserved.
//

#import "NSAttributedString+YYTextExtension.h"
#import "YYLabel.h"
#import "NSAttributedString+YYText.h"

@implementation NSAttributedString (YYTextExtension)
#pragma mark - 超过指定行显示"更多"
+ (NSAttributedString *)tyy_truncationTokenWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color tapAction:(YYTextAction)tapAction
{
    NSMutableAttributedString *mAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"...%@", text]];
    [mAttributedString tyy_setTextHighlightOfString:text color:color backgroundColor:nil tapAction:tapAction];
    mAttributedString.yy_font = font;
    
    //
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = mAttributedString;
    [seeMore sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    return truncationToken;
}

#pragma mark - Size
- (CGSize)tyy_boundingRectWithSize:(CGSize)size line:(NSInteger)line
{
    YYTextContainer *container = [YYTextContainer new];
    container.size = size;
    container.maximumNumberOfRows = line;
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:self];
    return layout.textBoundingSize;
}

- (CGSize)tyy_boundingRectWithWidth:(CGFloat)width line:(NSInteger)line
{
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    return [self tyy_boundingRectWithSize:size line:line];
}

- (CGFloat)tyy_heightWithWidth:(CGFloat)width line:(NSInteger)line
{
    return [self tyy_boundingRectWithWidth:width line:line].height;
}

- (CGFloat)tyy_heightWithWidth:(CGFloat)width
{
    return [self tyy_boundingRectWithWidth:width line:0].height;
}

@end


@implementation NSMutableAttributedString (YYTextExtension)

+ (NSMutableAttributedString *)tyy_attributedStringWithString:(NSString *)string
                                                        font:(UIFont *)font
                                                       color:(UIColor *)color
                                                 lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *mAttributedString = [[NSMutableAttributedString alloc] initWithString:(string ? string : @"")];
    mAttributedString.yy_font = font;
    mAttributedString.yy_color = color;
    mAttributedString.yy_lineSpacing = lineSpacing;
    return mAttributedString;
}


+ (NSMutableAttributedString *)tyy_attributedStringWithString:(NSString *)string
                                                        font:(UIFont *)font
                                                       color:(UIColor *)color
                                                 lineSpacing:(CGFloat)lineSpacing
                                                      suffix:(NSString *)suffix
                                                 suffixColor:(UIColor *)suffixColor
{
    NSString *splicedStr = [NSString stringWithFormat:@"%@%@", string, suffix];
    NSMutableAttributedString *mAttributedString = [self tyy_attributedStringWithString:splicedStr font:font color:color lineSpacing:lineSpacing];
    NSRange suffixRange = [splicedStr rangeOfString:suffix];
    [mAttributedString yy_setColor:suffixColor range:suffixRange];
    return mAttributedString;
}


- (void)tyy_setTextHighlightOfString:(NSString *)string
                              color:(UIColor *)color
                    backgroundColor:(UIColor *)backgroundColor
                          tapAction:(YYTextAction)tapAction
{
    NSRange range = [self.string rangeOfString:string];
    
    // ①设置高亮便捷方法
    [self yy_setTextHighlightRange:range color:color backgroundColor:backgroundColor tapAction:tapAction];
    
    
    /*
    // ②设置高亮
    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:color]; // 高亮状态下的"按钮"文字颜色(点击时)
    hi.tapAction = tapAction;

    [self yy_setColor:color range:[self.string rangeOfString:string]]; // 未点击时"按钮"文字颜色
    [self yy_setTextHighlight:hi range:[self.string rangeOfString:string]];
     */
}

@end
