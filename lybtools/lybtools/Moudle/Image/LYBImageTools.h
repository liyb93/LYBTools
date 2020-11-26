//
//  LYBImageTools.h
//  ybtools
//
//  Created by liyb on 2020/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYBImageTools : NSObject

+ (void)imageToolsWithInputPath:(NSString *)inputPath outPath:(NSString *)outPath radius:(CGFloat)radius;

/// 图标生成
/// @param inputPath 目标图片路径
/// @param outPath 输出路径
/// @param iconType 图标类型
/// iconType :  默认为0
/// 0:  只生成iphone
/// 1:  只生成ipad
/// 2:  只生成mac
/// 3:  生成iphone与ipad
/// 4:  生成iphone与mac
/// 5:  生成ipad与mac
/// 6:  生成iphone、ipad与mac
+ (void)imageToolsMakeIconWith:(NSString *)inputPath outPath:(NSString *)outPath iconType:(NSInteger)iconType;

@end

NS_ASSUME_NONNULL_END
