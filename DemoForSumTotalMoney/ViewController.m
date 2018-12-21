//
//  ViewController.m
//  DemoForSumTotalMoney
//
//  Created by iApple on 2018/12/19.
//  Copyright © 2018 iApple. All rights reserved.
//

#import "ViewController.h"

// 具体的cell信息
#import "RepaymentManageDetailCell.h"


// 为了适配iOS 11和iPhone X
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTabBarSafeAreaBottomHeight  ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34.0:0)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

// 获取屏幕宽高
#define kScreenWidth            [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight           [[UIScreen mainScreen] bounds].size.height
#define kScreenBounds           [UIScreen mainScreen].bounds

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 还款管理的表视图
 */
@property (nonatomic, strong) UITableView *repaymentDetailTableView;



@end

@implementation ViewController
{
    NSArray *_arraySectionData;
    NSArray *_arrayRowsData;
    
    /// 头部视图
    UIView *_vTopHeaderView;
    UILabel *_lblRepayMoneyTitle;
    UILabel *_lblRepayMoney;
    
    /// 尾部视图
    UIView *_vBottomFooterView;
    UIButton *_btnRepayRightNow;
    
    /// 选中的还款标的数组
    NSMutableArray *_arrToalSelectedRows;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self loadRepaymentDetailData];
    
    [self prepareForTableHeaderView];
    [self prepareForTableFooterView];
    
    [self prepareForDetailTableView];
    
}

- (void)loadRepaymentDetailData
{
    _arrToalSelectedRows = [NSMutableArray arrayWithCapacity:0];
    _arraySectionData = @[@""];
    _arrayRowsData = @[
                       @{
                           @"repaymentNo":@"No.84882AC",
                           @"repaymentMethod":@"等额本息",
                           @"repaymentMoney":@"1780.00",
                           @"repaymentPeriod":@"18",
                           @"repaymentTotal":@"24",
                           @"repaymentDate":@"2018/05/17"
                           },
                       @{
                           @"repaymentNo":@"No.84552AC",
                           @"repaymentMethod":@"等额本息",
                           @"repaymentMoney":@"1600.00",
                           @"repaymentPeriod":@"12",
                           @"repaymentTotal":@"24",
                           @"repaymentDate":@"2018/05/17"
                           },
                       @{
                           @"repaymentNo":@"No.84222AC",
                           @"repaymentMethod":@"等额本息",
                           @"repaymentMoney":@"1100.00",
                           @"repaymentPeriod":@"14",
                           @"repaymentTotal":@"24",
                           @"repaymentDate":@"2018/05/17"
                           },
                       @{
                           @"repaymentNo":@"No.84872AC",
                           @"repaymentMethod":@"等额本息",
                           @"repaymentMoney":@"1200.00",
                           @"repaymentPeriod":@"19",
                           @"repaymentTotal":@"24",
                           @"repaymentDate":@"2018/05/17"
                           }
                       ];
}

- (void)prepareForTableHeaderView
{
    CGFloat headerW = [UIScreen mainScreen].bounds.size.width;
    CGFloat headerH = 100;
    
    CGFloat lblTitleTop = 20;
    CGFloat lblTitleLeft = 30;
    CGFloat lblTitleW = headerW - lblTitleLeft * 2;
    CGFloat lblTitleH = 20;
    
    CGFloat paddingTitleToMoney = 10;
    CGFloat lblMoneyW = lblTitleW;
    CGFloat lblMoneyH = 40;
    
    
    _vTopHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerW, headerH)];
    _vTopHeaderView.backgroundColor = [UIColor whiteColor];
    
    _lblRepayMoneyTitle = [[UILabel alloc] initWithFrame:CGRectMake(lblTitleLeft, lblTitleTop, lblTitleW, lblTitleH)];
    _lblRepayMoneyTitle.text = @"待还金额 (元)";
    _lblRepayMoneyTitle.textColor = [UIColor blackColor];
    _lblRepayMoneyTitle.textAlignment = NSTextAlignmentLeft;
    _lblRepayMoneyTitle.font = [UIFont systemFontOfSize:14];
    [_vTopHeaderView addSubview:_lblRepayMoneyTitle];
    
    _lblRepayMoney = [[UILabel alloc] initWithFrame:CGRectMake(lblTitleLeft, CGRectGetMaxY(_lblRepayMoneyTitle.frame) + paddingTitleToMoney, lblMoneyW, lblMoneyH)];
    _lblRepayMoney.text = @"0.00";
    _lblRepayMoney.textColor = [UIColor blackColor];
    _lblRepayMoney.textAlignment = NSTextAlignmentLeft;
    _lblRepayMoney.font = [UIFont systemFontOfSize:34];
    [_vTopHeaderView addSubview:_lblRepayMoney];
    
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(0, headerH - 1, headerW, 1)];
    vLine.backgroundColor = [UIColor lightTextColor];
    [_vTopHeaderView addSubview:vLine];
    
}

- (void)prepareForTableFooterView
{
    CGFloat footerW = [UIScreen mainScreen].bounds.size.width;
    CGFloat footerH = 100;
    CGFloat btnTop = 60;
    CGFloat btnLeft = 35;
    CGFloat btnW = footerW - btnLeft * 2;
    CGFloat btnH = 40;
    
    _vBottomFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, footerW, footerH)];
    _vBottomFooterView.backgroundColor = [UIColor cyanColor];
    
    _btnRepayRightNow = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnRepayRightNow.frame = CGRectMake(btnLeft, btnTop, btnW, btnH);
    _btnRepayRightNow.backgroundColor = [UIColor orangeColor];
    [_btnRepayRightNow setTitle:@"立即还款" forState:UIControlStateNormal];
    [_btnRepayRightNow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_vBottomFooterView addSubview:_btnRepayRightNow];
    _btnRepayRightNow.layer.masksToBounds = YES;
    _btnRepayRightNow.layer.cornerRadius = btnH / 2;
    
}


- (void)prepareForDetailTableView
{
    
    CGFloat tableW = [UIScreen mainScreen].bounds.size.width;
    CGFloat tableH = [UIScreen mainScreen].bounds.size.height - kTopHeight - kTabBarSafeAreaBottomHeight;
    
    _repaymentDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, tableW, tableH) style:UITableViewStyleGrouped];
    _repaymentDetailTableView.backgroundColor = [UIColor cyanColor];
    _repaymentDetailTableView.delegate = self;
    _repaymentDetailTableView.dataSource = self;
    _repaymentDetailTableView.showsVerticalScrollIndicator = NO;
    _repaymentDetailTableView.showsHorizontalScrollIndicator = NO;
    _repaymentDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _repaymentDetailTableView.tableHeaderView = _vTopHeaderView;
    _repaymentDetailTableView.tableFooterView = _vBottomFooterView;
    _repaymentDetailTableView.rowHeight = 100;
    [self.view addSubview:_repaymentDetailTableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arraySectionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayRowsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseInfoID = @"reuseInfoID";
    RepaymentManageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseInfoID];
    if (!cell) {
        cell = [[RepaymentManageDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseInfoID];
    }
    NSInteger lastOne = _arrayRowsData.count - 1;
    BOOL isHaveLine = lastOne == indexPath.row ? NO : YES;
    [cell configRepaymentDetailCellWithDictionary:_arrayRowsData[indexPath.row] isHaveSegmentLine:isHaveLine];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
    header.backgroundColor = [UIColor cyanColor];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
    footer.backgroundColor = [UIColor cyanColor];
    return footer;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepaymentManageDetailCell *cell = (RepaymentManageDetailCell *)[_repaymentDetailTableView cellForRowAtIndexPath:indexPath];
    // 获取到当前cell选择的状态，然后取反
    BOOL isSelectedCell = cell.cellSelected;
    NSDictionary *dictSelectInfo = _arrayRowsData[indexPath.row];
    
    // 判断cell是否被选中
    if (!isSelectedCell) {
        cell.imgCheckBox.image = [UIImage imageNamed:@"checkbox_selected"];
        // 在可变数组中添加一个对象元素，添加到数组中
        [_arrToalSelectedRows addObject:dictSelectInfo];
        // 将cell的选中状态取反
        cell.cellSelected = !isSelectedCell;
    } else {
        cell.imgCheckBox.image = [UIImage imageNamed:@"checkbox_unselected_gray"];
        // 在可变数组中移除一个对象元素，从数组中移除指定的对象
        [_arrToalSelectedRows removeObject:dictSelectInfo];
        // 将cell的选中状态取反
        cell.cellSelected = !isSelectedCell;
    }
    
    [self actionToUpdateTotalWaitingForRepayMoneyWithRowIndexPaths:_arrToalSelectedRows];
}


- (void)actionToUpdateTotalWaitingForRepayMoneyWithRowIndexPaths:(NSArray *)rowIndexPaths
{
    
    double totalMoney = 0.00;
    
    for (NSDictionary *dictInfo in _arrToalSelectedRows) {
        double money = [dictInfo[@"repaymentMoney"] doubleValue];
        totalMoney = totalMoney + money;
    }
    
    _lblRepayMoney.text = [NSString stringWithFormat:@"%.2f", totalMoney];
}


@end
