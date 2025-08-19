//
//  HashTable.h
//  OCTemp
//
//  Created by jingwei on 2025/6/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HashTable : NSObject
- (instancetype)initWithCapacity:(NSUInteger)capacity;
- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
