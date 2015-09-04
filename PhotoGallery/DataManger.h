//
//  DataManger.h
//  PhotoGallery
//
//  Created by cuelogic on 04/09/15.
//  Copyright (c) 2015 Cuelogic Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManger : NSObject
+ (instancetype)sharedInstance;
-(void)saveImageType:(NSString *)imageType;
- (void)saveImage:(NSString *)imageName :(NSString *)imageUrl;
@end
