// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/NFT.sol";

// This is the test contract for MyToken
contract MyTokenTest is Test {
    MyToken private myToken;
    address private owner;
    address private minter;

    function setUp() public {
        owner = address(this); // Set the test contract as the owner
        minter = address(0x1); // Address to mint tokens to
        myToken = new MyToken(owner); // Deploy the MyToken contract
    }

    function testMintToken() public {
        uint256 initialBalance = myToken.balanceOf(minter);

        myToken.safeMint(minter);
        uint256 newBalance = myToken.balanceOf(minter);

        assertEq(newBalance, initialBalance + 1, "Minting failed");
        assertEq(myToken.ownerOf(0), minter, "Incorrect token owner");
    }

    function testSetBaseURI() public {
        string memory newURI = "newBaseURI";
        myToken.setBaseURI(newURI);
        
        string memory baseURI = myToken._baseTokenURI();

        assertEq(baseURI, newURI, "Base URI not updated correctly");
    }

    function testMintAndSetBaseURI() public {
        // Mint first token
        myToken.safeMint(minter);
        
        uint256 firstTokenId = 0;
        assertEq(myToken.ownerOf(firstTokenId), minter, "Incorrect first token owner");

        // Mint second token
        myToken.safeMint(minter);

        uint256 secondTokenId = 1;
        assertEq(myToken.ownerOf(secondTokenId), minter, "Incorrect second token owner");

        // Update base URI
        string memory newURI = "newBaseURI";
        myToken.setBaseURI(newURI);
        
        string memory baseURI = myToken._baseTokenURI();

        assertEq(baseURI, newURI, "Base URI not updated correctly");
    }
}