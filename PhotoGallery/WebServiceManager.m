//
//  WebServiceManager.m
//  PhotoGallery
//
//  Created by cuelogic on 04/09/15.
//  Copyright (c) 2015 Cuelogic Technologies. All rights reserved.
//

#import "WebServiceManager.h"
#import "Constants.h"


@implementation WebServiceManager
+ (instancetype)sharedInstance
{
    static WebServiceManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WebServiceManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}
-(void)getImagesFromServer{
    NSURLSession * sessionObj = [NSURLSession sharedSession];
    NSURL * webServiceUrl = [NSURL URLWithString:KgetImageWebServiceUrl];
   NSURLSessionDataTask *dataTask = [sessionObj dataTaskWithURL:webServiceUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"%@", json);
//       [self downloadAndStoreImageData:json];
       if ([self.delegate respondsToSelector:@selector(finishImageDataDownloading:)]) {
           [self.delegate finishImageDataDownloading:json];

       }
       
    }];
  [dataTask resume];
}

@end
