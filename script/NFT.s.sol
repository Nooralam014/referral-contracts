// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/NFT.sol";

contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address initialOwner = 0xC5EE6A5a3F78c05636cb3678500287A2c8AcAb12;

        MyToken nft = new MyToken(initialOwner);

        vm.stopBroadcast();
    }
}