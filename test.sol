// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    constructor() ERC20("Himani", "HM") Ownable(msg.sender) {}

    // Explicitly adding the mint function (already available via onlyOwner)
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Explicitly adding the burn function (already available via ERC20Burnable)
    function burn(uint256 amount) public override {
        _burn(msg.sender, amount);
    }

    // Explicitly adding the transfer function (standard ERC20 transfer function)
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        return super.transfer(recipient, amount);
    }

    struct Entity {
        string name;
        uint256 price;
    }

    mapping(uint256 => Entity) public features; // Mapping to store available features

    mapping(address => mapping(uint256 => bool)) public userFeatures; // Mapping to track purchased features

    event FeaturePurchased(address indexed user, uint256 featureId, string featureName); // Event for feature purchases

    // Function to add features (only owner)
    function addFeature(uint256 featureId, string memory name, uint256 price) public onlyOwner {
        features[featureId] = Entity(name, price);
    }

    // Function to buy features
    function buyFeature(uint256 featureId) public {
        Entity memory feature = features[featureId];
        require(bytes(feature.name).length != 0, "Feature does not exist");
        require(!userFeatures[msg.sender][featureId], "Feature already purchased");
        require(balanceOf(msg.sender) >= feature.price, "Insufficient balance");

        _transfer(msg.sender, address(this), feature.price);

        userFeatures[msg.sender][featureId] = true;

        emit FeaturePurchased(msg.sender, featureId, feature.name);
    }

    // View function to check if a user has purchased a feature
    function hasPurchasedFeature(address user, uint256 featureId) public view returns (bool) {
        return userFeatures[user][featureId];
    }
}
