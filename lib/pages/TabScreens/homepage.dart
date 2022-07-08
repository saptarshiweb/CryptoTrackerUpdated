// ignore_for_file: library_prefixes, deprecated_member_use

import 'package:cryptotracker_updated/controllers/db_helper.dart';
import 'package:cryptotracker_updated/widgets/confirm_dialog.dart';
import 'package:cryptotracker_updated/widgets/info_snackbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cryptotracker_updated/statics_and_theme/static.dart' as Static;
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageSingleColor extends StatefulWidget {
  const HomePageSingleColor({Key? key}) : super(key: key);

  @override
  _HomePageSingleColorState createState() => _HomePageSingleColorState();
}

class _HomePageSingleColorState extends State<HomePageSingleColor> {
  //
  bool trans = true;
  Color bg = Colors.white;
  Color bg1 = Colors.white;
  Color bg2 = Colors.grey.shade900;
  Color look = Colors.white;
  Color look1 = Colors.black;
  Color look2 = Colors.white;

  bool dark = true;

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
  int temp = 0;
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

  List<FlSpot> getPlotPoints(Map entireData) {
    dataSet = [];
    List tempdataSet = [];
    entireData.forEach((key, value) {
      if (value['type'] == "Expense" &&
          (value['date'] as DateTime).month == today.month) {
        //
        tempdataSet.add({
          'day': (value['date'] as DateTime).day,
          'amount': value['amount']
        });
      }
    });
    //
    // Sorting the list as per the date
    tempdataSet.sort((a, b) => a['day'].compareTo(b['day']));
    //
    for (var i = 0; i < tempdataSet.length; i++) {
      dataSet.add(
        FlSpot(
          tempdataSet[i]['day'].toDouble(),
          tempdataSet[i]['amount'].toDouble(),
        ),
      );
    }
    return dataSet;
  }

  getTotalBalance(Map entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    entireData.forEach((key, value) {
      if (value['type'] == "Income") {
        totalBalance += (value['amount'] as int);
        totalIncome += (value['amount'] as int);
      } else {
        totalBalance -= (value['amount'] as int);
        totalExpense += (value['amount'] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: dark == true ? Colors.black : Colors.white,
        ),
        child: FutureBuilder<Map>(
          future: fetch(),
          builder: (context, snapshot) {
            // print(snapshot.data);
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Oopssss !!! There is some error !",
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return nothing();
              }
              //
              getTotalBalance(snapshot.data!);
              getPlotPoints(snapshot.data!);

              // print(snapshot.data!);
              return ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 12),
                        FaIcon(FontAwesomeIcons.ethereum,
                            color: look, size: 37),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          'CRYPTOTRACKER',
                          style: TextStyle(
                            fontFamily: 'ale1',
                            fontWeight: FontWeight.bold,
                            fontSize: 29,
                            color: look,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (dark == false) {
                                dark = true;
                                look = look2;
                                bg = bg2;
                                all = all2;
                              } else {
                                dark = false;
                                look = look1;
                                bg = bg1;
                                all = all1;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.lightbulb_outline_sharp,
                            size: 38,
                            color: look,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 0, 5),
                    child: Row(
                      children: [
                        const SizedBox(width: 18),
                        write('Hello User   ', 28, look, true),
                        FaIcon(
                          FontAwesomeIcons.handHoldingUsd,
                          color: Colors.orange.shade800,
                          size: 34,
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: walletdisp(),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(
                      12.0,
                    ),
                    child: write("${months[today.month - 1]} ${today.year}", 36,
                        look, true),
                  ),
                  //

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        write('Recent Transactions', 23, look, true),
                        const Spacer(),
                        trans == false
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (trans == true) {
                                      trans = false;
                                    } else {
                                      trans = true;
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_drop_down_circle_sharp,
                                  color: Colors.lightGreenAccent.shade700,
                                  size: 36,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (trans == true) {
                                      trans = false;
                                    } else {
                                      trans = true;
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.cancel_presentation_outlined,
                                  color: Colors.deepOrangeAccent.shade400,
                                  size: 36,
                                ),
                              ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  //
                  trans == false
                      ? const SizedBox(
                          height: 0,
                          width: 0,
                        )
                      : ListView.builder(
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
                            if (dataAtIndex['type'] == "Income") {
                              return Slidable(
                                startActionPane: ActionPane(
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: dono,
                                        backgroundColor:
                                            Colors.deepOrange.shade800,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                      SlidableAction(
                                        onPressed: dono,
                                        backgroundColor: Colors.teal.shade700,
                                        foregroundColor: Colors.white,
                                        icon: Icons.share_sharp,
                                        label: 'Share',
                                      ),
                                    ]),
                                endActionPane: ActionPane(
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: dono,
                                        backgroundColor: Colors.purple.shade800,
                                        foregroundColor: Colors.white,
                                        icon: Icons.archive,
                                        label: 'Archive',
                                      ),
                                    ]),
                                child: incomeTile(
                                  dataAtIndex['amount'],
                                  dataAtIndex['note'],
                                  dataAtIndex['date'],
                                  index,
                                ),
                              );
                            } else {
                              return Slidable(
                                startActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: dono,
                                      backgroundColor:
                                          Colors.deepOrange.shade800,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                    SlidableAction(
                                      onPressed: dono,
                                      backgroundColor: Colors.teal.shade700,
                                      foregroundColor: Colors.white,
                                      icon: Icons.share_sharp,
                                      label: 'Share',
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: dono,
                                        backgroundColor: Colors.purple.shade800,
                                        foregroundColor: Colors.white,
                                        icon: Icons.archive,
                                        label: 'Archive',
                                      ),
                                    ]),
                                child: expenseTile(
                                  dataAtIndex['amount'],
                                  dataAtIndex['note'],
                                  dataAtIndex['date'],
                                  index,
                                ),
                              );
                            }
                          },
                        ),
                  //
                  const SizedBox(
                    height: 60.0,
                  ),
                ],
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

  void dono(BuildContext context) {}

  Widget walletdisp() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            gradient: dark == true ? walletdark() : walletlight(),
            border: Border.all(width: 0),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: dark == false
                    ? Colors.grey.withOpacity(0.5)
                    : Colors.black45,
                spreadRadius: 3,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  write('Total Balance', 27, look, true),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.euro_sharp,
                    color: look,
                    size: 29,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  write(totalBalance.toString(), 27, look, true),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(
                    Icons.upgrade_rounded,
                    size: 42,
                    color: Colors.lightGreenAccent.shade700,
                  ),
                  Column(
                    children: [
                      write('Income', 20, look, false),
                      write(totalIncome.toString(), 22, look, true),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    Icons.downloading_rounded,
                    size: 42,
                    color: Colors.redAccent.shade700,
                  ),
                  Column(
                    children: [
                      write('Expense', 20, look, false),
                      write(totalExpense.toString(), 22, look, true),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  LinearGradient alldark() {
    return LinearGradient(colors: [
      Colors.black,
      Colors.deepPurple.shade900,
      Colors.black,
    ], begin: Alignment.topLeft, end: Alignment.bottomRight);
  }

  LinearGradient alllight() {
    return const LinearGradient(colors: [
      Colors.white,
      Colors.white,
    ], begin: Alignment.topLeft, end: Alignment.bottomRight);
  }

  LinearGradient walletdark() {
    return LinearGradient(
      colors: [Colors.teal.shade400, Colors.purple.shade800],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  LinearGradient walletlight() {
    return const LinearGradient(
      colors: [
        Colors.pinkAccent,
        Colors.deepOrangeAccent,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
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

  Widget nothing() {
    return const Center(
      child: Text(
        "You haven't added Any Data !",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 28,
          fontFamily: 'ale1',
        ),
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

  void del(BuildContext context, int index) async {
    bool? answer = await showConfirmDialog(
      context,
      "WARNING",
      "This will delete this record. This action is irreversible. Do you want to continue ?",
    );
    if (answer != null && answer) {
      await dbHelper.deleteData(index);
      setState(() {});
    }
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
