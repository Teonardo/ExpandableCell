//
//  TestModel.m
//  ExpandableCell
//
//  Created by Teonardo on 2019/9/18.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "TestModel.h"
#import "NSAttributedString+YYTextExtension.h"

@implementation TestModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _expandingHeight = -1;
        _collapsingHeight = -1;
    }
    return self;
}

- (NSMutableAttributedString *)expandingAttrStr {
    if (!_expandingAttrStr) {
        _expandingAttrStr = [NSMutableAttributedString tyy_attributedStringWithString:self.content font:kContentTextFont color:kContentTextColor lineSpacing:kContentLineSpacing suffix:@"收起" suffixColor:kFoldButtonColor];
    }
    
    return _expandingAttrStr;
}

- (NSMutableAttributedString *)collapsingAttrStr {
    if (!_collapsingAttrStr) {
        _collapsingAttrStr = [NSMutableAttributedString tyy_attributedStringWithString:self.content font:kContentTextFont color:kContentTextColor lineSpacing:kContentLineSpacing];
    }
    return _collapsingAttrStr;
}

- (CGFloat)expandingHeight {
    if (_expandingHeight == -1) {
        _expandingHeight = [self.expandingAttrStr tyy_heightWithWidth:SCREEN_WIDTH];
    }
    return _expandingHeight;
}

- (CGFloat)collapsingHeight {
    if (_collapsingHeight == -1) {
        _collapsingHeight = [self.collapsingAttrStr tyy_heightWithWidth:SCREEN_WIDTH line:3]; // 设置最多显示3行
    }
    return _collapsingHeight;
}

- (CGFloat)currentHeight {
    return self.isExpanded ? self.expandingHeight : self.collapsingHeight;
}

@end
