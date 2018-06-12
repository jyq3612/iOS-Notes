//
//  BinaryTreeNode.m
//  BinaryTree
//
//  Created by 贾永强 on 2018/5/21.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "BinaryTreeNode.h"


@implementation BinaryTreeNode
+ (BinaryTreeNode *)createTreeWithValues:(NSArray *)values {
    BinaryTreeNode *root = nil;
    for (NSNumber *value in values) {
        root = [BinaryTreeNode addNodeWithRootNode:root Value:value];
    }
    
    return root;
}

+ (BinaryTreeNode *)addNodeWithRootNode:(BinaryTreeNode *)rootNode Value:(NSNumber *)value {
    if (!rootNode) {
        rootNode = [BinaryTreeNode new];
        rootNode.value = value;
    }
    else if ([value compare:rootNode.value] != NSOrderedDescending) {
        rootNode.leftNode = [BinaryTreeNode addNodeWithRootNode:rootNode.leftNode Value:value];
    }
    else {
        rootNode.rightNode = [BinaryTreeNode addNodeWithRootNode:rootNode.rightNode Value:value];
    }
    
    return rootNode;
}

+ (BinaryTreeNode *)nodeWithRootNode:(BinaryTreeNode *)rootNode index:(NSInteger)index {
    if (!rootNode) {
        return nil;
    }
    
    ///从最顶层开始所有的nodes
    NSMutableArray<BinaryTreeNode *> *allNodes = [NSMutableArray array];
    ///某一层的nodes
    NSMutableArray<BinaryTreeNode *> *hierarchyNodes = [@[rootNode] mutableCopy];
    ///下一层的nodes
    NSMutableArray<BinaryTreeNode *> *nextNodes = [NSMutableArray array];
    
    while (allNodes.count <= index && hierarchyNodes.count) {
        for (BinaryTreeNode *node in hierarchyNodes) {
            if (node.leftNode) {
                [nextNodes addObject:node.leftNode];
            }
            if (node.rightNode) {
                [nextNodes addObject:node.rightNode];
            }
        }
        
        [allNodes addObjectsFromArray:hierarchyNodes];
        [hierarchyNodes removeAllObjects];
        [hierarchyNodes addObjectsFromArray:nextNodes];
        [nextNodes removeAllObjects];
    }
    
    if (allNodes.count > index) {
        return allNodes[index];
    }
    
    return nil;
}

+ (void)traverseTreeWithRootNode:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *node))handle {
    if (rootNode) {
        if (handle) {
            handle(rootNode);
        }
        [self traverseTreeWithRootNode:rootNode.leftNode handle:handle];
        [self traverseTreeWithRootNode:rootNode.rightNode handle:handle];
    }
}

+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode handler:(void (^)(BinaryTreeNode *))handler {
    if (!rootNode) {
        return;
    }
    
    NSMutableArray *queueArray = [NSMutableArray array];
    [queueArray addObject:rootNode];
    while (queueArray.count > 0) {
        BinaryTreeNode *node = [queueArray firstObject];
        if (handler) {
            handler(node);
        }
        [queueArray removeObjectAtIndex:0];
        if (node.leftNode) {
            [queueArray addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode];
        }
    }
}

+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    
    NSInteger leftDepth = [self depthOfTree:rootNode.leftNode];
    NSInteger rightDepth = [self depthOfTree:rootNode.rightNode];
    return 1 + MAX(leftDepth, rightDepth);
}

+ (NSInteger)nodesnumberOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    return 1 + [self nodesnumberOfTree:rootNode.leftNode] + [self nodesnumberOfTree:rootNode.rightNode];
}

+ (NSInteger)levelNodesNumberOfTree:(BinaryTreeNode *)rootNode level:(NSInteger)level {
    if (!rootNode || level < 1) {
        return 0;
    }
    if (level == 1) {
        return 1;
    }
    level--;
    
    return [self levelNodesNumberOfTree:rootNode.leftNode level:level] + [self levelNodesNumberOfTree:rootNode.rightNode level:level];
}

+ (NSInteger)numberOfLeafsWithTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    if (rootNode && !rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    
    return [self numberOfLeafsWithTree:rootNode.leftNode] + [self numberOfLeafsWithTree:rootNode.rightNode];
}

+ (NSInteger)maxDistanceOfTree:(BinaryTreeNode *)rootNode {
    return 0;
}

@end
