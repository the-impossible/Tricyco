import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/components/delegatedForm.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/controllers/tricycleDataController.dart';
import 'package:tricycle/utils/constant.dart';
import 'package:tricycle/utils/form_validators.dart';

class UpdateTricycleForm extends StatefulWidget {
  const UpdateTricycleForm({super.key});

  @override
  State<UpdateTricycleForm> createState() => _UpdateTricycleFormState();
}

class _UpdateTricycleFormState extends State<UpdateTricycleForm> {
  TricycleDataController tricycleDataController =
      Get.put(TricycleDataController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: DelegatedText(text: "Update Tricycle", fontSize: 20),
            ),
            delegatedForm(
              fieldName: "Plate Number",
              icon: Icons.numbers,
              hintText: "Enter plate Number",
              validator: FormValidator.validatePlateNumber,
              formController: tricycleDataController.plateNumberController,
            ),
            delegatedForm(
              fieldName: "Tricycle Color",
              icon: Icons.numbers,
              hintText: "Enter tricycle color",
              validator: FormValidator.validateTricycleColor,
              formController: tricycleDataController.tricycleColorController,
            ),
            SizedBox(
              width: size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                    // Perform update operation
                    tricycleDataController.updateTricycle();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Constants.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: DelegatedText(
                  fontSize: 20,
                  text: "Update",
                  color: Constants.secondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
