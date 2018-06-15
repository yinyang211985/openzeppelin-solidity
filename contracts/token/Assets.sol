pragma solidity ^0.4.24;

import { Ownable } from '../ownership/Ownable.sol';
import { ERC20 } from '../token/ERC20/ERC20.sol';
import { ERC721 } from '../token/ERC721/ERC721.sol';
import { SafeERC20 } from '../token/ERC20/SafeERC20.sol';

contract Assets is Ownable {
  using SafeERC20 for ERC20;

  enum AssetType {
    None,
    ETH,
    ERC20,
    ERC721
  }

  struct ETHAsset {
    uint256 value;
  }

  struct ERC20Asset {
    ERC20 token;
    uint256 amount;
  }

  struct ERC721Asset {
    ERC721 token;
    uint256 tokenId;
  }

  AssetType[] private assetTypes;

  mapping (uint256 => ETHAsset) private ethAssets;
  mapping (uint256 => ERC20Asset) private erc20Assets;
  mapping (uint256 => ERC721Asset) private erc721Assets;

  function receiveETH() payable returns (uint256) {
    uint256 assetId = newAsset(ETH);

    ethAssets[assetId] = ETHAsset({
      value: msg.value
    })

    return assetId;
  }

  function receiveERC20(address token, uint256 amount) returns (uint256) {
    uint256 assetId = newAsset(ERC20);

    erc20Assets[assetId] = ERC20Asset({
      token: token,
      amount: amount
    })

    return assetId;
  }

  function receiveERC721(address token, uint256 tokenId) returns (uint256) {
    uint256 assetId = newAsset(ERC721);

    erc721Assets[assetId] = ERC721Asset({
      token: token,
      tokenId: tokenId,
    })

    return assetId;
  }

  function transfer(uint256 assetId, address recipient) onlyOwner {
    AssetType assetType = assetTypes[assetId];

    if (assetType == ETH) {
      _transferETH(assetId, recipient);
    } else if (assetType == ERC20) {
      _transferERC20(assetId, recipient);
    } else if (assetType == ERC721) {
      _transferERC721(assetId, recipient);
    } else {
      revert();
    }
  }

  function _transferETH(uint256 assetId, address recipient) private {
    ETHAsset asset = ethAssets[assetId];
    recipient.transfer(asset.value);
  }

  function _transferERC20(uint256 assetId, address recipient) private {
    ERC20Asset asset = erc20Assets[assetId];
    asset.token.safeTransfer(recipient, asset.amount);
  }

  function _transferERC721(uint256 assetId, address recipient) private {
    ERC721Asset asset = erc721Assets[assetId];
    asset.token.transfer(recipient, asset.tokenId);
  }

  function newAsset(AssetType assetType) private returns (uint256) {
    uint256 assetId = assetTypes.length;
    assetTypes.push(assetType);
    return assetId;
  }
}
