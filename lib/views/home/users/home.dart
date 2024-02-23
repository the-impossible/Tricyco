import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/components/navigationDrawer.dart';
import 'package:tricycle/controllers/tricycleDetailsController.dart';
import 'package:tricycle/models/tricycle_data.dart';
import 'package:tricycle/services/database.dart';
import 'package:tricycle/utils/constant.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  DatabaseService databaseService = Get.put(DatabaseService());

  TricycleDetailsController tricycleDetailsController =
      Get.put(TricycleDetailsController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Constants.secondaryColor,
        drawer: const DelegatedNavigationDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => scaffoldKey.currentState!.openDrawer(),
                  icon: const Icon(
                    Icons.menu,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 30),
                DelegatedText(
                  text: "Available Tricycle",
                  fontSize: 25,
                  fontName: 'InterBold',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: SizedBox(
                height: size.height * .8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DelegatedText(
                      text: 'Select Ride',
                      fontSize: 20,
                      fontName: 'InterBold',
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: StreamBuilder<List<TricycleData>>(
                          stream: databaseService.readTricycleData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                  "Something went wrong! ${snapshot.error}");
                            } else if (snapshot.hasData) {
                              final tricycleDataList = snapshot.data!;
                              if (tricycleDataList.isNotEmpty) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: tricycleDataList.length,
                                  itemBuilder: (context, index) {
                                    final tricycleData =
                                        tricycleDataList[index];
                                    return InkWell(
                                      onTap: () => {
                                        tricycleDetailsController.driverID =
                                            tricycleData.id,
                                        tricycleDetailsController
                                            .getTricycleDetails()
                                      },
                                      child: Card(
                                        margin: const EdgeInsets.only(top: 15),
                                        color: Constants.primaryColor,
                                        child: ListTile(
                                          leading:
                                              Image.asset("assets/keke.jpeg"),
                                          title: DelegatedText(
                                            text: tricycleData.plateNumber,
                                            fontSize: 18,
                                          ),
                                          subtitle: DelegatedText(
                                              text:
                                                  "${tricycleData.pass} Seats left",
                                              fontSize: 12),
                                          trailing: const Icon(
                                              Icons.arrow_forward_ios_rounded),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: DelegatedText(
                                        text: "No available Tricycle",
                                        fontSize: 20),
                                  ),
                                );
                              }
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
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
    );
  }
}
