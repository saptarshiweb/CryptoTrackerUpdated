// ignore_for_file: deprecated_member_use

import 'package:cryptotracker_updated/controllers/db_helper.dart';
import 'package:cryptotracker_updated/widgets/confirm_dialog.dart';
import 'package:cryptotracker_updated/widgets/info_snackbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cryptotracker_updated/statics_and_theme/static.dart' as Static;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:swipe_deck/swipe_deck.dart';

class Assettile extends StatefulWidget {
  const Assettile({Key? key}) : super(key: key);

  @override
  _AssettileState createState() => _AssettileState();
}

class _AssettileState extends State<Assettile> {
  //
  bool trans = true;
  Color bg = Colors.white;
  Color bg1 = Colors.white;
  Color bg2 = Colors.grey.shade900;
  Color look = Colors.white;
  Color look1 = Colors.black;
  Color look2 = Colors.white;

  String cry1 = "any";
  int r1 = 0;

  bool sell = false;

  bool dark = true;
  bool dyes = false;

  Color all = Colors.orangeAccent.shade100.withOpacity(0.3);
  Color all1 = Colors.blueGrey.shade300;
  Color all2 = Colors.black;

  late Box box;
  late SharedPreferences preferences;
  DbHelper dbHelper = DbHelper();
  Map? data;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];
  List<BarChartGroupData> barChartData = [];
  DateTime today = DateTime.now();
  List crypto = [];
  List price = [];

  int ind1 = 0;

  Color c = Colors.white;
  String cur = "";

  Map coin = {};
  Map coin2 = {};

  int ind = 0;

  bool cal = false;

  final TextEditingController _quan = TextEditingController();

  List<int> indval = [];
  int sum = 0;
  List crypname = [];
  List quan = [];
  List not = [];
  List rat = [];
  List cash = [];

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  void initState() {
    super.initState();

    getPreference();

    box = Hive.box('money');
  }

  getPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }
  //

  getval(Map x) {
    int i = 0;
    x.forEach((key, value) {
      crypname.add(value['crypto']);
      not.add(value['note']);
      rat.add(value['rate']);
      cash.add(value['amount']);

      quan.add(value['quantity']);
      sum++;
      indval.add(i);
      i++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map>(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Oopssss !!! There is some error !",
                ),
              );
            }
            if (snapshot.hasData) {
              // if (snapshot.data!.isEmpty) {
              //   return Center(
              //     child: Text(
              //       "You haven't added Any Data !",
              //     ),
              //   );
              // }
              //
              getval(snapshot.data!);

              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.purple.shade900,
                  Colors.deepPurple.shade900,
                ])),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.solidArrowAltCircleLeft,
                              color: look,
                              size: 35,
                            )),
                        const SizedBox(
                          width: 60,
                        ),
                        write('AssetList ', 35, look, true),
                        FaIcon(
                          FontAwesomeIcons.listAlt,
                          color: c,
                          size: 34,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    TextButton(
                        onPressed: () {
                          setState(() {
                            dyes = !dyes;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            write('Show Cards ', 32, Colors.white, true),
                            FaIcon(
                              dyes == false
                                  ? FontAwesomeIcons.arrowAltCircleDown
                                  : FontAwesomeIcons.solidWindowClose,
                              color: Colors.white,
                              size: 38,
                            ),
                          ],
                        )),

                    dyes == true
                        ? const SizedBox(height: 40)
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                    dyes == true ? deck() : const SizedBox(height: 0, width: 0),
                    sell == true
                        ? const SizedBox(
                            height: 20,
                          )
                        : const SizedBox(height: 0, width: 0),
                    sell == true
                        ? sellwindow(cry1, r1, ind1)
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                    const SizedBox(
                      height: 40,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length + 1,
                        itemBuilder: (context, index) {
                          Map dataAtIndex = {};

                          try {
                            dataAtIndex = snapshot.data![index];
                          } catch (e) {
                            // deleteAt deletes that key and value,
                            // hence makign it null here., as we still build on the length.
                            return Container();
                          }

                          if ((dataAtIndex['crypto'] != "") &&
                              (dataAtIndex['buyorsell'] == "buy")) {
                            return aset(
                                dataAtIndex['amount'],
                                dataAtIndex['crypto'],
                                dataAtIndex['quantity'],
                                dataAtIndex['rate']);
                          } else {
                            return const SizedBox(
                              height: 0,
                              width: 0,
                            );
                          }
                        }),

                    const SizedBox(height: 50),

                    // Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: Row(
                    //     children: [
                    //       write('Recent Transactions', 23, look, true),
                    //       Spacer(),
                    //       trans == false
                    //           ? IconButton(
                    //               onPressed: () {
                    //                 setState(() {
                    //                   if (trans == true) {
                    //                     trans = false;
                    //                   } else {
                    //                     trans = true;
                    //                   }
                    //                 });
                    //               },
                    //               icon: Icon(
                    //                 Icons.arrow_drop_down_circle_sharp,
                    //                 color: Colors.lightGreenAccent.shade700,
                    //                 size: 36,
                    //               ),
                    //             )
                    //           : IconButton(
                    //               onPressed: () {
                    //                 setState(() {
                    //                   if (trans == true) {
                    //                     trans = false;
                    //                   } else {
                    //                     trans = true;
                    //                   }
                    //                 });
                    //               },
                    //               icon: Icon(
                    //                 Icons.cancel_presentation_outlined,
                    //                 color: Colors.deepOrangeAccent.shade400,
                    //                 size: 36,
                    //               ),
                    //             ),
                    //       SizedBox(
                    //         width: 20,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    //
                    // trans == false
                    //     ? SizedBox(
                    //         height: 0,
                    //         width: 0,
                    //       )
                    //     : ListView.builder(
                    //         shrinkWrap: true,
                    //         physics: NeverScrollableScrollPhysics(),
                    //         itemCount: snapshot.data!.length + 1,
                    //         itemBuilder: (context, index) {
                    //           Map dataAtIndex = {};
                    //           try {
                    //             dataAtIndex = snapshot.data![index];
                    //           } catch (e) {
                    //             // deleteAt deletes that key and value,
                    //             // hence makign it null here., as we still build on the length.
                    //             return Container();
                    //           }
                    //           if (dataAtIndex['type'] == "Income") {
                    //             return incomeTile(
                    //               dataAtIndex['amount'],
                    //               dataAtIndex['note'],
                    //               dataAtIndex['date'],
                    //               index,
                    //             );
                    //           } else {
                    //             return expenseTile(
                    //               dataAtIndex['amount'],
                    //               dataAtIndex['note'],
                    //               dataAtIndex['date'],
                    //               index,
                    //             );
                    //           }
                    //         },
                    //       ),
                    //

                    const SizedBox(
                      height: 800.0,
                    ),
                  ],
                ),
              );
            } else {
              return const Text(
                "Loading...",
              );
            }
          },
        ),
      ),
    );
  }

  Widget deck() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: SwipeDeck(
        aspectRatio: 1,
        startIndex: 2,
        // ignore: avoid_unnecessary_containers
        emptyIndicator: Container(
          child: const Center(
            child: Text("Nothing Here"),
          ),
        ),
        // cardSpreadInDegrees: 5, // Change the Spread of Background Cards
        // onSwipeLeft: () {
        //   print("USER SWIPED LEFT -> GOING TO NEXT WIDGET");
        // },
        // onSwipeRight: () {
        //   print("USER SWIPED RIGHT -> GOING TO PREVIOUS WIDGET");
        // },
        // onChange: (index) {
        //   print(c[index]);
        // },
        widgets: indval
            .map((e) => GestureDetector(
                onTap: () {
                  // ignore: avoid_print
                  print(e);
                },
                // ignore: sized_box_for_whitespace
                child: Container(
                  height: 1800,
                  width: 1000,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: fin(e + 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          write(crypname[e].toString(), 20, look, true),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.pin,
                              color: Colors.grey.shade200,
                              size: 22,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.chartPie,
                            color: look,
                            size: 18,
                          ),
                          write(' Quantity valid: ' + quan[e].toString() + ' ',
                              14, look, true),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.stickyNote,
                            color: look,
                            size: 17,
                          ),
                          write(not[e], 12, look, true),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.googlePay,
                            color: look,
                            size: 14,
                          ),
                          write('Transaction Amount: ', 11, look, true),
                          FaIcon(
                            FontAwesomeIcons.euroSign,
                            color: look,
                            size: 13,
                          ),
                          write(cash[e].toString(), 11, look, true),
                        ],
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  write('Sell ', 14, look, true),
                                  FaIcon(
                                    FontAwesomeIcons.exchangeAlt,
                                    color: look,
                                    size: 12,
                                  ),
                                ]),
                          ),
                        ],
                      )
                    ]),
                  ),
                )))
            .toList(),
      ),
    );
  }

  LinearGradient g1() {
    return LinearGradient(
      colors: [
        Colors.orange.shade700,
        Colors.deepOrange.shade700,
        Colors.pinkAccent.shade700,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  LinearGradient g2() {
    return LinearGradient(
      colors: [
        Colors.tealAccent.shade400,
        Colors.teal.shade600,
        Colors.teal.shade800,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  LinearGradient g3() {
    return LinearGradient(
      colors: [
        Colors.lime.shade900,
        Colors.greenAccent.shade700,
        Colors.green.shade800,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  LinearGradient fin(int j) {
    if (j == 1) {
      return g1();
    }
    if (j % 2 == 0) {
      return g2();
    }
    if (j % 3 == 0) {
      return g3();
    }

    return g1();
  }

  Widget sellwindow(String cry, int r, int ind) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.black, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 9,
                  ),
                  FaIcon(FontAwesomeIcons.syncAlt, color: look, size: 25),
                  write('   Sell ' + cry, 26, look, true),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        sell = false;
                      });
                    },
                    icon: Icon(
                      Icons.cancel_sharp,
                      color: Colors.deepOrange.shade900,
                      size: 37,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  write('Rate  ' + r.toString(), 22, look, true),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _quan,
                    decoration: InputDecoration(
                      hintText: 'Enter the Quantity ',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'lato',
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'lato',
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    cal = true;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      write('Calculate  ', 20, Colors.grey.shade200, true),
                      FaIcon(
                        FontAwesomeIcons.calculator,
                        color: look,
                        size: 22,
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    )),
              ),
              const SizedBox(
                height: 24,
              ),
              cal == true
                  ? ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                write(
                                    '  Selling Amount =  ' +
                                        calcul(_quan.text.toString(), r)
                                            .toString() +
                                        "   ",
                                    18,
                                    look,
                                    true),
                                FaIcon(
                                  FontAwesomeIcons.euroSign,
                                  color: look,
                                  size: 22,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            write('Do you want to sell ?', 22, look, true),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await dbHelper.deleteData(ind);
                                  cal = false;
                                  sell = false;

                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          color: Colors.purple.shade900,
                                          child: Container(
                                            height: 180,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey.shade900,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                write(
                                                    'Item Successfully Sold !! Thank You ',
                                                    18,
                                                    look,
                                                    true),
                                                const SizedBox(
                                                  height: 14,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors
                                                              .deepOrange
                                                              .shade900,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          )),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            14.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        write('Close    ', 24,
                                                            look, true),
                                                        FaIcon(
                                                          FontAwesomeIcons
                                                              .solidWindowClose,
                                                          size: 26,
                                                          color: look,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ]),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.greenAccent.shade700,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      write('Confirm ', 16, look, true),
                                      FaIcon(FontAwesomeIcons.solidCheckCircle,
                                          color: look, size: 20)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    cal = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepOrange.shade800,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      write('Cancel ', 16, look, true),
                                      Icon(
                                        Icons.cancel,
                                        color: look,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ])
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bl() {
    return const SizedBox(
      height: 0,
      width: 0,
    );
  }

  int calcul(String q, int r) {
    if (q == "") {
      return 0;
    }
    int j = int.parse(q);
    j = j * r;
    return j;
  }

  Widget aset(int am, String cry, int q, int r) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade900,
              Colors.blueGrey.shade900,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  write(cry + " Purchase ", 20, look, true),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          cry1 = cry;
                          r1 = r;
                          sell = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.greenAccent.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sell,
                            color: look,
                            size: 17,
                          ),
                          write('Sell', 18, look, true),
                        ],
                      )),
                  const SizedBox(
                    width: 5,
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.moneyCheckAlt, size: 16, color: look),
                  write('  Transaction Amount = ' + am.toString(), 18, look,
                      true),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  write('Quantity Purchased ', 18, look, true),
                  FaIcon(FontAwesomeIcons.checkDouble, size: 16, color: look),
                  write(' ' + q.toString(), 18, look, true),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  write('Rate Purchased:   ', 20, look, true),
                  FaIcon(
                    FontAwesomeIcons.euroSign,
                    color: Colors.deepOrange.shade800,
                    size: 18,
                  ),
                  write(
                      ' ' + r.toString(), 24, Colors.deepOrange.shade800, true),
                ],
              )
            ],
          ),
        ),
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

  Widget expenseTile(int value, String note, DateTime date, int index) {
    return InkWell(
      splashColor: Static.PrimaryMaterialColor[400],
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          deleteInfoSnackBar,
        );
      },
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
          context,
          "WARNING",
          "This will delete this record. This action is irreversible. Do you want to continue ?",
        );
        if (answer != null && answer) {
          await dbHelper.deleteData(index);
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(width: 0),
          borderRadius: BorderRadius.circular(10),
          gradient: look != look1
              ? LinearGradient(colors: [
                  Colors.grey.shade900,
                  Colors.grey.shade900,
                ])
              : LinearGradient(colors: [
                  Colors.orange.shade100.withOpacity(0.7),
                  Colors.yellow.shade100.withOpacity(0.8),
                ]),
          boxShadow: [
            BoxShadow(
              color: dark == false ? Colors.grey.shade300 : Colors.black,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_down_outlined,
                          size: 28.0,
                          color: Colors.red.shade900,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        write('Expense', 21, look, true),
                      ],
                    ),

                    //
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: write("${date.day} ${months[date.month - 1]}", 15,
                          look, true),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.euro,
                          size: 24,
                          color: Colors.redAccent.shade700,
                        ),
                        write("- $value", 24, Colors.redAccent.shade700, true),
                      ],
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: write(note, 14, look, true),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget incomeTile(int value, String note, DateTime date, int index) {
    return InkWell(
      splashColor: Static.PrimaryMaterialColor[400],
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          deleteInfoSnackBar,
        );
      },
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
          context,
          "WARNING",
          "This will delete this record. This action is irreversible. Do you want to continue ?",
        );

        if (answer != null && answer) {
          await dbHelper.deleteData(index);
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(width: 0),
          borderRadius: BorderRadius.circular(10),
          gradient: look != look1
              ? LinearGradient(colors: [
                  Colors.grey.shade900,
                  Colors.grey.shade900,
                ])
              : LinearGradient(colors: [
                  Colors.lightGreen.shade100.withOpacity(0.8),
                  Colors.yellow.shade100.withOpacity(0.8),
                ]),
          boxShadow: [
            BoxShadow(
              color: dark == false ? Colors.grey.shade300 : Colors.black,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_circle_up_outlined,
                      size: 28.0,
                      color: look != look1
                          ? Colors.lightGreenAccent.shade400
                          : Colors.greenAccent.shade700,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    write('Credit', 20, look, true),
                  ],
                ),
                //
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: write(
                      "${date.day} ${months[date.month - 1]} ", 15, look, true),
                ),
                //
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.euro,
                      size: 24,
                      color: look != look1
                          ? Colors.lightGreenAccent.shade400
                          : Colors.greenAccent.shade700,
                    ),
                    write(
                        "+ $value",
                        24,
                        look != look1
                            ? Colors.lightGreenAccent.shade400
                            : Colors.greenAccent.shade700,
                        true),
                  ],
                ),
                //
                //
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: write(note, 14, look, true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
