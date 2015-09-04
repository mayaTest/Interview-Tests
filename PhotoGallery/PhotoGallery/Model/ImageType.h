//
//  ImageType.h
//  
//
//  Created by cuelogic on 04/09/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

@interface ImageType : NSManagedObject

@property (nonatomic, retain) NSNumber * imageTypeId;
@property (nonatomic, retain) NSString * imageType;
@property (nonatomic, retain) NSSet *image;
@end

@interface ImageType (CoreDataGeneratedAccessors)

- (void)addImageObject:(Image *)value;
- (void)removeImageObject:(Image *)value;
- (void)addImage:(NSSet *)values;
- (void)removeImage:(NSSet *)values;

@end
