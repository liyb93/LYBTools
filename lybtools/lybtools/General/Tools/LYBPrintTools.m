//
//  LYBPrintTools.m
//  ybtools
//
//  Created by liyb on 2020/11/18.
//

#import "LYBPrintTools.h"

const NSString *LYBPrintColorDefault = @"\033[0m";

const NSString *LYBPrintColorRed = @"\033[1;31m";
const NSString *LYBPrintColorGreen = @"\033[1;32m";
const NSString *LYBPrintColorBlue = @"\033[1;34m";
const NSString *LYBPrintColorWhite = @"\033[1;37m";
const NSString *LYBPrintColorBlack = @"\033[1;30m";
const NSString *LYBPrintColorYellow = @"\033[1;33m";
const NSString *LYBPrintColorCyan = @"\033[1;36m";
const NSString *LYBPrintColorMagenta = @"\033[1;35m";

const NSString *LYBPrintColorWarning = @"\033[1;33m";
const NSString *LYBPrintColorError = @"\033[1;31m";
const NSString *LYBPrintColorStrong = @"\033[1;32m";

#define LYBBeginFormat \
if (!format) return; \
va_list args; \
va_start(args, format); \
format = [[NSString alloc] initWithFormat:format arguments:args];

#define LYBEndFormat va_end(args);

@implementation LYBPrintTools
+ (void)printError:(NSString *)format, ... {
    LYBBeginFormat;
    format = [@"Error: " stringByAppendingString:format];
    [self printColor:(NSString *)LYBPrintColorError format:@"%@\n", format];
}

+ (void)printSuccess:(NSString *)format, ... {
    LYBBeginFormat;
    format = [@"Success: " stringByAppendingString:format];
    [self printColor:(NSString *)LYBPrintColorGreen format:@"%@\n", format];
}

+ (void)printWarning:(NSString *)format, ... {
    LYBBeginFormat;
    format = [@"Warning: " stringByAppendingString:format];
    [self printColor:(NSString *)LYBPrintColorWarning format:@"%@\n", format];
    LYBEndFormat;
}

+ (void)printStrong:(NSString *)format, ... {
    LYBBeginFormat;
    [self printColor:(NSString *)LYBPrintColorStrong format:format];
    LYBEndFormat;
}

+ (void)print:(NSString *)format, ... {
    LYBBeginFormat;
    [self printColor:nil format:format];
    LYBEndFormat;
}

+ (void)printColor:(NSString *_Nullable)color format:(NSString *)format, ... {
    LYBBeginFormat;
    NSMutableString *printStr = [NSMutableString string];
    if (color && ![color isEqual:LYBPrintColorDefault]) {
        [printStr appendString:color];
        [printStr appendString:format];
        [printStr appendString:(NSString *)LYBPrintColorDefault];
    } else {
        [printStr appendString:(NSString *)LYBPrintColorDefault];
        [printStr appendString:format];
    }
    printf("%s", printStr.UTF8String);
    LYBEndFormat;
}
@end
