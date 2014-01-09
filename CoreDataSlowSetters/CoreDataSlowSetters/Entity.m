#import "Entity.h"


@interface Entity ()

// Private interface goes here.

@end


@implementation Entity

- (void)setCustom:(NSString *)custom {
    [self willChangeValueForKey:@"custom"];
    [self setPrimitiveCustom:custom];
    [self didChangeValueForKey:@"custom"];
}

@end
