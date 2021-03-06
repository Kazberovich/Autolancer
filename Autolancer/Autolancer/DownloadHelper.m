//
//  DownloadHelper.m
//  TheMovieDbClient
//
//  Created by mac-214 on 06.02.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "DownloadHelper.h"


@implementation DownloadHelper

- (void) dealloc
{
    [super dealloc];
}

+ (NSURL *) getUserIdURL: (NSString*) sessionId
{
    return [NSURL URLWithString:[self append:baseApiUrl, accountPartofUrl, api_key, ampersant, sessionIdPart, sessionId, nil]];
}

+ (NSURL *) getWatchlistUrl: (NSString*) sessionId : (NSString*)userId
{
    return [NSURL URLWithString:[self append:baseApiUrl, accountPartofUrl, slash, userId, movieWatchlistPart, api_key, ampersant, sessionIdPart, sessionId, nil]];
}

+ (NSURL*) getImageURLWithShortcut:(NSString *)shortcut
{
    return [NSURL URLWithString:[self append:baseApiImageUrl, shortcut, nil]];    
}

+ (NSString*) getSimilarMoviesURLForId: (NSString*) movieId
{
    NSString *fullUrl = [self append:baseApiUrl, basicMovieInfoUrl, movieId, similarMoviesPartOfUrl, api_key, nil];
    NSLog(@"FUll: %@", fullUrl);
    return fullUrl;
}

+ (NSString*) getBasicMovieInformationUrl: (NSString*) movId
{
    NSLog(@"getBasicMovieInformationURL: id = %@", movId);
    NSString* fullUrl = [self append: baseApiUrl, basicMovieInfoUrl, movId, api_key, nil];
    NSLog(@"Full URL = %@", fullUrl);
    
    return fullUrl;
}

+ (NSString*) getTeamMovieUrlForId: (NSString*) movieId{
    
    NSString *fullUrl = [self append:baseApiUrl, basicMovieInfoUrl, movieId, teamPartOfUrl, api_key, nil];
    NSLog(@"Full URL = %@", fullUrl);
    return fullUrl;
}

+ (NSString*) getBackdropsUrlForId: (NSString*) movieId{
    
    NSString *fullUrl = [self append:baseApiUrl, basicMovieInfoUrl, movieId, backdropsUrl, api_key, nil];
    NSLog(@"Full URL = %@", fullUrl);
    return fullUrl;
}

// autolancer methods
//@"http://autolancer.by/wp-admin/admin-ajax.php?action=get_tendertypes&uid=rrrr&user_id=3"
+ (NSString *)getTenderTypesURLWithUUID:(NSString *)uuid andUserID:(NSString *)userID
{
    NSString *fullURL = [self append: cstAutolanderBaseURL, cstAutolancerAction, cstMethodTenderTypes, ampersant, cstAutolancerUUID, uuid, ampersant, cstAutolancerUserID, userID, nil];
    return fullURL;
}

//http://autolancer.by/wp-admin/admin-ajax.php?action=get_tendercats&tendertype_id=3&uid=rrrr&user_id=3
+ (NSString *)getCategoriesForTendertypeID:(NSString *)tenderTypeID andUUID:(NSString *)uuid withUserID:(NSString *)userID
{
    NSString *fullURL = [self append:cstAutolanderBaseURL, cstAutolancerAction, cstMethodCategoriesForType, ampersant, cstTenderTypeID, tenderTypeID, ampersant, cstAutolancerUUID, uuid, ampersant, cstAutolancerUserID, userID, nil];
    return fullURL;
}

//http://autolancer.by/wp-admin/admin-ajax.php?action=get_regions&uid=rrrr&user_id=3
+ (NSString *)getRegionsURLWithUUID:(NSString *)uuid andUserID:(NSString *)userID
{
    NSString *fullURL = [self append: cstAutolanderBaseURL, cstAutolancerAction, cstMethodRegions, ampersant, cstAutolancerUUID, uuid, ampersant, cstAutolancerUserID, userID, nil];
    return fullURL;
}

//http://autolancer.by/wp-admin/admin-ajax.php?action=get_carmarks&uid=rrrr&user_id=3
+ (NSString *)getCarmarksURLWithUUID:(NSString *)uuid andUserID:(NSString *)userID
{
     NSString *fullURL = [self append: cstAutolanderBaseURL, cstAutolancerAction, cstMethodCarmarks, ampersant, cstAutolancerUUID, uuid, ampersant, cstAutolancerUserID, userID, nil];
    return fullURL;
}

//http://autolancer.by/wp-admin/admin-ajax.php?action=get_models&uid=rrrr&user_id=3&carmark_id=622
+ (NSString *)getCarModelsURLForCarmarkID:(NSString *)carmarkID  andUUID:(NSString *)uuid andUserID:(NSString *)userID
{
    NSString *fullURL = [self append:cstAutolanderBaseURL, cstAutolancerAction, cstMethodCarmodels, ampersant, cstCarmarkID, carmarkID, ampersant, cstAutolancerUUID, uuid, ampersant, cstAutolancerUserID, userID, nil];
    return fullURL;
}

+ (NSString *)getPublicationURL
{
    NSString *fullURL = [self append:cstAutolanderBaseURL, cstAutolancerAction, cstMethodTenderSave, nil];
    return fullURL;
}

+ (NSString *) append:(id) first, ...
{
    NSString * result = @"";
    id eachArg;
    va_list alist;
    if(first)
    {
    	result = [result stringByAppendingString:first];
    	va_start(alist, first);
    	while((eachArg = va_arg(alist, id)))
        {
    		result = [result stringByAppendingString:eachArg];
        }
    	va_end(alist);
    }
    NSLog(@"%@", result);
    return result;
}

@end
