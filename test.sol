// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20,Ownable,ERC20Burnable
{

    constructor() ERC20("Himani", "HM") Ownable(msg.sender){}

    function mint(address to, uint256 amount)public onlyOwner   // function for mpnting tokens. 
    {
        _mint(to, amount);
    }
    struct Entity                   // creating structure entity.
    {
        string name;
        uint256 price;
    }
    

    mapping(uint256 => Entity) public features;         // done mapping to store available features

    mapping(address => mapping(uint256 => bool)) public userFeatures;  // done mapping to keep track of which features a user has bought


    event FeaturePurchased(address indexed user, uint256 featureId, string featureName); // creating event, through this we will be purchasing features.


    function addFeature(uint256 featureId, string memory name, uint256 price) public onlyOwner  // function to add features.
    {
        features[featureId] = Entity(name, price);
    }

    function buyFeature(uint256 featureId) public    // function to buy features.
    {
        Entity memory feature = features[featureId];
        require(bytes(feature.name).length != 0, "Feature does not exist");
        require(!userFeatures[msg.sender][featureId], "Feature already purchased");
        require(balanceOf(msg.sender) >= feature.price, "Insufficient balance");

        _transfer(msg.sender, address(this), feature.price);

        userFeatures[msg.sender][featureId] = true;

        emit FeaturePurchased(msg.sender, featureId, feature.name);
    }


    function hasPurchasedFeature(address user, uint256 featureId) public view returns (bool)  // it will make sure that the feature is succesfully pyrchased or not.
    {
        return userFeatures[user][featureId];
    }
    
}
