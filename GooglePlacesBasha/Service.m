//
//  Service.m
//  GooglePlacesBasha
//
//  Created by Rajashekhar on 24/05/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import "Service.h"
#import "AppDelegate.h"
@implementation Service
+(Service *)sharedInstance
{
    static Service *serviceApi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serviceApi = [[Service alloc]init];
    });
    
    return serviceApi;
}


+(void)getGooglePlaces:(NSString *)itemDetails withCompletionBlock:(getAllServices)completionBlock{
    NSString *strurl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=(cities)&language=arabic&key=AIzaSyB2RI9WUzjuhLtlRJeBmucn3fnmlWFAxmQ",itemDetails];
    
    NSURL *url = [NSURL URLWithString:[strurl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request  completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      //(@"Response:%@",response);
                                      //(@"Response:%@",data);
                                      if(error){
                                          completionBlock(nil,error);
                                      }
                                      NSError *error1;
                                      NSArray *allCatsArr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error1];
                                      
                                      //NSLog(@"All Services:%@",allCatsArr);
                                      
                                      if(error1){
                                          completionBlock(nil,error1);
                                      }
                                      
                                      else{
                                          completionBlock(allCatsArr,error);
                                      }
                                      
                                  }];
    
    [task resume];
    
    
}

@end
