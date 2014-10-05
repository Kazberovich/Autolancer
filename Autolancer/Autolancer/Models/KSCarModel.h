//
//  KSCarModel.h
//  Autolancer
//
//  Created by user on 05.10.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSCarModel : NSObject

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *title;

- (id)initWithServerResponse:(NSDictionary *)responseObject;

@end
