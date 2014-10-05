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
#import "DownloadHelper.h"
#import "KSTenderCategory.h"
#import "KSTenderPlace.h"
#import "KSCarmark.h"
#import "KSCarModel.h"


@interface KSNewTenderViewController ()

@property (nonatomic, retain) NSArray *loadedTypesArray;
@property (nonatomic, retain) NSArray *loadedCategoriesArray;
@property (nonatomic, retain) NSArray *loadedCarmarksArray;
@property (nonatomic, retain) NSArray *loadedPlacesArray;
@property (nonatomic, retain) NSArray *loadedModelsArray;

@property (nonatomic, retain) NSMutableArray *loadedPlaces;
@property (nonatomic, retain) NSMutableArray *loadedCarmarks;
@property (nonatomic, retain) NSMutableArray *loadedCategories;
@property (nonatomic, retain) NSMutableArray *loadedTypes;
@property (nonatomic, retain) NSMutableArray *loadedModels;

@property (nonatomic, retain) NSMutableIndexSet *selectedIndexes;
@property (nonatomic, retain) NSMutableIndexSet *selectedIndexesForCategories;
@property (nonatomic, retain) NSMutableIndexSet *selectedIndexesForPlaces;
@property (nonatomic, retain) NSMutableIndexSet *selectedIndexesForTypes;
@property (nonatomic, retain) NSMutableIndexSet *selectedIndexesForCarmarks;
@property (nonatomic, retain) NSMutableIndexSet *selectedIndexesForModels;

@property (nonatomic, retain) NSString *selectedTenderTypeID;
@property (nonatomic, retain) NSString *selectedCarmarkID;

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
@synthesize selectedIndexesForCarmarks;
@synthesize selectedIndexesForModels;
@synthesize image = _image;
@synthesize loadedTypesArray = _loadedTypesArray;
@synthesize selectedTenderTypeID = _selectedTenderTypeID;
@synthesize selectedCarmarkID = _selectedCarmarkID;
@synthesize indicator = _indicator;

- (void)dealloc
{
    selectedIndexesForCategories = nil;
    selectedIndexesForPlaces = nil;
    selectedIndexesForTypes = nil;
    selectedIndexesForModels = nil;
    selectedIndexesForCarmarks = nil;
    
    [_selectedTenderTypeID release];
    [_selectedCarmarkID release];
    [_indicator release];
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
    
   // [_scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height - self.navigationController.navigationBar.bounds.size.height)];
    //[_scrollView setScrollEnabled:YES];
    
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
    
    [_indicator startAnimating];
    
    float paddingTopBottom = 20.0f;
    float paddingLeftRight = 20.0f;
    
    CGPoint point = CGPointMake(paddingLeftRight, (self.navigationController.navigationBar.frame.size.height + paddingTopBottom) + paddingTopBottom);
    CGSize size = CGSizeMake((self.view.frame.size.width - (paddingLeftRight * 2)), self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - ((self.navigationController.navigationBar.frame.size.height + paddingTopBottom) + (paddingTopBottom * 2)));
    
    NSString *listTitle = [[[NSString alloc] init] autorelease];
    
    switch ([selector tag]) {
        case 0:
        {
            listTitle = @"Тип заказа";
            
            [ApiLoadService getResponseForURL:[NSURL URLWithString:[DownloadHelper getTenderTypesURLWithUUID:@"rrr" andUserID:@"3"]] callback:^(NSDictionary *dictionary, NSURL *url) {
                
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
                
                LPPopupListView *listView = [[LPPopupListView alloc] initWithTitle:listTitle list:[self list:[selector tag]] selectedIndexes:self.selectedIndexesForTypes point:point size:size multipleSelection:NO];
                listView.delegate = self;
                [_indicator stopAnimating];
                
                [listView showInView:self.navigationController.view animated:YES];
            }];
            break;
        }
        case 1:
        {
            listTitle = @"Категории";
            
            [ApiLoadService getResponseForURL:[NSURL URLWithString:[DownloadHelper getCategoriesForTendertypeID:_selectedTenderTypeID andUUID:@"rrr" withUserID:@"123"]] callback:^(NSDictionary *dictionary, NSURL *url) {
     
                _loadedCategories = nil;
                _loadedCategories = [[[NSMutableArray alloc] init] autorelease];
                
                NSDictionary *dataDict = [dictionary objectForKey:@"data"];
                NSDictionary *cats = [dataDict objectForKey:@"cats"];
                NSLog(@"%@", cats);
                
                for(id category  in cats)
                {
                    [_loadedCategories addObject: [[KSTenderCategory alloc] initWithServerResponse:category]];
                }
                [_loadedCategories retain];
                
                LPPopupListView *listView = [[LPPopupListView alloc] initWithTitle:listTitle list:[self list:[selector tag]] selectedIndexes:self.selectedIndexesForCategories point:point size:size multipleSelection:YES];
                listView.delegate = self;
                [_indicator stopAnimating];
                [listView showInView:self.navigationController.view animated:YES];
            }];

            break;
        }
        case 2:
        {
            listTitle = @"Местоположение";
            
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
                                         
                                         LPPopupListView *listView = [[LPPopupListView alloc] initWithTitle:listTitle list:[self list:[selector tag]] selectedIndexes:self.selectedIndexesForPlaces point:point size:size multipleSelection:YES];
                                         listView.delegate = self;
                                         [_indicator stopAnimating];
                                         [listView showInView:self.navigationController.view animated:YES];
                                     }];
            
            break;
        }
        case 3:
        {
            listTitle = @"Марка автомобиля";
            
            [ApiLoadService getResponseForURL:[NSURL URLWithString:[DownloadHelper getCarmarksURLWithUUID:@"rrr" andUserID:@"123"]] callback:^(NSDictionary *dictionary, NSURL *url) {
                NSLog(@"%@", dictionary);
                NSLog(@"%@" , dictionary);
                _loadedCarmarks = [[[NSMutableArray alloc] init] autorelease];
                
                NSDictionary *carmarksDictionary = [dictionary objectForKey:@"data"];
                NSDictionary *carmarks = [carmarksDictionary objectForKey:@"carmarks"];
                NSLog(@"%@", carmarks);
                
                for(id carmark in carmarks)
                {
                    KSCarmark *mark = [[KSCarmark alloc] initWithServerResponse:carmark];
                    [_loadedCarmarks addObject:mark];
                    [mark release];
                }
                [_loadedCarmarks retain];
                
                LPPopupListView *listView = [[LPPopupListView alloc] initWithTitle:listTitle list:[self list:[selector tag]] selectedIndexes:self.selectedIndexesForCarmarks point:point size:size multipleSelection:NO];
                listView.delegate = self;
                [_indicator stopAnimating];
                [listView showInView:self.navigationController.view animated:YES];
            }];
            
            break;
        }
        case 4:
        {
            listTitle = @"Модель автомобиля";
            
            [ApiLoadService getResponseForURL:[NSURL URLWithString:[DownloadHelper getCarModelsURLForCarmarkID:_selectedCarmarkID andUUID:@"rrr" andUserID:@"123"]] callback:^(NSDictionary *dictionary, NSURL *url) {
                
                NSLog(@"%@", dictionary);
                _loadedModels = [[[NSMutableArray alloc] init] autorelease];
                
                NSDictionary *carmodelsDictionary = [dictionary objectForKey:@"data"];
                NSDictionary *carmodels = [carmodelsDictionary objectForKey:@"carmodels"];
                NSLog(@"%@", carmodels);
                
                for(id carmodel in carmodels)
                {
                    KSCarmark *model = [[KSCarmark alloc] initWithServerResponse:carmodel];
                    [_loadedModels addObject:model];
                    [model release];
                }
                [_loadedModels retain];
                
                LPPopupListView *listView = [[LPPopupListView alloc] initWithTitle:listTitle list:[self list:[selector tag]] selectedIndexes:self.selectedIndexesForModels point:point size:size multipleSelection:NO];
                listView.delegate = self;
                [_indicator stopAnimating];
                [listView showInView:self.navigationController.view animated:YES];
            }];
            
            break;
        }

        default:
            break;
    }
}

#pragma mark - LPPopupListViewDelegate

- (void)popupListView:(LPPopupListView *)popUpListView didSelectIndex:(NSInteger)index
{
    switch (self.currentTag) {
        case 0:
        {
            _selectedTenderTypeID = ((KSTenderType*)[_loadedTypes objectAtIndex:index]).ID;
            _typeTextView.text = @"";
            self.typeTextView.text = [self.typeTextView.text stringByAppendingFormat:@" - %@\n", [[self list:0] objectAtIndex:index]];
            self.categoryTextView.text = @"";
            self.selectedIndexesForCategories = nil;

            break;
        }
        case 3:
        {
            _selectedCarmarkID = ((KSCarmark *)[_loadedCarmarks objectAtIndex:index]).ID;
            _carmarkTextView.text = @"";
            _carmarkTextView.text = [_carmarkTextView.text stringByAppendingFormat:@" - %@\n", [[self list:3] objectAtIndex:index]];
            _carmodelTextView.text = @"";
            self.selectedIndexesForModels = nil;
            
            break;
        }
        case 4:
        {
            _carmodelTextView.text = @"";
            _carmodelTextView.text = [_carmodelTextView.text stringByAppendingFormat:@" - %@\n", [[self list:4] objectAtIndex:index]];
            
            break;
        }
        default:break;
    }
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
                self.placeTextView.text = [self.placeTextView.text stringByAppendingFormat:@"%@\n", [[self list:2] objectAtIndex:idx]];
            }];
            
            break;
        }
        case 3:
        {
            self.selectedIndexesForCarmarks = [[NSMutableIndexSet alloc] initWithIndexSet:selectedIndexes];
            self.carmarkTextView.text = @"";
            [selectedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                self.carmarkTextView.text = [self.carmarkTextView.text stringByAppendingFormat:@"%@\n", [[self list:3] objectAtIndex:idx]];
            }];
            
            break;
        }
        case 4:
        {
            self.selectedIndexesForModels = [[NSMutableIndexSet alloc] initWithIndexSet:selectedIndexes];
            self.carmodelTextView.text = @"";
            [selectedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                self.carmodelTextView.text = [self.carmodelTextView.text stringByAppendingFormat:@"%@\n", [[self list:4] objectAtIndex:idx]];
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
        case 3:
        {
            NSMutableArray *carmarksArray = [[[NSMutableArray alloc] init] autorelease];
            for (KSCarmark *carmark in _loadedCarmarks)
            {
                [carmarksArray addObject:carmark.title];
            }
            _loadedCarmarksArray = [NSArray arrayWithArray:carmarksArray];
            return _loadedCarmarksArray;
            break;
        }
        case 4:
        {
            NSMutableArray *carmodelsArray = [[[NSMutableArray alloc] init] autorelease];
            for (KSCarModel *carmodel in _loadedModels)
            {
                [carmodelsArray addObject:carmodel.title];
            }
            _loadedModelsArray = [NSArray arrayWithArray:carmodelsArray];
            return _loadedModelsArray;
            break;
        }
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
