
import "dart:core";
import "package:flutter/material.dart";
import "../controllers/currency_controller.dart";
import "package:mvc_pattern/mvc_pattern.dart";


class HomePage extends StatefulWidget {
 @override
 _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC {

  CurrencyController? _controller;

  _HomePageState(): super(CurrencyController()) {
    _controller = controller as CurrencyController;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller?.init();
  }
  bool isMax = false;



  Widget build (BuildContext context) {
    var state = _controller?.currentState;
    return Scaffold(
        appBar: AppBar(
          title: Text("Currencies list"),
        ),
        body: Center(
        child:Container(
          width: 1400,
        margin: EdgeInsets.symmetric(vertical: 100),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1,color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [BoxShadow(
            color: Color.fromRGBO(255, 255, 255, 0.5),
            blurRadius: 34,
            offset: Offset(0,0),
          )]
        ),
        child: ListView(
          children: [
           Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2)),
                  )
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "#",
                  style: TextStyle(
                    fontWeight: FontWeight.w900
                  ),
                ),
                Text(
                  "Название",
                    style: TextStyle(
                    fontWeight: FontWeight.w900
                ),
                ),
                Text(
                  "Цена",
                  style: TextStyle(
                      fontWeight: FontWeight.w900
                  ),
                ),
                Text(
                  "Изм. (24ч)",
                  style: TextStyle(
                      fontWeight: FontWeight.w900
                  ),
                ),
                Text(
                  "Капитализ.",
                  style: TextStyle(
                      fontWeight: FontWeight.w900
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    !isMax ? setState(() => isMax = true) : setState(() => isMax = false);
                    isMax ? setState(() => state = state?..sort((a,b) => b["values"]["USD"]["volume24h"] - a["values"]["USD"]["volume24h"])) :
                    setState(() => state = state?..sort((a,b) => a["values"]["USD"]["volume24h"] - b["values"]["USD"]["volume24h"]));
                  },
                  child: Text(
                      "Объем(24ч)",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                      color: Colors.lightGreen
                    ),
                  ),
                ),
                ),
                Text(
                    "Объем/Рын.Кап.",
                  style: TextStyle(
                      fontWeight: FontWeight.w900
                  ),
                ),
                Text(
                    "В обращении",
                  style: TextStyle(
                      fontWeight: FontWeight.w900
                  ),
                )
              ],
            ),
            ),
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state?.length,
                  itemBuilder: (context,index) {
                    return _buildItem(state![index], index + 1);
                  }),
            )
          ],
        ),]
        ),
        ),
        ),
              );
  }

  Widget _buildItem(state, int index) {
    return Container(

      child:
      Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2)),
        )
      ),
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
      child: Row(
        children: [
          Container(
            width: 18,
            margin: EdgeInsets.only(right: 100),
          child:Text(
            index.toString(),
          ),
          ),
         Container(
           width: 158,
         margin: EdgeInsets.only(right: 20),
         child:Row(
           children: [
             Padding(
               padding: EdgeInsets.only(right: 5),
                child: Text(
                   state["name"].toString(),
                 ),
             )
             ,
             Text(
               state["symbol"].toString(),
             ),

           ],
         ),
         ),
          Container(
            width: 63,
          margin: EdgeInsets.only(right: 80),
          child:Text(
            "\$ " + state["values"]["USD"]["price"].toString().substring(0,7),
          ),
          ),
          Container(
            width: 65,
          margin: EdgeInsets.only(right: 110),
          child: Text(
            state["values"]["USD"]["percentChange24h"].toString().contains("-") ?
            state["values"]["USD"]["percentChange24h"].toString() + " %":
            "+" + state["values"]["USD"]["percentChange24h"].toString() + " %",
          ),
          ),
          Container(
            width: 55,
          margin: EdgeInsets.only(right: 135),
          child:Text(
              state["values"]["USD"]["marketCap"] > 100000000000 ?
            state["values"]["USD"]["marketCap"].toString().substring(0,3) + "," + state["values"]["USD"]["marketCap"].toString().substring(4,6) + "B" :
              state["values"]["USD"]["marketCap"].toString().substring(0,2) + "," + state["values"]["USD"]["marketCap"].toString().substring(3,5) + "B"
          ),
          ),
          Container(
            width: 55,
            margin: EdgeInsets.only(right: 135),
            child:Text(
              state["values"]["USD"]["volume24h"] > 10000000000 ?
              state["values"]["USD"]["volume24h"].toString().substring(0,2) + "," + state["values"]["USD"]["volume24h"].toString().substring(3,5) + "B" :
              state["values"]["USD"]["volume24h"] > 1000000000 ?
              state["values"]["USD"]["volume24h"].toString().substring(0,1) + "," + state["values"]["USD"]["volume24h"].toString().substring(2,4) + "B" :
              state["values"]["USD"]["volume24h"].toString().substring(0,3) + "," + state["values"]["USD"]["marketCap"].toString().substring(4,6) + "M"

          ),
          ),
          Container(
            width: 55,
          margin: EdgeInsets.only(right: 165),
          child:Text(
         (state["values"]["USD"]["volume24h"] / state["values"]["USD"]["marketCap"]).toString().substring(0,5)
          ),
          ),
          Text(
            state["circulatingSupply"] > 100000000000 ?
          state["circulatingSupply"].toString().substring(0,3) + "," + state["circulatingSupply"].toString().substring(4,6) + "B" :
            state["circulatingSupply"] > 10000000000  ?
           state["circulatingSupply"].toString().substring(0,2) + "," + state["circulatingSupply"].toString().substring(3,5) + "B" :
            state["circulatingSupply"] > 1000000000 ?
            state["circulatingSupply"].toString().substring(0,1) + "," + state["circulatingSupply"].toString().substring(2,4) + "B" :
            state["circulatingSupply"].toString().substring(0,3) + "," + state["circulatingSupply"].toString().substring(4,6) + "M"
          ),
        ],
    ),
      ) ,
    );
  }


}