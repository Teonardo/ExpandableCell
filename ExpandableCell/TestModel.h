//
//  TestModel.h
//  ExpandableCell
//
//  Created by Teonardo on 2019/9/18.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kContentTextColor ([UIColor blackColor])           // 文字颜色
#define kContentTextFont ([UIFont systemFontOfSize:18.0])  // 字体大小
#define kContentLineSpacing 8                              // 文本行间距
#define kFoldButtonColor [UIColor blueColor]               // 展开/收起 文本颜色

NS_ASSUME_NONNULL_BEGIN

@interface TestModel : NSObject

/** 需要折叠处理的文本内容*/
@property (nonatomic, copy) NSString *content;


/** 展开时的富文本*/
@property (nonatomic, strong) NSMutableAttributedString *expandingAttrStr;
/** 折叠时的富文本*/
@property (nonatomic, strong) NSMutableAttributedString *collapsingAttrStr;
/** 是否是展开状态*/
@property (nonatomic, assign, getter=isExpanded) BOOL expanded;
/** 展开时Cell高度*/
@property (nonatomic, assign) CGFloat expandingHeight;
/** 收起时Cell高度*/
@property (nonatomic, assign) CGFloat collapsingHeight;
/** cell 当前高度*/
@property (nonatomic, assign) CGFloat currentHeight;


@end

NS_ASSUME_NONNULL_END
