//
//  Service.h
//  GooglePlacesBasha
//
//  Created by Rajashekhar on 24/05/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service : NSObject

typedef void (^getAllServices)(NSArray *result, NSError *error);
typedef void (^getStringResponse)(NSString *result, NSError *error);
typedef void (^getResponse)(NSDictionary *result, NSError *error);
typedef void (^getAllCategories)(NSArray *result, NSError *error);





+(void)getGooglePlaces:(NSString *)itemDetails withCompletionBlock:(getAllServices)completionBlock;

@end
