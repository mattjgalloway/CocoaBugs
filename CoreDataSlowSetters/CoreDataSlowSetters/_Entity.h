// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Entity.h instead.

#import <CoreData/CoreData.h>


extern const struct EntityAttributes {
	__unsafe_unretained NSString *custom;
	__unsafe_unretained NSString *generic;
} EntityAttributes;

extern const struct EntityRelationships {
} EntityRelationships;

extern const struct EntityFetchedProperties {
} EntityFetchedProperties;





@interface EntityID : NSManagedObjectID {}
@end

@interface _Entity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EntityID*)objectID;





@property (nonatomic, strong) NSString* custom;



//- (BOOL)validateCustom:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* generic;



//- (BOOL)validateGeneric:(id*)value_ error:(NSError**)error_;






@end

@interface _Entity (CoreDataGeneratedAccessors)

@end

@interface _Entity (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCustom;
- (void)setPrimitiveCustom:(NSString*)value;




- (NSString*)primitiveGeneric;
- (void)setPrimitiveGeneric:(NSString*)value;




@end
