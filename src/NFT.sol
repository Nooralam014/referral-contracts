// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title MyToken ERC721 Token Contract
/// @notice This contract creates a customizable ERC721 token with pausing and URI storage capabilities.
/// @dev This contract integrates with OpenZeppelin's ERC721, ERC721Enumerable, ERC721URIStorage, and ERC721Pausable.
contract MyToken is
    ERC721,
    ERC721Enumerable,
    ERC721URIStorage,
    ERC721Pausable,
    Ownable
{
    uint256 private _nextTokenId;

    /// @notice Emitted when a new token is minted.
    /// @param to The address to which the token is minted.
    /// @param tokenId The ID of the minted token.
    /// @param uri The URI of the minted token.
    event Mint(address indexed to, uint256 indexed tokenId, string uri);

    /// @notice Constructor to initialize the token with a name, symbol, and initial owner.
    /// @param name The name of the token.
    /// @param symbol The symbol of the token.
    /// @param initialOwner The initial owner of the token.
    constructor(
        string memory name,
        string memory symbol,
        address initialOwner
    ) ERC721(name, symbol) Ownable(initialOwner) {}

    /// @notice Returns the base URI for the token metadata.
    /// @dev Overrides the _baseURI function from ERC721.
    /// @return An empty string as the base URI.
    function _baseURI() internal pure override returns (string memory) {
        return "";
    }

    /// @notice Pauses all token transfers.
    /// @dev Only callable by the owner.
    function pause() public onlyOwner {
        _pause();
    }

    /// @notice Unpauses all token transfers.
    /// @dev Only callable by the owner.
    function unpause() public onlyOwner {
        _unpause();
    }

    /// @notice Mints a new token with a specified URI to a specified address.
    /// @param to The address to which the token is minted.
    /// @param uri The URI of the minted token.
    function safeMint(address to, string memory uri) public {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        emit Mint(to, tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    /// @notice Updates the token ownership.
    /// @dev Overrides the _update function from ERC721, ERC721Enumerable, and ERC721Pausable.
    /// @param to The address to which the token is being transferred.
    /// @param tokenId The ID of the token being transferred.
    /// @param auth The authorized address for the transfer.
    /// @return The updated owner address.
    function _update(
        address to,
        uint256 tokenId,
        address auth
    )
        internal
        override(ERC721, ERC721Enumerable, ERC721Pausable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    /// @notice Increases the balance of a specified address.
    /// @dev Overrides the _increaseBalance function from ERC721 and ERC721Enumerable.
    /// @param account The address whose balance is being increased.
    /// @param value The amount by which the balance is increased.
    function _increaseBalance(
        address account,
        uint128 value
    ) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    /// @notice Returns the URI of a specified token.
    /// @dev Overrides the tokenURI function from ERC721 and ERC721URIStorage.
    /// @param tokenId The ID of the token.
    /// @return The URI of the token.
    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    /// @notice Checks if the contract supports a specified interface.
    /// @dev Overrides the supportsInterface function from ERC721, ERC721Enumerable, and ERC721URIStorage.
    /// @param interfaceId The ID of the interface.
    /// @return True if the contract supports the interface, false otherwise.
    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
