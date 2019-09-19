//
//  TestCell.m
//  ExpandableCell
//
//  Created by Teonardo on 2019/9/18.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "TestCell.h"
#import "YYLabel.h"
#import "NSAttributedString+YYTextExtension.h"


@interface TestCell ()
@property (nonatomic, strong) YYLabel *contentLabel;

@end

@implementation TestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customUI];
    }
    return self;
}

#pragma mark - UI
- (void)customUI {
    
    // 内容
    // 注意: YYLabel 本身不支持固有内容高度, 也就是在布局时无法使用默认高度, 不想UILabel 会有一个默认高度.
    YYLabel *label = [YYLabel new];
    [self.contentView addSubview:label];
    self.contentLabel = label;
    label.userInteractionEnabled = YES;
    label.numberOfLines = 0;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentLabel.frame = self.contentView.bounds;

}

#pragma mark - Private Method

// 显示初始状态(未展开时)
// 当文本超出指定行数时在末尾显示 "展开按钮", 将文本限制在指定行数内.
// 思路: 利用 YYLabel 的 truncationToken 属性设置 "展开按钮"
- (void)showOriginalState {
    // 1️⃣ 设置内容
    _contentLabel.attributedText = self.model.collapsingAttrStr;
    
    // 2️⃣ 添加 展开
    __weak typeof(self)weakSelf = self;
    NSAttributedString *truncationToken = [NSAttributedString tyy_truncationTokenWithText:@"展开" font:kContentTextFont color:kFoldButtonColor tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if ([strongSelf.delegate respondsToSelector:@selector(cellDidClickTailButton:)]) {
            [strongSelf.delegate cellDidClickTailButton:strongSelf];
        }
    }];
    _contentLabel.truncationToken = truncationToken;
    
}

// 显示展开状态
// 思路: 利用 YYText 对 NSAttributedString 的 扩展, 设置 高亮文本并添加点击事件, 形成"收起按钮"效果
- (void)showExpansionState {
    // 1️⃣ 清空truncationToken
    _contentLabel.truncationToken = nil; // 重要
    
    // 2️⃣ 添加 收起
    NSMutableAttributedString *mAttrStr = self.model.expandingAttrStr;
    __weak typeof(self)weakSelf = self;
    [mAttrStr tyy_setTextHighlightOfString:@"收起" color:kFoldButtonColor backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if ([strongSelf.delegate respondsToSelector:@selector(cellDidClickTailButton:)]) {
            [strongSelf.delegate cellDidClickTailButton:strongSelf];
        }
    }];
    _contentLabel.attributedText = mAttrStr;
}

#pragma mark - Setter
- (void)setModel:(TestModel *)model {
    
    __weak typeof(model)weakModel = model;
    _model = weakModel;
    
    if (model.isExpanded) {
        [self showExpansionState];
    } else {
        [self showOriginalState];
    }
}

@end
