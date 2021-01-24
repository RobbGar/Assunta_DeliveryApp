import 'package:assunta/pages/adds/rounded_title.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[

          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                RoundedTitle(title: "Info su di Noi"),
                TimelineTile(
                  indicatorStyle: buildIndicatorStyle(context),
                  bottomLineStyle: buildLineStyle(context),
                  isFirst: true,
                  alignment: TimelineAlign.manual,
                  lineX: 0.1,

                  rightChild: Padding(padding: EdgeInsets.all(20),child: Text(" Santa Maria del Campo (Santa Maia in ligure) è una frazione del comune di Rapallo, nella città metropolitana di Genova. Dista all'incirca tre 3,5 km dal centro urbano rapallese.", style: buildTextStyle(),)),
                ),

                TileDivider(),

                TimelineTile(
                  topLineStyle: buildLineStyle(context),
                  indicatorStyle: buildIndicatorStyleForImages(context),
                  bottomLineStyle: buildLineStyle(context),
                  alignment: TimelineAlign.manual,
                  lineX: 0.9,
                  leftChild: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Image(
                      height: 150,
                      width: 150,
                      image: AssetImage("asset/chiesa.jpg"),

                    ),
                  )
                ),

                TileDivider(),

                TimelineTile(
                  topLineStyle: buildLineStyle(context),
                  indicatorStyle: buildIndicatorStyle(context),
                  bottomLineStyle: buildLineStyle(context),
                  alignment: TimelineAlign.manual,
                  lineX: 0.1,
                  rightChild: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "La frazione, che ancora conserva in un buona parte il suo aspetto originario con aree verdi e coltivate, è dominata dalla bella parrocchiale di Nostra Signora Assunta che si erge al di sopra di un’ampia scalinata ed è affiancata dall’oratorio della Natività di Maria, sede della confraternita di Nostra Signora del Suffragio."
                      , style: buildTextStyle(),
                    ),
                  ),
                ),

                TileDivider(),

                TimelineTile(
                    topLineStyle: buildLineStyle(context),
                    indicatorStyle: buildIndicatorStyleForImages(context),
                    bottomLineStyle: buildLineStyle(context),
                    alignment: TimelineAlign.manual,
                    lineX: 0.9,
                    leftChild: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Image(
                        height: 85,
                        width: 85,
                        image: AssetImage("asset/ragazzi_saluti.jpg"),

                      ),
                    )
                ),

                TileDivider(),

                TimelineTile(
                  topLineStyle: buildLineStyle(context),
                  indicatorStyle: buildIndicatorStyle(context),
                  bottomLineStyle: buildLineStyle(context),
                  alignment: TimelineAlign.manual,
                  lineX: 0.1,
                  rightChild: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "La festa patronale della frazione ricorre il 15 agosto, giorno dell'Assunzione di Maria al cielo ed è celebrata con tre giorni di festeggiamenti stands gastronomici, serate danzanti e un grande spettacolo pirotecnico.",
                      style: buildTextStyle(),
                    ),
                  ),
                ),

                TileDivider(),

                TimelineTile(
                  isLast: true,
                  topLineStyle: buildLineStyle(context),
                  indicatorStyle: buildIndicatorStyle(context),
                  alignment: TimelineAlign.manual,
                  lineX: 0.9,
                  leftChild:  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Image(
                      height: 150,
                      width: 150,
                      image: AssetImage("asset/sera.jpg"),

                    ),
                  ),
                ),

              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              padding: EdgeInsets.all(10),
              color: Theme.of(context).buttonColor,
              child: Text("Info sull'App"),
              onPressed: () {
                showAboutDialog(
                    context: context,
                    applicationName: "Assunta",
                    applicationVersion: "1.0",
                    children: [
                      Text("Creata da Roberto Garbarino"),
                      Text("Per Info contattare roberto.garbarino266@gmail.com")
                    ]
                );
              },
            ),
          )
        ],
      );
  }

  TextStyle buildTextStyle() {
    return TextStyle(
                      fontSize: 20
                    );
  }

  IndicatorStyle buildIndicatorStyle(BuildContext context) {
    return IndicatorStyle(
                    color: Theme.of(context).accentColor,
                    width: 25
                );
  }

  IndicatorStyle buildIndicatorStyleForImages(BuildContext context) {
    return IndicatorStyle(
        color: Theme.of(context).accentColor,
        width: 6
    );
  }

  LineStyle buildLineStyle(BuildContext context) {
    return LineStyle(
                    color: Theme.of(context).accentColor,
                    width: 6
                );
  }
}

class TileDivider extends StatelessWidget {
  const TileDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineDivider(
      thickness: 6,
      begin: 0.1,
      end: 0.9,
      color: Theme.of(context).accentColor,
    );
  }
}
