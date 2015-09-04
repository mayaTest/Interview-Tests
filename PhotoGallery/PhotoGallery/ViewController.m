//
//  ViewController.m
//  PhotoGallery
//
//  Created by Sachin Patil on 24/08/15.
//  Copyright (c) 2015 Cuelogic Technologies. All rights reserved.
//

#import "ViewController.h"
#import "WebServiceManager.h"
#import "DataManger.h"
#import "AppDelegate.h"
@interface ViewController ()<ImageDataProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [WebServiceManager sharedInstance].delegate = self;
    [[WebServiceManager sharedInstance] getImagesFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ImageDataProtocol delegate Method

-(void)finishImageDataDownloading:(NSDictionary *)imageDataDict {
    // save Image data into database
    
    for (NSString *key in imageDataDict) {
        [[DataManger sharedInstance] saveImageType:key];
        NSArray * imagesArray = [imageDataDict valueForKey:key];
        for (NSDictionary * imageDict in imagesArray) {
            NSString * imageName = [imageDict valueForKey:@"name"];
            NSString * imageUrl = [imageDict valueForKey:@"imgURL"];
            [[DataManger sharedInstance] saveImage:imageName :imageUrl];
        }
        
    }
  
}
@end
