import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/components/navigationDrawer.dart';
import 'package:tricycle/controllers/approveBookingController.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/services/database.dart';
import 'package:tricycle/utils/constant.dart';
import 'package:tricycle/models/bookingList_data.dart';

class BookingStatusPage extends StatelessWidget {
  BookingStatusPage({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DatabaseService databaseService = Get.put(DatabaseService());
  ApproveBookingController approveBookingController =
      Get.put(ApproveBookingController());

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
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  height: size.height * .7,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: StreamBuilder<Booking?>(
                      stream: databaseService
                          .getBookingStatus(Get.parameters['docRef']),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              "Something went wrong! ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          return Wrap(
                            alignment: WrapAlignment.center,
                            runSpacing: 20,
                            children: [
                              Image.asset(
                                'assets/keke.png',
                                width: 200,
                                height: 200,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DelegatedText(
                                    text: "Status.: ",
                                    fontSize: 20,
                                    fontName: 'InterBold',
                                  ),
                                  DelegatedText(
                                    text: (snapshot.data!.disapprove)
                                        ? "Disapproved"
                                        : (snapshot.data!.status)
                                            ? "Approved"
                                            : "Pending",
                                    fontSize: 18,
                                    fontName: 'InterBold',
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DelegatedText(
                                    text: "From.: ",
                                    fontSize: 20,
                                    fontName: 'InterBold',
                                  ),
                                  Flexible(
                                    child: DelegatedText(
                                      text: snapshot.data!.from,
                                      fontSize: 18,
                                      fontName: 'InterBold',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DelegatedText(
                                    text: "To.: ",
                                    fontSize: 20,
                                    fontName: 'InterBold',
                                  ),
                                  Flexible(
                                    child: DelegatedText(
                                      text: snapshot.data!.to,
                                      fontSize: 18,
                                      fontName: 'InterBold',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DelegatedText(
                                    text: "Seats.: ",
                                    fontSize: 20,
                                    fontName: 'InterBold',
                                  ),
                                  Flexible(
                                    child: DelegatedText(
                                      text: snapshot.data!.seats.toString(),
                                      fontSize: 18,
                                      fontName: 'InterBold',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              DelegatedText(
                                fontSize: 17,
                                text: (snapshot.data!.disapprove)
                                    ? "Your ride has been canceled"
                                    : (snapshot.data!.status)
                                        ? "Your ride will start soon"
                                        : "Your ride is pending approval",
                                color: Constants.tertiaryColor,
                              ),
                              const SizedBox(height: 30),
                              (databaseService.userData!.userType == 'Driver')
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * .32,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              approveBookingController.seats =
                                                  snapshot.data!.seats;
                                              if (snapshot.data!.disapprove !=
                                                      true &&
                                                  snapshot.data!.status !=
                                                      true) {
                                                approveBookingController
                                                    .disapproveStatus(Get
                                                        .parameters['docRef']!);
                                              } else {
                                                ScaffoldMessenger.of(
                                                        Get.context!)
                                                    .showSnackBar(
                                                  delegatedSnackBar(
                                                      "You can only cancel pending ride",
                                                      false),
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Constants.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: DelegatedText(
                                              fontSize: 20,
                                              text: ('Cancel'),
                                              color: Constants.secondaryColor,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: size.width * .32,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              approveBookingController.seats =
                                                  snapshot.data!.seats;
                                              if (snapshot.data!.status !=
                                                  true) {
                                                approveBookingController
                                                    .approveStatus(Get
                                                        .parameters['docRef']!);
                                              } else {
                                                ScaffoldMessenger.of(
                                                        Get.context!)
                                                    .showSnackBar(
                                                  delegatedSnackBar(
                                                      "Already Approved",
                                                      false),
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Constants.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: DelegatedText(
                                              fontSize: 20,
                                              text: (databaseService
                                                          .userData!.userType ==
                                                      'Driver')
                                                  ? 'Approve'
                                                  : 'View History',
                                              color: Constants.secondaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(
                                      width: size.width,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.offNamed(Routes.history);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Constants.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: DelegatedText(
                                          fontSize: 20,
                                          text: ('History'),
                                          color: Constants.secondaryColor,
                                        ),
                                      ),
                                    ),
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
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
