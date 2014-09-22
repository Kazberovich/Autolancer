//
//  KSTenderType.h
//  Autolancer
//
//  Created by mac-214 on 22.09.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSTenderType : NSObject

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *title;

- (void)initWithDictionary:(NSDictionary *)dictionary;

@end
