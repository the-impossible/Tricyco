import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/routes/routes.dart';
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
  final user = FirebaseAuth.instance.currentUser!;
  final size = MediaQuery.of(context).size;
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
            CircleAvatar(
              backgroundColor: Constants.primaryColor,
              maxRadius: 50,
              minRadius: 50,
              child: ClipOval(
                child: Image.asset(
                  'assets/user.png',
                  height: 160,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Richard",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w300,
                letterSpacing: 1,
              ),
            ),
            DelegatedText(
              text: user.email.toString(),
              fontSize: 16,
            ),
            const Text(
              "08124235487",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(15),
      child: Wrap(
        runSpacing: 5,
        children: [
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
                    content: const Text('Are you sure you want to log out?'),
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
