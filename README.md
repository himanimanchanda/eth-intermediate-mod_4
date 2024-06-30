# eth-intermediate-mod_4
# DegenToken Contract 

## Overview
DegenToken is a Solidity smart contract that implements an ERC20 token named "Himani" with symbol "HM". It also includes additional functionalities for feature management and ownership control.

## Features
1. **ERC20 Token**: Implements the ERC20 standard for fungible tokens.
2. **Ownership**: Inherits from Ownable.sol to provide ownership functionalities.
3. **Token Minting**: Allows the contract owner to mint new tokens.
4. **Token Burning**: Implements burn functionality for tokens.
5. **Feature Management**: Allows the owner to define and manage additional features.
6. **Feature Purchasing**: Users can purchase defined features using their token balance.

## Usage
### Token Deployment
The token is deployed with the name "Himani" and symbol "HM". Ownership of the contract is assigned to the deployer.

### Adding Features
Features can be added by the contract owner using the `addFeature` function. Each feature is identified by a unique ID, has a name, and requires a specific token price for purchase.

### Buying Features
Users can buy features by calling the `buyFeature` function, providing the ID of the feature they wish to purchase. The function checks if the user has sufficient tokens and if the feature has not been purchased before.

### Checking Purchases
The contract provides a function `hasPurchasedFeature` to check if a user has successfully purchased a specific feature.

## Example
Here's a simple example of using the contract:

1. Deploy the contract.
2. Mint some tokens using the `mint` function.
3. Add features using `addFeature`.
4. Users can then buy these features using their token balance.
5. Use `hasPurchasedFeature` to verify feature ownership.

## License
This project is licensed under the MIT License. See LICENSE file for more details.

