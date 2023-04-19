import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/components/navigationDrawer.dart';
import 'package:tricycle/controllers/tricycleDetailsController.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/services/database.dart';
import 'package:tricycle/utils/constant.dart';

class KekeDetailsPage extends StatelessWidget {
  KekeDetailsPage({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TricycleDetailsController tricycleDetailsController =
      Get.put(TricycleDetailsController());

  DatabaseService databaseService = Get.put(DatabaseService());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Constants.secondaryColor,
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
                        text: "Tricycle Details",
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
                  child: Column(
                    children: [
                      StreamBuilder<String?>(
                          stream: databaseService
                              .getImage(FirebaseAuth.instance.currentUser!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                  "Something went wrong! ${snapshot.error}");
                            } else if (snapshot.hasData) {
                              return SizedBox(
                                width: 400,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40.0, bottom: 40),
                                  child: ClipOval(
                                    child: Image.network(
                                      snapshot.data!,
                                      width: 160,
                                      height: 160,
                                      // colorBlendMode: BlendMode.darken,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                      DelegatedText(
                        text: tricycleDetailsController.driverData!.name,
                        fontSize: 20,
                        fontName: 'InterBold',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DelegatedText(
                              text: "Plate No.: ",
                              fontSize: 20,
                              fontName: 'InterBold',
                            ),
                            DelegatedText(
                              text: tricycleDetailsController
                                  .tricycleData!.plateNumber,
                              fontSize: 20,
                              fontName: 'InterBold',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DelegatedText(
                              text: "Seat Left.: ",
                              fontSize: 20,
                              fontName: 'InterBold',
                            ),
                            const SizedBox(width: 20),
                            DelegatedText(
                              text: tricycleDetailsController.tricycleData!.pass
                                  .toString(),
                              fontSize: 20,
                              fontName: 'InterBold',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 70),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              var data = {
                                'driverID': tricycleDetailsController.driverID,
                                'userID': FirebaseAuth.instance.currentUser!.uid
                              };
                              Get.offNamed(Routes.decideRoute,
                                  parameters: data);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Constants.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: DelegatedText(
                              fontSize: 20,
                              text: 'Book Ride',
                              color: Constants.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
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
