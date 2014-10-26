//
//  NPTableViewCell.m
//  AnimatedTableViewDemo
//
//  Created by Niccolo on 26/10/14.
//  Copyright (c) 2014 Liqid S.r.l. All rights reserved.
//

#import "NPTableViewCell.h"

@implementation NPTableViewCell


- (void)setIsClosed:(BOOL)isClosed
{
    [self setupViewCellWithClosed:isClosed];
}

- (void)setupViewCellWithClosed:(BOOL)isClosed
{
    self.changeBoxStateButton = ({
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 10, CGRectGetWidth(self.contentView.frame)-40, 50);
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [UIColor purpleColor].CGColor;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 250, 0, 0)];
        button;
    });
    [self.contentView addSubview:self.changeBoxStateButton];
    
    self.titleLabel = ({
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 250, 50)];
        label.textColor = [UIColor purpleColor];
        label.textAlignment = NSTextAlignmentLeft;
        label;
    });
    [self.changeBoxStateButton addSubview:self.titleLabel];
    
    CGFloat heightTableView = isClosed ? 100 : 0;
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.changeBoxStateButton.frame), CGRectGetWidth(self.contentView.bounds)-40, heightTableView)];
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.layer.borderWidth = 0.5;
    self.containerView.layer.borderColor = [UIColor purpleColor].CGColor;
    [self.contentView addSubview:self.containerView];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
