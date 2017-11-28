//
//  TwitterCell.m
//  TwitterListDemo
//
//  Created by bjovov on 2017/11/28.
//  Copyright © 2017年 Cao Xueliang. All rights reserved.
//

#import "TwitterCell.h"
#import "TwitterCommentCell.h"
#import "MLTweetModel.h"

#pragma mark - 个人信息
/**
 个人信息View
 */
@implementation TwitterProfileView{
    BOOL _trackingTouch;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellProfileHeight;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    @weakify(self);
    
    _avatarView = [UIImageView new];
    _avatarView.size = CGSizeMake(40, 40);
    _avatarView.origin = CGPointMake(kWBCellPadding, kWBCellPadding + 3);
    _avatarView.contentMode = UIViewContentModeScaleAspectFill;
    _avatarView.clipsToBounds = YES;
    [self addSubview:_avatarView];
    
    _nameLabel = [YYLabel new];
    _nameLabel.size = CGSizeMake(kWBCellNameWidth, 24);
    _nameLabel.left = _avatarView.right + kWBCellNamePaddingLeft;
    _nameLabel.centerY = 27;
    _nameLabel.lineBreakMode = NSLineBreakByClipping;
    [self addSubview:_nameLabel];
    
    _locationLabel = [YYLabel new];
    _locationLabel.frame = _nameLabel.frame;
    _locationLabel.centerY = 47;
    [self addSubview:_locationLabel];
    _locationLabel.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([weak_self.cell.delegate respondsToSelector:@selector(cell: didClickInLabel: textRange:)]) {
            [weak_self.cell.delegate cell:weak_self.cell didClickInLabel:(YYLabel *)containerView textRange:range];
        }
    };
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _trackingTouch = NO;
    UITouch *touch = touches.anyObject;
    CGPoint point1 = [touch locationInView:_avatarView];
    CGPoint point2 = [touch locationInView:_nameLabel];
    if (CGRectContainsPoint(_avatarView.bounds, point1)) {
        _trackingTouch = YES;
    }
    if (CGRectContainsPoint(_nameLabel.bounds, point2) && _nameLabel.textLayout.textBoundingRect.size.width > point2.x) {
        _trackingTouch = YES;
    }
    if (!_trackingTouch) {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if (!_trackingTouch) {
//        [super touchesEnded:touches withEvent:event];
//    }else{
//        if ([_cell.delegate respondsToSelector:@selector(cell: didClickUser:)]) {
//            [_cell.delegate cell:_cell didClickUser:_cell.statusView.layout.tweetModel];
//        }
//    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_trackingTouch) {
        [super touchesCancelled:touches withEvent:event];
    }
}

@end

#pragma mark - 视频View
@implementation TwitterVideoView
- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = KWBVideoWidth;
        frame.size.height = KWBVideoHeight;
    }
    self = [super initWithFrame:frame];
    @weakify(self);
    
    _videoImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _videoImageButton.origin = CGPointMake(kWBCellPadding + 40 + kWBCellNamePaddingLeft, 0);
    _videoImageButton.size = CGSizeMake(KWBVideoWidth, KWBVideoHeight);
    _videoImageButton.contentMode = UIViewContentModeScaleAspectFill;
    [_videoImageButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if ([weak_self.cell.delegate respondsToSelector:@selector(cellDidClickedVideo:)]) {
            [weak_self.cell.delegate cellDidClickedVideo:weak_self.cell];
        }
    }];
    [self addSubview:_videoImageButton];
    
    _startImageView = [UIImageView new];
    _startImageView.image = [UIImage imageNamed:@"mlgj-2x88"];
    _startImageView.frame = CGRectMake(0, 0, 30, 30);
    _startImageView.center = _videoImageButton.center;
    [self addSubview:_startImageView];
    
    return self;
}

@end

#pragma mark - 底部工具条
@implementation TwitterToolbarView
- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellToolbarHeight;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    
    _repostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _repostButton.exclusiveTouch = YES;
    _repostButton.size = CGSizeMake(CGFloatPixelRound(self.width/3.0), self.height);
    [_repostButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.exclusiveTouch = YES;
    _commentButton.size = CGSizeMake(CGFloatPixelRound(self.width/3.0), self.height);
    _commentButton.left = CGFloatPixelRound(self.width/3.0);
    [_commentButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _likeButton.exclusiveTouch = YES;
    _likeButton.size = CGSizeMake(CGFloatPixelRound(self.width/3.0), self.height);
    _likeButton.left = CGFloatPixelRound(self.width/3.0 * 2.0);
    [_likeButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    
    _repostImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"unLiked"]];
    _repostImageView.centerY = self.height / 2.0;
    [_repostButton addSubview:_repostImageView];
    
    _commentImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"commented"]];
    _commentImageView.centerY = self.height / 2.0;
    [_commentButton addSubview:_commentImageView];
    
    _likeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shared"]];
    _likeImageView.centerY = self.height / 2.0;
    [_likeButton addSubview:_likeImageView];
    
    _repostLabel = [YYLabel new];
    _repostLabel.height = self.height;
    [_repostButton addSubview:_repostLabel];
    
    _commentLabel = [YYLabel new];
    _commentLabel.height = self.height;
    [_commentButton addSubview:_commentLabel];
    
    _likeLabel = [YYLabel new];
    _likeLabel.height = self.height;
    [_likeButton addSubview:_likeLabel];
    
    UIColor *dark = [UIColor colorWithWhite:0 alpha:0.2];
    UIColor *clear = [UIColor colorWithWhite:0 alpha:0];
    NSArray *colors = @[(id)clear.CGColor,(id)dark.CGColor, (id)clear.CGColor];
    NSArray *locations = @[@0.2, @0.5, @0.8];
    
    _line1 = [CAGradientLayer layer];
    _line1.locations = locations;
    _line1.colors = colors;
    _line1.startPoint = CGPointMake(0, 0);
    _line1.endPoint = CGPointMake(0, 1);
    _line1.size = CGSizeMake(CGFloatFromPixel(1), self.height);
    _line1.left = _repostButton.right;
    
    _line2 = [CAGradientLayer layer];
    _line2.locations = locations;
    _line2.colors = colors;
    _line2.startPoint = CGPointMake(0, 0);
    _line2.endPoint = CGPointMake(0, 1);
    _line2.size = CGSizeMake(CGFloatFromPixel(1), self.height);
    _line2.left = _commentButton.right;
    
    _topLine = [CALayer layer];
    _topLine.size = CGSizeMake(self.width, CGFloatFromPixel(1));
    _topLine.backgroundColor = kWBCellLineColor.CGColor;
    
    _bottomLine = [CALayer layer];
    _bottomLine.size = CGSizeMake(self.width, CGFloatFromPixel(1));
    _bottomLine.bottom = self.height;
    _bottomLine.backgroundColor = UIColorHex(e8e8e8).CGColor;
    
    [self addSubview:_repostButton];
    [self addSubview:_commentButton];
    [self addSubview:_likeButton];
    [self.layer addSublayer:_line1];
    [self.layer addSublayer:_line2];
    [self.layer addSublayer:_topLine];
    [self.layer addSublayer:_bottomLine];
    
    @weakify(self);
    [_repostButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if ([weak_self.cell.delegate respondsToSelector:@selector(cellDidClickRepost:)]) {
            [weak_self.cell.delegate cellDidClickRepost:weak_self.cell];
        }
    }];
    
    [_commentButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if ([weak_self.cell.delegate respondsToSelector:@selector(cellDidClickComment:)]) {
            [weak_self.cell.delegate cellDidClickComment:weak_self.cell];
        }
    }];
    
    [_likeButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if ([weak_self.cell.delegate respondsToSelector:@selector(cellDidClickLike:)]) {
            [weak_self.cell.delegate cellDidClickLike:weak_self.cell];
        }
    }];
    
    return self;
}

//- (void)setWithLayout:(MLTweetLayouts *)layout{
//    
//}

@end

#define mark - 点赞评论View
@implementation TwitterLikeOrCommentView
- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kWBCellContentWidth;
        frame.size.height = kScreenHeight;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    self.backgroundColor = UIColorHex(F7F7F7);
    self.layer.cornerRadius = 3.0f;
    
    _likeBeginImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"praised_icon"]];
    _likeBeginImageView.size = CGSizeMake(16, 16);
    _likeBeginImageView.origin = CGPointMake(8, 9);
    [self addSubview:_likeBeginImageView];
    
    _likeUsersLabel = [YYLabel new];
    _likeUsersLabel.left = 8 + 20;
    _likeUsersLabel.width = kWBCellContentWidth - 8 - 10 - 20;
    [self addSubview:_likeUsersLabel];
    
    _commentTable = [UITableView new];
    _commentTable.size = CGSizeMake(kWBCellContentWidth, 20);
    _commentTable.origin = CGPointMake(0, 0);
    _commentTable.top = _likeUsersLabel.bottom;
    _commentTable.backgroundColor = [UIColor clearColor];
    [_commentTable registerClass:[TwitterCommentCell class] forCellReuseIdentifier:@"TwitterCommentCell"];
    _commentTable.dataSource = self;
    _commentTable.delegate = self;
    [self addSubview:_commentTable];
    
    _separateLayer = [CALayer layer];
    _separateLayer.backgroundColor = [UIColor colorWithRed:(220 / 255.0) green:(220 / 255.0) blue:(220 / 255.0) alpha:1].CGColor;
    _separateLayer.frame = CGRectMake(0, 0, kWBCellContentWidth, CGFloatFromPixel(1));
    [_commentTable.layer addSublayer:_separateLayer];
    
    return self;
}

- (void)setCommentArray:(NSArray *)commentArray{
    if (!commentArray) {
        return;
    }
    _commentArray = commentArray;
    [_commentTable reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCommentModel *model;
    if (self.commentArray.count > 0) {
        model  = self.commentArray[indexPath.row];
    }
    
    @weakify(self);
    MLTweetCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MLTweetCommentCell" forIndexPath:indexPath];
    cell.commentModel = model;
    
    //点击评论昵称
    cell.DidClickedUserName = ^(TweetCommentModel *commentModel){
        MLTweetCell *cell = weak_self.cell;
        if ([cell.delegate respondsToSelector:@selector(cellDidClickedCommentUser:)]) {
            [cell.delegate cellDidClickedCommentUser:commentModel];
        }
    };
    
    //点击回复用户的昵称
    cell.DidClickedReplyUserName = ^(NSString *member_id){
        MLTweetCell *cell = weak_self.cell;
        if ([cell.delegate respondsToSelector:@selector(cellDidClickedReplyUser:)]) {
            [cell.delegate cellDidClickedReplyUser:member_id];
        }
    };
    
    //点击评论链接
    cell.DidClickedLink = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        if ([weak_self.cell.delegate respondsToSelector:@selector(cell:didClickInLabel:textRange:)]) {
            [weak_self.cell.delegate cell:weak_self.cell didClickInLabel:(YYLabel *)containerView textRange:range];
        }
    };
    
    return cell;
}

@end

@implementation TwitterCell

@end
