//
//  KSNewTenderViewController.m
//  Autolancer
//
//  Created by mac-214 on 24.04.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSNewTenderViewController.h"
#import "ApiLoadService.h"
#import "KSTenderType.h"

@interface KSNewTenderViewController ()

@property (nonatomic, retain) NSMutableArray *loadedTypes;
@property (nonatomic, retain) NSMutableIndexSet *selectedIndexes;
@property (nonatomic, retain) NSMutableIndexSet *selectedIndexesForCategories;
@property (nonatomic, retain) NSMutableIndexSet *selectedIndexesForPlaces;
@property (nonatomic, retain) NSMutableIndexSet *selectedIndexesForTypes;

@property (assign) NSInteger currentTag;

@end

@implementation KSNewTenderViewController

@synthesize scrollView = _scrollView;
@synthesize selectTenderType = _selectTenderType;
@synthesize selectCatrgory = _selectCatrgory;
@synthesize selectPlace = _selectPlace;
@synthesize loadedTypes = _loadedTypes;
@synthesize selectedIndexesForCategories;
@synthesize selectedIndexesForPlaces;
@synthesize selectedIndexesForTypes;
@synthesize image = _image;

- (void)dealloc
{
    selectedIndexesForCategories = nil;
    selectedIndexesForPlaces = nil;
    selectedIndexesForTypes = nil;
    
    [_image release];
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
    self.tabBarController.title = @"Новый заказ";
    
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height)];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Готово" style:UIBarButtonItemStyleBordered target:self action:@selector(actionDone)];
    doneItem.image = [UIImage imageNamed:@"apply.png"];
    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(openCamera)];
    NSArray *actionButtonItems = @[doneItem];
    
    self.tabBarController.navigationItem.rightBarButtonItems = actionButtonItems;
    self.tabBarController.navigationItem.leftBarButtonItem = cameraItem;
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.tabBarController.navigationItem.rightBarButtonItems = nil;
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
}

- (void)actionCamera
{
    NSLog(@"actionCamera");
}

- (void)actionDone
{
    NSLog(@"actionDone");
}

#pragma mark - Button

- (IBAction)buttonClicked:(id)selector
{
    self.currentTag = [selector tag];
    
    float paddingTopBottom = 20.0f;
    float paddingLeftRight = 20.0f;
    
    CGPoint point = CGPointMake(paddingLeftRight, (self.navigationController.navigationBar.frame.size.height + paddingTopBottom) + paddingTopBottom);
    CGSize size = CGSizeMake((self.view.frame.size.width - (paddingLeftRight * 2)), self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - ((self.navigationController.navigationBar.frame.size.height + paddingTopBottom) + (paddingTopBottom * 2)));
    
    NSString *listTitle = [[[NSString alloc] init] autorelease];
    
    switch ([selector tag]) {
        case 0:
        {
            listTitle = @"Тип заказа";
            LPPopupListView *listView = [[LPPopupListView alloc] initWithTitle:listTitle list:[self list:[selector tag]] selectedIndexes:self.selectedIndexesForTypes point:point size:size multipleSelection:YES];
            listView.delegate = self;
            
            [listView showInView:self.navigationController.view animated:YES];
            break;
        }
        case 1:
        {
            listTitle = @"Категории";
            LPPopupListView *listView = [[LPPopupListView alloc] initWithTitle:listTitle list:[self list:[selector tag]] selectedIndexes:self.selectedIndexesForCategories point:point size:size multipleSelection:YES];
            listView.delegate = self;
            
            [listView showInView:self.navigationController.view animated:YES];
            break;
        }
        case 2:
        {
            listTitle = @"Местоположение";
            LPPopupListView *listView = [[LPPopupListView alloc] initWithTitle:listTitle list:[self list:[selector tag]] selectedIndexes:self.selectedIndexesForPlaces point:point size:size multipleSelection:YES];
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
            
            self.typeTextView.text = @"";
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

#pragma mark - Camera

- (void) openCamera
{
    DBCameraContainerViewController *cameraContainer = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cameraContainer];
    [nav setNavigationBarHidden:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

//Use your captured image
#pragma mark - DBCameraViewControllerDelegate

- (void) captureImageDidFinish:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
    [_image setImage:image];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
