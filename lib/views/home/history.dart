import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/components/navigationDrawer.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/utils/constant.dart';
import 'package:tricycle/utils/form_validators.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

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
                    SizedBox(width: size.width * .2),
                    DelegatedText(
                      text: "History",
                      fontSize: 25,
                      fontName: 'InterBold',
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Get.offNamed(Routes.bookingStatus),
                    child: Card(
                      margin: const EdgeInsets.only(
                        top: 15,
                        right: 20,
                        left: 20,
                      ),
                      color: Constants.primaryColor,
                      child: ListTile(
                        leading: Image.asset("assets/tricycle.png"),
                        title: DelegatedText(
                          text:
                              "A ride from main gate to computer science dept",
                          fontSize: 18,
                        ),
                        subtitle: DelegatedText(
                            text: "Status: Pending", fontSize: 16),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> locations = [
  'Computer Science Dept',
  'Central Admin',
  'Main Gate',
  'Staff Gate',
  'Library'
];

class FromDropdownMenu extends StatefulWidget {
  const FromDropdownMenu({super.key});

  @override
  State<FromDropdownMenu> createState() => _FromDropdownMenuState();
}

class _FromDropdownMenuState extends State<FromDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    String? location;

    return DropdownButtonFormField<String>(
      validator: FormValidator.validateLocation,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: Constants.primaryColor,
          ),
        ),
      ),
      value: location,
      hint: const Text('Select Current Location'),
      onChanged: (String? newValue) {
        setState(() {
          location = newValue!;
        });
      },
      items: locations
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
    );
  }
}

class ToDropdownMenu extends StatefulWidget {
  const ToDropdownMenu({super.key});

  @override
  State<ToDropdownMenu> createState() => _ToDropdownMenuState();
}

class _ToDropdownMenuState extends State<ToDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    String? location;

    return DropdownButtonFormField<String>(
      validator: FormValidator.validateLocation,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: Constants.primaryColor,
          ),
        ),
      ),
      value: location,
      hint: const Text('Select Destination Location'),
      onChanged: (String? newValue) {
        setState(() {
          location = newValue!;
        });
      },
      items: locations
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
    );
  }
}
