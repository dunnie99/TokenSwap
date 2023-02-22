// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./IToken.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

    
contract tokenSwapping {


    AggregatorV3Interface ETHUSD = AggregatorV3Interface(0xA39434A63A52E749F02807ae27335515BA4b07F7);
    AggregatorV3Interface DAIUSD = AggregatorV3Interface(0x0d79df66BE487753B02D015Fb622DED7f0E9798d);
    AggregatorV3Interface LINKUSD = AggregatorV3Interface(0x48731cF7e84dc94C5f84577882c14Be11a5B7456);
    AggregatorV3Interface USDCUSD = AggregatorV3Interface(0xAb5c49580294Aff77670F839ea425f5b78ab3Ae7);
    
    address Owner;
    IToken internal DAI;
    IToken internal LINK;
    IToken internal USDC;
    int tokenDecimal;

    constructor(){
        DAI = IToken(0x6B175474E89094C44Da98b954EedeAC495271d0F);
        LINK = IToken(0x514910771AF9Ca656af840dff83E8264EcF986CA);
        USDC = IToken(0x7EA2be2df7BA6E54B1A9C70676f668455E329d29);
        Owner = msg.sender;
    }

    modifier onlyOwner() {
        require (msg.sender == Owner, "not Owner");
        _;
    }

    function transfer_(IToken token, int amount_, address _to) internal returns(bool){
        bool check = token.transfer( _to, uint (amount_));
        require(check, "Transaction failed");
        return check;
    }

    function transferFrom_(IToken token, address from, int _amount) internal returns(bool) {
        bool takeToken = token.transferFrom(from, address(this), uint(_amount));
        return takeToken;
    }

    function getPrice(AggregatorV3Interface _token2swap, int _decimal) public view returns (int){
    (, int256 answer, , , ) = _token2swap.latestRoundData();

    return (answer / _decimal); 
    }


    // function checkAmount(uint amount1, uint amount2) pure internal {
    //     require(amount1 > 0 && amount2 > 0, "Insufficient amount");
    // }

    function swapETHUSDC() payable external {
        require(msg.value > 0, "Insufficient Ether");
        int ethPrice = getPrice(ETHUSD, tokenDecimal);
        int usdcPrice = getPrice(USDCUSD, tokenDecimal);
        int usdcOut = ((int(msg.value) * ethPrice) / usdcPrice);
        transfer_(USDC, usdcOut, msg.sender);
         
    }

    function swapETHDAI() payable external {
        require(msg.value > 0, "Insufficient Ether");
        int ethPrice = getPrice(ETHUSD, tokenDecimal);
        int daiPrice = getPrice(DAIUSD, tokenDecimal);
        int daiOut = ((int(msg.value) * ethPrice) / daiPrice);
        transfer_(DAI, daiOut, msg.sender);
         
    }

    function swapETHLINK() payable external {
        require(msg.value > 0, "Insufficient Ether");
        int ethPrice = getPrice(ETHUSD, tokenDecimal);
        int linkPrice = getPrice(LINKUSD, tokenDecimal);
        int linkOut = ((int(msg.value) * ethPrice) / linkPrice);
        transfer_(LINK, linkOut, msg.sender);
         
    }


    function swapDAILINK(uint _amount) external returns(bool) {
        require(_amount > 0, "Insufficient Dai");
        bool status = transferFrom_(DAI, msg.sender, int (_amount));
        require(status, "Insufficient liquidity");
        int daiPrice = getPrice(DAIUSD, tokenDecimal);
        int linkPrice = getPrice(LINKUSD, tokenDecimal);
        int linkOut = ((int(_amount) * daiPrice) / linkPrice);
        transfer_(LINK, linkOut, msg.sender);
         
    }


    function swapLINKDAI(uint _amount) payable external {
        require(_amount > 0, "Insufficient Link");
        bool status = transferFrom_(LINK, msg.sender, int (_amount));
        require(status, "Insufficient liquidity");
        int linkPrice = getPrice(LINKUSD, tokenDecimal);
        int daiPrice = getPrice(DAIUSD, tokenDecimal);
        int daiOut = ((int(_amount) * linkPrice) / daiPrice);
        transfer_(DAI, daiOut, msg.sender);
         
    }

    function swapUSDCDAI(uint _amount) payable external {
        require(_amount > 0, "Insufficient USDC");
        bool status = transferFrom_(USDC, msg.sender, int (_amount));
        require(status, "Insufficient liquidity");
        int usdcPrice = getPrice(USDCUSD, tokenDecimal);
        int daiPrice = getPrice(DAIUSD, tokenDecimal);
        int daiOut = ((int(_amount) * usdcPrice) / daiPrice);
        transfer_(DAI, daiOut, msg.sender);
         
    }

    function swapDAIUSDC(uint _amount) payable external {
        require(_amount > 0, "Insufficient DAI");
        bool status = transferFrom_(DAI, msg.sender, int (_amount));
        require(status, "Insufficient liquidity");
        int daiPrice = getPrice(DAIUSD, tokenDecimal);
        int usdcPrice = getPrice(USDCUSD, tokenDecimal);
        int usdcOut = ((int(_amount) * daiPrice) / usdcPrice);
        transfer_(USDC, usdcOut, msg.sender);
         
    }


    function swapLINKUSDC(uint _amount) payable external {
        require(_amount > 0, "Insufficient Link");
        bool status = transferFrom_(LINK, msg.sender, int (_amount));
        require(status, "Insufficient liquidity");
        int linkPrice = getPrice(LINKUSD, tokenDecimal);
        int usdcPrice = getPrice(USDCUSD, tokenDecimal);
        int usdcOut = ((int(_amount) * linkPrice) / usdcPrice);
        transfer_(USDC, usdcOut, msg.sender);
         
    }

    function swapUSDCLINK(uint _amount) payable external {
        require(_amount > 0, "Insufficient USDC");
        bool status = transferFrom_(USDC, msg.sender, int (_amount));
        require(status, "Insufficient liquidity");
        int usdcPrice = getPrice(USDCUSD, tokenDecimal);
        int linkPrice = getPrice(LINKUSD, tokenDecimal);
        int linkOut = ((int(_amount) * usdcPrice) / linkPrice);
        transfer_(LINK, linkOut, msg.sender);
         
    }


// WITHDRAW AND BALANCEOF CONTRACT TOKENS.


    function balanceOf_(IToken _token) public returns(uint){
        uint tokenBalance = _token.balanceOf(address(this));
        return tokenBalance;
    }
    function withdraw(IToken token, uint amount_) public onlyOwner() {
        token.transfer(msg.sender, amount_);
    
    }











}





















































































