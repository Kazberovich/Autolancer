//
//  DownloadHelper.h
//  TheMovieDbClient
//
//  Created by mac-214 on 06.02.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//


#import <Foundation/Foundation.h>

#define api_key @"?api_key=48ed176d044976544817d2b4f21f3567"
#define baseApiUrl @"http://api.themoviedb.org"
#define baseApiImageUrl @"http://image.tmdb.org/t/p/w500"
#define basicMovieInfoUrl @"/3/movie/"
#define teamPartOfUrl @"/credits"
#define backdropsUrl @"/images"
#define similarMoviesUrl @"/"
#define similarMoviesPartOfUrl @"/similar_movies"
#define accountPartofUrl @"/3/account"
#define movieWatchlistPart @"/movie_watchlist"
#define ampersant @"&"
#define sessionIdPart @"session_id="
#define slash @"/"
#define kGetTokenRequestBody @"https://api.themoviedb.org/3/authentication/token/new?api_key=48ed176d044976544817d2b4f21f3567"
#define kAuthentificationURL @"https://www.themoviedb.org/authenticate/"
#define kNewSession @"https://api.themoviedb.org/3/authentication/session/new?api_key=48ed176d044976544817d2b4f21f3567&request_token="

#pragma mark - Autolancer URL constants

#define cstAutolanderBaseURL @"http://autolancer.by/wp-admin/admin-ajax.php?"
#define cstAutolancerAction @"action="
#define cstAutolancerUUID @"uid="
#define cstAutolancerUserID @"user_id="

//tendertypes
#define cstTenderTypesURL @"http://autolancer.by/wp-admin/admin-ajax.php?action=get_tendertypes&uid=rrrr&user_id=3"
#define cstMethodTenderTypes @"get_tendertypes"

//tendercats
#define cstMethodCategoriesForType @"get_tendercats"
#define cstTenderTypeID @"tendertype_id="

//regions
#define cstMethodRegions @"get_regions"

@interface DownloadHelper : NSObject

@property (nonatomic, retain) NSString *movieId;

+ (NSString *) getBasicMovieInformationUrl: (NSString*) movieId;
+ (NSString *) getTeamMovieUrlForId: (NSString*) movieId;
+ (NSString *) getBackdropsUrlForId: (NSString*) movieId;
+ (NSString *) getSimilarMoviesURLForId: (NSString*) movieId;
+ (NSURL *) getImageURLWithShortcut: (NSString*) shortcut;
+ (NSString *) append:(id) first, ...;
+ (NSURL *) getWatchlistUrl: (NSString*) sessionId : (NSString*)userId;
+ (NSURL *) getUserIdURL: (NSString*) sessionId;

// autolancer methods
+ (NSString *)getTenderTypesURLWithUUID:(NSString *)uuid andUserID:(NSString *)userID;
+ (NSString *)getCategoriesForTendertypeID:(NSString *)tenderTypeID andUUID:(NSString *)uuid withUserID:(NSString *)userID;
+ (NSString *)getRegionsURLWithUUID:(NSString *)uuid andUserID:(NSString *)userID;


@end
