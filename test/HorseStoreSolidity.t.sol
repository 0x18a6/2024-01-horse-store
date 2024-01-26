// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Base_Test} from "./Base.t.sol";
import {HorseStore} from "../src/HorseStore.sol";

import {Handler} from "./handlers/Handler.sol";

contract HorseStoreSolidity is Base_Test {
    Handler solidityHandler;

    function setUp() public override {
        horseStore = new HorseStore();

        solidityHandler = new Handler(horseStore);
        targetContract(address(solidityHandler));
    }
}
