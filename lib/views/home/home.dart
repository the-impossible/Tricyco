import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/components/navigationDrawer.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/utils/constant.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
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
          child: Column(
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
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 14,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Get.toNamed(Routes.kekeDetails),
                                child: Card(
                                  margin: const EdgeInsets.only(top: 15),
                                  color: Constants.primaryColor,
                                  child: ListTile(
                                    leading: Image.asset("assets/keke.jpeg"),
                                    title: DelegatedText(
                                      text: "Driver",
                                      fontSize: 18,
                                    ),
                                    subtitle: DelegatedText(
                                        text: "4 Seats", fontSize: 12),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                  ),
                                ),
                              );
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
      ),
    );
  }
}
