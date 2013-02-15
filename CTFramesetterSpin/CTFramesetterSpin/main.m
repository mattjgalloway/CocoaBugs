#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

int main(int argc, char *argv[]) {
    @autoreleasepool {
		NSMutableAttributedString *nsAttrStr = [[NSMutableAttributedString alloc] initWithString:@"BADGER 🙆😚😘 BADGER"];
		[nsAttrStr addAttribute:@"TEST" value:@"TEST" range:NSMakeRange(7, 1)];
		CFAttributedStringRef cfAttrStr = (__bridge CFAttributedStringRef)nsAttrStr;
		__unused CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(cfAttrStr);
        return 0;
    }
}
