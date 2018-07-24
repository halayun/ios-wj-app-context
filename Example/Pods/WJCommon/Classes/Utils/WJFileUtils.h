//
//  WJFileUtilss.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/17.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define WJ_FILE_DIR_DOCUMENT                        [WJFileUtils documentDir]
#define WJ_FILE_DIR_TMP                             [WJFileUtils tmpDir]
#define WJ_FILE_DIR_APP                             [WJFileUtils appDir]
#define WJ_FILE_DIR_CACHE                           [WJFileUtils cacheDir]
#define WJ_FILE_SIZE(filePath)                      [WJFileUtils fileSize:filePath]
#define WJ_FILE_DELETE(filePath)                    [WJFileUtils deleteFile:filePath]
#define WJ_FILE_EXIST(filePath)                     [WJFileUtils existFile:filePath]
#define WJ_FILE_READ(filePath)                      [WJFileUtils readFileByPath:filePath]
#define WJ_FILE_WRITE(data,filePath,replace)        [WJFileUtils writeFile:data forPath:filePath replace:replace]
#define WJ_FILE_COPY(filePath,targetPath)           [WJFileUtils copyFile:filePath target:targetPath]
#define WJ_FILE_MOVE(filePath,targetPath)           [WJFileUtils moveFile:filePath target:targetPath]
#define WJ_FILE_WRITE_JPEG(image,quality,forPath)   [WJFileUtils writeJPEGImage:image quality:quality forPath:forPath]
#define WJ_FILE_WRITE_PNG(image,filePath)           [WJFileUtils writePNGImage:image forPath:filePath]

/**
 *  文件操作工具类
 */
@interface WJFileUtils : NSObject

/**
 *  应用程序文档目录
 *
 *  @return 文档目录
 */
+ (NSString *) documentDir;

/**
 *  应用程序临时文件路径
 *
 *  @return 临时文件路径
 */
+ (NSString *) tmpDir;

/**
 *  获得应用程序目录
 *
 *  @return 应用程序根目录
 */
+ (NSString *) appDir;

/**
 *  应用程序缓存目录
 *
 *  @return 缓存目录
 */
+ (NSString *) cacheDir;

/**
 *  读取文件
 *
 *  @param filePath 文件地址
 *
 *  @return 文件NSData
 */
+ (NSData*) readFileByPath:(NSString*) filePath;

/**
 *  写入文件
 *
 *  @param fileData 文件NSData
 *  @param filePath 文件路径
 *  @param replace  如果文件存在是否替换
 *
 *  @return 是否成功
 */
+ (BOOL) writeFile:(NSData*) fileData forPath:(NSString *) filePath replace:(BOOL) replace;

/**
 *  保存一个jpg图片到本地
 *
 *  @param image              图片
 *  @param compressionQuality 图片质量
 *  @param filePath           文件路径
 *
 *  @return 是否成功
 */
+ (BOOL) writeJPEGImage:(UIImage *) image quality:(CGFloat) compressionQuality forPath:(NSString *) filePath;

/**
 *  保存一个png图片到本地
 *
 *  @param image    图片
 *  @param filePath 文件路径
 *
 *  @return 是否成功
 */
+ (BOOL) writePNGImage:(UIImage *) image forPath:(NSString*) filePath;

/**
 *  删除文件
 *
 *  @param filePath 文件路径
 *
 *  @return 是否成功
 */
+ (BOOL) deleteFile:(NSString*) filePath;

/**
 *  是否存在此文件
 *
 *  @param filePath 文件路径
 *
 *  @return 是否存在
 */
+ (BOOL) existFile:(NSString*) filePath;

/**
 *  移动文件
 *
 *  @param filePath       源文件路径
 *  @param targetFilePath 目标文件路径
 *
 *  @return 是否成功
 */
+ (BOOL) moveFile:(NSString*) filePath target:(NSString*) targetPath;

/**
 *  拷贝文件
 *
 *  @param filePath       源文件路径
 *  @param targetFilePath 目标文件路径
 *
 *  @return 是否成功
 */
+ (BOOL) copyFile:(NSString*) filePath target:(NSString*) targetPath;

/**
 *  文件大小
 *
 *  @param filePath 文件路径
 *
 *  @return 文件大小（字节）
 */
+ (long long) fileSize:(NSString*) filePath;

@end
