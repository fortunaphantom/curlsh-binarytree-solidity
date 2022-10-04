// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

import "./StandardTest.sol";
import "./MyBinaryTree.sol";

contract BinaryTreeTest is StandardTest {
    MyBinaryTree Tree;

    function setUp() public {
        Tree = new MyBinaryTree();
    }

    /*
     state change tests
    */

    function testInsert() public {
        Tree.insert(1);
        assertTrue(Tree.getRoot() == 1);
    }

    function testFindElement() public {
        Tree.insert(1);
        assertTrue(Tree.findElement(1));
        assertTrue(!Tree.findElement(2));
    }

    function testDeletion() public {
        Tree.insert(1);
        Tree.insert(4);
        Tree.insert(2);
        Tree.insert(3);
        Tree.deleteNode(1);
        assertTrue(!Tree.findElement(1));
        assertTrue(Tree.findElement(4));
        assertTrue(Tree.findElement(2));
        assertTrue(Tree.findElement(3));
    }

    function testClearTree() public {
        Tree.insert(1);
        Tree.insert(4);
        Tree.insert(2);
        Tree.insert(3);
        Tree.deleteNode(1);
        Tree.deleteNode(2);
        Tree.deleteNode(3);
        Tree.deleteNode(4);
        assertTrue(!Tree.findElement(1));
        assertTrue(!Tree.findElement(4));
        assertTrue(!Tree.findElement(2));
        assertTrue(!Tree.findElement(3));
    }

    function testFindMin() public {
        Tree.insert(1);
        Tree.insert(4);
        Tree.insert(2);
        Tree.insert(3);
        assertTrue(Tree.findMin() == 1);
    }

    function testFindMax() public {
        Tree.insert(1);
        Tree.insert(4);
        Tree.insert(2);
        Tree.insert(3);
        assertTrue(Tree.findMax() == 4);
    }

    function testTreeSize() public {
        Tree.insert(1);
        Tree.insert(4);
        Tree.insert(2);
        Tree.insert(3);
        assertTrue(Tree.getTreeSize() == 4);
    }

    /*
    * Topic: Binary Trees
    * Problem 2: Create a function that returns bool, checks if two binary trees are identical, given the root of each
    */
    function testCompareTree() public {
        MyBinaryTree Tree1 = new MyBinaryTree();
        MyBinaryTree Tree2 = new MyBinaryTree();

        Tree1.insert(1);
        Tree1.insert(4);
        Tree1.insert(2);
        Tree1.insert(3);


        Tree2.insert(1);
        Tree2.insert(4);
        Tree2.insert(2);
        Tree2.insert(3);

        assertTrue(Tree1.compareNodes(Tree2));
    }

    /*
    * Topic: Binary Trees
    * Problem 1: Create a function that swaps left & right children for each node within a binary tree, given the root node
    */
    function testSwapChildren() public {
        Tree.insert(1);
        Tree.insert(4);
        Tree.insert(2);
        Tree.insert(3);
        Tree.swapChildren(Tree.rootAddress());
        StandardBinaryTree.Node memory root = Tree.getRootNode();
        StandardBinaryTree.Node memory leftChild = Tree.getNode(root.left);
        assertTrue(leftChild.value == 4);
    }
}
