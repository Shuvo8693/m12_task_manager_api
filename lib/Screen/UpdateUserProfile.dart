import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m12_task_manager_api/Data/Auth_Controller/auth_controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/userProfileController.dart';
import '../Widget/Profile_summery.dart';
import '../Widget/background_picture.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserProfileController userProfileController =
      Get.find<UserProfileController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    userProfileController.emailTEController.text = authController.user?.email ?? '';
    userProfileController.firstNameTEController.text = authController.user?.firstName ?? '';
    userProfileController.lastNameTEController.text = authController.user?.lastName ?? '';
    userProfileController.phoneNumberTEController.text = authController.user?.mobile ?? '';
  }

  XFile? photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundBody(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 70,
                  color: Colors.green,
                  child: const ProfileSummary(
                    onTapProfile: false,
                  )),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Update Profile',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 58,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 55,
                                  color: Colors.black26,
                                  child: IconButton(
                                      onPressed: () async {
                                        XFile? image = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 60);
                                        if (image != null) {
                                          photo = image;
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 35,
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 55,
                                  color: Colors.white,
                                  child: Visibility(
                                      visible: photo == null,
                                      replacement: Center(
                                          child: Text(photo?.name ?? '')),
                                      child: Center(
                                          child: Text(
                                        'Take a Picture',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: userProfileController.emailTEController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Enter your mail';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller:
                              userProfileController.firstNameTEController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'First Name',
                          ),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Enter your first name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller:
                              userProfileController.lastNameTEController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Last Name',
                          ),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Enter your last name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller:
                              userProfileController.phoneNumberTEController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: 'Phone Number',
                          ),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Enter your phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller:
                              userProfileController.passWordTEController,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'Password (Optional)',
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: GetBuilder<UserProfileController>(
                                builder: (userController) {
                              return userController.profileInProgress
                                  ? const Center(child: CircularProgressIndicator())
                                  : ElevatedButton(
                                      onPressed: () {
                                        updateProfile();
                                        /*Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> null), (route) => false);*/
                                      },
                                      child: const Icon(
                                          Icons.arrow_circle_right_outlined));
                            })),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> updateProfile() async {
    if (_formKey.currentState!.validate()) {

      String? photoInBase64;

      if (photo != null) {
        List<int> photoBytes = await photo!.readAsBytes();
        photoInBase64 = base64Encode(photoBytes);
        userProfileController.photoInController = photoInBase64; // photo ta server e encode kore send kore dessi

        Get.find<UserProfileController>().updateProfile();
      }
    }
  }
}
