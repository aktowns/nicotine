#define LOG(content, args...) \
  [of_stdout writeString:[OFString stringWithFormat:@"%@\n", \
    [OFString stringWithFormat:content, ##args]]]

#define INF(content, args...) \
    LOG([OFString stringWithFormat:@"[I] %@", content], ##args)

#define ERR(content, args...) \
    LOG([OFString stringWithFormat:@"[E] %@", content], ##args)
