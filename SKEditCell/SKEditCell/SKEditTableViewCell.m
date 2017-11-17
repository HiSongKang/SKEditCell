//
//  SKEditTableViewCell.m
//  SKEditCell
//
//  Created by songkang on 2017/11/17.
//  Copyright © 2017年 songkang. All rights reserved.
//

#import "SKEditTableViewCell.h"
#import "Masonry.h"

@interface SKEditTableViewCell ()
@property (nonatomic, strong) UIView *separatorLine;/**< 分割线 */
@property (nonatomic, strong) UILabel *fundNameLabel;/**< 标题 */
@property (nonatomic, strong) UILabel *fundCodeLabel;/**< 副标题 */
@property (nonatomic, strong) UIButton *remindBt;/**< 提醒按钮 */
@property (nonatomic, strong) UIButton *moveTopBtn;/**< 置顶按钮 */
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation SKEditTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.fundNameLabel];
        [self.contentView addSubview:self.fundCodeLabel];
        [self.contentView addSubview:self.tipLabel];
        [self.contentView addSubview:self.remindBt];
        [self.contentView addSubview:self.moveTopBtn];
        self.multipleSelectionBackgroundView = [[UIView alloc]init];
        self.multipleSelectionBackgroundView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.separatorLine];
        [self configSubViewsLayout];
    }
    return self;
}
- (void)configTitle:(NSString *)title
{
    self.fundNameLabel.text = title;
}
- (void)showRemindBtn:(BOOL)isShow
{
    //5.0.0迭代暂时不做提醒，此处全部为YES
    self.remindBt.hidden = YES;
}
- (void)showOrHiddenHoldTips:(BOOL)isShowTips
{
    self.tipLabel.hidden = isShowTips;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing: editing animated: YES];
    
    if (editing) {
        
        for (UIView * view in self.subviews) {
            if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewCellReorderControl"]) {
                for (UIView * subview in view.subviews) {
                    if ([subview isKindOfClass: [UIImageView class]]) {
                        ((UIImageView *)subview).image = [UIImage imageNamed: @"QT-058-1"];
                        [subview sizeToFit];
                    }
                }
            }
        }
        for (UIControl *control in self.subviews){
            if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
                for (UIView *v in control.subviews)
                {
                    if ([v isKindOfClass: [UIImageView class]]) {
                        UIImageView *img=(UIImageView *)v;
                        if (self.selected) {
                            img.image=[UIImage imageNamed:@"QT-012-2"];
                        }else
                        {
                            img.image=[UIImage imageNamed:@"QT-012-3"];
                        }
                    }
                }
            }
        }
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    self.tipLabel.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.1];
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.tipLabel.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.1];
    self.separatorLine.backgroundColor = [UIColor blackColor];
}

-(void)layoutSubviews
{
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"QT-012-2"];
                    }else
                    {
                        img.image=[UIImage imageNamed:@"QT-012-3"];
                    }
                }
            }
        }
    }
    [super layoutSubviews];
}

- (void)configSubViewsLayout
{
    CGFloat totalWidth = [UIScreen mainScreen].bounds.size.width * 0.4;
    CGFloat averageW = totalWidth / 3;
    [self.moveTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-averageW);
        make.width.mas_equalTo(averageW);
        make.top.bottom.equalTo(self.contentView);
    }];
    [self.remindBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.moveTopBtn.mas_left);
        make.width.mas_equalTo(averageW);
    }];
    [self.fundNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(16);
        make.right.lessThanOrEqualTo(self.remindBt.mas_left);
    }];
    [self.fundCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.fundNameLabel.mas_bottom).offset(3);
        make.height.mas_equalTo(12);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fundCodeLabel.mas_right).offset(5);
        make.width.mas_equalTo(25);
        make.centerY.equalTo(self.fundCodeLabel).offset(0.5);
    }];
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(-50);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width+50);
    }];
}
- (void)moveTopBtnClick:(UIButton *)moveTopBtn
{
    //    moveTopBtn.selected = !moveTopBtn.selected;
    //    if (moveTopBtn.selected) {
    if (self.moveTopBtnBlock) {
        self.moveTopBtnBlock();
    }
    //    }
}
- (void)remindBtnClick:(UIButton *)remindBtn
{
    if (self.remindBtnBlock) {
        self.remindBtnBlock(@"名字",@"测试");
    }
}
- (void)updateRemindBtnSelected:(BOOL)isSelected
{
    self.remindBt.selected = isSelected;
}
- (UIView *)separatorLine
{
    if (_separatorLine) {
        return _separatorLine;
    }
    
    _separatorLine = [[UIView alloc] init];
    _separatorLine.backgroundColor = [UIColor blackColor];
    
    return _separatorLine;
}
- (UILabel *)fundNameLabel
{
    if (!_fundNameLabel) {
        _fundNameLabel = [[UILabel alloc]init];
        _fundNameLabel.font = [UIFont systemFontOfSize:16];
        _fundNameLabel.textColor = [UIColor blackColor];
    }
    return _fundNameLabel;
}
- (UILabel *)fundCodeLabel
{
    if (!_fundCodeLabel) {
        _fundCodeLabel = [[UILabel alloc]init];
        _fundCodeLabel.font = [UIFont systemFontOfSize:12];
        _fundCodeLabel.textColor = [UIColor blackColor];
        [_fundCodeLabel sizeToFit];
    }
    return _fundCodeLabel;
}

- (UIButton *)remindBt
{
    if (!_remindBt) {
        _remindBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_remindBt setImage:[UIImage imageNamed:@"QT-056-1"] forState:UIControlStateNormal];
        [_remindBt setImage:[UIImage imageNamed:@"QT-056-2"] forState:UIControlStateSelected];
        [_remindBt addTarget: self action:@selector(remindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _remindBt.hidden = YES;
    }
    return _remindBt;
}
- (UIButton *)moveTopBtn
{
    if (!_moveTopBtn) {
        _moveTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moveTopBtn setImage:[UIImage imageNamed:@"QT-057-1"] forState:UIControlStateNormal];
        [_moveTopBtn setImage:[UIImage imageNamed:@"QT-057-2"] forState:UIControlStateSelected];
        [_moveTopBtn addTarget:self action:@selector(moveTopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moveTopBtn;
}
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.text = @"持有";
        _tipLabel.hidden = YES;
        _tipLabel.textColor = [UIColor redColor];
        _tipLabel.font = [UIFont systemFontOfSize:8];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.layer.borderColor = [[UIColor redColor] CGColor];
        _tipLabel.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.1];
        _tipLabel.layer.masksToBounds = YES;
        _tipLabel.layer.cornerRadius = 2;
    }
    return _tipLabel;
}

@end
