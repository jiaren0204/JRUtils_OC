//
//  Method_JR.h
//  JRUtils_OC
//
//  Created by 梁嘉仁 on 2020/6/6.
//  Copyright © 2020 梁嘉仁. All rights reserved.
//

#import "Macro_JR.h"
#import <CommonCrypto/CommonCryptor.h>

static CGFloat const kTabBarHeight = 49;

#pragma mark - 屏幕尺寸
/** 是否刘海手机 */
static inline BOOL Common_IsPhoneX()
{
    BOOL iPhoneX = NO;

    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [UIApplication sharedApplication].windows.firstObject;
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneX = YES;
        }
    }
    return iPhoneX;
}

/** iphoneX 底部Safe_Area */
static inline CGFloat Common_Safe_Area_Bottom()
{
    return Common_IsPhoneX() ? 34 : 0;
}

static inline CGFloat Common_StatusBar_Height()
{
    return Common_IsPhoneX() ? 44 : 20;
}

/** 导航栏+状态栏高度 */
static inline CGFloat Common_Nav_Height()
{
    return 44 + Common_StatusBar_Height();
}

/** Tabbar高度 */
static inline CGFloat Common_Tabbar_Height()
{
    return Common_Safe_Area_Bottom() + kTabBarHeight;
}

/** 除去导航栏+状态栏高度View的高度 */
static inline CGFloat Common_View_Height_WithOut_Nav()
{
    return SCREEN_HEIGHT - Common_Nav_Height();
}


#pragma mark - 导航栏
/** 隐藏导航栏(无动画) */
static inline void Common_NavHidden(UIViewController *vc,BOOL isHidden)
{
    [vc.navigationController setNavigationBarHidden:isHidden];
}

/** 隐藏导航栏(带动画) */
static inline void Common_NavHiddenWithAnimation(UIViewController *vc,BOOL isHidden)
{
    [vc.navigationController setNavigationBarHidden:isHidden animated:YES];
}

static inline NSString * Common_GetAppVersion() {
    return [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
}

#pragma mark - 文件管理
static inline void Common_CreateDir(NSString *dirPath)
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:dirPath]) {
        [fileMgr createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

static inline NSString * Common_DocumentPath()
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

static inline BOOL Common_FileIsExists(NSString *filePath)
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    return [fileMgr fileExistsAtPath:filePath];
}

/** 搜索指定路径的所有文件路径 */
static inline NSArray<NSString *>* Common_ShowPathFilePath(NSString *path)
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    NSArray *subPaths = [mgr subpathsAtPath:path];
    
    NSMutableArray<NSString *> *resultArr = [NSMutableArray new];
    for (NSString *subPath in subPaths) {
        [resultArr addObject:[path stringByAppendingPathComponent:subPath]];
    }
    
    return resultArr;
}

/** 搜索指定路径的所有文件名 */
static inline NSArray<NSString *>* Common_ShowPathFileName(NSString *path)
{
    NSArray<NSString *> *paths = Common_ShowPathFilePath(path);
    
    NSMutableArray<NSString *> *resultArr = [NSMutableArray new];
    for (NSString *path in paths) {
        NSArray *components = [path componentsSeparatedByString:@"/"];
        if (components) {
            [resultArr addObject:components.lastObject];
        }
    }
    
    return resultArr;
}

static inline NSArray<NSString *>* Common_ShowDocuFileWithSuffix(NSString *suffix)
{
    NSString *docuPath = Common_DocumentPath();
    NSArray<NSString *> *docuFiles = Common_ShowPathFilePath(docuPath);
    
    NSMutableArray<NSString *> *resultArr = [NSMutableArray new];
    for (NSString *filepath in docuFiles) {
        if ([filepath hasSuffix:suffix]) {
            [resultArr addObject:filepath];
        }
    }
    
    return resultArr;
}

/** 删除指定路径的文件 */
static inline void Common_DeleteFileInPath(NSString *filePath)
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    BOOL bRet = [fileMgr fileExistsAtPath:filePath];
    
    if (bRet) {
        NSError *err;
        if ([fileMgr removeItemAtPath:filePath error:&err]) {
        }
        
        if (err!=nil) {
            NSLog(@"%@", err);
        }
    }
}

#pragma mark - 多线程
static inline dispatch_queue_t Common_Create_Concurrent_Queue(const char *label)
{
    return dispatch_queue_create(label,dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, QOS_CLASS_DEFAULT, 0));
}

static inline dispatch_queue_t Common_Create_Serial_Queue(const char *label)
{
    return dispatch_queue_create(label,dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_DEFAULT, 0));
}

#pragma mark - 发邮件
static inline void Common_SendEmail(NSString *mailAddress, NSString *title, NSString *body) {
    
    NSMutableString *mailUrl = [[NSMutableString alloc] init];
    
    //添加收件人,如有多个收件人，可以使用componentsJoinedByString方法连接，连接符为","
    NSString *recipients = mailAddress;
    [mailUrl appendFormat:@"mailto:%@?", recipients];
    
    //添加邮件主题
    [mailUrl appendFormat:@"&subject=%@", title];
    
    //添加邮件内容
    NSString *bodyStr = [NSString stringWithFormat:@"&body=%@", body];
    [mailUrl appendString:bodyStr];
    
    //跳转到系统邮件App发送邮件
    NSString *emailPath = [mailUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailPath] options:@{} completionHandler:nil];
}

static inline void Common_SendFeedbackMailInApp(NSString *feedBackStr, NSString *problemStr, NSString *mailAddress) {
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *systemVersion = device.systemVersion;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *appNameAndVersion = [NSString stringWithFormat:@"%@ V%@", app_Name, app_Version];
    NSString *title = [NSString stringWithFormat:@"%@(%@ iOS)", feedBackStr, app_Name];
    NSString *body = [NSString stringWithFormat:@"%@:\n\n\n\n\n\n\n_____\nfrom %@\nfrom %@ iOS %@", problemStr, appNameAndVersion, device.model, systemVersion];
    Common_SendEmail(mailAddress, title, body);
}

#pragma mark - AppStore
static inline NSString *Common_Get_AppStore_Address(NSString *appid)
{
    return [NSString stringWithFormat:@"itunes.apple.com/app/id%@", appid];
}

static inline void Common_Goto_AppStore_Rate(NSString *appid)
{
    NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/itunes-u/id%@?action=write-review&mt=8", appid];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{} completionHandler:nil];
}

#pragma mark - 解档归档
/** 数据归档 */
static inline void Common_Archived_Data(id obj, NSString *path)
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj requiringSecureCoding:NO error:nil];
    if ([data writeToFile:path atomically:YES]) {
        NSLog(@"归档成功 %@", path);
    }
}

/** 数据解档 */
static inline id Common_Unarchived_Data(NSString *path)
{
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data error:nil];
    unarchiver.requiresSecureCoding = NO;
    return [unarchiver decodeTopLevelObjectForKey:NSKeyedArchiveRootObjectKey error:nil];
}

#pragma mark - 其他
static inline id Common_JsonSerializationLocalFile(NSString *filePath)
{
    return [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingMutableLeaves error:nil];
}


/** 实例化Xib */
static inline id Common_InstantiateXibView(Class currentClass)
{
    NSString *vcName = NSStringFromClass(currentClass);
    return [[[NSBundle mainBundle] loadNibNamed:vcName owner:nil options:nil] lastObject];
}

/** 找到当前展示的VC */
static inline UIViewController *Common_Find_CurrentViewController()
{
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    UIViewController *topViewController = [window rootViewController];
    
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}

static inline NSData* Common_AES256ParmDecryptWithKey(NSString *key, NSData *data) {
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    
    return nil;
}

/** 拨打电话 */
static inline void Common_Ring_Up(NSString *phoneNum)
{
    NSMutableString *str= [[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNum];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:str];
    [application openURL:URL options:@{} completionHandler:nil];
}


