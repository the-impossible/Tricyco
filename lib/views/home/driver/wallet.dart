import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedForm.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/components/navigationDrawer.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/utils/constant.dart';
import 'package:tricycle/utils/form_validators.dart';

class DriverWallet extends StatelessWidget {
  DriverWallet({super.key});

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
                                text: 'Earnings',
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
                        Icons.monetization_on,
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
                  height: size.height * .65,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DelegatedText(text: 'Disburse Funds', fontSize: 18),
                        const delegatedForm(
                          fieldName: 'Amount',
                          icon: Icons.monetization_on,
                          hintText: 'Enter the Amount',
                        ),
                        const delegatedForm(
                          fieldName: 'Account Number',
                          icon: Icons.numbers,
                          hintText: 'Enter Account Number',
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: BankNamesDropdownMenu(),
                        ),
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
                                text: 'Withdraw Funds',
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

class BankNamesDropdownMenu extends StatefulWidget {
  const BankNamesDropdownMenu({super.key});

  @override
  State<BankNamesDropdownMenu> createState() => _BankNamesDropdownMenuState();
}

List<String> bankNames = [
  'Access Bank Plc',
  'Fidelity Bank Plc',
  'First City Monument Bank Limited',
  'First Bank of Nigeria Limited',
  'Guaranty Trust Holding Company Plc',
  'Union Bank of Nigeria Plc,',
  'United Bank for Africa Plc',
  'Citibank Nigeria Limited',
  'Ecobank Nigeria',
  'Heritage Bank Plc',
  'Keystone Bank Limited',
  'Polaris Bank Limited',
  'Stanbic IBTC Bank Plc',
  'Standard Chartered',
  'Sterling Bank Plc',
  'Titan Trust bank',
  'Unity Bank Plc',
  'Wema Bank Plc',
];

class _BankNamesDropdownMenuState extends State<BankNamesDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    String? userType;

    return DropdownButtonFormField<String>(
      validator: FormValidator.validateBankNames,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Constants.secondaryColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: Constants.secondaryColor,
          ),
        ),
        fillColor: Constants.secondaryColor,
        // filled: true,
      ),
      value: userType,
      hint: const Text('Select Bank Name'),
      onChanged: (String? newValue) {
        setState(() {
          userType = newValue!;
        });
      },
      items: bankNames
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
    );
  }
}
