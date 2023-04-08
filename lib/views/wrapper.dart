import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/services/database.dart';
import 'package:tricycle/utils/loading.dart';
import 'package:tricycle/views/auth/authenticate.dart';
import 'package:tricycle/views/home/driver/driverHome.dart';
import 'package:tricycle/views/home/users/home.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  DatabaseService databaseService = Get.put(DatabaseService());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return Center(
            child: DelegatedText(
              text: 'Something went wrong!',
              fontSize: 20,
            ),
          );
        } else if (snapshot.hasData) {
          // check for the userType (userType == Driver)? (Driver.hasProfile)? DriverHomepage : UpdateProfile : Homepage
          final userId = FirebaseAuth.instance.currentUser!.uid;
          databaseService.uid = userId;
          return FutureBuilder(
              future: databaseService.getUserType(userId),
              builder: (context, AsyncSnapshot<String> userTypeSnapshot) {
                if (userTypeSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Loading();
                } else if (userTypeSnapshot.hasError) {
                  return Center(
                    child: DelegatedText(
                      text: 'Something went wrong!',
                      fontSize: 20,
                    ),
                  );
                } else {
                  String userType = userTypeSnapshot.data!;
                  if (userType == 'Driver') {
                    return DriverHomePage();
                  }
                  return HomePage();
                }
              });
        } else {
          return const Authenticate();
        }
      },
    );
  }
}
