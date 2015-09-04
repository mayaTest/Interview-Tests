//
//  WebServiceManager.h
//  PhotoGallery
//
//  Created by cuelogic on 04/09/15.
//  Copyright (c) 2015 Cuelogic Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ImageDataProtocol <NSObject>
-(void)finishImageDataDownloading:(NSDictionary *)imageDataDict;
@end
@interface WebServiceManager : NSObject<NSURLSessionDataDelegate>
+ (instancetype)sharedInstance;
@property(nonatomic,strong)id<ImageDataProtocol>delegate;
-(void)getImagesFromServer;
@end
