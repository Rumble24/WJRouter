//
//  HashTable.m
//  OCTemp
//
//  Created by jingwei on 2025/6/6.
//

#import "HashTable.h"


// 哈希节点结构
@interface HashNode : NSObject
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) id object;
@property (nonatomic, assign) BOOL isDeleted; // 标记删除状态（开放寻址法需要）
@end

@implementation HashNode
@end



@implementation HashTable {
    NSMutableArray *_buckets;  // 存储桶数组
    NSUInteger _capacity;      // 容量
    NSUInteger _count;         // 当前元素数量
}


- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super init];
    if (self) {
        _capacity = capacity;
        _buckets = [NSMutableArray arrayWithCapacity:capacity];
        
        // 初始化所有桶为nil
        for (NSUInteger i = 0; i < capacity; i++) {
            [_buckets addObject:[NSNull null]];
        }
    }
    return self;
}

// 哈希函数：计算键的哈希值并映射到数组索引
- (NSUInteger)hashForKey:(NSString *)key {
    // 使用NSString的hash方法获取哈希值
    NSUInteger hashValue = [key hash];
    // 取模运算确定索引
    return hashValue % _capacity;
}

// 插入/更新键值对
- (void)setObject:(id)object forKey:(NSString *)key {
    if (!key || !object) return;
    
    NSUInteger index = [self hashForKey:key];
    NSUInteger originalIndex = index;
    
    // 线性探测解决冲突
    do {
        HashNode *node = _buckets[index];
        if ([node isKindOfClass:[NSNull class]] || node.isDeleted || [node.key isEqual:key]) {
            // 找到空位置或已存在的键，插入新节点
            HashNode *newNode = [[HashNode alloc] init];
            newNode.key = key;
            newNode.object = object;
            newNode.isDeleted = NO;
            _buckets[index] = newNode;
            if (![node isKindOfClass:[NSNull class]] && !node.isDeleted) {
                // 替换已存在的键，不增加计数
            } else {
                _count++;
                // 负载因子超过0.7时扩容
                if (_count > _capacity * 0.7) {
                    [self resize];
                }
            }
            return;
        }
        
        // 继续探测下一个位置
        index = (index + 1) % _capacity;
    } while (index != originalIndex); // 回到起点表示表已满
}

// 获取值
- (id)objectForKey:(NSString *)key {
    if (!key) return nil;
    
    NSUInteger index = [self hashForKey:key];
    NSUInteger originalIndex = index;
    
    do {
        HashNode *node = _buckets[index];
        if ([node isKindOfClass:[NSNull class]]) {
            // 找到空位置，说明键不存在
            return nil;
        }
        if (!node.isDeleted && [node.key isEqual:key]) {
            // 找到有效节点
            return node.object;
        }
        
        // 继续探测
        index = (index + 1) % _capacity;
    } while (index != originalIndex);
    
    return nil;
}

// 删除键值对
- (void)removeObjectForKey:(NSString *)key {
    if (!key) return;
    
    NSUInteger index = [self hashForKey:key];
    NSUInteger originalIndex = index;
    
    do {
        HashNode *node = _buckets[index];
        if ([node isKindOfClass:[NSNull class]]) {
            return; // 键不存在
        }
        if (!node.isDeleted && [node.key isEqual:key]) {
            // 标记为已删除
            node.isDeleted = YES;
            _count--;
            return;
        }
        
        // 继续探测
        index = (index + 1) % _capacity;
    } while (index != originalIndex);
}

// 扩容方法
- (void)resize {
    NSUInteger newCapacity = _capacity * 2;
    HashTable *newTable = [[HashTable alloc] initWithCapacity:newCapacity];
    
    // 重新哈希所有元素
    for (HashNode *node in _buckets) {
        if (![node isKindOfClass:[NSNull class]] && !node.isDeleted) {
            [newTable setObject:node.object forKey:node.key];
        }
    }
    
    // 更新当前表
    _capacity = newCapacity;
    _buckets = newTable->_buckets;
}

@end
