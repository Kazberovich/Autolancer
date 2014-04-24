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

@interface KSTendersViewController ()

@end

@implementation KSTendersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ApiLoadService getResponseForURL:[NSURL URLWithString:@"http://autolancer.by/wp-admin/admin-ajax.php?action=get_tenders&uuid=rrrr&page=2&user_id=3&categories=1:2"] callback:^(NSDictionary *dictionary, NSURL *url) {
        
        NSLog(@"%@" , dictionary);
        NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
        
        NSDictionary *dataDict = [dictionary objectForKey:@"data"];
        NSDictionary *tenders = [dataDict objectForKey:@"tenders"];
        for(id tender in tenders)
        {
            KSTender *newTender = [[[KSTender alloc] init] autorelease];
            [newTender initWithServerResponse:tender];
            [array addObject:newTender];
        }
        
        NSLog(@"sds");
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
