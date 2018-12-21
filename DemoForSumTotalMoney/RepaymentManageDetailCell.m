//
//  RepaymentManageDetailCell.m
//  HiLender
//
//  Created by iApple on 2018/12/17.
//  Copyright © 2018 iApple. All rights reserved.
//

#import "RepaymentManageDetailCell.h"

@implementation RepaymentManageDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 初始化的时候,cell是未被点击的
        _cellSelected = NO;
        _isCellSelected = NO;
        
        
        // 是否选中的 复选框 图片
        _imgCheckBox = [UIImageView new];
        [self.contentView addSubview:_imgCheckBox];
        
        // 还款具体信息
        _lblRepayDetailInfo = [UILabel new];
        _lblRepayDetailInfo.textColor = [UIColor grayColor];
        _lblRepayDetailInfo.textAlignment = NSTextAlignmentLeft;
        _lblRepayDetailInfo.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_lblRepayDetailInfo];
        
        // 最迟还款日期
        _lblLastRepayDate = [UILabel new];
        _lblLastRepayDate.textColor = [UIColor grayColor];
        _lblLastRepayDate.textAlignment = NSTextAlignmentLeft;
        _lblLastRepayDate.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_lblLastRepayDate];
        
        // 分割线
        _vSegmentLine = [UIView new];
        _vSegmentLine.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_vSegmentLine];
        _vSegmentLine.hidden = YES;
        
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    // 获取当前cell的宽度和高度
    CGFloat W = self.contentView.frame.size.width;
    CGFloat H = self.contentView.frame.size.height;
    
    // 左边距
    CGFloat paddingLeft = 30;
    
    // 复选框图标
    CGFloat imgW = 20;
    CGFloat imgH = imgW;
    CGFloat imgTop = (H - imgH) / 2;
    CGFloat paddingImgToLbl = 20;
    
    // 还款详情
    CGFloat lblDetailW = W - paddingLeft * 2 - imgW - paddingImgToLbl;
    CGFloat lblDetailH = 20;
    // 还款日期
    CGFloat lblDateW = lblDetailW;
    CGFloat lblDateH = 20;
    CGFloat paddingInside = 20;
    CGFloat paddingTopBottom = (H - lblDetailH - lblDateH - paddingInside) / 2;
    
    // 分割线
    CGFloat lineW = W - paddingLeft * 2;
    CGFloat lineH = 1;
    CGFloat lineY = H - lineH;
    
    _imgCheckBox.frame = CGRectMake(paddingLeft, imgTop, imgW, imgH);
    
    _lblRepayDetailInfo.frame = CGRectMake(CGRectGetMaxX(_imgCheckBox.frame) + paddingImgToLbl, paddingTopBottom, lblDetailW, lblDetailH);
    
    _lblLastRepayDate.frame = CGRectMake(CGRectGetMinX(_lblRepayDetailInfo.frame), CGRectGetMaxY(_lblRepayDetailInfo.frame) + paddingInside, lblDateW, lblDateH);
    
    _vSegmentLine.frame = CGRectMake(paddingLeft, lineY, lineW, lineH);
}


- (void)configRepaymentDetailCellWithDictionary:(NSDictionary *)dict isHaveSegmentLine:(BOOL)isHaveSegmentLine
{
    if (isHaveSegmentLine) {
        _vSegmentLine.hidden = NO;
    } else {
        _vSegmentLine.hidden = YES;
    }
    
    NSString *strRepaymentNo = dict[@"repaymentNo"];
    NSString *strRepaymentMethod = dict[@"repaymentMethod"];
    NSString *strRepaymentMoney = dict[@"repaymentMoney"];
    NSString *strRepaymentPeriod = dict[@"repaymentPeriod"];
    NSString *strRepaymentTotal = dict[@"repaymentTotal"];
    NSString *strRepaymentDate = dict[@"repaymentDate"];
    

    _imgCheckBox.image = [UIImage imageNamed:@"checkbox_unselected_gray"];
    
    _lblRepayDetailInfo.text = [NSString stringWithFormat:@"%@   %@  %@", strRepaymentNo, strRepaymentMethod, strRepaymentMoney];
    
    _lblLastRepayDate.text = [NSString stringWithFormat:@"第%@期/共%@期   最迟还款日期:  %@", strRepaymentPeriod, strRepaymentTotal, strRepaymentDate];
}


@end
