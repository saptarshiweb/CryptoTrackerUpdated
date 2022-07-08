// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:cryptotracker_updated/models/chartdata.dart';
import 'package:cryptotracker_updated/widgets/add_transaction2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SpecificCoin extends StatefulWidget {
  final String image;
  final String name;
  final String symbol;
  final double cur;
  final double rate;
  final List price;

  final String id;
  final double price_change;

  static bool dark = false;

  const SpecificCoin({
    Key? key,
    required this.image,
    required this.name,
    required this.symbol,
    required this.cur,
    required this.rate,
    required this.price,
    required this.id,
    required this.price_change,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _SpecificCoinState createState() => _SpecificCoinState(
      image, name, symbol, cur, rate, price, id, price_change);
}

class _SpecificCoinState extends State<SpecificCoin> {
  Random random = Random();
  int next(int min, int max) => random.nextInt(max - min);

  int cash = 0;

  bool dark = true;

  bool mock = false;

  bool purchase = false;

  Color bg = Colors.grey.shade900;
  Color bg1 = Colors.white;
  Color bg2 = Colors.grey.shade900;
  Color look = Colors.white;
  Color look1 = Colors.black;
  Color look2 = Colors.white;

  Color all = Colors.grey.shade100;
  Color all1 = Colors.blueGrey.shade300;
  Color all2 = Colors.black;

  String image;
  String name;
  String symbol;
  double cur;
  double rate;
  List price;
  String id;

  String choice = '24h';

  int period = 18;

  double price_change;
  _SpecificCoinState(this.image, this.name, this.symbol, this.cur, this.rate,
      this.price, this.id, this.price_change);

  Map coin = {};
  Map coindes = {};
  String des = '';

  bool cal = false;
  int total = 0;

  Future fetchCoinData() async {
    http.Response response;

    response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/$id?localization=false&sparkline=true'));

    if (response.statusCode == 200) {
      setState(() {
        coin = json.decode(response.body);
        coindes = coin['description'];
        des = coindes['en'].toString();
      });
    }
  }

  @override
  void initState() {
    fetchCoinData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: dark == true ? Colors.black : Colors.grey.shade200,
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: dark == false
                  ? LinearGradient(colors: [
                      Colors.purpleAccent.shade100.withOpacity(0.3),
                      Colors.lightGreenAccent.shade100.withOpacity(0.2),
                      Colors.yellowAccent.shade100.withOpacity(0.2),
                    ])
                  : const LinearGradient(colors: [
                      Colors.black,
                      Colors.black,
                      Colors.black,
                    ]),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.arrowAltCircleLeft,
                            size: 28,
                            color: dark == false ? Colors.black : Colors.white,
                          )),
                      const SizedBox(
                        width: 3,
                      ),
                      write('Back', 23,
                          dark == false ? Colors.black : Colors.white, true),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (dark == false) {
                                look = look2;
                                dark = true;
                                bg = bg2;
                              } else {
                                dark = false;
                                look = look1;
                                bg = bg1;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.lightbulb_outline_rounded,
                            color: dark == false ? Colors.black : Colors.white,
                            size: 32,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: dark == false
                            ? LinearGradient(
                                colors: [
                                  Colors.orange.shade100.withOpacity(0.7),
                                  Colors.yellow.shade100.withOpacity(0.6),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : const LinearGradient(
                                colors: [
                                  Colors.black,
                                  Colors.black,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        border: Border.all(width: 0),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          dark == false
                              ? BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 2.0, // soften the shadow
                                  spreadRadius: 3.0, //extend the shadow
                                  offset: const Offset(
                                    3.0,
                                    2.0, // Move to right 10  horizontally

                                    // Move to bottom 10 Vertically
                                  ),
                                )
                              : BoxShadow(
                                  color: Colors.grey.shade900,
                                  blurRadius: 0.2, // soften the shadow
                                  spreadRadius: 0.5, //extend the shadow
                                  offset: const Offset(
                                    3.0,
                                    2.0, // Move to right 10  horizontally

                                    // Move to bottom 10 Vertically
                                  ),
                                ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(7, 26, 3, 9),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Image(
                                image: NetworkImage(image),
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              write(name, 18, look, true),
                              const Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.euro,
                                    size: 18,
                                    color: look,
                                  ),
                                  write(cur.toString(), 16, look, true),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 45,
                              ),
                              write(
                                  symbol.toUpperCase(),
                                  15,
                                  dark == false
                                      ? Colors.grey.shade700
                                      : Colors.white70,
                                  false),
                              const Spacer(),
                              write(
                                  rate.toString()[0] == '-'
                                      ? rate.toString()
                                      : '+' + rate.toString(),
                                  14,
                                  rate.toString()[0] == '-'
                                      ? Colors.red
                                      : Colors.green,
                                  true),
                              const SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          graph(price, rate.toString()),
                          Row(
                            children: [
                              const SizedBox(width: 6),
                              ChoiceChip(
                                  label:
                                      write('24 Hour', 16, Colors.white, true),
                                  selected: choice == "24h" ? true : false,
                                  backgroundColor: Colors.blueGrey.shade700,
                                  selectedColor: Colors.deepPurple.shade900,
                                  onSelected: (val) {
                                    if (val) {
                                      setState(() {
                                        period = 18;
                                        choice = "24h";
                                      });
                                    }
                                  }),
                              const SizedBox(
                                width: 6,
                              ),
                              ChoiceChip(
                                  label: write('7 Day', 16, Colors.white, true),
                                  selected: choice == "7d" ? true : false,
                                  backgroundColor: Colors.blueGrey.shade700,
                                  selectedColor: Colors.deepPurple.shade900,
                                  onSelected: (val) {
                                    if (val) {
                                      setState(() {
                                        period = 26;
                                        choice = "7d";
                                      });
                                    }
                                  }),
                              const SizedBox(
                                width: 6,
                              ),
                              ChoiceChip(
                                  label:
                                      write('1 month', 16, Colors.white, true),
                                  selected: choice == "1m" ? true : false,
                                  backgroundColor: Colors.blueGrey.shade700,
                                  selectedColor: Colors.deepPurple.shade900,
                                  onSelected: (val) {
                                    if (val) {
                                      setState(() {
                                        period = 34;
                                        choice = "1m";
                                      });
                                    }
                                  }),
                              const SizedBox(
                                width: 6,
                              ),
                              ChoiceChip(
                                  label:
                                      write('2 month', 16, Colors.white, true),
                                  selected: choice == "2m" ? true : false,
                                  backgroundColor: Colors.blueGrey.shade700,
                                  selectedColor: Colors.deepPurple.shade900,
                                  onSelected: (val) {
                                    if (val) {
                                      setState(() {
                                        period = 40;
                                        choice = "2m";
                                      });
                                    }
                                  }),
                            ],
                          ),
                          Row(children: [
                            const SizedBox(
                              width: 6,
                            ),
                            ChoiceChip(
                                label: write('6 month', 16, Colors.white, true),
                                selected: choice == "6m" ? true : false,
                                backgroundColor: Colors.blueGrey.shade700,
                                selectedColor: Colors.deepPurple.shade900,
                                onSelected: (val) {
                                  if (val) {
                                    setState(() {
                                      period = 47;
                                      choice = "6m";
                                    });
                                  }
                                }),
                            const SizedBox(
                              width: 6,
                            ),
                            ChoiceChip(
                                label: write('1 Year', 16, Colors.white, true),
                                selected: choice == "1Y" ? true : false,
                                backgroundColor: Colors.blueGrey.shade700,
                                selectedColor: Colors.deepPurple.shade900,
                                onSelected: (val) {
                                  if (val) {
                                    setState(() {
                                      period = 54;
                                      choice = "1Y";
                                    });
                                  }
                                }),
                          ])
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                walletbuy(),
                const SizedBox(height: 5),
                pur(),
                const SizedBox(
                  height: 7,
                ),
                mocktrade(),
                const SizedBox(
                  height: 7,
                ),
                aboutcoin(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }

  Widget mocktrade() {
    if (mock == false) {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                gradient: dark == false
                    ? LinearGradient(
                        colors: [
                          Colors.orange.shade100.withOpacity(0.7),
                          Colors.yellow.shade100.withOpacity(0.6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [
                          Colors.grey.shade900,
                          Colors.grey.shade900,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                border: Border.all(width: 0),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  dark == false
                      ? BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 2.0, // soften the shadow
                          spreadRadius: 3.0, //extend the shadow
                          offset: const Offset(
                            3.0,
                            2.0, // Move to right 10  horizontally

                            // Move to bottom 10 Vertically
                          ),
                        )
                      : const BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0, // soften the shadow
                          spreadRadius: 3.0, //extend the shadow
                          offset: Offset(
                            3.0,
                            2.0, // Move to right 10  horizontally

                            // Move to bottom 10 Vertically
                          ),
                        ),
                ]),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 18,
                    ),
                    write('Buy ' + name + '  ', 23, look, true),
                    Icon(
                      Icons.shopping_cart,
                      color: look,
                      size: 24,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (mock == true) {
                              mock = false;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.cancel_sharp,
                          color: Colors.red.shade600,
                          size: 25,
                        )),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                write('Rate ' + cur.toString(), 22, look, true),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter the Quantity",
                          hintStyle: TextStyle(
                              color: look == look1
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade400),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: 'lato',
                          color: look,
                        ),
                        onChanged: (val) {
                          try {
                            cash = int.parse(val);
                          } catch (e) {
                            // show Error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                duration: const Duration(
                                  seconds: 2,
                                ),
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: look,
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      "Enter only Numbers as Amount",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'lato',
                                        color: look,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        // textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        total = cash * cur.toInt();

                        cal = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          write('Calculate  ', 21, look, true),
                          Icon(
                            Icons.calculate_outlined,
                            color: look,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent.shade700,
                      onPrimary: Colors.lightGreenAccent.shade400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                cal == false
                    ? const SizedBox(height: 0, width: 0)
                    : Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            write('Total Amount to be Paid ' + total.toString(),
                                18, look, true),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => Transact(
                                          cash: total.toDouble(),
                                          note1: name + " Purchase",
                                          expense: true,
                                          crypto: name,
                                          buyorsell: 'buy',
                                          quantity: cash,
                                          rate: cur.toInt(),
                                        )));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  write('Proceed to Payment ', 15, look, true),
                                  Icon(
                                    Icons.payment,
                                    color: look,
                                    size: 18,
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.teal.shade700,
                                onPrimary: Colors.lightGreenAccent.shade400,
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  cal = false;
                                });
                              },
                              child: Row(
                                children: [
                                  write('Cancel  ', 15, look, true),
                                  Icon(
                                    Icons.cancel,
                                    color: look,
                                    size: 18,
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.deepOrange.shade400,
                                primary: Colors.red,
                              ),
                            )
                          ],
                        )
                      ]),
                const SizedBox(
                  height: 9,
                ),
              ],
            )),
      );
    }
  }

  Widget walletbuy() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: dark == false
                ? LinearGradient(colors: [
                    Colors.orange.shade100.withOpacity(0.7),
                    Colors.yellow.shade100.withOpacity(0.6),
                  ])
                : LinearGradient(colors: [
                    Colors.grey.shade900,
                    Colors.grey.shade900,
                  ]),
            border: Border.all(
              width: 0,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              dark == false
                  ? BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 2.0, // soften the shadow
                      spreadRadius: 3.0, //extend the shadow
                      offset: const Offset(
                        3.0,
                        2.0, // Move to right 10  horizontally

                        // Move to bottom 10 Vertically
                      ),
                    )
                  : const BoxShadow(
                      color: Colors.black,
                    )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image(
                    image: NetworkImage(image),
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  write(name + ' Wallet', 19, look, true),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.euro,
                        color: look,
                        size: 20,
                      ),
                      write(cur.toString() + ' ', 18, look, true),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.arrowAltCircleRight,
                        color: look == look1
                            ? Colors.grey.shade600
                            : Colors.lightGreenAccent,
                        size: 30,
                      ))
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SwipeCard()),
                      // );

                      setState(() {
                        purchase = true;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        write(
                            'Buy  ',
                            24,
                            look == look1 ? Colors.white : Colors.grey.shade200,
                            true),
                        FaIcon(
                          FontAwesomeIcons.arrowAltCircleRight,
                          color: look == look1
                              ? Colors.white
                              : Colors.grey.shade200,
                          size: 30,
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: look == look1
                          ? Colors.greenAccent.shade700
                          : Colors.greenAccent.shade700,
                      onSurface: Colors.deepOrangeAccent.shade200,
                      onPrimary: Colors.greenAccent.shade200,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pur() {
    if (purchase == true) {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: dark == false
                ? LinearGradient(colors: [
                    Colors.orange.shade100.withOpacity(0.7),
                    Colors.yellow.shade100.withOpacity(0.6),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)
                : LinearGradient(colors: [
                    Colors.grey.shade900,
                    Colors.grey.shade900,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            border: Border.all(width: 0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    write('Purchase CryptoCurrency', 22, look, true),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 35,
                      ),
                      onPressed: () {
                        setState(() {
                          purchase = false;
                        });
                      },
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            mock = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: write('Mock Trade', 17, look, true),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal.shade900,
                          onPrimary: Colors.yellowAccent.shade700,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: write('Actual Trade', 17, look, true),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange.shade800,
                          onPrimary: Colors.redAccent.shade400,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }

  Widget recent() {
    return Container();
  }

  Widget graph(List price, String v) {
    List<ChartData> data = [];

    for (int i = 0; i < min(price.length, period); i++) {
      double tem = price[i];

      data.add(ChartData(i + 100, tem));
    }

    Color col = Colors.greenAccent.shade700;

    if (v[0] == '-') {
      col = Colors.redAccent.shade700;
    }
    return SizedBox(
      height: 170,
      width: double.infinity,
      child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(isVisible: false),
          primaryYAxis: CategoryAxis(isVisible: false),
          legend: Legend(isVisible: false),
          tooltipBehavior: TooltipBehavior(enable: false),
          series: <ChartSeries<ChartData, String>>[
            LineSeries(
                dataSource: data,
                width: 2.5,
                color: col,
                xValueMapper: (ChartData data, _) => data.val1.toString(),
                yValueMapper: (ChartData data, _) => data.val2)
          ]),
    );
  }

  Widget aboutcoin() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: dark == false
              ? LinearGradient(colors: [
                  Colors.orange.shade100.withOpacity(0.7),
                  Colors.yellow.shade100.withOpacity(0.6),
                ])
              : LinearGradient(colors: [
                  Colors.grey.shade900,
                  Colors.grey.shade900,
                ]),
          boxShadow: [
            dark == false
                ? BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 2.0, // soften the shadow
                    spreadRadius: 3.0, //extend the shadow
                    offset: const Offset(
                      2.0,
                      1.0,

                      // Move to bottom 10 Vertically
                    ),
                  )
                : const BoxShadow(
                    color: Colors.black,
                  )
          ],
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Row(
                children: [
                  write('  About ' + name, 22, look, true),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Text(
                    //   des,
                    //   textAlign: TextAlign.left,
                    //   maxLines: 6,
                    //   overflow: TextOverflow.ellipsis,
                    //   softWrap: true,
                    //   style: TextStyle(
                    //     color: look,
                    //     fontSize: 16,
                    //     fontFamily: 'lato',
                    //   ),
                    // )

                    write(cor(des), 16, look, false),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(9, 1, 0, 2),
                    child: Text(
                      'Details',
                      style: TextStyle(
                        color: Colors.blueAccent.shade400,
                        fontSize: 18,
                        fontFamily: 'lato',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blueAccent.shade400,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String cor(String s) {
    String str = '';
    int c = 0;

    int tot = 0;
    int j = 0;

    for (int i = 0; i < s.length; i++) {
      if (s[i] == ' ') {
        c++;
        tot++;
      }

      j++;

      if (j > 30) {
        str += '\n';
        j = 0;
        c = 0;
      }
      str += s[i];

      if (c == 5) {
        str += '\n';
        c = 0;
        j = 0;
      }

      if (s[i] == '.' && tot >= 17) {
        return str;
      }
    }
    return str;
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
