//
//  LYBImageTools.m
//  ybtools
//
//  Created by liyb on 2020/11/18.
//

#import "LYBImageTools.h"
#import "NSImage+Extension.h"
#import "LYBPrintTools.h"
#import "NSDate+Extension.h"
#import "Macro.h"


@implementation LYBImageTools

+ (void)imageToolsWithInputPath:(NSString *)inputPath outPath:(NSString *)outPath radius:(CGFloat)radius {
    if ([[NSFileManager defaultManager] fileExistsAtPath:inputPath]) {    // 检测是否是文件路径
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:inputPath];
        if (image) {
            image = [image roundCornersImageCornerRadius:radius];
            BOOL result = [self saveImage:image outPath:outPath];
            if (result) {
                [LYBPrintTools printSuccess:@"圆角裁剪成功"];
            } else {
                [LYBPrintTools printError:@"圆角裁剪失败"];
            }
        } else {
            [LYBPrintTools printError:@"输入路径错误"];
        }
    } else {
        [LYBPrintTools printError:@"输入路径错误"];
    }
}

+ (void)imageToolsMakeIconWith:(NSString *)inputPath outPath:(NSString *)outPath iconType:(NSInteger)iconType {
    BOOL isDirectory;
    if (![[NSFileManager defaultManager] fileExistsAtPath:outPath isDirectory:&isDirectory] || !isDirectory) {
        [LYBPrintTools printError:@"输出路径错误"];
        return;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:inputPath]) {    // 检测是否是文件路径
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:inputPath];
        if (image) {
            if (iconType == 0) {
                NSString *folderPath = [self createFolderWithPath:outPath name:@"iOS"];
                // 添加markIcon
                NSMutableArray *iphoneIcons = [NSMutableArray arrayWithArray:LYB_Iphone_Icon];
                [iphoneIcons addObject:LYB_Mark_Icon];
                BOOL result = [self dealIconsWithImage:image icons:iphoneIcons outPath:folderPath];
                if (result) {
                    [LYBPrintTools printSuccess:@"icon制作成功"];
                } else {
                    [LYBPrintTools printError:@"icon制作失败"];
                }
            } else if (iconType == 1) {
                NSString *folderPath = [self createFolderWithPath:outPath name:@"iOS"];
                // 添加markIcon
                NSMutableArray *iphoneIcons = [NSMutableArray arrayWithArray:LYB_Ipad_Icon];
                [iphoneIcons addObject:LYB_Mark_Icon];
                BOOL result = [self dealIconsWithImage:image icons:iphoneIcons outPath:folderPath];
                if (result) {
                    [LYBPrintTools printSuccess:@"icon制作成功"];
                } else {
                    [LYBPrintTools printError:@"icon制作失败"];
                }
            } else if (iconType == 2) {
                NSString *folderPath = [self createFolderWithPath:outPath name:@"Mac"];
                BOOL result = [self dealIconsWithImage:image icons:LYB_Mac_Icon outPath:folderPath];
                if (result) {
                    [LYBPrintTools printSuccess:@"icon制作成功"];
                } else {
                    [LYBPrintTools printError:@"icon制作失败"];
                }
            } else if (iconType == 3) {
                NSString *folderPath = [self createFolderWithPath:outPath name:@"iOS"];
                // 添加markIcon
                NSMutableArray *iphoneIcons = [NSMutableArray arrayWithArray:LYB_Iphone_Icon];
                [iphoneIcons addObjectsFromArray:LYB_Ipad_Icon];
                [iphoneIcons addObject:LYB_Mark_Icon];
                BOOL result = [self dealIconsWithImage:image icons:iphoneIcons outPath:folderPath];
                if (result) {
                    [LYBPrintTools printSuccess:@"icon制作成功"];
                } else {
                    [LYBPrintTools printError:@"icon制作失败"];
                }
            } else if (iconType == 4) {
                NSString *iosPath = [self createFolderWithPath:outPath name:@"iOS"];
                NSMutableArray *iphoneIcons = [NSMutableArray arrayWithArray:LYB_Iphone_Icon];
                [iphoneIcons addObject:LYB_Mark_Icon];
                BOOL iosResult = [self dealIconsWithImage:image icons:iphoneIcons outPath:iosPath];
                NSString *macPath = [self createFolderWithPath:outPath name:@"Mac"];
                BOOL macResult = [self dealIconsWithImage:image icons:LYB_Mac_Icon outPath:macPath];
                if (iosResult && macResult) {
                    [LYBPrintTools printSuccess:@"icon制作成功"];
                } else if (iosResult && !macResult) {
                    [LYBPrintTools printError:@"mac icon制作失败"];
                } else if (macResult && !iosResult) {
                    [LYBPrintTools printError:@"ios icon制作失败"];
                } else {
                    [LYBPrintTools printError:@"ios、mac icon制作失败"];
                }
            } else if (iconType == 5) {
                NSString *iosPath = [self createFolderWithPath:outPath name:@"iOS"];
                NSMutableArray *iphoneIcons = [NSMutableArray arrayWithArray:LYB_Ipad_Icon];
                [iphoneIcons addObject:LYB_Mark_Icon];
                BOOL iosResult = [self dealIconsWithImage:image icons:iphoneIcons outPath:iosPath];
                NSString *macPath = [self createFolderWithPath:outPath name:@"Mac"];
                BOOL macResult = [self dealIconsWithImage:image icons:LYB_Mac_Icon outPath:macPath];
                if (iosResult && macResult) {
                    [LYBPrintTools printSuccess:@"icon制作成功"];
                } else if (iosResult && !macResult) {
                    [LYBPrintTools printError:@"mac icon制作失败"];
                } else if (macResult && !iosResult) {
                    [LYBPrintTools printError:@"ios icon制作失败"];
                } else {
                    [LYBPrintTools printError:@"ios、mac icon制作失败"];
                }
            } else if (iconType == 6) {
                NSString *iosPath = [self createFolderWithPath:outPath name:@"iOS"];
                NSMutableArray *iphoneIcons = [NSMutableArray arrayWithArray:LYB_Iphone_Icon];
                [iphoneIcons addObjectsFromArray:LYB_Ipad_Icon];
                [iphoneIcons addObject:LYB_Mark_Icon];
                BOOL iosResult = [self dealIconsWithImage:image icons:iphoneIcons outPath:iosPath];
                NSString *macPath = [self createFolderWithPath:outPath name:@"Mac"];
                BOOL macResult = [self dealIconsWithImage:image icons:LYB_Mac_Icon outPath:macPath];
                if (iosResult && macResult) {
                    [LYBPrintTools printSuccess:@"icon制作成功"];
                } else if (iosResult && !macResult) {
                    [LYBPrintTools printError:@"mac icon制作失败"];
                } else if (macResult && !iosResult) {
                    [LYBPrintTools printError:@"ios icon制作失败"];
                } else {
                    [LYBPrintTools printError:@"ios、mac icon制作失败"];
                }
            } else {
                [LYBPrintTools printError:@"图标类型错误, 请看详细使用方式"];
            }
        } else {
            [LYBPrintTools printError:@"输入路径错误"];
        }
    } else {
        [LYBPrintTools printError:@"输入路径错误"];
    }
}

// 保存图片
+ (BOOL)saveImage:(NSImage *)image outPath:(NSString *)outPath {
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:outPath isDirectory:&isDirectory]) {
        if (isDirectory) {
            NSString *timestamp = [NSDate currentTimestamp];
            outPath = [outPath stringByAppendingFormat:@"/%@.png", timestamp];
        }
    }
    
    NSData *imageData = [image TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    [imageRep setSize:image.size];
    imageData = [imageRep representationUsingType:NSBitmapImageFileTypePNG properties:@{}];
    if (imageData) {
        BOOL result = [imageData writeToFile:outPath atomically:YES];
        return result;
    } else {
        return NO;
    }
}

+ (BOOL)dealIconsWithImage:(NSImage *)image icons:(NSArray *)icons outPath:(NSString *)path {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in icons) {
        NSInteger size = [dict[@"size"] integerValue];
        NSInteger scale = [dict[@"scale"] integerValue];
        NSString *idiom = dict[@"idiom"];
        NSImage *img = [image scaleToSize:CGSizeMake(size/2.0, size/2.0)];
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:dict];
        NSString *sizeString;
        if (size % scale == 0) {    // 没有小数
            sizeString = [NSString stringWithFormat:@"%zix%zi", size / scale, size / scale];
        } else {
            CGFloat s = (CGFloat)size / scale;
            sizeString = [NSString stringWithFormat:@"%.1fx%.1f", s, s];
        }
        NSString *scaleString = [NSString stringWithFormat:@"%zix", scale];
        NSString *filename = [NSString stringWithFormat:@"%@App_%@@%@.png", idiom, sizeString, scaleString];
        data[@"size"] = sizeString;
        data[@"scale"] = scaleString;
        data[@"filename"] = filename;
        [arr addObject:data];
        BOOL result = [self saveImage:img outPath:[NSString stringWithFormat:@"%@/%@", path, filename]];
        if (!result) {
            [LYBPrintTools printError:@"%@图标生成失败", filename];
        }
    }
    // 拼接配置文件
    NSMutableDictionary *config = [NSMutableDictionary dictionary];
    config[@"images"] = [arr copy];
    config[@"info"] = @{@"author": @"xcode", @"version": @"1"};
    return [self saveIconConfigFileWithData:config path:path];
}

/// 存储icon配置文件
+ (BOOL)saveIconConfigFileWithData:(NSDictionary *)data path:(NSString *)path {
    path = [path stringByAppendingFormat:@"Contents.json"];
    NSError *err;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:&err];
    }
    NSData *d = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingFragmentsAllowed error:&err];
    NSString *json = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
    if (err) {
        return NO;
    }
    return [json writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

// 创建icon存储路径
+ (NSString *)createFolderWithPath:(NSString *)path name:(NSString *)name {
    path = [path stringByAppendingFormat:@"/%@/AppIcon.appiconset/", name];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    return path;
}

@end
