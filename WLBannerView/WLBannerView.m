//
//  WLBannerView.m
//  WLBannerViewDemo
//
//  Created by weil on 2019/12/31.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLBannerView.h"
#import "WLBannerViewCell.h"

@interface WLBannerView<T> ()<UIScrollViewDelegate>
@property (nonatomic, assign) Class cellCls;
@property (nonatomic, strong) NSArray<T> *data;
@property (nonatomic, strong) WLBannerViewCell *leftCell;
@property (nonatomic, strong) WLBannerViewCell *centerCell;
@property (nonatomic, strong) WLBannerViewCell *rightCell;
@property (nonatomic, assign, readwrite) NSUInteger cur_index;
@property (nonatomic, strong) dispatch_source_t scrollTimer;
@end

@implementation WLBannerView
- (instancetype)initWithCellCls:(Class)cls {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.cellCls = cls;
        self.cur_index = 0;
        self.autoScrollInterval = 3.0;
        self.autoScroll = YES;
        [self _initSubviews];
    }
    return self;
}
- (instancetype)init {
    return [self initWithCellCls:[WLBannerViewCell class]];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithCellCls:[WLBannerViewCell class]];
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    return [self initWithCellCls:[WLBannerViewCell class]];
}
- (void) _initSubviews {
    self.delegate = self;
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.leftCell = [[self.cellCls alloc] init];
    [self addSubview:self.leftCell];
    self.centerCell = [[self.cellCls alloc] init];
    [self addSubview:self.centerCell];
    self.rightCell = [[self.cellCls alloc] init];
    [self addSubview:self.rightCell];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tap)];
    [self.centerCell addGestureRecognizer:tap];
}
- (void) _initTimer {
    self.scrollTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.autoScrollInterval * NSEC_PER_SEC));
    dispatch_source_set_timer(self.scrollTimer, start, (uint64_t)(self.autoScrollInterval * NSEC_PER_SEC), 0);
    dispatch_source_set_event_handler(self.scrollTimer, ^{
        [self _autoChangeCurrentPage];
    });
}
- (void)setupData:(NSArray *)data {
    self.data = data;
    [self.leftCell setupData:[self _getDataBeforeIndex:self.cur_index]];
    [self.centerCell setupData:[self _getDataAtIndex:self.cur_index]];
    [self.rightCell setupData:[self _getDataNextIndex:self.cur_index]];
    if (self.isAutoScrollEnabled) {
        if (self.scrollTimer) {
            dispatch_cancel(self.scrollTimer);
            self.scrollTimer = nil;
        }
        if (data.count > 1) {
            [self _initTimer];
            dispatch_resume(self.scrollTimer);
        }
    }
    self.scrollEnabled = data.count > 1;
}
- (void)reload {
    self.leftCell.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.centerCell.frame = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
    self.rightCell.frame = CGRectMake(self.bounds.size.width*2, 0, self.bounds.size.width, self.bounds.size.height);
    self.contentSize = CGSizeMake(3*self.bounds.size.width, 0);
    self.contentOffset = CGPointMake(self.bounds.size.width, 0);
}
- (void)scrollToIndex:(NSUInteger)index {
    self.cur_index = index;
    self.cur_index = MAX(0, self.cur_index);
    self.cur_index = MIN(self.cur_index, self.data.count);
    [self.leftCell setupData:[self _getDataBeforeIndex:self.cur_index]];
    [self.centerCell setupData:[self _getDataAtIndex:self.cur_index]];
    [self.rightCell setupData:[self _getDataNextIndex:self.cur_index]];
    self.contentOffset = CGPointMake(self.bounds.size.width, 0);
}
- (void) _autoChangeCurrentPage {
    [UIView animateWithDuration:0.25 animations:^{
        self.centerCell.userInteractionEnabled = NO;
        self.contentOffset = CGPointMake(self.bounds.size.width*2, 0);
    } completion:^(BOOL finished) {
        self.cur_index++;
        if (self.cur_index == self.data.count) {
            self.cur_index = 0;
        }
        self.centerCell.userInteractionEnabled = YES;
        [self.leftCell setupData:[self _getDataBeforeIndex:self.cur_index]];
        [self.centerCell setupData:[self _getDataAtIndex:self.cur_index]];
        [self.rightCell setupData:[self _getDataNextIndex:self.cur_index]];
        self.contentOffset = CGPointMake(self.bounds.size.width, 0);
    }];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.isAutoScrollEnabled) {
        if (self.scrollTimer) {
            dispatch_cancel(self.scrollTimer);
            self.scrollTimer = nil;
        }
    }
    if (self.bannerDelegate && [self.bannerDelegate respondsToSelector:@selector(bannerViewWillDragging:)]) {
        [self.bannerDelegate bannerViewWillDragging:self];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate  {
    if (self.isAutoScrollEnabled) {
        [self _initTimer];
        dispatch_resume(self.scrollTimer);
    }
    if (self.bannerDelegate && [self.bannerDelegate respondsToSelector:@selector(bannerViewDidEndDragging:)]) {
        [self.bannerDelegate bannerViewDidEndDragging:self];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat floatIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    NSUInteger toIndex = self.cur_index;
    if (floatIndex > self.cur_index) {
        toIndex++;
        if (toIndex == self.data.count) {
            toIndex = 0;
        }
    }else {
        toIndex--;
        if (toIndex < 0) {
            toIndex = self.data.count - 1;
        }
    }
    if (self.bannerDelegate && [self.bannerDelegate respondsToSelector:@selector(bannerView:willScrollToIndex:fromIndex:)]) {
        [self.bannerDelegate bannerView:self willScrollToIndex:toIndex fromIndex:self.cur_index];
    }
    if (self.bannerDelegate && [self.bannerDelegate respondsToSelector:@selector(bannerViewDidScroll:)]) {
        [self.bannerDelegate bannerViewDidScroll:self];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (index == 0) {
        self.cur_index--;
        if (self.cur_index < 0) {
            self.cur_index = self.data.count - 1;
        }
        [self.leftCell setupData:[self _getDataBeforeIndex:self.cur_index]];
        [self.centerCell setupData:[self _getDataAtIndex:self.cur_index]];
        [self.rightCell setupData:[self _getDataNextIndex:self.cur_index]];
        self.contentOffset = CGPointMake(self.bounds.size.width, 0);
    }else if (index == 2) {
        self.cur_index++;
        if (self.cur_index >= self.data.count) {
            self.cur_index = 0;
        }
        [self.leftCell setupData:[self _getDataBeforeIndex:self.cur_index]];
        [self.centerCell setupData:[self _getDataAtIndex:self.cur_index]];
        [self.rightCell setupData:[self _getDataNextIndex:self.cur_index]];
        self.contentOffset = CGPointMake(self.bounds.size.width, 0);
    }
    if (self.bannerDelegate && [self.bannerDelegate respondsToSelector:@selector(bannerViewDidEndDelecerating:)]) {
        [self.bannerDelegate bannerViewDidEndDelecerating:self];
    }
    if (self.bannerDelegate && [self.bannerDelegate respondsToSelector:@selector(bannerView:didScrollToIndex:)]) {
        [self.bannerDelegate bannerView:self didScrollToIndex:self.cur_index];
    }
}
#pragma mark - private methods
- (id) _getDataAtIndex:(NSUInteger)index {
    if (index < 0 || index >= self.data.count) {
        return nil;
    }
    return self.data[index];
}
- (id) _getDataBeforeIndex:(NSUInteger)index {
    if (index == 0) {
        return self.data.lastObject;
    }
    return self.data[index - 1];
}
- (id) _getDataNextIndex:(NSUInteger)index {
    if (index == self.data.count - 1) {
        return self.data.firstObject;
    }
    return self.data[index + 1];
}
- (void) _tap {
    if (self.bannerDelegate && [self.bannerDelegate respondsToSelector:@selector(bannerView:didClickItemAtIndex:)]) {
        [self.bannerDelegate bannerView:self didClickItemAtIndex:self.cur_index];
    }
}
@end
