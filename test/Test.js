const { expect } = require('chai');
const { BigNumber } = require('ethers');
const { ethers } = require('hardhat');
const Web3 = require('web3');

let owner, addr1, addr2, addr3;
let BinaryTreeContract;
let instanceBinaryTree;

let provider = ethers.getDefaultProvider();

const contractName = 'BinaryTreeTest';

beforeEach(async function () {
  [owner, addr1, addr2, addr3] = await ethers.getSigners();
  BinaryTreeContract = await ethers.getContractFactory(contractName);
  instanceBinaryTree = await BinaryTreeContract.deploy();
  await instanceBinaryTree.connect(owner).setUp();
});

describe('BinaryTreeContract Test', function () {
  it('testInsert', async function () {
    // await instanceBinaryTree.connect(owner);
    await instanceBinaryTree.connect(owner).testInsert();
  });
  it('testFindMin', async function () {
    // await instanceBinaryTree.connect(owner);
    await instanceBinaryTree.connect(owner).testFindMin();
  });
});
