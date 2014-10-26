//
//  ViewController.m
//  AnimatedTableViewDemo
//
//  Created by Niccolo on 26/10/14.
//  Copyright (c) 2014 Liqid S.r.l. All rights reserved.
//

#import "ViewController.h"
#import "NPTableViewCell.h"

static NSString* const CellIdentifier = @"CellId";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* boxCellOrder;

@property (nonatomic, assign) BOOL firstAccess;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.firstAccess = YES;
    
    self.boxCellOrder = [@[
                           [@{@"type": @"tableBox", @"closed" : @(NO), @"title" : @"0", @"detail_title" : @"vedi dettagli", @"detail_tag" : @0} mutableCopy],
                           [@{@"type": @"tableBox", @"closed" : @(YES), @"title" : @"1", @"detail_title" : @"vedi dettagli", @"detail_tag" : @1} mutableCopy],
                           [@{@"type": @"tableBox", @"closed" : @(YES), @"title" : @"2", @"detail_title" : @"vedi dettagli", @"detail_tag" : @2} mutableCopy],
                           [@{@"type": @"tableBox", @"closed" : @(YES), @"title" : @"3", @"detail_title" : @"vedi dettagli", @"detail_tag" : @4} mutableCopy],
                           [@{@"type": @"tableBox", @"closed" : @(YES), @"title" : @"4", @"detail_title" : @"", @"detail_tag" : @6} mutableCopy],
                           [@{@"type": @"tableBox", @"closed" : @(YES), @"title" : @"5", @"detail_title" : @"", @"detail_tag" : @7} mutableCopy],
                           [@{@"type": @"tableBox", @"closed" : @(YES), @"title" : @"6", @"detail_title" : @"", @"detail_tag" : @5} mutableCopy],
                           
                           ] mutableCopy];
    
    self.tableView = ({
        UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 320, CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[NPTableViewCell class] forCellReuseIdentifier:CellIdentifier];
        tableView.contentSize = CGSizeMake(320, 1000);
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0);
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView;
    });
    [self.view addSubview:self.tableView];
    
    [self performSelector:@selector(changeFirstAccess) withObject:self afterDelay:1.0];
}

- (void)changeFirstAccess
{
    self.firstAccess = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.boxCellOrder.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NPTableViewCell* cell = (NPTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary* box = self.boxCellOrder[indexPath.row];
    BOOL isClosed = ![box[@"closed"] boolValue];
    
    cell.titleLabel = nil;
    cell.changeBoxStateButton = nil;
    cell.containerView = nil;
    
    cell.isClosed = isClosed;
    
    if (!isClosed) {
        cell.changeBoxStateButton.selected = YES;
    }
    
    cell.titleLabel.text = box[@"title"];
    
    [cell.changeBoxStateButton addTarget:self action:@selector(changeTableCellFrame:) forControlEvents:UIControlEventTouchUpInside];
    cell.changeBoxStateButton.tag = indexPath.row;
    

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* box = self.boxCellOrder[indexPath.row];
    
    if (![box[@"closed"] boolValue]) {
      
        return 170.0f;
        
    }
    
    return 70.0f;
}

- (void)changeTableCellFrame:(id)sender
{
    UIButton* button = (UIButton*)sender;
    
    button.selected = [self.boxCellOrder[button.tag][@"closed"] boolValue];

    
    self.boxCellOrder[button.tag][@"closed"] = @(!button.selected);
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    NPTableViewCell* weakCell = (NPTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        if (button.selected) {
            CGRect newFrame = weakCell.containerView.frame;
            newFrame.size.height = 100;
            weakCell.containerView.frame = newFrame;
        } else {
            CGRect newFrame = weakCell.containerView.frame;
            newFrame.size.height = 0;
            weakCell.containerView.frame = newFrame;
        }


    }];
    

}


@end
