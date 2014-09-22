//
//  KSTenderPlace.h
//  Autolancer
//
//  Created by mac-214 on 22.09.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSTenderPlace : NSObject

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *title;

- (id)initWithServerResponse:(NSDictionary *)responseObject;

@end
