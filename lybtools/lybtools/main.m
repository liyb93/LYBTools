//
//  main.m
//  ybtools
//
//  Created by liyb on 2020/11/18.
//

#import <Foundation/Foundation.h>
#import "LYBPrintTools.h"
#import "LYBFileTools.h"
#import "LYBImageTools.h"
#import "NSString+Extension.h"
#import "Macro.h"

static NSString *LYBPrintColorCount;
static NSString *LYBPrintColorNo;
static NSString *LYBPrintColorName;
static NSString *LYBPrintColorPath;
static NSString *LYBPrintColorId;
static NSString *LYBPrintColorTip;

void print_usage(void);
void init_colors(void);

/// @param argc 参数个数
/// @param argv 参数数组
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 初始化颜色
        init_colors();
        
        if (argc == 1) {    // 参数不够，提示功能列表
            print_usage();
            return 0;
        }
        
        // 第一个参数(其实是第二个参数，第一个参数为工具名，可忽略)
        NSString *firstArg = [NSString stringWithUTF8String:argv[1]];
        if ([firstArg isEqualToString:@"-help"] || [firstArg isEqualToString:@"-h"]) {  // 帮助
            print_usage();
        } else if ([firstArg isEqualToString:@"-version"] || [firstArg isEqualToString:@"-v"]) {    // 版本
            [LYBPrintTools print:@"%@\n", LYB_Version];
        } else if ([firstArg isEqualToString:@"-plist"] || [firstArg isEqualToString:@"-p"]) { // 转plist
            if (argc == 4) {    // 4个参数
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                NSString *outPath = [NSString stringWithUTF8String:argv[3]];
                if (inputPath && outPath) {
                    [LYBFileTools plistWithInputPath:inputPath outPath:outPath];
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else if (argc == 3) { // 无输出路径
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                if (inputPath) {
                    NSString *outPath = [inputPath stringByDeletingLastPathComponent];
                    [LYBFileTools plistWithInputPath:inputPath outPath:outPath];
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else {
                [LYBPrintTools printError:@"参数错误"];
            }
        } else if ([firstArg isEqualToString:@"-json"] || [firstArg isEqualToString:@"-j"]) {  // 转json
            if (argc == 4) {    // 4个参数
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                NSString *outPath = [NSString stringWithUTF8String:argv[3]];
                if (inputPath && outPath) {
                    [LYBFileTools jsonWithInputPath:inputPath outPath:outPath];
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else if (argc == 3) { // 无输出路径
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                if (inputPath) {
                    NSString *outPath = [inputPath stringByDeletingLastPathComponent];
                    [LYBFileTools jsonWithInputPath:inputPath outPath:outPath];
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else {
                [LYBPrintTools printError:@"参数错误"];
            }
        } else if ([firstArg isEqualToString:@"-xml"] || [firstArg isEqualToString:@"-x"]) {  // 转xml
            if (argc == 4) {    // 4个参数
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                NSString *outPath = [NSString stringWithUTF8String:argv[3]];
                if (inputPath && outPath) {
                    [LYBFileTools xmlWithInputPath:inputPath outPath:outPath];
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else if (argc == 3) { // 无输出路径
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                if (inputPath) {
                    NSString *outPath = [inputPath stringByDeletingLastPathComponent];
                    [LYBFileTools xmlWithInputPath:inputPath outPath:outPath];
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else {
                [LYBPrintTools printError:@"参数错误"];
            }
        } else if ([firstArg isEqualToString:@"-imgcut"] || [firstArg isEqualToString:@"-ic"]) {  // 图片切圆角
            if (argc == 5) {    // 5个参数
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                NSString *outPath = [NSString stringWithUTF8String:argv[3]];
                NSString *size = [NSString stringWithUTF8String:argv[4]];
                if (inputPath && outPath && size) {
                    CGFloat radius = [size doubleValue];
                    [LYBImageTools imageToolsWithInputPath:inputPath outPath:outPath radius:radius];
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else if (argc == 4) { // 无输出路径
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                NSString *size = [NSString stringWithUTF8String:argv[3]];
                if (inputPath && size) {
                    CGFloat radius = [size doubleValue];
                    NSString *outPath = [inputPath stringByDeletingLastPathComponent];
                    [LYBImageTools imageToolsWithInputPath:inputPath outPath:outPath radius:radius];
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else {
                [LYBPrintTools printError:@"参数错误"];
            }
        } else if ([firstArg isEqualToString:@"-icon"] || [firstArg isEqualToString:@"-i"]) {   // app图标
            if (argc == 5) {    // 带app类型
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                NSString *outPath = [NSString stringWithUTF8String:argv[3]];
                NSString *iconType = [NSString stringWithUTF8String:argv[4]];
                if (inputPath && outPath && iconType) {
                    [LYBImageTools imageToolsMakeIconWith:inputPath outPath:outPath types:[NSString stringWithFormat:@"[%@]", iconType]];
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else if (argc == 4) { // 不带输出路径或app类型
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                NSString *argv4 = [NSString stringWithUTF8String:argv[3]];
                if (argv4 && inputPath) {
                    if ([argv4 containsString:@"/"]) {  // 输出路径
                        [LYBImageTools imageToolsMakeIconWith:inputPath outPath:argv4 types:@"[0]"];
                    } else {    // 类型
                        NSString *outPath = [inputPath stringByDeletingLastPathComponent];
                        [LYBImageTools imageToolsMakeIconWith:inputPath outPath:outPath types:[NSString stringWithFormat:@"[%@]", argv4]];
                    }
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else if (argc == 3) { // 不带输出路径和app类型
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                if (inputPath) {
                    NSString *outPath = [inputPath stringByDeletingLastPathComponent];
                    [LYBImageTools imageToolsMakeIconWith:inputPath outPath:outPath types:@"[0]"];
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else {
                [LYBPrintTools printError:@"参数错误"];
            }
        }
    }
    return 0;
}

// 功能列表
void print_usage() {
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-help/-h"];
    [LYBPrintTools print:@"\t功能列表\t\t-help/-h\n"];
    
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-version/-v"];
    [LYBPrintTools print:@"\t版本号\t\t\t-version/-v\n"];
    
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-plist/-p"];
    [LYBPrintTools print:@"\txml/json转plist\t\t-plist/-p 文件路径 输出路径(可选)\n"];
    
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-json/-j"];
    [LYBPrintTools print:@"\txml/plist转json\t\t-json/-j 文件路径 输出路径(可选)\n"];
    
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-xml/-x"];
    [LYBPrintTools print:@"\t\tjson/plist转xml\t\t-xml/-x 文件路径 输出路径(可选)\n"];
    
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-imgcut/-ic"];
    [LYBPrintTools print:@"\t图片切圆角\t\t-imgcut/-ic 文件路径 输出路径(可选) 圆角半径\n"];
    
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-icon/-i"];
    [LYBPrintTools print:@"\tApp图标生成\t\t-icon/-i 文件路径 输出路径(可选) 图标类型(可选,以英文逗号分隔):\n\t\t\t\t\t0:  iphone\n\t\t\t\t\t1:  ipad\n\t\t\t\t\t2:  mac\n\t\t\t\t\t3:  carplay\n\t\t\t\t\t4:  watch\n\t\t\t\t\t5:  android\n"];
}

// 颜色配置
void init_colors() {
    LYBPrintColorCount = LYBPrintColorMagenta;
    LYBPrintColorNo = LYBPrintColorDefault;
    LYBPrintColorName = LYBPrintColorRed;
    LYBPrintColorPath = LYBPrintColorBlue;
    LYBPrintColorId = LYBPrintColorCyan;
    LYBPrintColorTip = LYBPrintColorCyan;
}
