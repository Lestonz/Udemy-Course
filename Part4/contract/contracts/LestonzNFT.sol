// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract LestonzNFT is ERC721A, Ownable, ReentrancyGuard {
    using Strings for uint; 

    string public uri = "ipfs://QmdxuFiDrCjc9TZycroxpiYjHeKWXMrJmZwHQ2HS3TbnWW/";
    string public uriExtantion = ".json";

    uint public cost = 0.03 ether; //30000000000000000
    uint public maxSupply = 5;
    uint public maxMintPerTx = 2;  // Each address should be 2 times mint;

    TokenOwnership[] private _ownerships;
    uint private _currentIndex;

    constructor() ERC721A("LestonzNFT", "LSTNFT") {}

    modifier mintPriceControl (uint _mintAmount) {
        if(msg.sender != owner()) {
            require(msg.value >= cost * _mintAmount, "Insufficient Balance!");
        }
        _;
    }

    modifier mintControl(uint _mintAmount) {
        require(_mintAmount > 0 && _mintAmount <= maxMintPerTx, "Invalid number for mint!" );
        require(totalSupply() + _mintAmount <= maxSupply, "Max supply has passed.");
        _;
    }

    function mint(uint _mintAmount) public payable mintControl(_mintAmount) mintPriceControl(_mintAmount) {
        _safeMint(_msgSender(), _mintAmount);
    }

    function mintForOwner(uint _amount, address _reciever) public mintControl(_amount) onlyOwner {
        _safeMint(_reciever, _amount );
    }

    function walletControl(address _owner) public view returns(uint[] memory) {
        uint ownerTokenCount = balanceOf(_owner); // checked to NFT balance of address
        uint[] memory ownedTokenIds = new uint[](ownerTokenCount);
        uint currentTokenId = _startTokenId();
        uint ownedTokenIndex = 0;
        address latestOwnerAddress;

        while (ownedTokenIndex < ownerTokenCount && currentTokenId < _currentIndex) {
            TokenOwnership memory ownership = _ownerships[currentTokenId];

            if(!ownership.burned) {
                if(ownership.addr != address(0)) {
                    latestOwnerAddress = ownership.addr;
                }

                if (latestOwnerAddress == _owner) {
                    ownedTokenIds[ownedTokenIndex] = currentTokenId;

                    ownedTokenIndex ++;
                }
            }
            currentTokenId ++;
        }
        return ownedTokenIds;
    }

    function _startTokenId() internal view virtual override returns(uint) {
        return 1;
    }

    function tokenURI (uint _tokenId) public view virtual override returns(string memory) {
        require(_exists(_tokenId), "ERC721 Metadata: not defined for this token!");

        string memory currentBaseURI = _baseURI();
        return bytes(currentBaseURI).length > 0 
            ? string(abi.encodePacked(currentBaseURI, _tokenId.toString(), uriExtantion )) 
            : " ";
    }

    function changeCost(uint _cost) public onlyOwner {
        cost = _cost;
    }

    function maxMintPerTxUpdate(uint _amount) public onlyOwner {
        maxMintPerTx = _amount;
    }

    function URIUpdate(string memory _uri) public onlyOwner  {
        uri = _uri;
    }

    function URIExtantionUpdate(string memory _uriExtantion) public onlyOwner  {
        uriExtantion = _uriExtantion;
    }

    function _baseURI() internal view virtual override returns(string memory) {
        return uri;
    }

    function withdraw() public onlyOwner nonReentrant {
        (bool success, ) = payable(owner()).call{value: address(this).balance}('');
        require(success, "We have some problem from withdraw!");
    }


}
