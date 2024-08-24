// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import "./simplStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;
   
    function DeployContract () public {
        SimpleStorage simpleStorageInstance = new SimpleStorage();
        simpleStorageArray.push(simpleStorageInstance);
    }     

    function StoreContract (uint256 _StorageIndex, int256 _StorageValue) public  {
        simpleStorageArray[_StorageIndex].SetYouFavNumber(_StorageValue);
    }

    function GetContract (uint256 _StorageIndex) public view returns(int256) {
        return simpleStorageArray[_StorageIndex].GetYouFavNumber();
        
    }   
}
