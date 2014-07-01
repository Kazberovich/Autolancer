//
//  KSSubscribesViewController.m
//  Autolancer
//
//  Created by user on 14.06.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSSubscribesViewController.h"

@interface KSSubscribesViewController ()

@property (nonatomic, retain) NSMutableArray *loadedTypes;
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

- (void)dealloc
{
    selectedIndexesForCategories = nil;
    selectedIndexesForPlaces = nil;
    selectedIndexesForTypes = nil;
    _currentTag = nil;
    
    [_typeTextView release];
    [_scrollView release];
    [_selectTenderType release];
    [_selectCatrgory release];
    [_selectPlace release];
    [_loadedTypes release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
            LPPopupListView *listView = [[LPPopupListView alloc] initWithTitle:@"Тип заказа" list:[self list:[selector tag]] selectedIndexes:self.selectedIndexesForTypes point:point size:size multipleSelection:YES];
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
                self.typeTextView.text = [self.typeTextView.text stringByAppendingFormat:@"%@\n", [[self list:0] objectAtIndex:idx]];
            }];
            
            break;
        }
            case 1:
        {
            self.selectedIndexesForCategories = [[NSMutableIndexSet alloc] initWithIndexSet:selectedIndexes];
            
            self.categoryTextView.text = @"";
            [selectedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                self.categoryTextView.text = [self.categoryTextView.text stringByAppendingFormat:@"%@\n", [[self list:1] objectAtIndex:idx]];
            }];
            
            break;
        }
            
            case 2:
        {
            self.selectedIndexesForPlaces = [[NSMutableIndexSet alloc] initWithIndexSet:selectedIndexes];
            
            self.placeTextView.text = @"";
            [selectedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                self.placeTextView.text = [self.placeTextView.text stringByAppendingFormat:@"%@\n", [[self list:2] objectAtIndex:idx]];
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
    switch (index) {
            case 0:
            return [NSArray arrayWithObjects:@"Услуги/работы", @"Новые", @"Б/у", nil];
            break;
            
            case 1:
            return [NSArray arrayWithObjects:@"Покраска", @"Земельные", @"Электричество", nil];
            break;
            
            case 2:
            return [NSArray arrayWithObjects:@"Минск", @"Брест", @"Гомель", nil];
            break;
            
        default:
            return [NSArray arrayWithObjects:@"Car", @"Motor", @"Airplane", @"Boat", @"Bike", nil];
    }
}


@end
