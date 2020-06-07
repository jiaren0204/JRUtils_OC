#define WEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF __strong typeof(self) strongSelf = weakSelf;

#define Angle2Radian(x) ((x) / 180.0 * M_PI)

#define ISIPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define MAIN_Screen    [UIScreen mainScreen]
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

// 单例
// .h
#define singleton_interface(class) + (instancetype)shared##class;

// .m
#define singleton_implementation(class) \
static class *_instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
\
    return _instance; \
} \
\
+ (instancetype)shared##class \
{ \
    if (_instance == nil) { \
        _instance = [[class alloc] init]; \
    } \
\
    return _instance; \
}


