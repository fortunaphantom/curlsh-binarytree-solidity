// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract StandardBinaryTree {
    struct Node {
        uint256 value;
        bytes32 left;
        bytes32 right;
    }

    mapping (bytes32 => Node) internal tree;

    bytes32 public rootAddress;

    constructor() {
    }

    /* 
        * These are insertion and deletion functions.
            - Insertion (average log(n)), worst case O(n)):
                - Start at the root node (rootAddress)
                - If the value is less than the current node's value, go left.
                - If the value is greater than the current node's value, go right.
                - Generate ID for the new node.
                - Insert the new node into the tree via the ID.
                - Returns the address of the new node.
            - Deletion (average log(n)), worst case O(n):
                - Start at the root node (rootAddress)
                - If the value is less than the current node's value, go left.
                - If the value is greater than the current node's value, go right.
                - If the value is equal to the current node's value, start node deletion.
                - If the leaf has children, replace the leaf with the child.
                - If the leaf has no children, delete the leaf.
                - have left preference over right when deleting.
    */


    // inserts
    function insert(uint256 value) public {
        Node memory root = tree[rootAddress];
        // if the tree is empty
        if (root.value == 0) {
            root.value = value;
            root.left = 0;
            root.right = 0;
            tree[0] = root;
            rootAddress = _generateId(value, 0);
            tree[rootAddress] = root;
        } else {
            // if the tree is not empty
            // find the correct place to insert the value
            _insertHelper(value, rootAddress);
        }
    }

    // helper function for insert
    function _insertHelper(uint256 value, bytes32 nodeAddress) internal {
        // Parent node 
        Node memory node = tree[nodeAddress];

        // if the value is less than the current node, insert it to the left
        // else, insert it to the right
        if (value < node.value) {
            // if the value is less than the current node
            // check if the left node is empty
            if (node.left == 0) {
                // if the left node is empty
                // insert the value
                _insertNode(value, nodeAddress, 0);
            } else {
                // if the left node is not empty
                // recursively call the function
                _insertHelper(value, node.left);
            }
        } else {
            // if the value is greater than the current node
            // check if the right node is empty
            if (node.right == 0) {
                // if the right node is empty
                // insert the value
                _insertNode(value, nodeAddress, 1);
            } else {
                // if the right node is not empty
                // recursively call the function
                _insertHelper(value, node.right);
            }
        }
    }

    // inserts a node
    function _insertNode(uint256 value, bytes32 nodeAddress, uint256 location) internal {
        Node memory parentNode = tree[nodeAddress];
        bytes32 nodeId = _generateId(value, nodeAddress);
        if (location == 0) {
            // if the value is less than the current node
            parentNode.left = nodeId;
        } else {
            // if the value is greater than the current node
            parentNode.right = nodeId;
        }

        // update the tree
        tree[nodeAddress] = parentNode;
        tree[nodeId] = Node(value, 0, 0);
    }


    // deletes
    function deleteNode(uint256 value) public {
        _deleteNodeHelper(value, rootAddress);
    }


    // recusively delete the node
    function _deleteNodeHelper(uint256 value, bytes32 nodeAddress) internal {
        Node memory node = tree[nodeAddress];
        if (node.value == value) {
            _deleteLeaf(nodeAddress);
        } else if (node.value > value) {
            if (node.left == 0) {
                return;
            } else {
                _deleteNodeHelper(value, node.left);
            }
        } else {
            if (node.right == 0) {
                return;
            } else {
                _deleteNodeHelper(value, node.right);
            }
        }
    }

    // deletes a leaf node
    function _deleteLeaf(bytes32 nodeAddress) internal {
        Node memory node = tree[nodeAddress];
        if (node.left != 0 && node.right != 0) {
            bytes32 tempNodeAddress = node.left;
            while (tree[tempNodeAddress].right != 0) {
                tempNodeAddress = tree[tempNodeAddress].right;
            }
            uint256 tempValue = tree[tempNodeAddress].value;
            _deleteNodeHelper(tempValue, node.left);
            node.value = tempValue;
        } else if (node.left != 0) {
            node.value = tree[node.left].value;
            node.left = tree[node.left].left;
            node.right = tree[node.left].right;
            tree[nodeAddress] = node;
        } else if (node.right != 0) {
            node.value = tree[node.right].value;
            node.left = tree[node.right].left;
            node.right = tree[node.right].right;
            tree[nodeAddress] = node;
        } else {
            tree[nodeAddress] = Node(0, 0, 0);
        }
    }

    // helper function to generate an ID
    function _generateId(uint256 value, bytes32 parentAddress) internal view returns (bytes32) {
        // generate a unique id for the node
        return keccak256(
            abi.encodePacked(
                value,
                parentAddress,
                block.timestamp
            )
        );
    }


    /* 
        * These are traversal functions.
            - Preorder traversal (O(n)):
                - Start at the root node (rootAddress)
                - Visit the node
                - Traverse the left subtree
                - Traverse the right subtree
            - Inorder traversal (O(n)):
                - Start at the root node (rootAddress)
                - Traverse the left subtree
                - Visit the node
                - Traverse the right subtree
            - Postorder traversal (O(n)):
                - Start at the root node (rootAddress)
                - Traverse the left subtree
                - Traverse the right subtree
                - Visit the node
    */

    // inorder traversal
    function displayInOrder() public {
        _displayInOrderHelper(rootAddress);
    }

    // recursive helper function for inorder traversal
    function _displayInOrderHelper(bytes32 nodeAddress) internal {
        Node memory node = tree[nodeAddress];
        if (node.left != 0) {
            _displayInOrderHelper(node.left);
        }
        // console.log(node.value);
        if (node.right != 0) {
            _displayInOrderHelper(node.right);
        }
    }   

    // preorder traversal
    function displayPreOrder() public {
        _displayPreOrderHelper(rootAddress);
    }

    // recursive helper function for preorder traversal
    function _displayPreOrderHelper(bytes32 nodeAddress) internal {
        Node memory node = tree[nodeAddress];
        // console.log(node.value);
        if (node.left != 0) {
            _displayPreOrderHelper(node.left);
        }
        if (node.right != 0) {
            _displayPreOrderHelper(node.right);
        }
    }

    // post order traversal
    function displayPostOrder() public {
        _displayPostOrderHelper(rootAddress);
    }

    // recursive helper function for postorder traversal
    function _displayPostOrderHelper(bytes32 nodeAddress) internal {
        Node memory node = tree[nodeAddress];
        if (node.left != 0) {
            _displayPostOrderHelper(node.left);
        }
        if (node.right != 0) {
            _displayPostOrderHelper(node.right);
        }
        // console.log(node.value);
    }


    // This function is used to test the tree, returns the nodes in the tree as a string
    function getTree() public view returns (string memory) {
        string memory result;
        Node memory node;
        bytes32 tempRoot = rootAddress;
        node = tree[tempRoot];
        while (node.left != 0 || node.right != 0) {
            node = tree[tempRoot];
            result = string(abi.encodePacked(result," ", node.value));
            if (node.left != 0) {
                tempRoot = node.left;
            } else {
                tempRoot = node.right;
            }
        }

        return result;
    }



    /*
        These are search functions.
            - Search for a value in the tree (average log(n)), worst case O(n)):
                - Start at the root node (rootAddress)
                - If the value is less than the current node, traverse the left subtree
                - If the value is greater than the current node, traverse the right subtree
                - If the value is equal to the current node, return true
                - If the value is not in the tree, return false
    */

    // search for a value in the tree
    function findElement(uint256 value) public view returns (bool) {
        return _findElementHelper(value, rootAddress);
    }

    // recursive helper function for findElement
    function _findElementHelper(uint256 value, bytes32 nodeAddress) internal view returns (bool) {
        Node memory node = tree[nodeAddress];
        if (node.value == value) {
            return true;
        } else if (node.value > value) {
            if (node.left == 0) {
                return false;
            } else {
                return _findElementHelper(value, node.left);
            }
        } else {
            if (node.right == 0) {
                return false;
            } else {
                return _findElementHelper(value, node.right);
            }
        }
    } 


    /*
        - Here are some other functions that occasionally accompany tree implementations.
    */
    function findMin() public view returns (uint256) {
        return _findMinHelper(rootAddress);
    }

    function _findMinHelper(bytes32 nodeAddress) internal view returns (uint256) {
        Node memory node = tree[nodeAddress];
        if (node.left == 0) {
            return node.value;
        } else {
            return _findMinHelper(node.left);
        }
    }

    function findMax() public view returns (uint256) {
        return _findMaxHelper(rootAddress);
    }

    function _findMaxHelper(bytes32 nodeAddress) internal view returns (uint256) {
        Node memory node = tree[nodeAddress];
        if (node.right == 0) {
            return node.value;
        } else {
            return _findMaxHelper(node.right);
        }
    }

    function getRoot() public view returns (uint256) {
        if (tree[rootAddress].value != 0) {
            return tree[rootAddress].value;
        } 
        
        revert ("Tree is empty");
    }

    function getTreeSize() public view returns (uint256) {
        return getTreeSizeHelper(rootAddress);
    }

    function getTreeSizeHelper(bytes32 nodeAddress) internal view returns (uint256) {
        Node memory node = tree[nodeAddress];
        if (node.left == 0 && node.right == 0) {
            return 1;
        } else {
            if (node.left == 0) {
                return 1 + getTreeSizeHelper(node.right);
            } else if (node.right == 0) {
                return 1 + getTreeSizeHelper(node.left);
            } else {
                return 1 + getTreeSizeHelper(node.left) + getTreeSizeHelper(node.right);
            }
        }
    }

    function getNode(bytes32 key) public view returns (Node memory) {
        return tree[key];
    }

    function getRootNode() public view returns (Node memory) {
        if (tree[rootAddress].value != 0) {
            return tree[rootAddress];
        } 
        
        revert ("Tree is empty");
    }
}
