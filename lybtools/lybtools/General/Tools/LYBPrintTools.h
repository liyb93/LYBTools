//
//  LYBPrintTools.h
//  ybtools
//
//  Created by liyb on 2020/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *LYBPrintColorDefault;

extern NSString *LYBPrintColorRed;
extern NSString *LYBPrintColorGreen;
extern NSString *LYBPrintColorBlue;
extern NSString *LYBPrintColorWhite;
extern NSString *LYBPrintColorBlack;
extern NSString *LYBPrintColorYellow;
extern NSString *LYBPrintColorCyan;
extern NSString *LYBPrintColorMagenta;

extern NSString *LYBPrintColorWarning;
extern NSString *LYBPrintColorError;
extern NSString *LYBPrintColorStrong;

@interface LYBPrintTools : NSObject
+ (void)print:(NSString *)format, ...;
+ (void)printError:(NSString *)format, ...;
+ (void)printSuccess:(NSString *)format, ...;
+ (void)printWarning:(NSString *)format, ...;
+ (void)printStrong:(NSString *)format, ...;
+ (void)printColor:(NSString * _Nullable)color format:(NSString *)format, ...;
@end

NS_ASSUME_NONNULL_END
