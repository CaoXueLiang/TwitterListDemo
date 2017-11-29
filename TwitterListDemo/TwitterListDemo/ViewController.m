//
//  ViewController.m
//  TwitterListDemo
//
//  Created by 曹学亮 on 2017/11/27.
//  Copyright © 2017年 Cao Xueliang. All rights reserved.
//

#import "ViewController.h"
#import "MLTweetLayouts.h"
#import "TwitterCell.h"

@interface ViewController ()<TwitterCellDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,strong) NSMutableArray *layoutsArray;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"首页";
    
    [self.view addSubview:self.myTable];
    self.myTable.frame = self.view.bounds;
    [self getData];
}

#pragma mark - UITableView M
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.layoutsArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"MLTweetCell";
    TwitterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TwitterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
    }
    [cell setLayout:self.layoutsArray[indexPath.row]];
    cell.statusView.layout.selectIndex = indexPath.row;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ((MLTweetLayouts *)self.layoutsArray[indexPath.row]).totalHeight;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - Cell Delegate
///点击了 Cell
- (void)cellDidClick:(TwitterCell *)cell{
    
}

///点击了Cell菜单
- (void)cellDidClickMenu:(TwitterCell *)cell{
    
}

///点击了展开收起按钮
- (void)cellDidClickExpendButton:(TwitterCell *)cell{
    
}

///点击了视频
- (void)cellDidClickedVideo:(TwitterCell *)cell{
    
}

///点击了关注
- (void)cellDidClickFollow:(TwitterCell *)cell{
    
}

///点击了转发
- (void)cellDidClickRepost:(TwitterCell *)cell{
    
}

//点击了点赞的昵称
- (void)cellDidClickedLikedUser:(TweetLikeModel *)userModel{
    
}

///点击了评论的昵称
- (void)cellDidClickedCommentUser:(TweetCommentModel *)userModel{
    
}

///点击了回复人的昵称
- (void)cellDidClickedReplyUser:(NSString *)memberId{
    
}

///点击了下方 Tag
- (void)cellDidClickTag:(TwitterCell *)cell{
    
}

///点击了评论
- (void)cellDidClickComment:(TwitterCell *)cell{
    
}

///评论评论中的内容
- (void)cellDidClickedCommentListCell:(TwitterCell *)cell commentIndex:(NSInteger)index{
    
}

///点击了赞
- (void)cellDidClickLike:(TwitterCell *)cell{
    
}

///点击了用户
- (void)cell:(TwitterCell *)cell didClickUser:(MLTweetModel *)user{
    
}

///点击了图片
- (void)cell:(TwitterCell *)cell didClickImageAtIndex:(NSUInteger)index{
    
}

///点击了 Label 的链接
- (void)cell:(TwitterCell *)cell didClickInLabel:(YYLabel *)label textRange:(NSRange)textRange{
    
}

#pragma mark - Setter && Getter
- (NSMutableArray *)layoutsArray{
    if (!_layoutsArray) {
        _layoutsArray = [[NSMutableArray alloc]init];
    }
    return _layoutsArray;
}

- (UITableView *)myTable{
    if (!_myTable) {
        _myTable = [UITableView new];;
        _myTable.delegate = self;
        _myTable.dataSource = self;
        _myTable.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _myTable.showsVerticalScrollIndicator = NO;
        _myTable.tableFooterView = [UIView new];
    }
    return _myTable;
}

- (void)getData{
    NSData *data = [NSData dataNamed:@"dynamic.json"];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *arr = dictionary[@"return_data"];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *entryDict = obj;
        MLTweetModel *tweetModel = [MLTweetModel yy_modelWithJSON:entryDict];
        MLTweetLayouts *layout = [[MLTweetLayouts alloc]initWithStatus:tweetModel isDeatil:NO];
        //只显示能看到的动态
        if ([tweetModel.nosee isEqualToString:@"N"]) {
            [self.layoutsArray addObject:layout];
        }
    }];
    [self.myTable reloadData];
}

@end
