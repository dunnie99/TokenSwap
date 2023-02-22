import { ethers } from "hardhat";

async function main() {
    /// contract addresses
    const DAI = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
    const LINK = "0x514910771AF9Ca656af840dff83E8264EcF986CA";
    const USDC ="0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";

    
    /// Token holders
    const daiHolder = "0xb527a981e1d415AF696936B3174f2d7aC8D11369";
    const LinkHolder = "0x0757e27AC1631beEB37eeD3270cc6301dD3D57D4";
    const UsdcHolder = "0xDa9CE944a37d218c3302F6B82a094844C6ECEb17";
    

    const tokenSwap = await ethers.getContractFactory("tokenSwapping");
    const TokenSwap = await tokenSwap.deploy();
    await TokenSwap.deployed();













    
  }
  
  // We recommend this pattern to be able to use async/await everywhere
  // and properly handle errors.
  main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  