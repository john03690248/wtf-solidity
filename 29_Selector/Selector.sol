// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract DemoContract {

}

contract Selector{
    event Log(bytes data);
    event SelectorEvent(bytes4);

    struct User {
        uint256 uid;
        bytes name;
    }

    enum School { SCHOOL1, SCHOOL2, SCHOOL3 }

    function mint(address /*to*/) external{
        emit Log(msg.data);
    } 

    function mintSelector() external pure returns(bytes4 mSelector){
        return bytes4(keccak256("mint(address)"));
    }

    function nonParamSelector() external returns(bytes4 selectorWithNonParam){
        emit SelectorEvent(this.nonParamSelector.selector);
        return bytes4(keccak256("nonParamSelector()"));
    }

    function elementaryParamSelector(uint256 param1, bool param2) external returns(bytes4 selectorWithElementaryParam){
        emit SelectorEvent(this.elementaryParamSelector.selector);
        return bytes4(keccak256("elementaryParamSelector(uint256,bool)"));
    }

    function fixedSizeParamSelector(uint256[3] memory param1) external returns(bytes4 selectorWithFixedSizeParam){
        emit SelectorEvent(this.fixedSizeParamSelector.selector);
        return bytes4(keccak256("fixedSizeParamSelector(uint256[3])"));
    }

    function nonFixedSizeParamSelector(uint256[] memory param1,string memory param2) external returns(bytes4 selectorWithNonFixedSizeParam){
        emit SelectorEvent(this.nonFixedSizeParamSelector.selector);
        return bytes4(keccak256("nonFixedSizeParamSelector(uint256[],string)"));
    }

    function mappingParamSelector(DemoContract demo, User memory user, uint256[] memory count, School mySchool) external returns(bytes4 selectorWithMappingParam){
        emit SelectorEvent(this.mappingParamSelector.selector);
        return bytes4(keccak256("mappingParamSelector(address,(uint256,bytes),uint256[],uint8)"));
    }

    function callWithSignature() external{
        uint256[] memory param1 = new uint256[](3);
        param1[0] = 1;
        param1[1] = 2;
        param1[2] = 3;

        User memory user;
        user.uid = 1;
        user.name = "0xa0b1";

        (bool success0, bytes memory data0) = address(this).call(abi.encodeWithSelector(0x03817936));
        (bool success1, bytes memory data1) = address(this).call(abi.encodeWithSelector(0x3ec37834, 1, 0));
        (bool success2, bytes memory data2) = address(this).call(abi.encodeWithSelector(0xead6b8bd, [1,2,3]));
        (bool success3, bytes memory data3) = address(this).call(abi.encodeWithSelector(0xf0ca01de, param1, "abc"));
        (bool success4, bytes memory data4) = address(this).call(abi.encodeWithSelector(0xe355b0ce, 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99, user, param1, 1));
        require(success0 && success1 && success2 && success3 && success4);
    }
}