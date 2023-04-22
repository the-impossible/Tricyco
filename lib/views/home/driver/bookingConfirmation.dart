import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/components/navigationDrawer.dart';
import 'package:tricycle/controllers/startRide.dart';
import 'package:tricycle/models/bookingList_data.dart';
import 'package:tricycle/models/tricycle_data.dart';
import 'package:tricycle/models/user_data.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/services/database.dart';
import 'package:tricycle/utils/constant.dart';

class DriverBookingConfirmationPage extends StatelessWidget {
  DriverBookingConfirmationPage({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DatabaseService databaseService = Get.put(DatabaseService());
  StartRideController startRideController = Get.put(StartRideController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Constants.secondaryColor,
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
                      const SizedBox(width: 5),
                      DelegatedText(
                        text: "Booking Confirmation",
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
                    ],
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  height: size.height * .7,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 10,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: DelegatedText(
                            text: "All approved bookings",
                            fontSize: 18,
                            fontName: "InterBold",
                          ),
                        ),
                        StreamBuilder<List<BookingList>>(
                          stream: databaseService.getDriverApprovedBookings(
                              FirebaseAuth.instance.currentUser!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                  "Something went wrong! ${snapshot.error}");
                            } else if (snapshot.hasData) {
                              final bookingList = snapshot.data!;
                              if (bookingList.isNotEmpty) {
                                return SizedBox(
                                  height: size.height * .57,
                                  child: Column(
                                    children: [
                                      SingleChildScrollView(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: bookingList.length,
                                          itemBuilder: (context, index) {
                                            final bookingData =
                                                bookingList[index];
                                            return Card(
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              color: Constants.secondaryColor,
                                              child: StreamBuilder<UserData?>(
                                                stream: databaseService
                                                    .getUserProfile(
                                                        bookingData.userID),
                                                builder: (context, futureShot) {
                                                  if (futureShot.hasData) {
                                                    return ListTile(
                                                      onTap: () {
                                                        var data = {
                                                          'docRef':
                                                              bookingData.id!
                                                        };
                                                        Get.toNamed(
                                                            Routes
                                                                .bookingStatus,
                                                            parameters: data);
                                                      },
                                                      title: DelegatedText(
                                                        text: futureShot
                                                            .data!.name,
                                                        fontSize: 18,
                                                      ),
                                                      subtitle: DelegatedText(
                                                          text:
                                                              "Destination: ${bookingData.to}",
                                                          fontSize: 12),
                                                      trailing: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          CircleAvatar(
                                                            maxRadius: 12,
                                                            backgroundColor:
                                                                Constants
                                                                    .primaryColor,
                                                            child:
                                                                DelegatedText(
                                                              text:
                                                                  "${bookingData.seats}",
                                                              fontSize: 17,
                                                              color: Constants
                                                                  .secondaryColor,
                                                            ),
                                                          ),
                                                          const Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            size: 30,
                                                            color: Constants
                                                                .primaryColor,
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const Spacer(),
                                      StreamBuilder<TricycleData?>(
                                        stream: databaseService.getRideStatus(
                                            FirebaseAuth
                                                .instance.currentUser!.uid),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                "Something went wrong! ${snapshot.error}");
                                          } else if (snapshot.hasData) {
                                            return SizedBox(
                                              width: size.width,
                                              height: 50,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  (snapshot.data!.hasStarted
                                                      ? startRideController
                                                          .endRide(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                      : startRideController
                                                          .startRide(
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary:
                                                      Constants.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                child: DelegatedText(
                                                  fontSize: 20,
                                                  text: ((snapshot
                                                          .data!.hasStarted
                                                      ? "End Ride"
                                                      : "Start Ride")),
                                                  color:
                                                      Constants.secondaryColor,
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: DelegatedText(
                                      text: "No approved bookings",
                                      fontSize: 17,
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
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
    );
  }
}
