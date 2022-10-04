const { expect } = require('chai');
const { BigNumber } = require('ethers');
const { ethers } = require('hardhat');
const Web3 = require('web3');

let owner, addr1, addr2, addr3;
let BinaryTreeTestContract, BinaryTreeContract;
let instanceBinaryTreeTest, instanceBinaryTree;

let provider = ethers.getDefaultProvider();

const contractName = 'BinaryTreeTest';

beforeEach(async function () {
  [owner, addr1, addr2, addr3] = await ethers.getSigners();
  BinaryTreeTestContract = await ethers.getContractFactory(contractName);
  instanceBinaryTreeTest = await BinaryTreeTestContract.deploy();
  await instanceBinaryTreeTest.connect(owner).setUp();
  BinaryTreeContract = await ethers.getContractFactory("MyBinaryTree");
  instanceBinaryTree = await BinaryTreeContract.deploy();
});

describe('BinaryTreeContract Test', function () {
  it('testInsert', async function () {
    await instanceBinaryTreeTest.connect(owner).testInsert();
  });

  it('testFindMin', async function () {
    await instanceBinaryTreeTest.connect(owner).testFindMin();
  });

  it('testCompareTree', async function () {
    await instanceBinaryTreeTest.connect(owner).testCompareTree();
  });
  
  it('testSwapChildren', async function () {
    await instanceBinaryTreeTest.connect(owner).testSwapChildren();
  });
});
