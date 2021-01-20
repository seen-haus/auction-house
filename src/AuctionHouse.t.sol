// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.0;

import "ds-test/test.sol";

import "./AuctionHouse.sol";

contract AuctionHouseTest is DSTest {
    AuctionHouse house;

    function setUp() public {
        house = new AuctionHouse();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
