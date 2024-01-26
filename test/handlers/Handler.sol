// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {HorseStore} from "../../src/HorseStore.sol";

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

contract Handler is CommonBase, StdCheats, StdUtils {
    HorseStore public horseStore;

    constructor(HorseStore _horseStore) {
        horseStore = _horseStore;
    }

    function mintHorse() external {
        horseStore.mintHorse();
    }

    function feedHorse(uint256 _horseId) external {
        horseStore.feedHorse(_horseId);
    }

    function isHappyHorse(uint256 horseId) external view returns (bool) {
        return horseStore.isHappyHorse(horseId);
    }
}
