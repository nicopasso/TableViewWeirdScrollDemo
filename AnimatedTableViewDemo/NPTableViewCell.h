//
//  NPTableViewCell.h
//  AnimatedTableViewDemo
//
//  Created by Niccolo on 26/10/14.
//  Copyright (c) 2014 Liqid S.r.l. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPTableViewCell : UITableViewCell

//Views
@property (nonatomic, strong) UIView* containerView;
@property (nonatomic, strong) UIButton* changeBoxStateButton;
@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, assign) BOOL isClosed;

@end
