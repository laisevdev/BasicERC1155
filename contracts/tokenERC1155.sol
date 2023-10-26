// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract BasicToken1155 is ERC1155, Ownable, Pausable {

    uint256 public constant VITALIK_ATHOME = 0;
    uint256  public constant BAD_VITALIK = 1;    

    uint256  constant GOLDENTOKEN = 2;
   
   
    constructor()
         ERC1155("https://ipfs.io/ipfs/bafybeihtixxgkce64vg6fe32v2knumoprw24qje543mvoroirenbjnjrxi/{id}.json") {

        _mint(msg.sender, VITALIK_ATHOME, 1, "");
        _mint(msg.sender, BAD_VITALIK, 1, "");        

        _mint(msg.sender, GOLDENTOKEN, 1000, "");
    }


    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function uri(uint256 _tokenId) override public pure returns (string memory) {
       return string(abi.encodePacked("https://ipfs.io/ipfs/bafybeihtixxgkce64vg6fe32v2knumoprw24qje543mvoroirenbjnjrxi/",Strings.toString(_tokenId),".json")
       );
   }

   function contractURI () public pure returns (string memory) {
       return "https://ipfs.io/ipfs/bafybeihtixxgkce64vg6fe32v2knumoprw24qje543mvoroirenbjnjrxi/0.json";
   }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}