#import "event.h"

@implementation Event
@synthesize evhttp, delegate;

void glue(struct evhttp_request *req, id arg) {
  id response = [arg EventReceiverWithURI:[OFString stringWithCString:evhttp_request_uri(req)] andRequest:req];
  if (response == nil) {
    printf("[I] Returning not found for: %s\n", evhttp_request_uri(req));
    evhttp_send_error(req, HTTP_NOTFOUND, "Not found");
  } else if ([response isKindOfClass:[OFString class]]) {
    printf("[I] Returning generic response for: %s\nwith:\n%s",evhttp_request_uri(req), [response cString]);
    struct evbuffer *send_buf = evbuffer_new();
    evbuffer_add_printf(send_buf, "%s", [response cString]);
    evhttp_send_reply(req, HTTP_OK, "OK", send_buf);
    evbuffer_free(send_buf);
  } else if ([response isKindOfClass:[OFDictionary class]]) {
    evhttp_send_error(req, [[response objectForKey:kReturnType] intValue], [[response objectForKey:kReturnString] cString]);
  } else {
    //[OFException raise:@"Invalid return type from EventReceiver" format:@"%s is invalid", [[[response class] description] cString]];
  }
}

- (id) init {
  evbase = event_init();
  evhttp = evhttp_new(evbase);
  return self;
}

- (void) bind:(int) port {
  evhttp_bind_socket(evhttp, NULL, port);
  evhttp_set_gencb(evhttp, glue, delegate);
}

- (void) listen {
  int rc;
  rc = event_base_loop(evbase, 0);
  if (rc) fprintf(stderr, "fatal: %d\n", rc);
}


@end