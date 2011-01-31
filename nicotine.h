#import <ObjFW/ObjFW.h>
#import "event.h"
#import "helpers.h"

@interface Nicotine : OFObject <EventProtocol>
{
  Event* event;
}

@end