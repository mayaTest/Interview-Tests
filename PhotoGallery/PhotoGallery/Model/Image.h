//
//  Image.h
//  
//
//  Created by cuelogic on 04/09/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ImageType;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) ImageType *imageType;

@end
