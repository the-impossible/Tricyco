import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/components/navigationDrawer.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/utils/constant.dart';

class BookingStatusPage extends StatelessWidget {
  BookingStatusPage({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Constants.secondaryColor,
        drawer: const NavigationDrawer(),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 30),
                      DelegatedText(
                        text: "Booking Status",
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
                  height: size.height * .7,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 20,
                      children: [
                        Image.asset(
                          'assets/keke.jpeg',
                          width: 200,
                          height: 200,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DelegatedText(
                              text: "Status.: ",
                              fontSize: 20,
                              fontName: 'InterBold',
                            ),
                            DelegatedText(
                              text: "Pending",
                              fontSize: 18,
                              fontName: 'InterBold',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DelegatedText(
                              text: "From.: ",
                              fontSize: 20,
                              fontName: 'InterBold',
                            ),
                            DelegatedText(
                              text: "Central Admin",
                              fontSize: 18,
                              fontName: 'InterBold',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DelegatedText(
                              text: "To.: ",
                              fontSize: 20,
                              fontName: 'InterBold',
                            ),
                            DelegatedText(
                              text: "Computer Science",
                              fontSize: 18,
                              fontName: 'InterBold',
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        DelegatedText(
                          fontSize: 17,
                          text: 'Your ride will start soon',
                          color: Constants.tertiaryColor,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => Get.offNamed(Routes.history),
                            style: ElevatedButton.styleFrom(
                              primary: Constants.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: DelegatedText(
                              fontSize: 20,
                              text: 'View History',
                              color: Constants.secondaryColor,
                            ),
                          ),
                        ),
                      ],
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
