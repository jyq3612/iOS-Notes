//
//  BinaryTreeNode.h
//  BinaryTree
//
//  Created by 贾永强 on 2018/5/21.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinaryTreeNode : NSObject

@property (strong, nonatomic) NSNumber *value;
@property (strong, nonatomic) BinaryTreeNode *leftNode;
@property (strong, nonatomic) BinaryTreeNode *rightNode;

+ (BinaryTreeNode *)createTreeWithValues:(NSArray *)values;
+ (BinaryTreeNode *)addNodeWithRootNode:(BinaryTreeNode *)rootNode Value:(NSNumber *)value;
///按照层次遍历
+ (BinaryTreeNode *)nodeWithRootNode:(BinaryTreeNode *)rootNode index:(NSInteger)index;
///依次遍历 本示例中先访问根结点，然后左子节点，再右子节点
+ (void)traverseTreeWithRootNode:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *node))handle;
///层次遍历
+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler;
///二叉树的深度
+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode;
///所有节点数
+ (NSInteger)nodesnumberOfTree:(BinaryTreeNode *)rootNode;
///某层的节点数
+ (NSInteger)levelNodesNumberOfTree:(BinaryTreeNode *)rootNode level:(NSInteger)level;
///二叉树叶子节点数
+ (NSInteger)numberOfLeafsWithTree:(BinaryTreeNode *)rootNode;
///二叉树的最大距离（直径）
+ (NSInteger)maxDistanceOfTree:(BinaryTreeNode *)rootNode;
@end
