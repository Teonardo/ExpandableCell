//
//  ExpandableCellProtocol.h
//  ExpandableCell
//
//  Created by Teonardo on 2019/9/19.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ExpandableCellProtocol <NSObject>

/** 点击了展开/收起*/
- (void)cellDidClickTailButton:(UITableViewCell *)cell;

@end

NS_ASSUME_NONNULL_END
