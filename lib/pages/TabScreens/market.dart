// ignore_for_file: deprecated_member_use

import 'package:cryptotracker_updated/models/chartdata.dart';
import 'package:cryptotracker_updated/pages/TabScreens/home.dart';
import 'package:cryptotracker_updated/pages/TabScreens/specificcoin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'dart:async';

import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';

class Marketscreen extends StatefulWidget {
  const Marketscreen({Key? key}) : super(key: key);

  @override
  _MarketscreenState createState() => _MarketscreenState();
}

class _MarketscreenState extends State<Marketscreen> {
  Random random = Random();
  int next(int min, int max) => random.nextInt(max - min);

  bool dark = true;
  Color bg = Colors.black;
  Color bg1 = Colors.white;
  Color bg2 = Colors.grey.shade900;
  Color look = Colors.white;
  Color look1 = Colors.black;
  Color look2 = Colors.white;

  Color all = Colors.orangeAccent.shade100.withOpacity(0.3);
  Color all1 = Colors.blueGrey.shade300;
  Color all2 = Colors.black;

  Color but1 = Colors.deepOrangeAccent.shade100;
  Color but2 = Colors.lightGreenAccent.shade100;

  bool b1 = true;
  bool b2 = false;

  List cryptodata = [];
  bool isload = true;

  String url1 =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=7d";

  Future fetchCryptoData() async {
    isload = true;
    http.Response response;

    response = await http.get(Uri.parse(url1));

    if (response.statusCode == 200) {
      setState(() {
        isload = false;
        cryptodata = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    fetchCryptoData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark == false ? Colors.grey.shade100 : Colors.black,
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: dark == false
                      ? LinearGradient(colors: [
                          Colors.teal.shade100.withOpacity(0.6),
                          Colors.orange.shade100.withOpacity(0.4),
                        ])
                      : LinearGradient(colors: [
                          Colors.grey.shade900,
                          Colors.grey.shade900,
                        ]),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  border: Border.all(width: 1.2, color: Colors.grey.shade900)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 5, 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        write('Market  ', 24, look, true),
                        Icon(
                          Icons.price_check,
                          size: 34,
                          color: look,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (look == look1) {
                                  look = look2;
                                  bg = bg2;
                                  all = all2;
                                  dark = true;
                                  HomePagecrypto.dark = true;
                                } else {
                                  look = look1;
                                  bg = bg1;
                                  all = all1;
                                  dark = false;
                                  HomePagecrypto.dark = false;
                                }
                              });
                            },
                            icon: Icon(
                              Icons.lightbulb_outline_sharp,
                              size: 36,
                              color: look,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: dark == false
                                ? Colors.orangeAccent.shade200
                                : Colors.deepOrangeAccent.shade700,
                          ),
                          onPressed: () {
                            setState(() {
                              b1 = true;
                              b2 = false;
                              if (b1 == true) {
                                but1 = Colors.deepOrangeAccent.shade100;
                                but2 = Colors.lightGreenAccent.shade100;
                              } else {
                                but1 = Colors.deepOrangeAccent.shade700;
                                but2 = Colors.lightGreenAccent.shade700;
                              }
                            });
                          },
                          child: write('   CryptoAssets   ', 21, look, true),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: dark == false
                                ? Colors.lightGreenAccent.shade400
                                : Colors.greenAccent.shade700,
                          ),
                          onPressed: () {
                            setState(() {});
                          },
                          child: write('    Exchanges    ', 21, look, true),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: marketlist(),
            )
          ],
        ),
      ),
    );
  }

  Widget marketlist() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 15, 4, 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: dark == false
              ? LinearGradient(colors: [
                  Colors.orangeAccent.shade100.withOpacity(0.2),
                  Colors.yellow.shade100.withOpacity(0.3),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)
              : LinearGradient(colors: [
                  Colors.blueGrey.shade900,
                  Colors.blueGrey.shade900,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          border: Border.all(width: 0.7, color: Colors.grey.shade900),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            (isload == true)
                ? SizedBox(
                    height: 550,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                        backgroundColor: Colors.deepOrange.shade800,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 550,
                    width: double.maxFinite,
                    child: ListView.builder(
                        itemCount: cryptodata.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                            child: Row(
                              children: [
                                Image(
                                  image: NetworkImage(
                                      '${cryptodata[index]['image']}'),
                                  height: 20,
                                  width: 20,
                                ),
                                write(
                                    '  ${cryptodata[index]['name']}',
                                    '${cryptodata[index]['name']}'.length < 14
                                        ? 16
                                        : 10,
                                    look,
                                    true),
                                const Spacer(),
                                graph(
                                    cryptodata[index]['sparkline_in_7d']
                                        ['price'],
                                    '${cryptodata[index]['price_change_percentage_24h']}'
                                        .toString()),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.euro,
                                          size: 12,
                                          color: look,
                                        ),
                                        write(
                                            '${cryptodata[index]['current_price']}'
                                                .toString(),
                                            11,
                                            look,
                                            true),
                                      ],
                                    ),
                                    ic('${cryptodata[index]['price_change_percentage_24h']}'
                                        .toString()),
                                  ],
                                ),
                                nextpage(
                                    '${cryptodata[index]['image']}',
                                    ' ${cryptodata[index]['name']}',
                                    '${cryptodata[index]['symbol']}',
                                    cryptodata[index]['current_price']
                                        .toDouble(),
                                    cryptodata[index]
                                            ['price_change_percentage_24h']
                                        .toDouble(),
                                    cryptodata[index]['sparkline_in_7d']
                                        ['price'],
                                    '${cryptodata[index]['id']}',
                                    cryptodata[index][
                                            'price_change_percentage_7d_in_currency']
                                        .toDouble()),
                              ],
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }

  Widget ic(String s) {
    if (s[0] == '-') {
      return Row(
        children: [
          write(s, 12, Colors.red, true),
          const Icon(
            Icons.arrow_drop_down_sharp,
            color: Colors.red,
            size: 14,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          write(s, 12, Colors.greenAccent.shade400, true),
          Icon(
            Icons.arrow_upward_outlined,
            color: Colors.greenAccent.shade400,
            size: 14,
          ),
        ],
      );
    }
  }

  Widget graph(List price, String v) {
    List<ChartData> data = [];

    for (int i = 0; i < min(price.length, 30); i++) {
      double tem = price[i];

      data.add(ChartData(i + 10000, tem));
    }

    Color col = Colors.lightGreenAccent.shade400;

    if (v[0] == '-') {
      col = Colors.deepOrangeAccent.shade400;
    }
    return SizedBox(
      height: 53,
      width: 80,
      child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(isVisible: false),
          primaryYAxis: CategoryAxis(isVisible: false),
          legend: Legend(isVisible: false),
          tooltipBehavior: TooltipBehavior(enable: false),
          series: <ChartSeries<ChartData, String>>[
            LineSeries(
                dataSource: data,
                color: col,
                xValueMapper: (ChartData data, _) => data.val1.toString(),
                yValueMapper: (ChartData data, _) => data.val2)
          ]),
    );
  }

  Widget nextpage(String image, String name, String symbol, double cur,
      double rate, List price, String id, double priceChange) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SpecificCoin(
                        image: image,
                        name: name,
                        symbol: symbol,
                        cur: cur,
                        rate: rate,
                        price: price,
                        id: id,
                        price_change: priceChange,
                      )));
        },
        icon: FaIcon(
          FontAwesomeIcons.arrowAltCircleRight,
          color: Colors.deepOrangeAccent.shade400,
          size: 30,
        ),
        focusColor: Colors.lightGreenAccent.shade400,
        hoverColor: Colors.yellowAccent.shade400,
        splashColor: Colors.limeAccent.shade200,
        splashRadius: 4,
      ),
    );
  }

  Text write(String s, double size, Color c, bool j) {
    return Text(
      s,
      style: TextStyle(
        fontSize: size,
        color: c,
        fontWeight: j == true ? FontWeight.bold : FontWeight.normal,
        fontFamily: 'lato',
      ),
    );
  }
}
