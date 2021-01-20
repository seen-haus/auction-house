// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.0;

interface IERC1155 {
    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _id,
        uint256 _value,
        bytes calldata _data
    ) external;
}

contract EnglishAuction {
    // System settings
    uint256 public id;
    uint256 public fee;
    address public token;
    uint256 public start;
    uint256 public end;
    bool public ended = false;

    // Payable addresses
    address payable public haus;
    address payable public seller;

    // Current winning bid info
    uint256 public lastBid;
    uint256 public lastBidTime;
    address payable public winning;

    event Bid(address who, uint256 amount);
    event Won(address who, uint256 amount);

    constructor(
        address payable _seller,
        address payable _haus,
        uint256 _fee,
        address _token,
        uint256 _id,
        uint256 _startPrice,
        uint256 _startTime,
        uint256 _endTime
    ) {
        seller = _seller;
        haus = _haus;
        fee = _fee;
        token = _token;
        id = _id;
        lastBid = _startPrice;
        start = _startTime;
        end = _endTime;

        // transfer erc1155 to auction
        IERC1155(token).safeTransferFrom(
            seller,
            address(this),
            id,
            1,
            new bytes(0x0)
        );
    }

    function bid() public payable {
        // Check we have a valid bid
        require(msg.sender == tx.origin, "bid:no contracts");
        require(block.timestamp >= start, "bid:auction not started");
        require(block.timestamp < end, "bid:auction ended");
        require(msg.value >= ((lastBid * 105) / 100), "bid:bid too small");

        // Give back the last bidders money
        if (lastBidTime != 0) {
            winning.transfer(lastBid);
        }

        lastBid = msg.value;
        winning = payable(address(msg.sender));
        lastBidTime = block.timestamp;

        emit Bid(msg.sender, msg.value);
    }

    function close() public {
        require(!ended, "close:close() already called");
        require(lastBidTime != 0, "close:no bids");
        require(block.timestamp >= end, "close:auction live");

        // transfer erc1155 to winner
        IERC1155(token).safeTransferFrom(
            address(this),
            winning,
            id,
            1,
            new bytes(0x0)
        );

        uint256 balance = address(this).balance;
        uint256 hausFee = (balance / 100) * fee;
        haus.transfer(hausFee);
        seller.transfer(address(this).balance);

        ended = true;

        emit Won(winning, lastBid);
    }

    function pull() public {
        require(!ended, "pull:pull already called");
        require(lastBidTime == 0, "pull:there were bids");
        require(block.timestamp >= end, "pull:auction live");

        // transfer erc1155 to seller
        IERC1155(token).safeTransferFrom(
            address(this),
            seller,
            id,
            1,
            new bytes(0x0)
        );

        ended = true;
    }

    function live() external view returns (bool) {
        if (block.timestamp < end) {
            return true;
        }
        return false;
    }

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes calldata
    ) external pure returns (bytes4) {
        return
            bytes4(
                keccak256(
                    "onERC1155Received(address,address,uint256,uint256,bytes)"
                )
            );
    }
}
