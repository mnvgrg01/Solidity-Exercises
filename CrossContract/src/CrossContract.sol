// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CrossContract {
    /**
     * The function below is to call the price function of PriceOracle1 and PriceOracle2 contracts below and return the lower of the two prices
     */

    function getLowerPrice(
        address _priceOracle1,
        address _priceOracle2
    ) external returns (uint256) {
        // your code here
        (bool ok, bytes memory result) = _priceOracle1.call(
            abi.encodeWithSignature('price()')
        );
        require(ok, 'contract calling failed');
        uint256 price = abi.decode(result, (uint256));
        (bool ok1, bytes memory result1) = _priceOracle2.call(
            abi.encodeWithSignature('price()')
        );
        require(ok1, 'contract calling failed');
        uint256 price1 = abi.decode(result1, (uint256));
        return (price < price1) ? price : price1;
    }
}

contract PriceOracle1 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}

contract PriceOracle2 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}
