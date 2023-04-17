import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/models/user_data.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/services/database.dart';
import 'package:tricycle/utils/constant.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Constants.primaryColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) {
  final size = MediaQuery.of(context).size;
  DatabaseService databaseService = Get.put(DatabaseService());
  return Material(
    color: Constants.secondaryColor,
    child: InkWell(
      onTap: () {
        Navigator.pop(context);

        Get.toNamed(Routes.userProfile);
      },
      child: Container(
        padding: EdgeInsets.only(
          top: size.height * .05,
          bottom: size.height * .05,
          left: size.width * .1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<String?>(
                stream: databaseService
                    .getImage(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong! ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return CircleAvatar(
                      backgroundColor: Constants.primaryColor,
                      maxRadius: 50,
                      minRadius: 50,
                      child: ClipOval(
                        child: Image.network(
                          snapshot.data!,
                          height: 160,
                          width: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            StreamBuilder<UserData?>(
              stream: databaseService
                  .getUserProfile(FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong! ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        snapshot.data!.name,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1,
                        ),
                      ),
                      DelegatedText(
                        text: snapshot.data!.email,
                        fontSize: 16,
                      ),
                      Text(
                        snapshot.data!.phone,
                        style: const TextStyle(
                          fontSize: 16,
                          letterSpacing: 1,
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
          ],
        ),
      ),
    ),
  );
}

Widget buildMenuItems(BuildContext context) {
  DatabaseService databaseService = Get.put(DatabaseService());
  return Container(
    padding: const EdgeInsets.all(15),
    child: Wrap(
      runSpacing: 5,
      children: (databaseService.userData!.userType != 'Driver')
          ? [
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Get.offNamed(Routes.home);
                },
              ),
              ListTile(
                leading: const Icon(Icons.wallet),
                title: const Text('Wallet'),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(Routes.wallet);
                },
              ),
              ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('History'),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(Routes.history);
                  }),
              ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Personal Details'),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(Routes.userProfile);
                  }),
              const Divider(
                color: Colors.black54,
                thickness: 1,
              ),
              ListTile(
                leading: const Icon(Icons.login_rounded),
                title: const Text('Logout'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Log out'),
                        content:
                            const Text('Are you sure you want to log out?'),
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
                              Navigator.pop(context);
                              FirebaseAuth.instance.signOut();
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ]
          : [
              ListTile(
                  leading: const Icon(Icons.drive_eta),
                  title: const Text('Driver Home Page'),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(Routes.driverHomePage);
                  }),
              ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Personal Details'),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(Routes.userProfile);
                  }),
              ListTile(
                  leading: const Icon(Icons.list_rounded),
                  title: const Text('Booking List'),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(Routes.bookingList);
                  }),
              const Divider(
                color: Colors.black54,
                thickness: 1,
              ),
              ListTile(
                leading: const Icon(Icons.login_rounded),
                title: const Text('Logout'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Log out'),
                        content:
                            const Text('Are you sure you want to log out?'),
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
                              Navigator.pop(context);
                              FirebaseAuth.instance.signOut();
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
    ),
  );
}
