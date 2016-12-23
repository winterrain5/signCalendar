//
//  CSToolKit.h
//  CSToolKit
//
//  Created by 石冬冬 on 16/6/10.
//  Copyright © 2016年 3TI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <AudioToolbox/AudioToolbox.h>
@interface CSCommonUtils : NSObject

/**
 *  获取磁盘总空间
 *
 *  @return 磁盘大小(MB)
 */
+ (CGFloat) diskOfAllSizeMBytes;
/**
 *  磁盘可用空间
 *
 *  @return 磁盘大小(MB)
 */
+ (CGFloat) diskOfFreeSizeMBytes;
/**
 *  获取指定路径下某个文件的大小
 *
 *  @param filePath 文件路径
 *
 *  @return 文件大小
 */
+ (long long) fileSizeAtPath:(NSString *) filePath;
/**
 *  获取文件加下所有文件的大小
 *
 *  @param folderPath 文件夹的路径
 *
 *  @return 文件大小
 */
+ (long long) folderSizeAtPath:(NSString*) folderPath;
/**
 *  获取字符串（汉字）首字母
 *
 *  @param string 字符串（汉字）
 *
 *  @return 首字母
 */
+ (NSString *)firstCharacterWithString:(NSString *) string ;
/**
 *  将字符串数组按照元素首字母 顺序进行排序分组
 *
 *  @param array 字符串数组
 *
 *  @return 排序后的字典
 */
+ (NSDictionary *) dictionaryOrderByCharacterWithOriginalArray:(NSArray *) array;
/**
 *  获取当前时间
 *
 *  @param format 时间格式如： @"yyyy-MM-dd HH:mm:ss"、@"yyyy年MM月dd日 HH时mm分ss秒"
 *
 *  @return 当前时间
 */
+ (NSString *) currentDateWithFormat:(NSString *) format;
/**
 *  计算上次日期距离现在多久
 *
 *  @param lastTime          上次日期（需要和格式对应）
 *  @param lastTimeFormat    上次日期格式
 *  @param currentTime       最近日期（需要和格式对应）
 *  @param currentTimeFormat 最近日期格式
 *
 *  @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *) timeIntervalFromLastTime:(NSString *) lastTime
                         lastTimeFormat:(NSString *) lastTimeFormat
                          toCurrentTime:(NSString *) currentTime
                      currentTimeFormat:(NSString *) currentTimeFormat;
/**
 *  将十六进制颜色转换为UIColor对象
 *
 *  @param color 十六进制颜色
 *
 *  @return UIColor对象
 */
+ (UIColor *) colorWithHexString:(NSString *) color;
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
+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name;
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
+ (UIImage *)blurWithOriginalImage:(UIImage *)image blurName:(NSString *)name radius:(NSInteger)radius;
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
                                   contrast:(CGFloat)contrast;
/**
 *  创建毛玻璃效果的view
 */
+ (UIVisualEffectView *) effectViewWithFrame:(CGRect ) frame;
/**
 *  全屏截图
 */
+ (UIImage *) shotScreen;
/**
 *  截取view生成一张图片
 *
 *  @param view 需要截取的view
 *
 *  @return 生成的图片
 */
+ (UIImage *)shotWithView:(UIView *)view;
/**
 *  截取view中某个区域生成一张图片
 *
 *  @param view  需要截取的view
 *  @param scope 截取的区域
 *
 *  @return 生成的图片
 */
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope;
/**
 *  压缩图片到指定尺寸大小
 *
 *  @param image 原始图片
 *  @param size  压缩尺寸
 *
 *  @return 处理后的图片
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;
/**
 *  压缩图片到指定文件大小
 *
 *  @param image 原始图片
 *  @param size  最大字节大小
 *
 *  @return 指定文件大小的图片
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

/**
 *  设置文本框左侧图片
 *
 *  @param textFiled 文本框
 *  @param image     图片
 */
+(void)setTextFiledLeftImage:(UITextField*)textFiled image:(NSString*)image;
/**
 *  根据音效名称生成id
 *
 *  @param soundName 音效名称
 */
+(SystemSoundID)creatSoundIDWithSoundName:(NSString *)soundName;
/**
 *  播放音效
 */
+(void)playSoundWithSoundID:(SystemSoundID)soundID;
/**
 *  停止音效
 */
+(void)stopSoundWithSoundID:(SystemSoundID)soundID;
@end
