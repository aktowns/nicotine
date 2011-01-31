#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <dirent.h>
#include <string.h>
#include <event.h>
#include <evhttp.h>
#import <ObjFW/ObjFW.h>

#define kReturnType @"RETURNTYPE"
#define kReturnString @"RETURNSTRING"

#define RESP_BADREQUEST [OFNumber numberWithInt:HTTP_BADREQUEST]
#define RESP_MOVEPERM [OFNumber numberWithInt:HTTP_MOVEPERM]
#define RESP_MOVETEMP [OFNumber numberWithInt:HTTP_MOVETEMP]
#define RESP_NOCONTENT [OFNumber numberWithInt:HTTP_NOCONTENT]
#define RESP_NOTFOUND [OFNumber numberWithInt:HTTP_NOTFOUND]
#define RESP_NOTMODIFIED [OFNumber numberWithInt:HTTP_NOTMODIFIED]
#define RESP_OK [OFNumber numberWithInt:HTTP_OK]
#define RESP_SERVERUNAVAIL [OFNumber numberWithInt:HTTP_SERVUNAVAIL]

@protocol EventProtocol
-(id) EventReceiverWithURI:(OFString*) uri andRequest:(struct evhttp_request*) req;
@end

@interface Event : OFObject
{
  struct event_base* evbase;
  struct evhttp* evhttp;
  id delegate;
}
@property (nonatomic) struct evhttp* evhttp;
@property (nonatomic, retain) id delegate;

- (void) bind:(int) port;
- (void) listen;
@end