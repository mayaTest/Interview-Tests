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
#import "Image.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import "ImageCollectionViewCell.h"
#import "ImageType.h"
@interface ViewController ()<ImageDataProtocol,UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *imageGallaryCollectionView;
@property (strong, nonatomic)NSFetchedResultsController *fetchedResultsController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"isImagesDownload"]) {
        [WebServiceManager sharedInstance].delegate = self;
        [[WebServiceManager sharedInstance] getImagesFromServer];

    }
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    [self.imageGallaryCollectionView reloadData];
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
    [[NSUserDefaults standardUserDefaults] setValue:@"Yes" forKey:@"isImagesDownload"];
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    dispatch_async(dispatch_get_main_queue(), ^{
          [self.imageGallaryCollectionView reloadData];
    });
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext * context = [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityPerson = [NSEntityDescription entityForName:@"Image" inManagedObjectContext:context];
    [request setEntity:entityPerson];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"imageName" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];

    NSFetchedResultsController *fetchedResults = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController = fetchedResults;
    self.fetchedResultsController.delegate = (id)self;
    
    return self.fetchedResultsController;
}
#pragma mark- Collection view Data Source Method
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
     return [[self.fetchedResultsController sections] count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"imageGallaryCell";
    
    ImageCollectionViewCell *cell = (ImageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Image *imageObj = [self.fetchedResultsController objectAtIndexPath:indexPath];
   [cell.gallaryImageView setImageWithURL:[NSURL URLWithString:imageObj.imageUrl] placeholderImage:[UIImage imageNamed:@"Default"]];
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
   UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][indexPath.section];
        
      Image *imageObj = [self.fetchedResultsController objectAtIndexPath:indexPath];
        UILabel * textLabel = (UILabel *)[headerView viewWithTag:100];
        textLabel.text = sectionInfo.indexTitle;
        
        return headerView;
    
    }
   

return reusableview;
}
@end
