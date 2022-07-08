// ignore_for_file: deprecated_member_use

import 'package:cryptotracker_updated/controllers/db_helper.dart';
import 'package:cryptotracker_updated/models/assetprint.dart';
import 'package:cryptotracker_updated/models/chartdata.dart';
import 'package:cryptotracker_updated/pages/TabScreens/specificcoin.dart';
import 'package:cryptotracker_updated/swipe_deck/swipe_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dart:async';
import 'dart:math';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool trans = true;
  Color bg = Colors.white;
  Color bg1 = Colors.white;
  Color bg2 = Colors.grey.shade900;
  Color look = Colors.white;
  Color look1 = Colors.black;
  Color look2 = Colors.white;
  bool tranopen = false;

  bool dark = true;
  Random random = Random();
  int next(int min, int max) => random.nextInt(max - min);

  Color all = Colors.orangeAccent.shade100.withOpacity(0.3);
  Color all1 = Colors.blueGrey.shade300;
  Color all2 = Colors.black;

  List cryptodata = [];
  bool isload = true;
  String user = "";

  int grad = 0;

  String url1 =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=7d";

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

  DbHelper dbHelper = DbHelper();

  Future getName() async {
    user = await dbHelper.getName();
  }

  @override
  void initState() {
    fetchCryptoData();
    getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              GlowText(
                'CRYPTOTRACKER',
                glowColor: Colors.purple.shade900,
                style: const TextStyle(
                  fontFamily: 'ale1',
                  fontSize: 39,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ('Hello ' + user + '  ', 30, look, true),
                  GlowText(
                    'Hello $user ',
                    glowColor: Colors.black,
                    style: const TextStyle(
                      fontFamily: 'ale1',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const FaIcon(
                    FontAwesomeIcons.handsHelping,
                    color: Colors.white,
                    size: 32,
                  )
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              write('Good Morning, spread Positivity ', 19, look, true),
              const SizedBox(
                height: 14,
              ),
              Container(child: cryptotile()),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: dark == true
                        ? LinearGradient(colors: [
                            Colors.grey.shade900,
                            Colors.grey.shade900
                          ])
                        : const LinearGradient(
                            colors: [],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.notifications_on_sharp,
                              color: Colors.yellowAccent.shade700,
                              size: 28,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            write('Set Price Alert', 19, look, true),
                            write('Get Notified when your coins are moving .',
                                14, look, false),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.next_plan,
                                  size: 28,
                                  color: Colors.deepOrangeAccent.shade400,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      gradient: dark == true
                          ? LinearGradient(colors: [
                              Colors.grey.shade900,
                              Colors.grey.shade900
                            ])
                          : const LinearGradient(
                              colors: [],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              write('Investing Safely ', 12, look, true),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              write(
                                  "It's very difficult to time an investment,\nespecially when the market is volatile. ",
                                  16,
                                  Colors.white,
                                  true),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: const [
                              Text('Learn More',
                                  style: TextStyle(
                                    color: Colors.lightGreenAccent,
                                    fontFamily: 'lato',
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.lightGreenAccent,
                                  ))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              aset(),
              const SizedBox(
                height: 5,
              ),
              transhistory(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget aset() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(14, 7, 9, 2),
        child: Row(
          children: [
            write('  Assets', 30, look, true),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Assettile()));
                },
                icon: const FaIcon(
                  FontAwesomeIcons.arrowAltCircleRight,
                  color: Colors.white,
                  size: 30,
                )),
          ],
        ),
      ),
    ]);
  }

  Widget graph(List price, String v) {
    List<ChartData> data = [];

    int v = min(price.length, 30);

    for (int i = 0; i < v; i++) {
      double tem = price[i];

      data.add(ChartData(i + 1000000000, tem));
    }

    Color col = Colors.white;

    return SizedBox(
      height: 100,
      width: 167,
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

  Widget cryptotile() {
    if (isload == false) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 300,
            width: 350,
            child: ListView.builder(
                itemCount: cryptodata.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 250,
                      width: 200,
                      decoration: const BoxDecoration(),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(29),
                                topRight: Radius.circular(29),
                              ),
                              gradient: (index == 0 || index % 2 == 0)
                                  ? tile1()
                                  : (index == 1 || index % 3 == 0)
                                      ? tile2()
                                      : tile3(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 22, 12, 7),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      write(
                                          '  ${cryptodata[index]['name']}',
                                          '${cryptodata[index]['name']}'
                                                      .length <
                                                  9
                                              ? 17
                                              : 12,
                                          Colors.white,
                                          true),
                                      // Image(
                                      //   image: NetworkImage(
                                      //       '${cryptodata[index]['image']}'),
                                      //   height: 20,
                                      //   width: 20,
                                      // ),
                                      const Spacer(),
                                      write(
                                          '${cryptodata[index]['symbol']}'
                                              .toUpperCase(),
                                          12,
                                          Colors.grey.shade200,
                                          true),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      graph(
                                          cryptodata[index]['sparkline_in_7d']
                                              ['price'],
                                          '${cryptodata[index]['price_change_percentage_24h']}'
                                              .toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Image(
                                        image: NetworkImage(
                                            '${cryptodata[index]['image']}'),
                                        height: 36,
                                        width: 36,
                                      ),
                                      const Spacer(),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              write(
                                                  '${cryptodata[index]['market_cap_change_percentage_24h']}'
                                                              .toString()[0] ==
                                                          '-'
                                                      ? 'Loss'
                                                      : 'Profit',
                                                  15,
                                                  Colors.white,
                                                  true)
                                            ],
                                          ),
                                          write(
                                              '${cryptodata[index]['market_cap_change_percentage_24h']}'
                                                  .toString(),
                                              11,
                                              Colors.white,
                                              true),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                              child: Row(
                                children: [
                                  Column(children: [
                                    Row(
                                      children: [
                                        write('Current Price ', 15,
                                            Colors.black, false),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.euro_symbol_sharp,
                                          color: Colors.black,
                                          size: 22,
                                        ),
                                        deciwrite(
                                          '${cryptodata[index]['current_price']}'
                                              .toString(),
                                        )
                                      ],
                                    )
                                  ]),
                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              color: Colors.black,
                                              height: 170,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 0, 20, 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.grey.shade900,
                                                          Colors.grey.shade900,
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      )),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      // Row(
                                                      //   children: [

                                                      //     IconButton(
                                                      //         onPressed: () {
                                                      //           Navigator.pop(context);
                                                      //         },
                                                      //         icon: Icon(
                                                      //           Icons.pin_drop,
                                                      //           color: Colors.deepOrange.shade600,
                                                      //           size: 26,
                                                      //         )),
                                                      //     SizedBox(
                                                      //       width: 6,
                                                      //     )
                                                      //   ],
                                                      // ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        // final isAuthenticated =
                                                                        //     await LocalAuthApi.authenticate();

                                                                        // if (isAuthenticated) {
                                                                        //   Navigator.push(
                                                                        //       context,
                                                                        //       MaterialPageRoute(
                                                                        //           builder: (context) => SpecificCoin(
                                                                        //                 image: '${cryptodata[index]['image']}',
                                                                        //                 name: '${cryptodata[index]['name']}',
                                                                        //                 symbol: ' ${cryptodata[index]['symbol']}',
                                                                        //                 cur: cryptodata[index]['current_price'].toDouble(),
                                                                        //                 rate: cryptodata[index]['price_change_percentage_24h'].toDouble(),
                                                                        //                 price: cryptodata[index]['sparkline_in_7d']['price'],
                                                                        //                 id: '${cryptodata[index]['id']}',
                                                                        //                 price_change: cryptodata[index]['price_change_percentage_7d_in_currency'].toDouble(),
                                                                        //               )

                                                                        //               )

                                                                        //               );
                                                                        // }

                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              AlertDialog(
                                                                            backgroundColor:
                                                                                Colors.grey.shade900,
                                                                            content:
                                                                                Container(
                                                                              height: 300,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(12),
                                                                                color: Colors.grey.shade900,
                                                                              ),
                                                                              child: Column(
                                                                                children: [
                                                                                  write('Authentication Required', 20, Colors.white, true),
                                                                                  const SizedBox(
                                                                                    height: 12,
                                                                                  ),
                                                                                  write('Verify Identity', 17, Colors.white, true),
                                                                                  const SizedBox(
                                                                                    height: 14,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      const FaIcon(
                                                                                        FontAwesomeIcons.laptopCode,
                                                                                        size: 22,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      write('  Scan Fingerprint', 18, Colors.white, true),
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  IconButton(
                                                                                    onPressed: () {
                                                                                      setState(() {});
                                                                                    },
                                                                                    icon: FaIcon(
                                                                                      FontAwesomeIcons.fingerprint,
                                                                                      color: Colors.greenAccent.shade400,
                                                                                      size: 42,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 21,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      ElevatedButton(
                                                                                        style: ElevatedButton.styleFrom(
                                                                                          primary: Colors.greenAccent.shade700,
                                                                                        ),
                                                                                        onPressed: () {},
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              write('Success ', 14, Colors.white, true),
                                                                                              const FaIcon(
                                                                                                FontAwesomeIcons.userCheck,
                                                                                                size: 12,
                                                                                                color: Colors.white,
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        width: 6,
                                                                                      ),
                                                                                      ElevatedButton(
                                                                                        style: ElevatedButton.styleFrom(
                                                                                          primary: Colors.orange.shade700,
                                                                                        ),
                                                                                        onPressed: () {
                                                                                          Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                  builder: (context) => SpecificCoin(
                                                                                                        image: '${cryptodata[index]['image']}',
                                                                                                        name: '${cryptodata[index]['name']}',
                                                                                                        symbol: ' ${cryptodata[index]['symbol']}',
                                                                                                        cur: cryptodata[index]['current_price'].toDouble(),
                                                                                                        rate: cryptodata[index]['price_change_percentage_24h'].toDouble(),
                                                                                                        price: cryptodata[index]['sparkline_in_7d']['price'],
                                                                                                        id: '${cryptodata[index]['id']}',
                                                                                                        price_change: cryptodata[index]['price_change_percentage_7d_in_currency'].toDouble(),
                                                                                                      )));
                                                                                        },
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              write('Go ', 14, Colors.white, true),
                                                                                              const FaIcon(
                                                                                                FontAwesomeIcons.longArrowAltRight,
                                                                                                size: 12,
                                                                                                color: Colors.white,
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  TextButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        write('Cancel ', 22, Colors.white, true),
                                                                                        const Icon(Icons.cancel, color: Colors.white, size: 22),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            // actions: [
                                                                            //   ElevatedButton(
                                                                            //     onPressed: () {
                                                                            //       Navigator.of(context).pop(true);
                                                                            //     },
                                                                            //     style: ButtonStyle(
                                                                            //       backgroundColor: MaterialStateProperty.all(
                                                                            //         Colors.red,
                                                                            //       ),
                                                                            //     ),
                                                                            //     child: Text(
                                                                            //       "YES",
                                                                            //     ),
                                                                            //   ),
                                                                            //   ElevatedButton(
                                                                            //     onPressed: () {
                                                                            //       Navigator.of(context).pop(false);
                                                                            //     },
                                                                            //     child: Text(
                                                                            //       "No",
                                                                            //     ),
                                                                            //   ),
                                                                            // ],
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            write(
                                                                                'Authenticate ',
                                                                                30,
                                                                                Colors.white,
                                                                                true),
                                                                            const Icon(Icons.lock_open_outlined,
                                                                                color: Colors.white,
                                                                                size: 35)
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        primary: Colors
                                                                            .blueGrey
                                                                            .shade900,
                                                                        onPrimary: Colors
                                                                            .lightGreenAccent
                                                                            .shade400,
                                                                      )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            write(
                                                                                'Cancel',
                                                                                30,
                                                                                Colors.white,
                                                                                true),
                                                                            const Icon(
                                                                              Icons.cancel_rounded,
                                                                              color: Colors.white,
                                                                              size: 32,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        primary: Colors
                                                                            .deepOrange
                                                                            .shade900,
                                                                        onPrimary: Colors
                                                                            .lightGreenAccent
                                                                            .shade400,
                                                                      )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.price_check_outlined,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                        write(' Buy', 12, Colors.white, true),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.lightGreenAccent.shade700,
                                      onPrimary: Colors.purpleAccent.shade400,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      );
    } else {
      return SizedBox(
          height: 150,
          width: 100,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.deepOrange.shade900,
            ),
          ));
    }
  }

  Widget transhistory() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 1, 12, 1),
          child: Row(
            children: [
              write('Transaction History', 26, look, true),
              const Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (tranopen == false) {
                      tranopen = true;
                    } else {
                      tranopen == false;
                    }
                  });
                },
                icon: tran(),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        tranopen == true
            ? Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 18,
                      ),
                      write('Choose Option', 20, look, true),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (tranopen == false) {
                                tranopen = true;
                              } else {
                                tranopen = false;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.cancel_presentation_outlined,
                            color: look,
                            size: 23,
                          )),
                      const SizedBox(
                        width: 22,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                            CupertinoPageRoute(
                              builder: (context) => const SwipeCard(),
                            ),
                          )
                              .then((value) {
                            setState(() {});
                          });
                        },
                        child: Row(
                          children: [
                            write('View Details ', 18, look, true),
                            Icon(
                              Icons.open_in_new_outlined,
                              color: look,
                              size: 19,
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreenAccent.shade700,
                          onPrimary: Colors.yellowAccent.shade700,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            write('View List ', 18, look, true),
                            Icon(
                              Icons.open_in_full_outlined,
                              color: look,
                              size: 19,
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent.shade400,
                          onPrimary: Colors.redAccent.shade400,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
      ],
    );
  }

  Icon tran() {
    if (tranopen == false) {
      return Icon(Icons.navigate_next, color: look, size: 26);
    } else {
      return Icon(Icons.arrow_circle_down_outlined, color: look, size: 26);
    }
  }

  LinearGradient gradi(Color a, Color b, Color c) {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [a, b, c]);
  }

  Text deciwrite(String s) {
    String str = "";
    for (int i = 0; i < s.length; i++) {
      str += s[i];
      if (s[i] == '.') {
        int j = i + 1;

        int y = min(s.length, j + 2);
        while (j < y) {
          str += s[j];
          j++;
        }

        return write(str, 19, Colors.black, true);
      }
    }
    return write(str, 20, Colors.black, true);
  }

  LinearGradient tile1() {
    return LinearGradient(
      colors: [
        Colors.pinkAccent,
        Colors.pinkAccent.shade400,
        Colors.deepOrangeAccent.shade400,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  LinearGradient tile2() {
    return LinearGradient(
      colors: [
        Colors.purpleAccent.shade400,
        Colors.purpleAccent.shade700,
        Colors.purpleAccent.shade200,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  LinearGradient tile3() {
    return LinearGradient(
      colors: [
        Colors.yellowAccent.shade400,
        Colors.yellow.shade800,
        Colors.orangeAccent.shade400,
        Colors.deepOrangeAccent.shade400,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  Color dec(String s) {
    if (s[0] == '-') {
      return Colors.red;
    } else {
      return Colors.green;
    }
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

  Text al(String s, double size, Color c, bool j) {
    return Text(
      s,
      style: TextStyle(
        fontSize: size,
        color: c,
        fontWeight: j == true ? FontWeight.bold : FontWeight.normal,
        fontFamily: 'ale',
      ),
    );
  }
}
