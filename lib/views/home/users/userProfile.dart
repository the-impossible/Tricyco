import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedForm.dart';
import 'package:tricycle/components/delegatedSnackBar.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/components/navigationDrawer.dart';
import 'package:tricycle/controllers/profileController.dart';
import 'package:tricycle/models/user_data.dart';
import 'package:tricycle/services/database.dart';
import 'package:tricycle/utils/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tricycle/utils/form_validators.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File? image;
  DatabaseService databaseService = Get.put(DatabaseService());
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    profileController.emailController.text = databaseService.userData!.email;
    profileController.nameController.text = databaseService.userData!.name;
    profileController.phoneController.text = databaseService.userData!.phone;
    super.initState();
  }

  Future pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      setState(() {
        image = File(pickedFile.path);
        profileController.image = image;
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
        // drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Form(
              key: _formKey,
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
                      StreamBuilder<String?>(
                        stream: databaseService
                            .getImage(FirebaseAuth.instance.currentUser!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(
                                "Something went wrong! ${snapshot.error}");
                          } else if (snapshot.hasData) {
                            return Center(
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
                                      : Image.network(
                                          snapshot.data!,
                                          width: 160,
                                          height: 160,
                                          fit: BoxFit.cover,
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
                        },
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
                  StreamBuilder<UserData?>(
                      stream: databaseService.getUserProfile(
                          FirebaseAuth.instance.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              "Something went wrong! ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Center(
                                  child: DelegatedText(
                                    text: databaseService.userData!.name,
                                    fontSize: 22,
                                    fontName: 'InterBold',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: delegatedForm(
                                  fieldName: 'Full name',
                                  icon: Icons.person,
                                  hintText: 'Enter full name',
                                  validator: FormValidator.validateName,
                                  formController:
                                      profileController.nameController,
                                ),
                              ),
                              delegatedForm(
                                fieldName: 'Email',
                                icon: Icons.mail,
                                hintText: 'Enter Email',
                                validator: FormValidator.validateEmail,
                                formController:
                                    profileController.emailController,
                              ),
                              delegatedForm(
                                fieldName: 'Phone number',
                                icon: Icons.call,
                                hintText: 'Enter phone number',
                                validator: FormValidator.validatePhone,
                                formController:
                                    profileController.phoneController,
                                // editIcon: Icons.edit,
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            profileController.updateAccount();
                          }
                        },
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
      ),
    );
  }
}
