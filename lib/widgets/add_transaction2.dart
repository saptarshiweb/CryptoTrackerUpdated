import 'package:cryptotracker_updated/controllers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: library_prefixes
import 'package:cryptotracker_updated/statics_and_theme/static.dart' as Static;

class Transact extends StatefulWidget {
  final double cash;
  final String note1;
  final bool expense;

  final String crypto;
  final String buyorsell;
  final int quantity;
  final int rate;

  const Transact({
    Key? key,
    required this.cash,
    required this.note1,
    required this.expense,
    required this.crypto,
    required this.buyorsell,
    required this.quantity,
    required this.rate,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _TransactState createState() =>
      // ignore: no_logic_in_create_state
      _TransactState(cash, note1, expense, crypto, buyorsell, quantity, rate);
}

class _TransactState extends State<Transact> {
  DateTime selectedDate = DateTime.now();
  int? amount;
  String note = "Expense";
  String type = "Income";

  double cash;
  String note1;
  bool expense;

  String crypto;
  String buyorsell;
  int quantity;
  int rate;

  _TransactState(this.cash, this.note1, this.expense, this.crypto,
      this.buyorsell, this.quantity, this.rate);

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),

      //
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.orangeAccent.shade100.withOpacity(0.8),
            Colors.purpleAccent.shade100.withOpacity(0.6),
            Colors.deepPurpleAccent.shade100.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: ListView(
          padding: const EdgeInsets.all(
            12.0,
          ),
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.arrowAltCircleLeft,
                      color: Colors.black,
                      size: 35,
                    )),
                const Text(
                  "Add Transaction",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            //
            const SizedBox(
              height: 20.0,
            ),
            //
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent.shade700,
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                  ),
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  child: const Icon(
                    Icons.euro_sharp,
                    size: 24.0,
                    // color: Colors.grey[700],
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                crypto == ''
                    ? Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "0",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 24.0,
                          ),
                          onChanged: (val) {
                            try {
                              amount = int.parse(val);
                            } catch (e) {
                              // show Error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  duration: const Duration(
                                    seconds: 2,
                                  ),
                                  content: Row(
                                    children: const [
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        "Enter only Numbers as Amount",
                                        style: TextStyle(
                                          fontSize: 16.0,
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
                      )
                    : write(cash.toString(), 18, Colors.black, true),
              ],
            ),
            //
            const SizedBox(
              height: 20.0,
            ),
            //
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade900,
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                  ),
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  child: const Icon(
                    Icons.note_add_sharp,
                    size: 24.0,
                    // color: Colors.grey[700],
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                expense == false
                    ? Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Note on Transaction",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                          onChanged: (val) {
                            note = val;
                          },
                        ),
                      )
                    : Container(
                        child: write(note1, 20, Colors.grey.shade800, true),
                      )
              ],
            ),
            //
            const SizedBox(
              height: 20.0,
            ),
            //
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade900,
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                  ),
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet,
                    size: 24.0,
                    // color: Colors.grey[700],
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                crypto == ''
                    ? ChoiceChip(
                        label: Text(
                          "Income",
                          style: TextStyle(
                            fontSize: 18.0,
                            color:
                                type == "Income" ? Colors.white : Colors.black,
                          ),
                        ),
                        selectedColor: Static.PrimaryColor,
                        onSelected: (val) {
                          if (val) {
                            setState(() {
                              type = "Income";
                              if (note.isEmpty || note == "Expense") {
                                note = 'Income';
                              }
                            });
                          }
                        },
                        selected: type == "Income" ? true : false,
                      )
                    : write(
                        '  Expense - Crypto Buy ' +
                            crypto +
                            '\n  Quantity: ' +
                            quantity.toString() +
                            '\n  Rate: ' +
                            rate.toString(),
                        18,
                        Colors.black,
                        true),
                const SizedBox(
                  width: 8.0,
                ),
                crypto == ''
                    ? ChoiceChip(
                        label: Text(
                          "Expense",
                          style: TextStyle(
                            fontSize: 18.0,
                            color:
                                type == "Expense" ? Colors.white : Colors.black,
                          ),
                        ),
                        selectedColor: Static.PrimaryColor,
                        onSelected: (val) {
                          if (val) {
                            setState(() {
                              type = "Expense";

                              if (note.isEmpty || note == "Income") {
                                note = 'Expense';
                              }
                            });
                          }
                        },
                        selected: type == "Expense" ? true : false,
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
              ],
            ),
            //
            const SizedBox(
              height: 20.0,
            ),
            //
            SizedBox(
              height: 50.0,
              child: TextButton(
                onPressed: () {
                  _selectDate(context);
                  //
                  // to make sure that no keyboard is shown after selecting Date
                  FocusScope.of(context).unfocus();
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.zero,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent.shade700,
                        borderRadius: BorderRadius.circular(
                          16.0,
                        ),
                      ),
                      padding: const EdgeInsets.all(
                        12.0,
                      ),
                      child: const Icon(
                        Icons.date_range,
                        size: 24.0,
                        // color: Colors.grey[700],
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "${selectedDate.day} ${months[selectedDate.month - 1]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            const SizedBox(
              height: 20.0,
            ),
            //
            SizedBox(
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  if (expense == true) {
                    note = note1;
                  }
                  if (amount != null) {
                    DbHelper dbHelper = DbHelper();

                    dbHelper.addData(
                        amount!, selectedDate, type, note, '', 0, '', 0);
                    Navigator.of(context).pop();
                  } else if (crypto != '') {
                    DbHelper dbHelper = DbHelper();

                    dbHelper.addData(cash.toInt(), selectedDate, 'Expense',
                        note1, crypto, quantity, buyorsell, rate);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[700],
                        content: const Text(
                          "Please enter a valid Amount !",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: write('Add', 22, Colors.grey.shade800, true),
                style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent.shade400,
                ),
              ),
            ),
          ],
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
}
