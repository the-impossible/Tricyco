import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/components/navigationDrawer.dart';
import 'package:tricycle/controllers/decideRoute.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/utils/constant.dart';
import 'package:tricycle/utils/form_validators.dart';

class DecideRoutePage extends StatelessWidget {
  DecideRoutePage({super.key});

  DecideRouteController decideRouteController =
      Get.put(DecideRouteController());

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    print(Get.parameters['userID']);
    print(Get.parameters['driverID']);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Constants.secondaryColor,
        drawer: const NavigationDrawer(),
        body: Stack(
          children: [
            Image.asset(
              "assets/map.png",
              fit: BoxFit.fill,
              height: size.height,
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 25,
                        ),
                      ),
                      SizedBox(width: size.width * .1),
                      DelegatedText(
                        text: "Decide Route",
                        fontSize: 25,
                        fontName: 'InterBold',
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Constants.secondaryColor,
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
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  height: size.height * .6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        runSpacing: 20,
                        children: [
                          DelegatedText(
                            fontSize: 20,
                            text: 'Current Location',
                            color: Constants.tertiaryColor,
                          ),
                          const SizedBox(height: 20),
                          const FromDropdownMenu(),
                          const SizedBox(height: 20),
                          DelegatedText(
                            fontSize: 20,
                            text: 'Destination Location',
                            color: Constants.tertiaryColor,
                          ),
                          const SizedBox(height: 20),
                          const ToDropdownMenu(),
                          const SizedBox(height: 70),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DelegatedText(
                                text: "Amount.: ",
                                fontSize: 20,
                                fontName: 'InterBold',
                              ),
                              DelegatedText(
                                text: "N100.00",
                                fontSize: 20,
                                fontName: 'InterBold',
                              ),
                            ],
                          ),
                          const SizedBox(height: 70),
                          SizedBox(
                            width: size.width,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (decideRouteController.from !=
                                    decideRouteController.to) {
                                  if (_formKey.currentState!.validate()) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Payment Info'),
                                          content: const Text(
                                              'An amount of N100.00 will be charged from your wallet'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                decideRouteController
                                                    .bookTricycle();
                                              },
                                              child: const Text('Proceed'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(Get.context!)
                                      .showSnackBar(
                                    delegatedSnackBar(
                                        "Current location and destination location can't be the same",
                                        false),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Constants.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: DelegatedText(
                                fontSize: 20,
                                text: 'Proceed to Payment',
                                color: Constants.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<String> locations = [
  'Computer Science Dept',
  'Central Admin',
  'Main Gate',
  'Staff Gate',
  'Library'
];

class FromDropdownMenu extends StatefulWidget {
  const FromDropdownMenu({super.key});

  @override
  State<FromDropdownMenu> createState() => _FromDropdownMenuState();
}

class _FromDropdownMenuState extends State<FromDropdownMenu> {
  DecideRouteController decideRouteController =
      Get.put(DecideRouteController());

  @override
  Widget build(BuildContext context) {
    String? location;

    return DropdownButtonFormField<String>(
      validator: FormValidator.validateLocation,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: Constants.primaryColor,
          ),
        ),
      ),
      value: location,
      hint: const Text('Select Current Location'),
      onChanged: (String? newValue) {
        setState(() {
          location = newValue!;
          decideRouteController.from = newValue;
        });
      },
      items: locations
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

class ToDropdownMenu extends StatefulWidget {
  const ToDropdownMenu({super.key});

  @override
  State<ToDropdownMenu> createState() => _ToDropdownMenuState();
}

class _ToDropdownMenuState extends State<ToDropdownMenu> {
  DecideRouteController decideRouteController =
      Get.put(DecideRouteController());

  @override
  Widget build(BuildContext context) {
    String? location;

    return DropdownButtonFormField<String>(
      validator: FormValidator.validateLocation,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: Constants.primaryColor,
          ),
        ),
      ),
      value: location,
      hint: const Text('Select Destination Location'),
      onChanged: (String? newValue) {
        setState(() {
          location = newValue!;
          decideRouteController.to = newValue;
        });
      },
      items: locations
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
