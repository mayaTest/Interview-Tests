//
//  DataManger.m
//  PhotoGallery
//
//  Created by cuelogic on 04/09/15.
//  Copyright (c) 2015 Cuelogic Technologies. All rights reserved.
//

#import "DataManger.h"
#import "AppDelegate.h"
#import "ImageType.h"
#import "Image.h"
@implementation DataManger
+ (instancetype)sharedInstance
{
    static DataManger *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManger alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}
-(void)saveImageType:(NSString *)imageType
{
    NSManagedObjectContext * context = [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

    ImageType *imageTypeObj = [NSEntityDescription insertNewObjectForEntityForName:@"ImageType"
                                                        inManagedObjectContext:context];
 
    imageTypeObj.imageType = imageType;
    NSError * error;
    if ([context save:&error]) {
        
    }
}
- (void)saveImage:(NSString *)imageName :(NSString *)imageUrl {
    NSManagedObjectContext * context = [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    Image *imageObj = [NSEntityDescription insertNewObjectForEntityForName:@"Image"
                                                            inManagedObjectContext:context];
    
    imageObj.imageName = imageName;
    imageObj.imageUrl = imageUrl;
    NSError * error;

    if ([context save:&error]) {
        
    }
}
@end
