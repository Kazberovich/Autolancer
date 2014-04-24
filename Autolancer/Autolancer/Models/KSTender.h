//
//  KSTender.h
//  Autolancer
//
//  Created by mac-214 on 24.04.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSTender : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *carmark;
@property (nonatomic, retain) NSString *carmodel;
@property (nonatomic, retain) NSString *postDate;
@property (nonatomic, retain) NSString *place;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *views;
@property (nonatomic, retain) NSString *offers;
@property (nonatomic, retain) NSString *carYear;
@property (nonatomic, retain) NSString *description;

- (id)initWithServerResponse:(NSDictionary *)responseObject;

@end
