//
//  SampleTableViewController.m
//  TableCellAnimationSample
//
//  Created by algin on 2013/07/06.
//  Copyright (c) 2013年 algin. All rights reserved.
//

#import "SampleTableViewController.h"

@interface SampleTableViewController (){
    NSArray *_orgAnimationData;
    NSMutableArray *_animationsData;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedcontroller;

@end

@implementation SampleTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshControl addTarget:self
                            action:@selector(didStartRefresh:)
                  forControlEvents:UIControlEventValueChanged];
    _orgAnimationData = @[@{@"text":@"UITableViewRowAnimationFade",
                         @"animation":[NSNumber numberWithInteger:UITableViewRowAnimationFade]},
                         @{@"text":@"UITableViewRowAnimationLeft",
                         @"animation":[NSNumber numberWithInteger:UITableViewRowAnimationLeft]},
                         @{@"text":@"UITableViewRowAnimationTop",
                         @"animation":[NSNumber numberWithInteger:UITableViewRowAnimationTop]},
                         @{@"text":@"UITableViewRowAnimationBottom",
                         @"animation":[NSNumber numberWithInteger:UITableViewRowAnimationBottom]},
                         @{@"text":@"UITableViewRowAnimationNone",
                         @"animation":[NSNumber numberWithInteger:UITableViewRowAnimationNone]},
                         @{@"text":@"UITableViewRowAnimationMiddle",
                         @"animation":[NSNumber numberWithInteger:UITableViewRowAnimationMiddle]},
                         @{@"text":@"UITableViewRowAnimationAutomatic",
                         @"animation":[NSNumber numberWithInteger:UITableViewRowAnimationAutomatic]}
                         ];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self refreshCellData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _animationsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AnimationSampleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = [[_animationsData objectAtIndex:indexPath.row] objectForKey:@"text"];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger anim = [[[_animationsData objectAtIndex:indexPath.row] objectForKey:@"animation"] integerValue];
    
    if (_segmentedcontroller.selectedSegmentIndex == 0) {
        // add
        if (_animationsData.count != _orgAnimationData.count) {
            [_animationsData addObject: [_orgAnimationData objectAtIndex:_animationsData.count]];
        }
    }
    else {
        // remove
        [_animationsData removeLastObject];
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:anim];
}


#pragma mark - UIRefreshyConrol Actions

- (void)didStartRefresh:(id)sender
{
    [self performSelector:@selector(refreshCellData)
               withObject:nil
               afterDelay:1.f];
}


#pragma mark - Private Methods

- (void)refreshCellData
{
    _animationsData = [_orgAnimationData mutableCopy];
    [self.refreshControl endRefreshing];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end


