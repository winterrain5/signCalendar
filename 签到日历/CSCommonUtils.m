//
//  CSToolKit.m
//  CSToolKit
//
//  Created by 石冬冬 on 16/6/10.
//  Copyright © 2016年 3TI. All rights reserved.
//

#import "CSCommonUtils.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
@implementation CSCommonUtils

/**
 *  获取磁盘总空间
 *
 *  @return 磁盘大小(MB)
 */
+ (CGFloat)diskOfAllSizeMBytes {
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
    } else {
        NSNumber *number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}
/**
 *  磁盘可用空间
 *
 *  @return 磁盘大小(MB)
 */
+ (CGFloat) diskOfFreeSizeMBytes {
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
    } else {
        NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}
/**
 *  获取指定路径下某个文件的大小
 *
 *  @param filePath 文件路径
 *
 *  @return 文件大小
 */
+ (long long) fileSizeAtPath:(NSString *) filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        return 0;
    }
    return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
}
/**
 *  获取文件加下所有文件的大小
 *
 *  @param folderPath 文件夹的路径
 *
 *  @return 文件大小
 */
+ (long long) folderSizeAtPath:(NSString*) folderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath])
        return 0;
    NSEnumerator *fileEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    while ((fileName = [fileEnumerator nextObject]) != nil) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:filePath];
    }
    return folderSize;
}
/**
 *  获取字符串（汉字）首字母
 *
 *  @param string 字符串（汉字）
 *
 *  @return 首字母
 */
+ (NSString *)firstCharacterWithString:(NSString *) string {
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pingyin = [str capitalizedString];
    return [pingyin substringToIndex:1];
}
/**
 *  将字符串数组按照元素首字母 顺序进行排序分组
 *
 *  @param array 字符串数组
 *
 *  @return key 为排序后首字母索引  value 每个索引对应的数组
 */
+ (NSDictionary *) dictionaryOrderByCharacterWithOriginalArray:(NSArray *) array {
    if (array.count == 0) {
        return nil;
    }
    for (id obj in array) {
        if (![obj isKindOfClass:[NSString class]]) {
            return nil;
        }
    }
    UILocalizedIndexedCollation *indexedCollation = [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:indexedCollation.sectionTitles.count];
    // 创建27个分组数组
    for (int i = 0; i < indexedCollation.sectionTitles.count; i ++ ) {
        NSMutableArray *obj = [NSMutableArray array];
        [objects addObject:obj];
    }
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:objects.count];
    //按字母顺序进行分组
    NSInteger lastIndex = -1;
    for (int i = 0; i < array.count; i ++ ) {
        NSInteger index = [indexedCollation sectionForObject:array[i]  collationStringSelector:@selector(uppercaseString)];
        [[objects objectAtIndex:index] addObject:array[i]];
        lastIndex = index;
    }
    // 去掉空数组
    for (int i = 0; i < objects.count; i ++ ) {
        NSMutableArray *obj = objects[i];
        if (obj.count == 0) {
            [objects removeObject:obj];
        }
    }
    // 获取索引数组
    for (NSMutableArray *obj in objects) {
        NSString *str = obj[0];
        NSString *key = [self firstCharacterWithString:str];
        [keys addObject:key];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:objects forKey:keys];
    return dic;
}
/**
 *  获取当前时间
 *
 *  @param format 时间格式如： @"yyyy-MM-dd HH:mm:ss"、@"yyyy年MM月dd日 HH时mm分ss秒"
 *
 *  @return 当前时间
 */
+ (NSString *) currentDateWithFormat:(NSString *) format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:[NSDate date]];
}
/**
 *  计算上次日期距离现在多久
 *
 *  @param lastTime          上次日期（需要和格式对应）
 *  @param lastTimeFormat    上次日期格式
 *  @param currentTime       最近日期（需要和格式对应）
 *  @param currentTimeFormat 最近日期格式
 *
 *  @return xx分钟前、xx小时前、xx天前
 */+ (NSString *) timeIntervalFromLastTime:(NSString *) lastTime
                         lastTimeFormat:(NSString *) lastTimeFormat
                          toCurrentTime:(NSString *) currentTime
                      currentTimeFormat:(NSString *) currentTimeFormat {
    // 上次时间
     NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
     [dateFormatter1 setDateFormat:lastTimeFormat];
     NSDate *lastDate = [dateFormatter1 dateFromString:lastTime];
     // 当前时间
     NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
     [dateFormatter2 setDateFormat:currentTimeFormat];
     NSDate *currentDate = [dateFormatter2 dateFromString:currentTime];
     return [self timeIntervalFromLastTime:lastDate toCurrentTime:currentDate];
}
+ (NSString *) timeIntervalFromLastTime:(NSDate *) lastTime toCurrentTime:(NSDate *) currentTime {
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    
    //秒、分、小时、天、月、年
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    NSInteger month = intevalTime / 60 / 60 / 24 / 30;
    NSInteger yers = intevalTime / 60 / 60 / 24 / 365;
    
    if (minutes <= 10) {
        return  @"刚刚";
    }else if (minutes < 60){
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    }else if (hours < 24){
        return [NSString stringWithFormat: @"%ld小时前",(long)hours];
    }else if (day < 30){
        return [NSString stringWithFormat: @"%ld天前",(long)day];
    }else if (month < 12){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }else if (yers >= 1){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy年M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }
    return @"";
}
/**
 *  将十六进制颜色转换为UIColor对象
 *
 *  @param color 十六进制颜色
 *
 *  @return UIColor对象
 */
+ (UIColor *) colorWithHexString:(NSString *) color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // 长度为6或者8
    if (cString.length < 6) {
        return [UIColor clearColor];
    }
    // 0X 或者 # 开头
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    // 如果截取后长度不为6
    if (cString.length != 6) {
        return [UIColor clearColor];
    }
    // 截取 r g b 三种色域
    NSRange range;
    range.length = 2;
    
    // r
    range.location = 0;
    NSString *rString = [cString substringWithRange:range];
    // g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    // b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int  r,g,b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithHue:((float) r / 255.0f) saturation:((float) g / 255.0f) brightness:((float) b / 255.0f) alpha:1.0f];
}

/**
 *  对图片进行滤镜处理
 *
 *  @param UIImage 要处理的图片
 *
 *  @return 处理后的图片
 */
// 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
// 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
// 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
// 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome
// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name{
    
    //将UIImage转换成CIImage
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    
    //创建滤镜
    CIFilter *filter = [CIFilter filterWithName:name keysAndValues:kCIInputImageKey, ciImage, nil];
    
    //已有的值不改变，其他的设为默认值
    [filter setDefaults];
    
    //获取绘制上下文
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //渲染并输出CIImage
    CIImage *outputImage = [filter outputImage];
    
    //创建CGImage句柄
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *resultImage =  [UIImage imageWithCGImage:cgImage];
    //释放CGImage句柄
    CGImageRelease(cgImage);
    
    return resultImage;

    
    }
/**
 *  对图片进行模糊处理
 *
 *  @param later 要处理的图片
 *
 *  @return 处理后的图片
 */
// CIGaussianBlur ---> 高斯模糊
// CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)
// CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)
// CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)
// CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)
+ (UIImage *)blurWithOriginalImage:(UIImage *)image blurName:(NSString *)name radius:(NSInteger)radius{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter;
    if (name.length != 0) {
        filter = [CIFilter filterWithName:name];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        if (![name isEqualToString:@"CIMedianFilter"]) {
            [filter setValue:@(radius) forKey:@"inputRadius"];
        }
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
        UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return resultImage;
    }else{
        return nil;
    }
}
/**
 *  调整图片饱和度, 亮度, 对比度
 *
 *  @param image      目标图片
 *  @param saturation 饱和度
 *  @param brightness 亮度: -1.0 ~ 1.0
 *  @param contrast   对比度
 *
 */
+ (UIImage *)colorControlsWithOriginalImage:(UIImage *)image
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    [filter setValue:@(saturation) forKey:@"inputSaturation"];
    [filter setValue:@(brightness) forKey:@"inputBrightness"];// 0.0 ~ 1.0
    [filter setValue:@(contrast) forKey:@"inputContrast"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}
/**
 *  创建毛玻璃效果的view
 */
+ (UIVisualEffectView *) effectViewWithFrame:(CGRect ) frame {
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    return effectView;
}
/**
 *  全屏截图
 */
+ (UIImage *) shotScreen {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContext(window.bounds.size);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 *  截取view生成一张图片
 *
 *  @param view 需要截取的view
 *
 *  @return 生成的图片
 */
+ (UIImage *)shotWithView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 *  截取view中某个区域生成一张图片
 *
 *  @param view  需要截取的view
 *  @param scope 截取的区域
 *
 *  @return 生成的图片
 */
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope{
    CGImageRef imageRef = CGImageCreateWithImageInRect([self shotWithView:view].CGImage, scope);
    UIGraphicsBeginImageContext(scope.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, scope.size.width, scope.size.height);
    CGContextTranslateCTM(context, 0, rect.size.height);//下移
    CGContextScaleCTM(context, 1.0f, -1.0f);//上翻
    CGContextDrawImage(context, rect, imageRef);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    CGContextRelease(context);
    return image;
}
/**
 *  压缩图片到指定尺寸大小
 *
 *  @param image 原始图片
 *  @param size  压缩尺寸
 *
 *  @return 处理后的图片
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIImage *resultImage = image;
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIGraphicsEndImageContext();
    return resultImage;
}
/**
 *  压缩图片到指定文件大小
 *
 *  @param image 原始图片
 *  @param size  最大字节大小
 *
 *  @return 指定文件大小的图片
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length/1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}

/**
 *  设置文本框左侧图片
 *
 *  @param textFiled 文本框
 *  @param image     图片
 */
+(void)setTextFiledLeftImage:(UITextField*)textFiled image:(NSString*)image{
    textFiled.leftViewMode=UITextFieldViewModeAlways;
    textFiled.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:image]];
}
/**
 *  根据音效名称生成id
 *
 *  @param soundName 音效名称
 */
+(SystemSoundID)creatSoundIDWithSoundName:(NSString *)soundName {
    NSString *audioFile = [[NSBundle mainBundle]pathForResource:soundName ofType:nil];
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
    //1.获得系统声音ID
    SystemSoundID soundID=0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    return soundID;

}
/**播放音效*/
+(void)playSoundWithSoundID:(SystemSoundID)soundID{
    //2.播放音频
    AudioServicesPlaySystemSound(soundID);//播放音效
    //    AudioServicesPlayAlertSound(self.soundID);//播放音效并震动
}
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    //停止播放音效
    AudioServicesDisposeSystemSoundID(soundID);
}
/**停止播放音效*/
+(void)stopSoundWithSoundID:(SystemSoundID)soundID{
    //停止播放音效
    AudioServicesDisposeSystemSoundID(soundID);
}
@end
