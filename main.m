#import <ObjFW/ObjFW.h>
#import "nicotine.h"

int main(void) {
  OFAutoreleasePool *pool = [[OFAutoreleasePool alloc] init];
  [[Nicotine alloc] init];
  [pool release];
  return 0;
}