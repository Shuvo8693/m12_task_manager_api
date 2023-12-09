import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:m12_task_manager_api/Data/Auth_Controller/auth_controller.dart';
import 'package:m12_task_manager_api/Data/pojo_model_class/user_model.dart';
import 'package:m12_task_manager_api/Screen/login_screen.dart';
import '../Screen/UserProfile.dart';

class ProfileSummary extends StatefulWidget {
  const ProfileSummary({
    super.key,
    this.onTapProfile = true,

    ///protita screen thika true nea arce, ty segulo onTap e Navigate return korbe,
  });

  ///ar jei screen e false ache seta te Navigate return korbe na onTap e if condition e

  final bool onTapProfile;

  @override
  State<ProfileSummary> createState() => _ProfileSummaryState();
}

class _ProfileSummaryState extends State<ProfileSummary> {
  
  Widget _buildUserImage(String? imageBytes) {
    try {
      if (imageBytes != null) {
        Uint8List imageBytess = const Base64Decoder()
            .convert(imageBytes); // register e api post korar somoy "photo":"" rakhte hobe noyto , jokhn picture api theke fetch korbo tokhn garbage data ashbe picture tokhn error dekhabe/ tokhn replaceFist (from,to) String value use korte hobe ,from e exception catch kore
        return Image.memory(
          imageBytess,
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        );
      }
    } catch (e) {
      log('Error loading user image: $e');
    }
    // Return a default image or placeholder if an error occurs
    return const CircleAvatar(
      child: Icon(Icons.error),
    );
  }
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: AuthController.user,
      builder: (BuildContext context,UserModel? value,Widget? child){
        return ListTile(
          tileColor: Colors.green,
          leading: CircleAvatar(
              child: AuthController.user.value?.photo == null
                  ? const Icon(Icons.person)
                  : ClipRRect(
                borderRadius: BorderRadius.circular(19),
                  child: _buildUserImage(
                      AuthController.user.value?.photo ?? ''))),
          title: Text(fullName),
          subtitle: Text(AuthController.user.value?.email ?? ''),
          trailing: IconButton(
              onPressed: () {
                 AuthController.clearCache();
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                          (route) => false);
                }
              },
              icon: const Icon(Icons.logout_outlined)),

          ///protita screen thika true nea arce, ty segulo onTap e Navigate return korbe,
          ///ar jei screen e false ache seta te Navigate return korbe na onTap er if condition theke
          onTap: () {
            if (widget.onTapProfile == true) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()));
            }
          },
        );
      }
    );
  }

  String get fullName {
    return '${AuthController.user.value?.firstName ?? ''} ${AuthController.user.value?.lastName ?? ''}';
  }
}
