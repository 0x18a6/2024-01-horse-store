// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {HorseStore} from "../src/HorseStore.sol";
import {Test, console} from "forge-std/Test.sol";

abstract contract Base_Test is Test {
    string public constant NFT_NAME = "HorseStore";
    string public constant NFT_SYMBOL = "HS";

    address attacker = makeAddr("0x18a6");
    HorseStore horseStore;

    function setUp() public virtual {}

    function test_MintOneHorse() external {
        // rationale: check if u mint a horse, total supply is updated
        vm.prank(attacker);
        horseStore.mintHorse();

        assertEq(horseStore.totalSupply(), 1);
        /*
            @audit [HUFF] FAIL. Reas    on: assertion failed
            totalSupply() is not updated!!!
        */
    }

    function test_MintTwoHorses() external {
        // rationale: check if u mint two horses, total supply is updated
        vm.prank(address(0x01));
        horseStore.mintHorse();
        vm.prank(address(0x02));
        horseStore.mintHorse();

        assertEq(horseStore.totalSupply(), 2);
        /*
            @audit [HUFF] FAIL. Reason: revert: ALREADY_MINTED
        */
    }

    function test_BatchMint() external {
        vm.startPrank(attacker);
        for (uint256 i; i < 5; i++) {
            horseStore.mintHorse();
        }
        vm.stopPrank();
        assertEq(horseStore.totalSupply(), 5);
        /*
            @audit [HUFF] revert: ALREADY_MINTED
        */
    }

    function testFuzz_HorsesMustBeAbleToBeFedAllTheTime(uint256 timeExpired) external {
        // rationale: check if u can feed a horse all the time
        vm.warp(timeExpired); // `isHappyHorse` underflows
        horseStore.feedHorse(5);
        timeExpired = bound(timeExpired, 1 days, type(uint256).max);
        assertEq(horseStore.horseIdToFedTimeStamp(5), block.timestamp);

        /*
        @audit Failing tests:
        Encountered 1 failing test in test/HorseStoreHuff.t.sol:HorseStoreHuff
        [FAIL. Reason: EvmError: Revert; counterexample: calldata=0xfe6bb592ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff args=[115792089237316195423570985008687907853269984665640564039457584007913129639935

        Horse cannot be fed all the time!!!        
        */
    }

    function invariant_HorsesMustBeAbleToBeFedAllTheTime() external {
        horseStore.feedHorse(5);
        assertEq(horseStore.horseIdToFedTimeStamp(5), block.timestamp);
    }
}
