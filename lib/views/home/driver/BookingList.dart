import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/utils/constant.dart';

class BookingList extends StatelessWidget {
  const BookingList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Constants.secondaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    const SizedBox(width: 60),
                    DelegatedText(
                      text: 'Booking List',
                      fontSize: 25,
                      fontName: 'InterBold',
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Container(
                        height: size.height * .78,
                        width: size.width * .89,
                        decoration: BoxDecoration(
                          color: Constants.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 25,
                      child: Container(
                        width: size.width * .8,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Constants.secondaryColor,
                        ),
                        child: TabBar(
                          tabs: [
                            DelegatedText(
                              text: 'Requests',
                              fontSize: 20,
                              color: Constants.primaryColor,
                            ),
                            DelegatedText(
                              text: 'Approved',
                              fontSize: 20,
                              color: Constants.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 110,
                      left: 28,
                      child: SizedBox(
                        width: size.width * .8,
                        height: size.height * .65,
                        child: TabBarView(
                          children: [
                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 14,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.driverBookingStatus);
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.only(top: 15),
                                      color: Constants.secondaryColor,
                                      child: ListTile(
                                        title: DelegatedText(
                                          text: "Passenger Name",
                                          fontSize: 18,
                                        ),
                                        subtitle: DelegatedText(
                                            text:
                                                "Destination: Central Administration",
                                            fontSize: 12),
                                        trailing: const Icon(
                                            Icons.arrow_forward_ios_rounded),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 14,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.driverBookingStatus);
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.only(top: 15),
                                      color: Constants.secondaryColor,
                                      child: ListTile(
                                        title: DelegatedText(
                                          text: "Passenger Name",
                                          fontSize: 18,
                                        ),
                                        subtitle: DelegatedText(
                                            text:
                                                "Destination: Central Administration",
                                            fontSize: 12),
                                        trailing: const Icon(
                                            Icons.arrow_forward_ios_rounded),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
