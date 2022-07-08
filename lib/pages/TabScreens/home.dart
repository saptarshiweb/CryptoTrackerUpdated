import 'package:cryptotracker_updated/pages/TabScreens/homepage.dart';
import 'package:cryptotracker_updated/pages/TabScreens/homescreen.dart';
import 'package:cryptotracker_updated/pages/TabScreens/market.dart';
import 'package:cryptotracker_updated/pages/TabScreens/settings.dart';
import 'package:cryptotracker_updated/widgets/add_transaction2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePagecrypto extends StatefulWidget {
  static bool dark = true;

  const HomePagecrypto({Key? key}) : super(key: key);

  @override
  _HomePagecryptoState createState() => _HomePagecryptoState();
}

class _HomePagecryptoState extends State<HomePagecrypto> {
  Color bg = Colors.white;
  Color bg1 = Colors.white;
  Color bg2 = Colors.grey.shade900;
  Color look = Colors.black;
  Color look1 = Colors.black;
  Color look2 = Colors.white;

  Color all = Colors.grey.shade100;
  Color all1 = Colors.blueGrey.shade300;
  Color all2 = Colors.black;

  int _pageIndex = 0;
  late PageController _pageController;

  List<Widget> tabPages = [
    const Homescreen(),
    const HomePageSingleColor(),
    const Marketscreen(),
    const Settings(),
  ];

  get dark => null;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        selectedItemColor: dark == false
            ? Colors.deepPurple.shade900
            : Colors.purpleAccent.shade700,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(fontFamily: 'lato', fontSize: 12),
        selectedLabelStyle: TextStyle(
            fontFamily: 'lato',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: dark == true
                ? Colors.deepPurple.shade800
                : Colors.lightGreenAccent.shade400),
        unselectedItemColor: dark == false ? Colors.black : Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const FaIcon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.home,
                size: 28,
              ),
              backgroundColor: dark == false ? Colors.white : Colors.black,
              label: 'Home'),
          BottomNavigationBarItem(
              icon: const FaIcon(
                FontAwesomeIcons.userShield,
                size: 28,
              ),
              backgroundColor: dark == false ? Colors.white : Colors.black,
              label: 'PortFolio'),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.price_change,
                size: 30,
              ),
              backgroundColor: dark == false ? Colors.white : Colors.black,
              label: 'Market'),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.settings,
                size: 30,
              ),
              backgroundColor: dark == false ? Colors.white : Colors.black,
              label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        focusElevation: 0,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: Colors.black,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade900,
                              Colors.grey.shade900,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              write('    Choose the Options ', 18, Colors.white,
                                  true),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.deepOrange.shade600,
                                    size: 26,
                                  )),
                              const SizedBox(
                                width: 6,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      const isAuthenticated = true;

                                      if (isAuthenticated) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePageSingleColor()),
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          write('Authenticate ', 30,
                                              Colors.white, true),
                                          const Icon(Icons.lock_open_outlined,
                                              color: Colors.white, size: 35)
                                        ],
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blueGrey.shade900,
                                      onPrimary:
                                          Colors.lightGreenAccent.shade400,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(
                                        CupertinoPageRoute(
                                          builder: (context) => const Transact(
                                            cash: 0,
                                            note1: '',
                                            expense: false,
                                            crypto: '',
                                            buyorsell: '',
                                            quantity: 0,
                                            rate: 0,
                                          ),
                                        ),
                                      )
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          write('   Trade   ', 30, Colors.white,
                                              true),
                                          const Icon(
                                            Icons
                                                .account_balance_wallet_outlined,
                                            color: Colors.white,
                                            size: 32,
                                          ),
                                        ],
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blueGrey.shade900,
                                      onPrimary:
                                          Colors.lightGreenAccent.shade400,
                                    )),
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
        child: FaIcon(
          // ignore: deprecated_member_use
          FontAwesomeIcons.exchangeAlt,
          size: 32,
          color: dark == false ? Colors.white : Colors.white,
        ),
        backgroundColor: dark == false
            ? Colors.deepPurple.shade900
            : Colors.deepOrange.shade900,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,

      body: PageView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut);
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
