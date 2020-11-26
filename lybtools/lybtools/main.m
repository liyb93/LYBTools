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
        } else if ([firstArg isEqualToString:@"-plist"]) { // 转plist
            if (argc == 4) {    // 4个参数
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                NSString *outPath = [NSString stringWithUTF8String:argv[3]];
                if (inputPath && outPath) {
                    [LYBFileTools plistWithInputPath:inputPath outPath:outPath];
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else {
                [LYBPrintTools printError:@"参数错误"];
            }
        } else if ([firstArg isEqualToString:@"-json"]) {  // 转json
            if (argc == 4) {    // 4个参数
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                NSString *outPath = [NSString stringWithUTF8String:argv[3]];
                if (inputPath && outPath) {
                    [LYBFileTools jsonWithInputPath:inputPath outPath:outPath];
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else {
                [LYBPrintTools printError:@"参数错误"];
            }
        } else if ([firstArg isEqualToString:@"-xml"]) {  // 转xml
            if (argc == 4) {    // 4个参数
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                NSString *outPath = [NSString stringWithUTF8String:argv[3]];
                if (inputPath && outPath) {
                    [LYBFileTools xmlWithInputPath:inputPath outPath:outPath];
                } else {
                    [LYBPrintTools printError:@"参数错误"];
                }
            } else {
                [LYBPrintTools printError:@"参数错误"];
            }
        } else if ([firstArg isEqualToString:@"-imgcut"]) {  // 图片切圆角
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
            } else {
                [LYBPrintTools printError:@"参数错误"];
            }
        } else if ([firstArg isEqualToString:@"-icon"]) {   // app图标
            if (argc == 5) {    // 带app类型
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                NSString *outPath = [NSString stringWithUTF8String:argv[3]];
                NSString *iconType = [NSString stringWithUTF8String:argv[4]];
                NSInteger type = [iconType integerValue];
                if (type >= 0 && type <= 6) {
                    if (inputPath && outPath) {
                        [LYBImageTools imageToolsMakeIconWith:inputPath outPath:outPath iconType:type];
                    } else {
                        [LYBPrintTools printError:@"参数错误"];
                    }
                } else {
                    [LYBPrintTools printError:@"appType取值范围0~6"];
                }
            } else if (argc == 4) { // 不带app类型
                NSString *inputPath = [NSString stringWithUTF8String:argv[2]];
                NSString *outPath = [NSString stringWithUTF8String:argv[3]];
                if (inputPath && outPath) {
                    [LYBImageTools imageToolsMakeIconWith:inputPath outPath:outPath iconType:0];
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
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-plist"];
    [LYBPrintTools print:@"\t\txml/json转plist\t\t-plist 文件路径 输出路径\n"];
    
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-json"];
    [LYBPrintTools print:@"\t\txml/plist转json\t\t-json 文件路径 输出路径\n"];
    
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-xml"];
    [LYBPrintTools print:@"\t\tjson/plist转xml\t\t-xml 文件路径 输出路径\n"];
    
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-imgcut"];
    [LYBPrintTools print:@"\t\t图片切圆角\t\t-imgcut 文件路径 输出路径 圆角半径\n"];
    
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-icon"];
    [LYBPrintTools print:@"\t\tApp图标生成\t\t-icon 文件路径 输出路径 app类型(默认为0,可不传):\n\t\t\t\t\t0:  只生成iphone\n\t\t\t\t\t1:  只生成ipad\n\t\t\t\t\t2:  只生成mac\n\t\t\t\t\t3:  生成iphone与ipad\n\t\t\t\t\t4:  生成iphone与mac\n\t\t\t\t\t5:  生成ipad与mac\n\t\t\t\t\t6:  生成iphone、ipad与mac\n"];
    
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-help/-h"];
    [LYBPrintTools print:@"\t功能列表\t\t-help或-h\n"];
    
    [LYBPrintTools printColor:LYBPrintColorTip format:@"-version/-v"];
    [LYBPrintTools print:@"\t版本号\t\t\t-version或-v\n"];
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
