//
//  RepaymentManageDetailCell.h
//  HiLender
//
//  Created by iApple on 2018/12/17.
//  Copyright © 2018 iApple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepaymentManageDetailCell : UITableViewCell


/**
 是否选中的复选框图片 checkBox
 */
@property (nonatomic, strong) UIImageView *imgCheckBox;

/**
 还款的具体信息
 */
@property (nonatomic, strong) UILabel *lblRepayDetailInfo;

/**
 最迟还款日期
 */
@property (nonatomic, strong) UILabel *lblLastRepayDate;

/**
 分割线
 */
@property (nonatomic, strong) UIView *vSegmentLine;


/**
 记录cell是否被点击了，处于点击状态
 */
@property (nonatomic, assign) BOOL cellSelected;

/**
 记录cell是否被点击了，处于点击状态
 */
@property (nonatomic, assign) BOOL isCellSelected;






- (void)configRepaymentDetailCellWithDictionary:(NSDictionary *)dict isHaveSegmentLine:(BOOL)isHaveSegmentLine;



@end

NS_ASSUME_NONNULL_END
