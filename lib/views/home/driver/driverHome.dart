import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/components/navigationDrawer.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/utils/constant.dart';

class DriverHomePage extends StatelessWidget {
  DriverHomePage({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Constants.secondaryColor,
        drawer: const NavigationDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => scaffoldKey.currentState!.openDrawer(),
                icon: const Icon(
                  Icons.menu,
                  size: 25,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.bookingList);
                      },
                      child: Container(
                        height: 200,
                        width: size.width * .42,
                        decoration: BoxDecoration(
                          color: Constants.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.local_taxi,
                              size: 60,
                              color: Constants.secondaryColor,
                            ),
                            DelegatedText(
                              text: '50 Ride \nCompleted',
                              fontSize: 25,
                              align: TextAlign.center,
                              color: Constants.secondaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.driverWallet);
                      },
                      child: Container(
                        height: 200,
                        width: size.width * .42,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 233, 179, 99),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.monetization_on_rounded,
                              size: 60,
                              color: Constants.secondaryColor,
                            ),
                            DelegatedText(
                              text: 'N5000 \nEarnings',
                              fontSize: 25,
                              align: TextAlign.center,
                              color: Constants.secondaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: DelegatedText(
                  text: 'New Booking Request',
                  fontSize: 22,
                  fontName: 'InterBold',
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.driverBookingStatus);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 1,
                            margin: const EdgeInsets.only(top: 15),
                            color: Constants.primaryColor,
                            child: ListTile(
                              title: DelegatedText(
                                text: "User Name",
                                fontSize: 19,
                                fontName: 'InterMed',
                              ),
                              subtitle: DelegatedText(
                                  text: "Main Campus - Computer Science",
                                  fontSize: 14),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 30,
                                color: Constants.secondaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
