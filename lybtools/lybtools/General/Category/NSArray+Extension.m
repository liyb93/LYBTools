//
//  NSArray+Extension.m
//  JsonToPlist
//
//  Created by lib on 2018/12/5.
//  Copyright © 2018 lib. All rights reserved.
//

#import "NSArray+Extension.h"
#import "NSDictionary+Extension.h"

@implementation NSArray (Extension)
- (NSArray *)removeNull {
    NSMutableArray *arr = [self mutableCopy];
    for (NSInteger idx = 0; idx < arr.count; idx ++) {
        id data = arr[idx];
        if ([data isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)data;
            [arr replaceObjectAtIndex:idx withObject:[dict removeNull]];
        } else if ([data isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)data;
            [arr replaceObjectAtIndex:idx withObject:[array removeNull]];
        }
    }
    return arr;
}

- (NSString *)toJson {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
