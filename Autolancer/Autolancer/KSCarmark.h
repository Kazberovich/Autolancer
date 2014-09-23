//
//  KSCarmark.h
//  Autolancer
//
//  Created by mac-214 on 23.09.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSCarmark : NSObject

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *title;

- (id)initWithServerResponse:(NSDictionary *)responseObject;

@end
