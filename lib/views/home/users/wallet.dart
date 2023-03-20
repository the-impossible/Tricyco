import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedForm.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/components/navigationDrawer.dart';
import 'package:tricycle/utils/constant.dart';

class WalletPage extends StatefulWidget {
  WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Constants.secondaryColor,
        drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 90),
                    DelegatedText(
                        text: 'Wallet', fontSize: 25, fontName: 'InterBold')
                  ],
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        right: 10,
                        left: 10,
                      ),
                      child: Container(
                        width: size.width,
                        height: size.height * .12,
                        decoration: const BoxDecoration(
                            color: Constants.secondaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(221, 207, 203, 203),
                                blurRadius: 5,
                                spreadRadius: 4,
                                offset: Offset(1, 1),
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DelegatedText(
                                text: 'Balance',
                                fontSize: 20,
                                fontName: 'InterMed',
                              ),
                              DelegatedText(
                                text: 'N2000:00',
                                fontSize: 22,
                                fontName: 'InterBold',
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: size.width * .7,
                      top: 30,
                      child: Image.asset(
                        "assets/circle.png",
                        width: 70,
                        height: 70,
                      ),
                    ),
                    Positioned(
                      left: size.width * .75,
                      top: 50,
                      child: const Icon(
                        Icons.money,
                        size: 30,
                        color: Constants.secondaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(221, 207, 203, 203),
                          blurRadius: 5,
                          spreadRadius: 4,
                          offset: Offset(0, 1),
                        )
                      ]),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  height: size.height * .4,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DelegatedText(text: 'Fund Wallet', fontSize: 18),
                        const delegatedForm(
                            fieldName: 'Amount',
                            icon: Icons.monetization_on,
                            hintText: 'Enter the Amount'),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: size.width,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Constants.secondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: DelegatedText(
                                fontSize: 20,
                                text: 'Fund Wallet',
                                color: Constants.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
