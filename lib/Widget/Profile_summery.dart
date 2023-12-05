import 'package:flutter/material.dart';
import 'package:m12_task_manager_api/Data/Auth_Controller/auth_controller.dart';
import 'package:m12_task_manager_api/Screen/login_screen.dart';
import '../Screen/UserProfile.dart';

class ProfileSummary extends StatefulWidget {
  const ProfileSummary({
    super.key,
    this.onTapProfile = true,

    ///protita screen thika true nea arce, ty segulo onTap e Navigate return korbe, ar jei screen e false ache seta te Navigate return korbe na onTap e if condition e
  });
  final bool onTapProfile;

  @override
  State<ProfileSummary> createState() => _ProfileSummaryState();
}

class _ProfileSummaryState extends State<ProfileSummary> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.green,
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(fullName),
      subtitle: Text(AuthController.user!.email ?? ''),
      trailing: IconButton(
          onPressed: () async {
            await AuthController.clearCache();
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            }
          },
          icon: const Icon(Icons.logout_outlined)),

      ///protita screen thika true nea arce, ty segulo onTap e Navigate return korbe,
      ///ar jei screen e false ache seta te Navigate return korbe na onTap er if condition theke
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserProfile()));
      },
    );
  }

  String get fullName {
    return '${AuthController.user?.firstName ?? ''} ${AuthController.user?.lastName ?? ''}';
  }
}
