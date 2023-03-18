import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedForm.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/components/navigationDrawer.dart';
import 'package:tricycle/routes/routes.dart';
import 'package:tricycle/utils/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tricycle/utils/form_validators.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File? image;

  Future pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      setState(() {
        image = File(pickedFile.path);
      });
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          delegatedSnackBar("Failed to Capture image: $e", false));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Constants.secondaryColor,
        drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 25,
                  ),
                ),
                Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        maxRadius: 60,
                        minRadius: 60,
                        child: ClipOval(
                          child: (image != null)
                              ? Image.file(
                                  image!,
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/user.png',
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                                  // colorBlendMode: BlendMode.darken,
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 90,
                        left: 80,
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            pickImage();
                          },
                          child: const CircleAvatar(
                            backgroundColor: Constants.primaryColor,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Constants.tertiaryColor,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: DelegatedText(
                      text: "User Name",
                      fontSize: 22,
                      fontName: 'InterBold',
                    ),
                  ),
                ),
                const delegatedForm(
                  fieldName: 'Full name',
                  icon: Icons.person,
                  hintText: 'Enter full name',
                  editIcon: Icons.edit,
                ),
                const delegatedForm(
                  fieldName: 'Email',
                  icon: Icons.mail,
                  hintText: 'Enter Email',
                  editIcon: Icons.edit,
                ),
                const delegatedForm(
                  fieldName: 'Phone number',
                  icon: Icons.call,
                  hintText: 'Enter phone number',
                  // editIcon: Icons.edit,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Constants.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: DelegatedText(
                        fontSize: 18,
                        text: 'Save changes',
                        color: Constants.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
