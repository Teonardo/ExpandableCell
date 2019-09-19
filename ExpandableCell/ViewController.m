//
//  ViewController.m
//  ExpandableCell
//
//  Created by Teonardo on 2019/9/18.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "ViewController.h"
#import "TestCell.h"
#import "TestModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, ExpandableCellProtocol>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation ViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTableView];
}

#pragma mark - UI

- (void)addTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor lightGrayColor];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    tableView.tableFooterView = [UIView new];
    
    [tableView registerClass:[TestCell class] forCellReuseIdentifier:NSStringFromClass([TestCell class])];
    
    tableView.frame = self.view.bounds;
}

#pragma mark - Delegate

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestModel *model = self.modelArr[indexPath.row];
    return model.currentHeight;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TestCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    cell.model = self.modelArr[indexPath.row];
    return cell;
}

#pragma mark - ExpandableCellProtocol
- (void)cellDidClickTailButton:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    TestModel *model = self.modelArr[indexPath.row];
    model.expanded = !model.isExpanded;
    
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
    
    /*
     ⭐️ reloadRowsAtIndexPaths:withRowAnimation: 方法 每次都会用不同于当前的另一cell 来 替代当前位置的cell
     ⭐️ reloadData 会利用原来的cell, 只是重新请求cell的数据
     */
    
    [self.tableView reloadData];
}

#pragma mark - Getter
- (NSMutableArray *)modelArr {
    if (!_modelArr) {
        NSArray *arr = @[@"生命是两场盛宴", @"生活中，常常会生出各种各样的距离。空间和地理的，心和心的。", @"把生命和宴席联系到一起，是因为在同一天里参加了两个宴请。", @"一个是朋友喜得贵子，被邀去喝满月喜酒；一个是同事的母亲寿终正寝，吉日安葬。一红一白的请柬，大喜和大悲的盛宴，宣告着这个世界添了一丁，殁了一人，宣告着这个世界的每一天、每一个角落，都在上演着生和死、悲和喜的连续剧。", @"那天，是冬季里难得的一个好天气，阳光暖暖地烘托着喜庆，初为父亲的朋友更是笑逐颜开，空气中似乎都能摸得着欢乐和喜气。婴儿的生命，是刚刚绽出的新鲜芽儿，等待他的，是长长的岁月里，那些吮吸不尽的阳光雨露，品味不尽的酸甜苦辣。", @"离开喜悦的鼓噪，又去参加那位享寿85岁的老人的葬礼。满眼尽是白花和黑纱，充耳是绵绵的哀乐和哭泣。老人儿孙满堂，忠厚善良，安葬入土，主宾皆悲。葬礼后，照例是儿孙置办宴席致谢来宾。与老人有关或者和老人的儿女有关的亲朋好友，聚在桌前吃着说着。熟悉逝者的宾客，追忆着老人生前的琐事；不熟悉逝者的，则品着酒感慨人生，议论着世事的无常。", @"同是宴席，同是血脉相连的亲人，一边主持着生命的人之初，一边主持着生命的人之终；一边是眉开眼笑，一边是泪水涟涟。而这宴席的两位主角，却都浑然不知。", @"生命，其实就是两场盛宴之间的距离。我们每一个人满月的盛宴和出殡的盛宴之间，就是一段生与死的距离。泰戈尔在他的诗中说：“世界上最远的距离，是鱼和飞鸟的距离，一个在树上，一个却深潜水底。”他忘记了说，世界上最美的距离，是生和死的距离，一个是纯洁懵懂的人之初，一个是大彻大悟的人之终。"];
        _modelArr = [NSMutableArray arrayWithCapacity:arr.count];
        for (int i = 0; i < arr.count; i++) {
            TestModel *model = [TestModel new];
            model.content = arr[i];
            [_modelArr addObject:model];
        }
    }
    return _modelArr;
}


@end
