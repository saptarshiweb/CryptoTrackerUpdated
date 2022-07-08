// not just splash , will ask use for their name here

// ignore_for_file: deprecated_member_use

import 'package:cryptotracker_updated/auth/auth.config.dart';
import 'package:cryptotracker_updated/controllers/db_helper.dart';
import 'package:cryptotracker_updated/pages/TabScreens/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:awesome_card/awesome_card.dart';

import 'package:email_auth/email_auth.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  /// The boolean to handle the dynamic operations
  bool submitValid = false;

  String val = "";

  /// Text editing controllers to get the value from text fields
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();

  // Declare the object
  // ignore: unnecessary_new
  late EmailAuth emailAuth;

  bool isclear = false;
  bool otpenter = false;

  bool email2 = false;

  bool isthere = false;

  bool email = false;
  bool gogle = false;

  bool flipcard = false;

  /// a void function to verify if the Data provided is true
  /// Convert it into a boolean function to match your needs.
  bool verify() {
    var res = (emailAuth.validateOtp(
        recipientMail: _emailcontroller.value.text,
        userOtp: _otpcontroller.value.text));

    return res;
  }

  /// a void funtion to send the OTP to the user
  /// Can also be converted into a Boolean function and render accordingly for providers
  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: _emailcontroller.value.text, otpLength: 5);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }

  //
  DbHelper dbHelper = DbHelper();

  String name = "";

  @override
  void initState() {
    super.initState();

    // ignore: unnecessary_new
    emailAuth = new EmailAuth(
      sessionName: "Sample Session",
    );
    emailAuth.config(remoteServerConfiguration);
    getName();
  }

  Future getName() async {
    String? name = await dbHelper.getName();

    if (name != null) {
      isthere = true;
      val = name;
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => HomePageSingleColor(),
      //   ),
      // );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //

      //
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getName(),
            builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return Center(
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: Colors.white70,
              //         borderRadius: BorderRadius.circular(
              //           12.0,
              //         ),
              //       ),
              //       padding: EdgeInsets.all(
              //         16.0,
              //       ),
              //       child: Image.asset(
              //         "assets/icon.png",
              //         width: 64.0,
              //         height: 64.0,
              //       ),
              //     ),
              //   );
              // }

              if (val != "") {
                return welcome();
              }

              if (isclear == true) {
                return callyou();
              } else {
                if (email == true) {
                  return emailverify();
                } else {
                  return signapp();
                }
              }
            }),
      ),
    );
  }

  Widget welcome() {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                  height: 500,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                          height: 350,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.purple.shade900,
                                    Colors.black,
                                  ]),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'Cryptotracker',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'ale1',
                                  fontSize: 44,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  FaIcon(
                                    FontAwesomeIcons.bitcoin,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.ethereum,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                ],
                              )
                            ],
                          )),
                      Container(
                        color: Colors.white,
                        height: 150,
                        width: double.infinity,
                      ),
                    ],
                  )),
              Positioned(
                bottom: 50,
                child: Container(
                  height: 300,
                  width: 320,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/crypto.jpg'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '    Hello $val  ',
                style: const TextStyle(
                  fontFamily: 'ale1',
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              FaIcon(
                FontAwesomeIcons.handHoldingHeart,
                color: Colors.pink.shade500,
                size: 38,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 80, 0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePagecrypto()));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GlowText(
                      'Start Trading    ',
                      glowColor: Colors.grey.shade400,
                      style: const TextStyle(
                        fontFamily: 'lato',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    GlowIcon(
                      Icons.navigate_next_rounded,
                      color: Colors.white,
                      size: 38,
                      glowColor: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.teal.shade800,
                  onPrimary: Colors.lightGreenAccent.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
          ),
          const SizedBox(
            height: 350,
          ),
        ],
      ),
    );
  }

  Widget signapp() {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 30, 5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.shade800,
                        Colors.pink.shade800,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GlowText(
                            'Login Page   ',
                            glowColor: Colors.grey.shade600,
                            style: const TextStyle(
                              fontFamily: 'ale1',
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.white,
                            ),
                          ),
                          const FaIcon(
                            FontAwesomeIcons.userEdit,
                            color: Colors.white,
                            size: 37,
                          )
                        ]),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  flipcard = !flipcard;
                });
              },
              onDoubleTap: () {
                setState(() {
                  flipcard = !flipcard;
                });
              },
              child: CreditCard(
                  cardNumber: "1234 5678 1234 1234",
                  cardExpiry: "10/25",
                  cardHolderName: "Card Holder",
                  cvv: "456",
                  bankName: "Axis Bank",
                  cardType: CardType
                      .masterCard, // Optional if you want to override Card Type
                  showBackSide: flipcard,
                  frontBackground: CardBackgrounds.black,
                  backBackground: CardBackgrounds.white,
                  showShadow: true,
                  textExpDate: 'Exp. Date',
                  textName: 'Name',
                  textExpiry: 'MM/YY'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                // FaIcon(FontAwesomeIcons.digitalOcean,
                //     color: Colors.purple.shade900, size: 100),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.shade900,
                        Colors.deepPurple.shade900,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(34),
                      topRight: Radius.circular(34),
                    )),
                child: Column(children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 26,
                      ),
                      Text(
                        'Welcome  ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'ale1',
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.handHoldingUsd,
                        color: Colors.white,
                        size: 36,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      write('Manage your Expenses', 22, Colors.white, true),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      write(
                          'Mock Trade CryptoCurrency', 22, Colors.white, true),
                    ],
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              primary: Colors.black,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    write('Sign In ', 16, Colors.white, true),
                                    const FaIcon(
                                      FontAwesomeIcons.signInAlt,
                                      color: Colors.white,
                                      size: 29,
                                    ),
                                  ]),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                email = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              primary: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    write('Sign Up ', 16, Colors.black, true),
                                    const FaIcon(
                                      FontAwesomeIcons.userAlt,
                                      color: Colors.black,
                                      size: 26,
                                    ),
                                  ]),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ]))
          ],
        ));
  }

  Widget callyou() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 80.0,
        ),
        const Center(
          child: Text(
            'CRYPTOTRACKER',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'ale1',
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 120,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.bitcoin,
              color: Colors.deepOrange.shade600,
              size: 100,
            ),
            const SizedBox(
              width: 6,
            ),
            FaIcon(
              FontAwesomeIcons.ethereum,
              color: Colors.purple.shade900,
              size: 100,
            ),
            const SizedBox(
              width: 5,
            ),
            FaIcon(
              FontAwesomeIcons.ccPaypal,
              color: Colors.teal.shade800,
              size: 100,
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        const SizedBox(height: 80),
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),

              const Text(
                "  What should we Call You ?",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'lato',
                  color: Colors.white,
                ),
              ),
              //
              const SizedBox(
                height: 20.0,
              ),
              //
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Your Name",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: 'lato',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade300),
                    maxLength: 12,
                    onChanged: (val) {
                      name = val;
                    },
                  ),
                ),
              ),
              //
              const SizedBox(
                height: 20.0,
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      )),
                  onPressed: () async {
                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                            label: "OK",
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                          ),
                          backgroundColor: Colors.white,
                          content: const Text(
                            "Please Enter a name",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      );
                    } else {
                      DbHelper dbHelper = DbHelper();
                      await dbHelper.addName(name);
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => HomePagecrypto(),
                      //   ),
                      // );

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePagecrypto()));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Let's Start",
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'lato',
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Icon(
                          Icons.send_sharp,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const SizedBox(
          height: 400,
        ),
      ],
    );
  }

  Widget emailverify() {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.purple.shade900,
            Colors.black,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      email = false;
                    });
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.arrowAltCircleLeft,
                    color: Colors.white,
                    size: 34,
                  )),
              const Spacer(),
              write('Register', 25, Colors.white, true),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(children: [
            const SizedBox(
              width: 20,
            ),
            write('Sign Up', 38, Colors.white, true),
          ]),
          const SizedBox(
            height: 10,
          ),
          Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Username ',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'lato',
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'lato',
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 2),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Password ',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'lato',
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'lato',
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Spacer(),
                    write('Forgot Password ?', 18, Colors.black, true),
                    const SizedBox(
                      width: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              write('Sign in', 24, Colors.white, true),
                            ],
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 1, 8, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            setState(() {
                              email2 = true;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.deepOrange.shade900,
                                  size: 25,
                                ),
                                write('  Continue with Google OTP   ', 18,
                                    Colors.black, true),
                                FaIcon(
                                  FontAwesomeIcons.arrowRight,
                                  size: 18,
                                  color: Colors.blueGrey.shade900,
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.teal.shade700,
                                  size: 25,
                                ),
                                write('  Continue with Facebook       ', 18,
                                    Colors.black, true),
                                FaIcon(
                                  FontAwesomeIcons.arrowRight,
                                  size: 18,
                                  color: Colors.blueGrey.shade900,
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                email2 == false
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                write('Complete the Process', 22, Colors.black,
                                    true),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        email2 = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.redAccent.shade700,
                                      size: 28,
                                    )),
                                const SizedBox(
                                  width: 10,
                                )
                              ]),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  write('Email OTP Verification     ', 22,
                                      Colors.black, true),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.userLock,
                                    color: Colors.greenAccent.shade700,
                                    size: 26,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _emailcontroller,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Your Email ',
                                          hintStyle: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19,
                                            fontFamily: 'lato',
                                          ),
                                        ),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'lato',
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  sendOtp();

                                  setState(() {
                                    otpenter = true;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      write('Send OTP   ', 23, Colors.white,
                                          true),
                                      const Icon(
                                        Icons.send_outlined,
                                        color: Colors.white,
                                        size: 24,
                                      )
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.purple.shade900,
                                  onPrimary: Colors.lightGreenAccent.shade700,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                const SizedBox(height: 10),
                otpenter == true
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey.shade200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                )),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              otpenter = false;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Colors.red.shade600,
                                            size: 28,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    write('OTP Verification   ', 25,
                                        Colors.black, true),
                                    Icon(
                                      Icons.verified_sharp,
                                      color: Colors.teal.shade800,
                                      size: 30,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    write('Check your email Id. We have sent ',
                                        14, Colors.blueGrey.shade700, true),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    write('you the OTP at', 14,
                                        Colors.blueGrey.shade700, true),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    write(_emailcontroller.text, 14,
                                        Colors.blueGrey.shade700, true),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _otpcontroller,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Your OTP ',
                                          hintStyle: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: 'lato',
                                          ),
                                        ),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'lato',
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 4, 10, 4),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (verify() == true) {
                                        setState(() {
                                          isclear = true;
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          write('Verify OTP    ', 22,
                                              Colors.white, true),
                                          const Icon(
                                            Icons.verified_user_sharp,
                                            color: Colors.white,
                                            size: 26,
                                          )
                                        ],
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.lightGreenAccent.shade700,
                                      onPrimary: Colors.green.shade900,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                write('Did not receive the code ?', 18,
                                    Colors.blueGrey.shade700, true),
                                Text(
                                  'Re-Send Code',
                                  style: TextStyle(
                                    color: Colors.blueGrey.shade900,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blueGrey.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                    fontFamily: 'lato',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(height: 0, width: 0),
                const SizedBox(
                  height: 100,
                )
              ]))
        ]));
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
