//+------------------------------------------------------------------+
//|                                                          287.mq4 |
//|                                           Son Nguyen Development |
//|                                             https://g-saram.com/ |
//+------------------------------------------------------------------+
#property copyright "Son Nguyen Development"
#property link      "https://g-saram.com/"
#property version   "1.00"
#include "orderselect.mqh"
#include "draw_button.mqh"
#include "ganticket.mqh"
//+-----------------------------
#include "ordersend.mqh"
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
input double lots = 0.01; // lot
input int StopLoss = 50; // Pip
input int TakeProfit = 50; // Pip
input int TotalProfit = 30; // USD 
input int Trailing = 5;
input int Period_RSI = 14; // Day la gia tri duong RSI
input double LoiNhuanMongDoi = 20.00; // Day la muc loi nhuan 0.01 - > 2, 0.1 -> 20, 1 -> 200
int TicketGlobal[1500] = {NULL};
 int Ticket[100];
   int Ticket_Symbol[100];
double TrailingPip = Trailing *10 *Point;

class mtt
  {
   private:
      int OOP_Ticket, OOP_Type , OOP_MagicNumber ;
       double OOP_OpenPrice, OOP_Commision, OOP_Profit, OOP_Swap , OOP_TakeProfit , OOP_StopLoss;
     
         
   public:
      int OOPBuy (string _comment_OOP, double _lots) {
         int _result = OrderSend(Symbol(),OP_BUY,_lots,Ask,3,(Ask - TrailingPip), (Ask + TrailingPip),_comment_OOP , 144,NULL,Green);
         return _result;
      }
       int OOPBuyNosltp (string _comment_OOP, double _lots) {
         int _result = OrderSend(Symbol(),OP_BUY,_lots,Ask,3,(NULL), (NULL),_comment_OOP , 144,NULL,Green);
         return _result;
      }
      
      int OOPBuy_244 (string _comment_OOP, double _lots) {
         int _result = OrderSend(Symbol(),OP_BUY,_lots,Ask,3,(Ask - TrailingPip), (Ask + TrailingPip),_comment_OOP , 244,NULL,Green);
         return _result;
      }
       int OOPBuy_244Nosltp (string _comment_OOP, double _lots) {
         int _result = OrderSend(Symbol(),OP_BUY,_lots,Ask,3,(NULL), (NULL),_comment_OOP , 244,NULL,Green);
         return _result;
      }
      
      
      int OOPSell (string _comment_OOP, double _lots) {
         int _result = OrderSend(Symbol(),OP_SELL,_lots,Bid,3,(Bid + TrailingPip), (Bid + TrailingPip), _comment_OOP, 144, NULL, Red);
         return _result;
      }
            int OOPSellNosltp (string _comment_OOP, double _lots) {
         int _result = OrderSend(Symbol(),OP_SELL,_lots,Bid,3,(NULL), (NULL), _comment_OOP, 144, NULL, Red);
         return _result;
      }
      int OOPSell_244 (string _comment_OOP, double _lots) {
         int _result = OrderSend(Symbol(),OP_SELL,_lots,Bid,3,(Bid + TrailingPip), (Bid + TrailingPip), _comment_OOP, 244, NULL, Red);
         return _result;
      }
      int OOPSell_244Nosltp (string _comment_OOP, double _lots) {
         int _result = OrderSend(Symbol(),OP_SELL,_lots,Bid,3,(NULL), (NULL), _comment_OOP, 244, NULL, Red);
         return _result;
      }
  };


int OnInit()
  {
//---
  draw_button("CloseButton",0,70,100,100,30,"Close Button",Red);
  draw_button("CloseButton1",0,180,100,100,30,"Close Button 2",Red);
  draw_button("CloseButton2",0,290,100,100,30,"Close Button 3",Red);
 //  draw_button("CloseButton2",0,270,100,160,30,"Close Button 2",Red); 
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

void GanTicket() {
   int Count_Ticket = NULL;
   for(int _Count = 0;_Count <= OrdersTotal() ;_Count++)
     {
      if(OrderSelect(_Count,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderSymbol() == Symbol() )
           {
            TicketGlobal[Count_Ticket] = OrderTicket();
            Count_Ticket++;
           }
        }
     }   
}



int Count_Order_In_Chart() {
   int _result = NULL;
   for(int i=0;i<= OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderSymbol() == Symbol())
           {
            _result++;
           }
        }
     }
   return _result;
   
}
void OnTick()
  {
   double TakeProfit_Pip = TakeProfit * 10 * Point;
   double StopLoss_Pip = StopLoss * 10 * Point;
   int pos = NULL;
     GanTicket();
   int Ticket_Demo[1000]= {NULL};
   string comment_demo[1000] = {NULL};
 //  int average_rsi = int(avarage_for_RSI(3));
    mtt demo1;

//--
    int RSI_UP = int(iRSI(Symbol(),PERIOD_CURRENT,Period_RSI,PRICE_CLOSE,0));
    int RSI_UP_Pre = int(iRSI(Symbol(),PERIOD_CURRENT,Period_RSI,PRICE_CLOSE,1));
   // int RSI_MID = int(iRSI(Symbol(),PERIOD_CURRENT,200,PRICE_CLOSE,0));
   int RSI_MID = 50;
 //   int RSI_LOW = iRSI(Symbol(),PERIOD_CURRENT,Period_RSI,PRICE_CLOSE,0);
 
 // Singal 70
 if( RSI_UP == 70)
   {
       if(Count_MagicNumber_144() == 0)
            {
                comment_demo[0] = "Lenh Buy Dau tien tai RSI 70 " + Symbol();
            Ticket_Demo[0] = demo1.OOPBuyNosltp(comment_demo[0] ,lots);
            //pos = 0;
            Alert("So Ticket la: "  + string(Ticket_Demo[0]) + " Tai cap tien " + Symbol() + " Vi tri vao lenh " + comment_demo[0] ); 
            }
   }
   if(RSI_UP_Pre >= 70 && RSI_UP == 70)
     {
        if(Count_MagicNumber_144() == 1)
               {
                   comment_demo[1] = "Lenh Sell Dau Tien Tai RSI 70 " + Symbol();
               Ticket_Demo[1] = demo1.OOPSellNosltp(comment_demo[1],2*lots);
                    Alert("So Ticket la: "  + string(Ticket_Demo[1]) + " Tai cap tien " + Symbol() + " Vi tri vao lenh " + comment_demo[1] ); 
               }
     }
if(RSI_UP_Pre <= 70 && RSI_UP == 70)
  {
    
      if(Count_MagicNumber_144() == 2)
        {
         comment_demo[2] = "Lenh Buy Thu 2 tai RSI 70 " + Symbol();
         Ticket_Demo[2] = demo1.OOPBuyNosltp(comment_demo[2],2*lots);
         Alert("So Ticket la: "  + string(Ticket_Demo[2]) + " Tai cap tien " + Symbol() +  " Vi tri vao lenh " + comment_demo[2] ); 
        }
   
  }
//-- Vao lenh tai đường RSI(200)
  if(RSI_UP_Pre >= 50 && RSI_UP == 50)
    {
      if(Count_MagicNumber_244()  == 0 && Count_MagicNumber_144() > 0)
        {
         comment_demo[3] = "Lenh Sell thu 1 tai RSI 200 " + Symbol();
         Ticket_Demo[3] = demo1.OOPSell_244Nosltp(comment_demo[3],lots);
          // Alert("So Ticket la: "  + string(Ticket_Demo[3]) + " Tai cap tien " + Symbol() + " Vi tri vao lenh " + comment_demo[3] ); 
        }
    }
  if(RSI_UP_Pre <= 50 && RSI_UP == 50 )
    {
     if(Count_MagicNumber_244() == 1)
           {
           comment_demo[4] =   "Lenh Buy thu 1 tai RSI 200 " + Symbol();
            Ticket_Demo[4] = demo1.OOPBuy_244Nosltp( comment_demo[4], lots*3);
      //     Alert("So Ticket la: "  + string(Ticket_Demo[4]) +  " Tai cap tien " + Symbol() + " Vi tri vao lenh " + comment_demo[4] ); 
           }
    }
 // -- Singal 30 
 
   if(RSI_UP == 30 && RSI_UP_Pre >= 30)
     {
      if(Count_MagicNumber_144() == 0)
        {
         comment_demo[5] = "Lenh Sell thu 1 tai RSI 30 " + Symbol();
         Ticket_Demo[5] = demo1.OOPSellNosltp( comment_demo[5],lots);
         //pos = 1;
          Alert("So Ticket la: "  + string(Ticket_Demo[5]) + " Tai cap tien " + Symbol() + " Vi tri vao lenh " + comment_demo[5] ); 
        }
     }
   if(RSI_UP == 30 && RSI_UP_Pre <= 30)
     {
       if(Count_MagicNumber_144() == 1 )
         {
          comment_demo[6] = "Lenh Buy Thu 2 tai RSI 30 " + Symbol();
          Ticket_Demo[6] = demo1.OOPBuyNosltp(comment_demo[6],2*lots);
          Alert("So Ticket la: "  + string(Ticket_Demo[6]) + " Tai cap tien " + Symbol() + " Vi tri vao lenh " + comment_demo[6] );
         }
     }
   if(RSI_UP == 30 && RSI_UP_Pre >= 30)
     {
      if(Count_MagicNumber_144() == 2)
        {
         comment_demo[7] = "Lenh Sell thu 2 tai RSI 30 " + Symbol();
         Ticket_Demo[7] = demo1.OOPSellNosltp(comment_demo[7],2*lots); 
          Alert("So Ticket la: "  + string(Ticket_Demo[7]) + " Tai cap tien " + Symbol() + " Vi tri vao lenh " + comment_demo[7] );
        }
     }
     
 // -- singal tai RSI(MID)
   if(RSI_UP == 50 && RSI_UP_Pre <= 50)
     {
      if(Count_Magicnumbwe_344() == 0 && Count_MagicNumber_144() > 0)
        {
           comment_demo[8] = "Lenh Buy thu nhat tai RSI giua " + Symbol(); 
      Ticket_Demo[8] = OrderSend(Symbol(),OP_BUY,lots,Ask,0,NULL,NULL,comment_demo[8],344,NULL,Green);
      // Alert("So Ticket la: "  + string(Ticket_Demo[8]) + " Tai cap tien " + Symbol() + " Vi tri vao lenh " + comment_demo[8] );
        }
     }
   if(RSI_UP == 50 && RSI_UP_Pre >= 50)
     {
      if(Count_Magicnumbwe_344() == 1)
        {
          comment_demo[9] = "Lenh Sell thu hai tai RSI giua " + Symbol();
      Ticket_Demo[9] = OrderSend(Symbol(),OP_SELL,lots*4,Bid,0,NULL,NULL,comment_demo[9],344,NULL,Red);
       Alert("So Ticket la: "  + string(Ticket_Demo[9]) + " Tai cap tien " + Symbol() + " Vi tri vao lenh " + comment_demo[9] );
        }
     }
    if(SumProfit() > LoiNhuanMongDoi )
      {
       ClosesAllOrder();
      }
   
  }
  
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
  // GanTicket();
   if(sparam == "CloseButton")
     {
     CloseOrders();
      ObjectSetInteger(0,"CloseButton",OBJPROP_STATE,false);
     }
   if(sparam == "CloseButton1")
     {
      ThoatLenh();
      ObjectSetInteger(0,"CloseButton1",OBJPROP_STATE,false);
     }
   if(sparam == "CloseButton2")
     {
      ClosesAllOrder();
      ObjectSetInteger(0,"CloseButton2",OBJPROP_STATE,false);
     }
  }
  
  double SumProfit() {
      double _SumProfit = NULL;
      
      for(int _i=0;_i<OrdersTotal();_i++)
        {
         if(OrderSelect(TicketGlobal[_i],SELECT_BY_TICKET,MODE_TRADES))
           {
            _SumProfit = _SumProfit + (OrderProfit() + OrderSwap() + OrderCommission());
           }
        }
      return _SumProfit;

}
 //---

//--- Thoat Lenh
void ThoatLenh () {
   
int Count_demo = 0;
bool resultClose = FALSE;
//bool _result_2 = OrderClose(Order_Ticket_Number(1),OrderLots(),Ask,0,Red);
 
 //  Alert(_result_1 + " | " + _result_2);
//Comment(cusstomdemo);
  // Comment(MarketInfo(Symbol(),MODE_DIGITS));
   while(Count_Order_In_Chart() > 0)
     {
      if(OrderSelect( TicketGlobal[Count_demo],SELECT_BY_TICKET,MODE_TRADES))
        {
         int _type = OrderType();
         switch(_type)
           {
            case 0:
              resultClose =  OrderClose(TicketGlobal[Count_demo],OrderLots(),Bid,0,Red);
             Alert(GetLastError());
              
            case 1:
              resultClose = OrderClose(TicketGlobal[Count_demo],OrderLots(),Ask,0,Red);
             Alert(GetLastError());  
               
            default:
              break;
           }
        }
   Count_demo++;
  }

}
//+------------------------------------------------------------------+
int OrderInChart() {
     int _result = NULL;
     for(int _i=0; _i<=OrdersTotal() ;_i++)
       {
        if(OrderSelect(_i,SELECT_BY_POS,MODE_TRADES))
          {
           if(OrderSymbol() == Symbol())
             {
              _result++;
             }
          }
       }
      return _result;
}

int Count_MagicNumber_144 () {
   int _result = NULL;
   for(int _i=0; _i<OrdersTotal(); _i++)
     {
      if(OrderSelect(_i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderMagicNumber() == 144)
           {
            _result++;
           }
        }
     }
     return _result;
}
int Count_Magicnumbwe_344() {
   int _result = NULL;
   for(int i=0;i<= OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderSymbol() == Symbol() )
           {
            if(OrderMagicNumber() == 344)
              {
               _result++;
              }
           }
        }
     }
    return _result;
}

int Count_MagicNumber_244 () {
   int _result = NULL;
   for(int _i=0; _i<OrdersTotal(); _i++)
     {
      if(OrderSelect(_i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderMagicNumber() == 244)
           {
            _result++;
           }
        }
     }
     return _result;
}

int Closesell_Order()
      {
      int total = OrdersTotal();
      for(int i=total-1;i>=0;i--)
      {
        if(OrderSelect(i, SELECT_BY_POS)){
          if(OrderSymbol()== Symbol()){

        int type   = OrderType();

        bool result = false;

        switch(type)
        {
          //Close opened long positions
          case OP_BUY       : result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 3, Red );;
                              break;

          //Close opened short positions
          case OP_SELL      : result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 3, Red );
                              break;
        }

        if(result == false)
        {
          //Alert("Order " , OrderTicket() , " failed to close. Error:" , GetLastError() );
          Sleep(0);
        }
      }
        }
      }
      return(0);
      }
      
  
//---

  
void CloseOrders(){
   
   //Update the exchange rates before closing the orders
   RefreshRates();
      //Log in the terminal the total of orders, current and past
      Print(OrdersTotal());
      
   //Start a loop to scan all the orders
   //The loop starts from the last otherwise it would miss orders
   for(int i=(OrdersTotal()-1);i>=0;i--){
      
      //If the order cannot be selected throw and log an error
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){
         Print("ERROR - Unable to select the order - ",GetLastError());
         break;
      } 

      //Create the required variables
      //Result variable, to check if the operation is successful or not
      bool res=false;
      
      //Allowed Slippage, which is the difference between current price and close price
      int Slippage=0;
      
      //Bid and Ask Price for the Instrument of the order
      double BidPrice=MarketInfo(OrderSymbol(),MODE_BID);
      double AskPrice=MarketInfo(OrderSymbol(),MODE_ASK);

      //Closing the order using the correct price depending on the type of order
      if(OrderType()==OP_BUY){
         res=OrderClose(OrderTicket(),OrderLots(),BidPrice,Slippage);
      }
      if(OrderType()==OP_SELL){
         res=OrderClose(OrderTicket(),OrderLots(),AskPrice,Slippage);
      }
      
      //If there was an error log it
      if(res==false) Print("ERROR - Unable to close the order - ",OrderTicket()," - ",GetLastError());
   }
}

void ClosesAllOrder() {
    RefreshRates();
    int _Res = NULL;
    for(int i=0;i<= OrdersTotal() ;i++)
      {
       if(OrderSelect(i,SELECT_BY_POS))
         {
          if(OrderSymbol() == Symbol() )
            {
             _Res++;
            }
         }
      }
    double BidPrice = MarketInfo(Symbol(),MODE_BID);
    double AskPrice = MarketInfo(Symbol(),MODE_ASK);
    for(int j=_Res; j>=0; j--)
      {
       bool res = NULL;
       int _Type = NULL;
       if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES))
         {
          // OrderType() = _Type;
           if(OrderType() == OP_BUY)
             {
              res = OrderClose(OrderTicket(),OrderLots(),BidPrice,0,Red);
             }
           if(OrderType() == OP_SELL)
             {
              res = OrderClose(OrderTicket(),OrderLots(),AskPrice,0,Red);
             }
         
             
         }
      }
    
}