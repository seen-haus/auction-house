pragma solidity ^0.6.7;

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
