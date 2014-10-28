//
//  KSTendersViewController.m
//  Autolancer
//
//  Created by mac-214 on 24.04.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSTendersViewController.h"
#import "ApiLoadService.h"
#import "KSTender.h"
#import "KSTenderCell.h"
#import "KSDetailsViewController.h"

@interface KSTendersViewController ()

@property (nonatomic, retain) NSMutableArray *tendersArray;

@end

@implementation KSTendersViewController

@synthesize tendersArray = _tendersArray;
@synthesize tableView = _tableView;


- (void) dealloc
{
    [_tendersArray release];
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // self.tabBarController.tabBarItem setImage:<#(UIImage *)#>
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [ApiLoadService getResponseForURL:[NSURL URLWithString:@"http://autolancer.by/wp-admin/admin-ajax.php?action=get_tenders&uuid=rrrr"] callback:^(NSDictionary *dictionary, NSURL *url) {
        
        NSLog(@"%@" , dictionary);
        _tendersArray = [[[NSMutableArray alloc] init] autorelease];
        
        NSDictionary *dataDict = [dictionary objectForKey:@"data"];
        NSDictionary *tenders = [dataDict objectForKey:@"tenders"];
        for(id tender in tenders)
        {
            KSTender *newTender = [[[KSTender alloc] init] autorelease];
            [newTender initWithServerResponse:tender];
            [_tendersArray addObject:newTender];
        }
        
        [_tendersArray retain];
        [_tableView reloadData];
        NSLog(@"sds");
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationItem.title = @"Объявления";
    //self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.208 green:0.412 blue:0.62 alpha:1] /*#35699e*/;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.847 green:0.847 blue:0.871 alpha:1]};
    //self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.847 green:0.847 blue:0.871 alpha:1];
    
    //self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.208 green:0.412 blue:0.62 alpha:1];
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0.847 green:0.847 blue:0.871 alpha:1];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tendersArray count];
}
            
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"KSTenderCell";
    
    KSTenderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    KSTender *tender = (KSTender *)[_tendersArray objectAtIndex:indexPath.row];

    cell.backgroundColor = [UIColor colorWithRed:0.922 green:0.925 blue:0.933 alpha:1];
    cell.titleLabel.text = tender.title;
    
    cell.carmarkLabel.text = tender.carmark;
    cell.carmarkLabel.textColor = [UIColor colorWithRed:0.208 green:0.412 blue:0.62 alpha:1];
    
    cell.carmodelLabel.text = tender.carmodel;
    cell.carmodelLabel.textColor = [UIColor colorWithRed:0.208 green:0.412 blue:0.62 alpha:1];
    
    cell.caryearLabel.text = tender.carYear;
    cell.caryearLabel.textColor = [UIColor colorWithRed:0.208 green:0.412 blue:0.62 alpha:1];
    
    cell.typeLabel.text = tender.type;
    
    if ([tender.status isEqualToString:@"1"])
    {
        cell.actualityLabel.text = @"Не актуально";
    }
    else
    {
        cell.actualityLabel.text = @"Актуально";
    }
    
    cell.postDateLabel.text = tender.postDate;
    
    cell.placeLabel.text = tender.place;
    
    cell.viewOfferLabel.text = [NSString stringWithFormat:@"%@/%@", tender.views, tender.offers];
    cell.viewOfferLabel.textColor = [UIColor colorWithRed:0.847 green:0.847 blue:0.871 alpha:1];
    
    [cell.viewOfferLabel sizeToFit];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    KSDetailsViewController *detailsViewController = [[UIStoryboard  storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"details"];
    detailsViewController.tender = (KSTender *)[_tendersArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

@end
