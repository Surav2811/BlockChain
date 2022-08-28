pragma solidity ^ 0.8.16;

contract pandacoin_ico {
    // max coins
    uint public max_pandacoin = 100000;
    // USD - Coins conversion
    uint public usd_to_pandacoin = 1000;
    // Total coins bought
    uint public total_pandacoins_bought = 0;
    // Mapping investor address to equities
    mapping (address => uint) equity_pandacoins;
    mapping (address => uint) equity_usd;
    // Checking if an investor can buy PandaCoins
    modifier can_buy_pandacoin (uint usd_invested){
        require (usd_invested * usd_to_pandacoin + total_pandacoins_bought <= max_pandacoin);
        _ ;
    }
    // Getting the equity in pandacoins of an investor
    function equity_in_pandacoin (address investor) external constant returns (uint){
        return equity_pandacoins[investor];
    }

    // Getting the equity in USD of an investor
    function equity_in_usd (address investor) external constant returns (uint){
        return equity_usd[investor];
    }

    // BUying Pandacoins
    function buy_pandacoins (address investor, uint usd_invested) external
    can_buy_pandacoin(usd_invested){
        uint pandacoins_bought = usd_invested * usd_to_pandacoin;
        equity_pandacoins[investor] += pandacoins_bought;
        equity_usd[investor] = equity_pandacoins [investor]/1000;
        total_pandacoins_bought += pandacoins_bought;
    }
    // Selling PandaCoins
    function sell_pandacoins (address investor, uint pandacoins_sold) external{
        
        equity_pandacoins[investor] -= pandacoins_sold;
        equity_usd[investor] = equity_pandacoins [investor]/1000;
        total_pandacoins_bought += pandacoins_sold;
    } 
}