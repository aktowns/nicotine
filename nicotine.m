#import "nicotine.h"

@implementation Nicotine
-(id) init {
  INF(@"Nicotine libevent webserver written in objective-c by ashley towns <ashleyis@me.com>");
  event = [[Event alloc] init];
  [event setDelegate:self];
  [event bind:8081];
  INF(@"Nicotine initialized");
  [event listen];
  return self;
}

- (OFString*) builtinpage {
  return @"<h1>Welcome to Nicotine</h1>"
         @"<p>An objective-c 2.0 based cross platform webserver powered with libevent.<br />"
         @"Your host is <i>Linux HomeworldNG 2.6.32.9-rscloud #6 SMP Thu Mar 11 14:32:05 UTC 2010 x86_64 GNU/Linux</i>";
}

// 3 return options, nil will return a generic 404, OFString will return that as a 200 OK or to customise
// return a OFDictionary with kReturnType and kReturnString defined.
- (id) EventReceiverWithURI:(OFString*) uri andRequest:(struct evhttp_request*) req {
  INF(@"Connection received for %@", uri);
  
  if ([uri isEqual:@"/"]) {
    //OFMutableDictionary* response = [[OFMutableDictionary alloc] init];
    //[response setObject:RESP_OK forKey:kReturnType];
    //[response setObject:@"Well hello there" forKey:kReturnString];
    return [self builtinpage]; //response;
  } else if ([uri isEqual:@"/notfound"]) {
    return nil;
  } else if ([uri isEqual:@"/quickandeasy"]) {
    return @":)";
  }
  
  return nil;
}

@end
