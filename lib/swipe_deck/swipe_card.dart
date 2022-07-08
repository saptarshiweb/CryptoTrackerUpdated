import 'package:cryptotracker_updated/controllers/db_helper.dart';
import 'package:cryptotracker_updated/models/deckdata.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_deck/swipe_deck.dart';

class SwipeCard extends StatefulWidget {
  const SwipeCard({Key? key}) : super(key: key);

  @override
  _SwipeCardState createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  late Box box;
  late SharedPreferences preferences;
  DbHelper dbHelper = DbHelper();
  Map? data;

  List<DeckData> display = [];

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

  List<Container> card = [];

  var c = ['he', 'hh', 'hhhf', 'iui', 'Hello', 'okvr', 'hgjhjh', 'huggu'];

  getvalues(Map entiredata) {
    entiredata.forEach((key, value) {
      if (value['crypto'] != '') {
        card.add(carddesign(value['crypto'], value['buyorsell'], value['quant'],
            value['rate'], value['amount'], l1()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: FutureBuilder<Map>(
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
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "You haven't added Any Data !",
                ),
              );
              // }

            }
            getvalues(snapshot.data!);

            return ListView(
              children: [
                const SizedBox(height: 14),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.fullscreen_exit_outlined,
                        color: Colors.black,
                        size: 38,
                      ),
                    ),
                    const SizedBox(width: 14),
                    write('Detailed Transactions', 26, Colors.black, true),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                deck(),
              ],
            );
          } else {
            return const Text(
              "Loading...",
            );
          }
        },
      ),
    );
  }

  Widget deck() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: SwipeDeck(
        aspectRatio: 1,
        startIndex: 3,
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
        widgets: card
            .map((e) => GestureDetector(
                onTap: () {
                  // ignore: avoid_print
                  print(e);
                },
                // ignore: sized_box_for_whitespace
                child: Container(
                  height: 400,
                  width: 400,
                  child: e,
                )))
            .toList(),
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

  Container carddesign(String crypto, String buysell, int quant, int rate,
      int total, LinearGradient l) {
    return Container(
      decoration: BoxDecoration(
        gradient: l,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            write(crypto + " " + buysell, 22, Colors.white, true),
            write('Quantity Purchased ' + quant.toString(), 22, Colors.white,
                true),
            write('Rate ' + rate.toString(), 22, Colors.white, true),
          ],
        ),
      ),
    );
  }

  LinearGradient l1() {
    return LinearGradient(
      colors: [
        Colors.purple,
        Colors.purple.shade800,
        Colors.deepPurple.shade800
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
