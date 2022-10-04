// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "./StandardBinaryTree.sol";

contract MyBinaryTree is StandardBinaryTree {
    constructor() {
    }

    /*
    * Topic: Binary Trees
    * Problem 2: Create a function that returns bool, checks if two binary trees are identical, given the root of each
    */
    function compareNodes(MyBinaryTree treeObj) public view returns (bool) {
        return _compareNodesHelper(getRootNode(), treeObj.getRootNode(), treeObj);
    }

    // recursive checking
    function _compareNodesHelper(Node memory node1, Node memory node2, MyBinaryTree treeObj) internal view returns (bool) {
        if (node1.value != node2.value) {
            return false;
        }

        // left-child checking
        if (node1.left != 0 && node2.left != 0) {
            bool bLeft = _compareNodesHelper(getNode(node1.left), treeObj.getNode(node2.left), treeObj);
            if (!bLeft) {
                return false;
            }
        }
        else if ((node1.left != 0 && node2.left == 0) || (node1.left == 0 && node2.left != 0)) {
            return false;
        }

        // right-child checking
        if (node1.right != 0 && node2.right != 0) {
            bool bRight = _compareNodesHelper(getNode(node1.right), treeObj.getNode(node2.right), treeObj);
            if (!bRight) {
                return false;
            }
        }
        else if ((node1.right != 0 && node2.right == 0) || (node1.right == 0 && node2.right != 0)) {
            return false;
        }

        return true;
    }

    /*
    * Topic: Binary Trees
    * Problem 1: Create a function that swaps left & right children for each node within a binary tree, given the root node
    */

    function swapChildren(bytes32 _nodeAddress) public {
        return _swapChildrenHelper(_nodeAddress);
    }

    // recursive checking
    function _swapChildrenHelper(bytes32 _nodeAddress) internal {
        // exchange the left and right children
        bytes32 temp = tree[_nodeAddress].left;
        tree[_nodeAddress].left = tree[_nodeAddress].right;
        tree[_nodeAddress].right = temp;

        // exchange left child
        if (tree[_nodeAddress].left != 0) {
            _swapChildrenHelper(tree[_nodeAddress].left);
        }

        // exchange right child
        if (tree[_nodeAddress].right != 0) {
            _swapChildrenHelper(tree[_nodeAddress].right);
        }
    }
}
