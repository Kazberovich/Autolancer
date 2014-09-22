//
//  KSSubscribesViewController.m
//  Autolancer
//
//  Created by user on 14.06.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSSubscribesViewController.h"
#import "ApiLoadService.h"
#import "DownloadHelper.h"
#import "KSTenderType.h"
#import "KSTenderCategory.h"
#import "KSTenderPlace.h"

@interface KSSubscribesViewController ()

@property (nonatomic, retain) NSArray *loadedTypesArray;
@property (nonatomic, retain) NSMutableArray *loadedTypes;

@property (nonatomic, retain) NSArray *loadedCategoriesArray;
@property (nonatomic, retain) NSMutableArray *loadedCategories;

@property (nonatomic, retain) NSArray *loadedPlacesArray;
@property (nonatomic, retain) NSMutableArray *loadedPlaces;

@property (nonatomic, retain) NSMutableIndexSet *selectedIndexes;
@property (nonatomic, retain) NSMutableIndexSet *selectedIndexesForCategories;
@property (nonatomic, retain) NSMutableIndexSet *selectedIndexesForPlaces;
@property (nonatomic, retain) NSMutableIndexSet *selectedIndexesForTypes;
@property (assign) NSInteger currentTag;

@end

@implementation KSSubscribesViewController

@synthesize scrollView = _scrollView;
@synthesize selectTenderType = _selectTenderType;
@synthesize selectCatrgory = _selectCatrgory;
@synthesize selectPlace = _selectPlace;
@synthesize loadedTypes = _loadedTypes;
@synthesize selectedIndexesForCategories;
@synthesize selectedIndexesForPlaces;
@synthesize selectedIndexesForTypes;
@synthesize typeTextView = _typeTextView;
@synthesize currentTag =_currentTag;
@synthesize loadedPlaces = _loadedPlaces;
@synthesize loadedPlacesArray = _loadedPlacesArray;

- (void)dealloc
{
    selectedIndexesForCategories = nil;
    selectedIndexesForPlaces = nil;
    selectedIndexesForTypes = nil;

    [_typeTextView release];
    [_scrollView release];
    [_selectTenderType release];
    [_selectCatrgory release];
    [_selectPlace release];
    [_loadedTypes release];
    [_loadedTypesArray release];
    [_loadedCategories release];
    [_loadedCategoriesArray release];
    [_loadedPlaces release];
    [_loadedPlacesArray release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ApiLoadService getResponseForURL:[NSURL URLWithString:[DownloadHelper getTenderTypesURLWithUUID:@"rrr" andUserID:@"3"]]
                             callback:^(NSDictionary *dictionary, NSURL *url) {
        
        NSLog(@"%@" , dictionary);
        _loadedTypes = [[[NSMutableArray alloc] init] autorelease];
        
        NSDictionary *dataDict = [dictionary objectForKey:@"data"];
        NSDictionary *tenderTypes = [dataDict objectForKey:@"tendertypes"];
        NSLog(@"%@", tenderTypes);
        
        for(id tenderType in tenderTypes)
        {
            KSTenderType *type = [[KSTenderType alloc] initWithServerResponse:tenderType];
            [_loadedTypes addObject:type];
            [type release];
        }
        [_loadedTypes retain];
    }];
    
    
    [ApiLoadService getResponseForURL:[NSURL URLWithString:[DownloadHelper getRegionsURLWithUUID:@"rrr" andUserID:@"3"]]
                             callback:^(NSDictionary *dictionary, NSURL *url) {
                                 
                                 NSLog(@"%@" , dictionary);
                                 _loadedPlaces = [[[NSMutableArray alloc] init] autorelease];
                                 
                                 NSDictionary *dataDict = [dictionary objectForKey:@"data"];
                                 NSDictionary *regions = [dataDict objectForKey:@"regions"];
                                 NSLog(@"%@", regions);
                                 
                                 for(id region in regions)
                                 {
                                     KSTenderPlace *place = [[KSTenderPlace alloc] initWithServerResponse:region];
                                     [_loadedPlaces addObject:place];
                                     [place release];
                                 }
                                 [_loadedPlaces retain];
                             }];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.title = @"Подписки";
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.tabBarController.navigationItem.rightBarButtonItems = nil;
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
}

#pragma mark - Button

- (IBAction)buttonClicked:(id)selector
{
    self.currentTag = [selector tag];
    
    float paddingTopBottom = 20.0f;
    float paddingLeftRight = 20.0f;
    
    CGPoint point = CGPointMake(paddingLeftRight, (self.navigationController.navigationBar.frame.size.height + paddingTopBottom) + paddingTopBottom);
    CGSize size = CGSizeMake((self.view.frame.size.width - (paddingLeftRight * 2)), self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - ((self.navigationController.navigationBar.frame.size.height + paddingTopBottom) + (paddingTopBottom * 2)));
    
    switch ([selector tag]) {
        case 0:
        {
           
            LPPopupListView *listView = [[LPPopupListView alloc] initWithTitle:@"Тип заказа" list:[self list:[selector tag]] selectedIndexes:self.selectedIndexesForTypes point:point size:size multipleSelection:NO];
            listView.delegate = self;
            [listView showInView:self.navigationController.view animated:YES];
            
            break;
        }
        case 1:
        {
            LPPopupListView *listView = [[LPPopupListView alloc] initWithTitle:@"Категории" list:[self list:[selector tag]] selectedIndexes:self.selectedIndexesForCategories point:point size:size multipleSelection:YES];
            listView.delegate = self;
            
            [listView showInView:self.navigationController.view animated:YES];
            break;
        }
        case 2:
        {
            LPPopupListView *listView = [[LPPopupListView alloc] initWithTitle:@"Местоположение" list:[self list:[selector tag]] selectedIndexes:self.selectedIndexesForPlaces point:point size:size multipleSelection:YES];
            listView.delegate = self;
            
            [listView showInView:self.navigationController.view animated:YES];
            break;
        }
        default:
            
            break;
    }
}

#pragma mark - LPPopupListViewDelegate

- (void)popupListView:(LPPopupListView *)popUpListView didSelectIndex:(NSInteger)index
{
    NSLog(@"popUpListView - didSelectIndex: %ld", (long)index);
    
    switch (self.currentTag) {
        case 0:
        {
            _typeTextView.text = @"";
            self.typeTextView.text = [self.typeTextView.text stringByAppendingFormat:@" - %@\n", [[self list:0] objectAtIndex:index]];
            self.categoryTextView.text = @"";
            self.selectedIndexesForCategories = nil;
            
            [ApiLoadService getResponseForURL:[NSURL URLWithString:[DownloadHelper getCategoriesForTendertypeID:((KSTenderType*)[_loadedTypes objectAtIndex:index]).ID andUUID:@"rrr" withUserID:@"3"]] callback:^(NSDictionary *dictionary, NSURL *url) {
                
                _loadedCategories = nil;
                
                NSLog(@"%@" , dictionary);
                _loadedCategories = [[[NSMutableArray alloc] init] autorelease];
                
                NSDictionary *dataDict = [dictionary objectForKey:@"data"];
                
                NSDictionary *cats = [dataDict objectForKey:@"cats"];
                NSLog(@"%@", cats);
                
                for(id category  in cats)
                {
                    [_loadedCategories addObject: [[KSTenderCategory alloc] initWithServerResponse:category]];
                }
                [_loadedCategories retain];
            }];
            
            break;
        }
        case 1:
        {
            
            self.categoryTextView.text = @"";
            self.categoryTextView.text = [self.categoryTextView.text stringByAppendingFormat:@" - %@\n", [[self list:1] objectAtIndex:index]];
            
            break;
        }
            
        case 2:
        {
            self.placeTextView.text = @"";
            self.placeTextView.text = [self.placeTextView.text stringByAppendingFormat:@" - %@\n", [[self list:2] objectAtIndex:index]];
            
            break;
        }
            
        default:
            break;
    }

}

- (void)popupListViewDidHide:(LPPopupListView *)popUpListView selectedIndexes:(NSIndexSet *)selectedIndexes
{
    NSLog(@"popupListViewDidHide - selectedIndexes: %@", selectedIndexes.description);
    
    switch (self.currentTag) {
        case 0:
        {
            self.selectedIndexesForTypes = [[NSMutableIndexSet alloc] initWithIndexSet:selectedIndexes];
            
            _typeTextView.text = @"";
            [selectedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                self.typeTextView.text = [self.typeTextView.text stringByAppendingFormat:@" - %@\n", [[self list:0] objectAtIndex:idx]];
            }];
            
            break;
        }
        case 1:
        {
            self.selectedIndexesForCategories = [[NSMutableIndexSet alloc] initWithIndexSet:selectedIndexes];
            
            self.categoryTextView.text = @"";
            [selectedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                self.categoryTextView.text = [self.categoryTextView.text stringByAppendingFormat:@" - %@\n", [[self list:1] objectAtIndex:idx]];
            }];
            
            break;
        }
            
        case 2:
        {
            self.selectedIndexesForPlaces = [[NSMutableIndexSet alloc] initWithIndexSet:selectedIndexes];
            
            self.placeTextView.text = @"";
            [selectedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                self.placeTextView.text = [self.placeTextView.text stringByAppendingFormat:@" - %@\n", [[self list:2] objectAtIndex:idx]];
            }];
            
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark - Array List

- (NSArray *)list :(NSInteger)index
{
    switch (index)
    {
        case 0:
        {
            NSMutableArray *typesArray = [[[NSMutableArray alloc] init] autorelease];
            for (KSTenderType *type in _loadedTypes)
            {
                [typesArray addObject:type.title];
            }
            _loadedTypesArray = [NSArray arrayWithArray:typesArray];
            return  _loadedTypesArray;
            
            break;
        }
        case 1:
        {
            NSMutableArray *categoryArray = [[[NSMutableArray alloc] init] autorelease];
            for (KSTenderCategory *category in _loadedCategories)
            {
                [categoryArray addObject:category.title];
            }
            _loadedCategoriesArray = [NSArray arrayWithArray:categoryArray];
            return _loadedCategoriesArray;
            
            break;
        }
        case 2:
        {
            NSMutableArray *placesArray = [[[NSMutableArray alloc] init] autorelease];
            for (KSTenderPlace *place in _loadedPlaces)
            {
                [placesArray addObject:place.title];
            }
            _loadedPlacesArray = [NSArray arrayWithArray:placesArray];
            return _loadedPlacesArray;
           
            break;
        }
        default:
            return [NSArray arrayWithObjects:@"НЕТ", @"ДАННЫХ", @"ДЛЯ", @"ОТОБРАЖЕНИЯ", @"Bike", nil];
    }
}

@end
