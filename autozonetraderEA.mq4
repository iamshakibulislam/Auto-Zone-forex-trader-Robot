//+------------------------------------------------------------------+
//|                                             autozonetraderEA.mq4 |
//|                                   Copyright 2021, shakibul islam |
//|                                      https://www.webheavenit.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, shakibul islam"
#property link      "https://www.webheavenit.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

input bool five_digit_broker = true; //Is this five digit broker
input double stoplossOffset = 2;  //Stop loss offset
input double risk_percentage = 1; // Risk percentage
input double riskreward = 2;  //Reward to Risk default 2:1

input double minimum_stoploss = 5; // Minumum Stoploss


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---





 double BuyzoneSize = getPips(getZonePrice("buy"),getZonePrice("buy_sl"));
 
 double BuypatternDistance = getPips(Close[1],getZonePrice("buy"));
 
 
 
 double SellzoneSize = getPips(getZonePrice("sell_sl"),getZonePrice("sell"));
 
 double SellpatternDistance = getPips(getZonePrice("sell"),Close[1]);
 

//for buy trade
   if(patternScanner() != 0.00 &&
      patternScanner() < getZonePrice("buy") &&
      patternScanner() > getZonePrice("buy_sl") &&
      BuypatternDistance <= BuyzoneSize * 1.5 &&
      Close[1] > patternScanner() &&
      OrdersTotal() == 0
      
      
      )
      
     {

      double CalculatedPips = getPips(Close[1],patternScanner());
      
      double lotsize = getLotSize(CalculatedPips);
      
      
      
      double Tp = Ask+((CalculatedPips+stoplossOffset)*riskreward)*Point*10;
      double sl = Ask - ((CalculatedPips+stoplossOffset)*Point*10);
      
      if(five_digit_broker == false){
       double Tp = Ask+((CalculatedPips+stoplossOffset)*riskreward)*Point;
       double sl = Ask - ((CalculatedPips+stoplossOffset)*Point);
      
      }
      
      if(lotsize != 0.00 && lotsize > 0 && ObjectFind(0,"buy")==0 && ObjectFind(0,"buy_sl")==0 &&(CalculatedPips+stoplossOffset)>=minimum_stoploss){
      
      int ticket = OrderSend(Symbol(),OP_BUY,lotsize,Ask,2,sl,Tp,"traded from EA",9999,NULL,Blue);
       
       if(ticket > 0){delLine("buy");delLine("buy_sl");}
      
      }


     }
     
     
     else if(Close[1] < getZonePrice("buy_sl")&& getZonePrice("buy_sl") != 0 && getZonePrice("buy") !=0){
     
     delLine("buy");
     delLine("buy_sl");
     
     }
     
     
     
     
     
     
     
     
//for sell trade function starts here

if(patternScanner() != 0.00 &&
      patternScanner() > getZonePrice("sell") &&
      patternScanner() < getZonePrice("sell_sl") &&
      SellpatternDistance <= SellzoneSize *1.5 &&
      Close[1] < patternScanner() &&
      OrdersTotal() == 0
      
      
      )
      
     {

      double CalculatedPips = getPips(patternScanner(),Close[1]);
      
      double lotsize = getLotSize(CalculatedPips);
      
      
      
      double Tp = Bid-((CalculatedPips)*riskreward)*Point*10;
      double sl = Bid + ((CalculatedPips+stoplossOffset)*Point*10);
      
      if(five_digit_broker == false){
       double Tp = Bid-((CalculatedPips+stoplossOffset)*riskreward)*Point;
       double sl = Bid + ((CalculatedPips+stoplossOffset)*Point);
      
      }
      
      if(lotsize != 0.00 && lotsize > 0 && ObjectFind(0,"sell")==0 && ObjectFind(0,"sell_sl")==0 &&(CalculatedPips+stoplossOffset)>=minimum_stoploss){
      
      int ticket = OrderSend(Symbol(),OP_SELL,lotsize,Bid,2,sl,Tp,"traded from EA",9999,NULL,Blue);
       
       if(ticket != 0){delLine("sell");delLine("sell_sl");}
      
      }


     }
     
     
     else if(Close[1] > getZonePrice("sell_sl") && getZonePrice("sell_sl") != 0 && getZonePrice("sell") !=0){
     
     delLine("sell");
     delLine("sell_sl");
     
     }
     




//end of sell trade 



  }



//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double patternScanner()
  {


   double FirstCandleHigh = High[1];
   double FirstCandleLow = Low[1];
   double FirstCandleClose = Close[1];
   double FirstCandleOpen = Open[1];

   double SecondCandleHigh = High[2];
   double SecondCandleLow = Low[2];
   double SecondCandleOpen = Open[2];
   double SecondCandleClose = Close[2];

   double ThirdCandleHigh = High[3];
   double ThirdCandleLow = Low[3];
   double ThirdCandleOpen = Open[3];
   double ThirdCandleClose = Close[3];



   double FourthCandleHigh = High[4];
   double FourthCandleLow = Low[4];
   double FourthCandleOpen = Open[4];
   double FourthCandleClose = Close[4];



   double FifthCandleHigh = High[5];
   double FifthCandleLow = Low[5];
   double FifthCandleOpen = Open[5];
   double FifthCandleClose = Close[5];

//end of candle selection


   if(

      FirstCandleClose > FirstCandleOpen &&
      SecondCandleClose < SecondCandleOpen &&
      FirstCandleClose > SecondCandleHigh &&
      MathAbs(FirstCandleHigh - FirstCandleLow) > MathAbs(SecondCandleHigh - SecondCandleLow) &&
      (FirstCandleLow < SecondCandleLow || SecondCandleLow < ThirdCandleLow || ThirdCandleClose < ThirdCandleOpen)


   )
     {

      if(FirstCandleLow < SecondCandleLow)
        {
         return FirstCandleLow;
        }

      else
        {
         return SecondCandleLow;
        }

     }


   else
      if(

         FirstCandleClose < FirstCandleOpen &&
         SecondCandleClose > SecondCandleOpen &&
         FirstCandleClose < SecondCandleLow &&
         MathAbs(FirstCandleHigh - FirstCandleLow) > MathAbs(SecondCandleHigh - SecondCandleLow) &&
         (FirstCandleHigh > SecondCandleHigh || SecondCandleHigh > ThirdCandleHigh || ThirdCandleClose > ThirdCandleOpen)


      )
        {

         if(FirstCandleHigh > SecondCandleHigh)
           {
            return FirstCandleHigh;
           }

         else
           {
            return SecondCandleHigh;
           }

        }



      else
         if(
            MathAbs(FirstCandleHigh-FirstCandleClose) < MathAbs(FirstCandleClose - FirstCandleOpen) &&
            SecondCandleClose > SecondCandleOpen &&
            MathAbs(SecondCandleClose - SecondCandleOpen)*3 < MathAbs(FirstCandleHigh - FirstCandleLow) &&

            (ThirdCandleClose < ThirdCandleOpen || FirstCandleLow < SecondCandleLow || SecondCandleLow < ThirdCandleLow)

         )
           {
           
           if(FirstCandleLow < SecondCandleLow){return FirstCandleLow;}
            
            else if(FirstCandleLow > SecondCandleLow){
            return (SecondCandleLow);}

           } //end of bullish doji

//starting scanning for bearish doji

         else
            if(
               MathAbs(FirstCandleLow-FirstCandleClose) < MathAbs(FirstCandleOpen - FirstCandleClose) &&
               SecondCandleClose < SecondCandleOpen &&
               MathAbs(SecondCandleOpen - SecondCandleClose)*3 < MathAbs(FirstCandleHigh - FirstCandleLow) &&

               (ThirdCandleClose > ThirdCandleOpen || FirstCandleHigh > SecondCandleHigh || SecondCandleHigh > ThirdCandleHigh)

            )
              {
               
               if(FirstCandleHigh > SecondCandleHigh){return FirstCandleHigh;}
               
               else if(SecondCandleHigh > FirstCandleHigh){
               return (SecondCandleHigh);}

              }


            //starting three black/white crow pattern detection
            else
               if(
                  FirstCandleClose > FirstCandleOpen && MathAbs(FirstCandleHigh - FirstCandleClose) < MathAbs(FirstCandleClose - FirstCandleOpen) && FirstCandleHigh>SecondCandleHigh &&
                  SecondCandleClose > SecondCandleOpen && MathAbs(SecondCandleHigh - SecondCandleClose) < MathAbs(SecondCandleClose - SecondCandleOpen) && SecondCandleHigh>ThirdCandleHigh &&
                  ThirdCandleClose > ThirdCandleOpen && MathAbs(ThirdCandleHigh - ThirdCandleClose) < MathAbs(ThirdCandleClose - ThirdCandleOpen) && FourthCandleClose < FourthCandleOpen
               )
                 {

                  return (ThirdCandleLow);
                 }


               else
                  if(
                     FirstCandleClose < FirstCandleOpen && MathAbs(FirstCandleLow - FirstCandleClose) < MathAbs(FirstCandleOpen - FirstCandleClose) && FirstCandleLow<SecondCandleLow &&
                     SecondCandleClose < SecondCandleOpen && MathAbs(SecondCandleLow - SecondCandleClose) < MathAbs(SecondCandleOpen - SecondCandleClose) && SecondCandleLow<ThirdCandleLow &&
                     ThirdCandleClose < ThirdCandleOpen && MathAbs(ThirdCandleLow - ThirdCandleClose) < MathAbs(ThirdCandleOpen - ThirdCandleClose) && FourthCandleClose > FourthCandleOpen
                  )
                    {

                     return (ThirdCandleHigh);
                    }



                  else
                     if(

                        //bullish pinbar

                        FirstCandleOpen < FirstCandleClose && MathAbs(FirstCandleClose - FirstCandleOpen)*3 < MathAbs(FirstCandleOpen - FirstCandleLow) &&
                        MathAbs(FirstCandleHigh - FirstCandleClose) < MathAbs(FirstCandleClose-FirstCandleOpen)*2

                     )
                       {

                        return (FirstCandleLow);


                       }




                     else
                        if(

                           //bullish pinbar

                           FirstCandleOpen > FirstCandleClose && MathAbs(FirstCandleOpen - FirstCandleClose)*3 < MathAbs(FirstCandleHigh - FirstCandleOpen) &&
                           MathAbs(FirstCandleClose - FirstCandleLow) < MathAbs(FirstCandleOpen-FirstCandleClose)*2

                        )
                          {

                           return (FirstCandleHigh);


                          }



   return 0.00;


  }




//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getZonePrice(string level_name)
  {
//level names are the same as line name //  buy,buy_sl and sell ,sell_sl

   if(level_name == "buy")
     {

      return (ObjectGetDouble(0,"buy",OBJPROP_PRICE));

     }


   else
      if(level_name == "sell")
        {

         return (ObjectGetDouble(0,"sell",OBJPROP_PRICE));

        }


      else
         if(level_name == "sell_sl")
           {

            return (ObjectGetDouble(0,"sell_sl",OBJPROP_PRICE));

           }



         else
            if(level_name == "buy_sl")
              {

               return (ObjectGetDouble(0,"buy_sl",OBJPROP_PRICE));

              }


   return 0.00;

  }





//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getLotSize(double pips)
  {

   double riskamount = (AccountBalance()*0.01*risk_percentage);

   double lot = 0.00;

   if(five_digit_broker == true)
     {
      lot = (riskamount/pips)/(MarketInfo(Symbol(),MODE_TICKVALUE)*10);

      return lot;

     }


   else
     {

      lot = (riskamount/pips)/(MarketInfo(Symbol(),MODE_TICKVALUE));

      return lot;

     }

  }



//calculate pip from price difference


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getPips(double price1,double price2)
  {

   if(MarketInfo(Symbol(),MODE_DIGITS)==5)
     {

      double pipDiff = (MathAbs(price1 - price2)*10000);

      return pipDiff;

     }


   else
      if(MarketInfo(Symbol(),MODE_DIGITS)==3)
        {

         double pipDiff = (MathAbs(price1 - price2)*100);

         return pipDiff;
        }





      else
        {

         return 0.00;


        }



  }





//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool delLine(string name)
  {

   ObjectDelete(0,name);

   return true;

  }
//+------------------------------------------------------------------+
