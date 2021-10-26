# Auto-Zone-forex-trader-Robot
This is a robot for forex trader which opens order automatically when price hits a level on the chart based on candlestick patterns


Let say you have found a potential trading(an area or price range where the market will reverse) zone to buy EURUSD  .


You need to Place two horizontal line with name  "buy" and "buy_sl" . This two line represent potential price range . When price gets into the zone , ie - touches the line
with name "buy" and can not cross the line "buy_sl" It will be looking for candlestick patterns to get into a trade .


For the sell order two horizontal line need to create , One with name "sell" and one is "sell_sl" .  



For the buy trade "buy" horizontal line should be above the line "buy_sl" and for sell zone -  "sell" horizontal line should be below the line "sell_sl" .


sell_sl means stop level of the price zone . If price crosses this "buy_sl"/"sell_sl"  two horizontal line will be deleted as the zone becomes invalid.




