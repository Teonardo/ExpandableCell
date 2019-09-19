//
//  TestCell.h
//  ExpandableCell
//
//  Created by Teonardo on 2019/9/18.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestModel.h"
#import "ExpandableCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestCell : UITableViewCell

@property (nonatomic, weak) TestModel *model;

@property (nonatomic, weak) id<ExpandableCellProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
