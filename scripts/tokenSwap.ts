import { ethers } from "hardhat";

async function main() {


    const CloneMultiSig = await ethers.getContractFactory("cloneMultiSig");
    const cloneMultiSig = await CloneMultiSig.deploy();
    await cloneMultiSig.deployed();













    
  }
  
  // We recommend this pattern to be able to use async/await everywhere
  // and properly handle errors.
  main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  