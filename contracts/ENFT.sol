//Contract based on https://docs.openzeppelin.com/contracts/3.x/erc721
// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ENFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    event ENFTUpdated(uint256 tokenId, address owner, string tokenURI);

    function getCount() public view returns (uint256)
    {
        return _tokenIds.current();
    }

    constructor() public ERC721("ENFT", "B2B") {}

    function mintNFT(address recipient, string memory tokenURI)
        public onlyOwner
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _safeMint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        emit ENFTUpdated(newItemId, recipient, tokenURI);
        return newItemId;
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory)
    {
        return tokenURI(tokenId);
    }

    function setTokenURI(uint256 tokenId, string memory _tokenURI) public
    {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: caller is not owner nor approved"
        );
        _setTokenURI(tokenId, _tokenURI);
        emit ENFTUpdated(tokenId, _msgSender(), _tokenURI);
    }

}
