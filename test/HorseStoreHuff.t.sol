// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Base_Test} from "./Base.t.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {HorseStore} from "../src/HorseStore.sol";

import {Handler} from "./handlers/Handler.sol";

contract HorseStoreHuff is Base_Test {
    string public constant horseStoreLocation = "HorseStore";
    Handler huffHandler;

    function setUp() public override {
        horseStore = HorseStore(
            HuffDeployer.config().with_args(bytes.concat(abi.encode(NFT_NAME), abi.encode(NFT_SYMBOL))).deploy(
                horseStoreLocation
            )
        );

        huffHandler = new Handler(horseStore);
        targetContract(address(huffHandler));
    }
}
