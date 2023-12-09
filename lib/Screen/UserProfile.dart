

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m12_task_manager_api/Data/Auth_Controller/auth_controller.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/NetworkResponse.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/network_caller.dart';
import 'package:m12_task_manager_api/Data/Url/Url.dart';
import 'package:m12_task_manager_api/Data/pojo_model_class/user_model.dart';

import '../Widget/Profile_summery.dart';
import '../Widget/background_picture.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController = TextEditingController();
  final TextEditingController _passWordTEController = TextEditingController();

 final GlobalKey<FormState>_formKey=GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.user.value?.email ?? '';
    _firstNameTEController.text = AuthController.user.value?.firstName ?? '';
    _lastNameTEController.text = AuthController.user.value?.lastName ?? '';
    _phoneNumberTEController.text = AuthController.user.value?.mobile ?? '';
  }
   XFile? photo;
  bool _profileInProgress=false;

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
                                      onPressed: ()async {
                                        XFile? image= await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 60);
                                       if(image!=null){
                                         photo=image;
                                         if(mounted){
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
                                  child:  Visibility(
                                     visible: photo==null,
                                      replacement: Center(child: Text(photo?.name??'')) ,
                                      child: Center(child: Text('Take a Picture',style: Theme.of(context).textTheme.titleMedium,))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: _emailTEController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                          validator: (String? value){
                            if(value?.trim().isEmpty??true){
                              return 'Enter your mail';
                            }return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: _firstNameTEController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'First Name',
                          ),
                          validator: (String? value){
                            if(value?.trim().isEmpty??true){
                              return 'Enter your first name';
                            }return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: _lastNameTEController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Last Name',
                          ),
                          validator: (String? value){
                            if(value?.trim().isEmpty??true){
                              return 'Enter your last name';
                            }return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: _phoneNumberTEController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: 'Phone Number',
                          ),
                          validator: (String? value){
                            if(value?.trim().isEmpty??true){
                              return 'Enter your phone number';
                            }return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
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
                            child: Visibility(
                              visible: _profileInProgress==false,
                              replacement: const Center(child: CircularProgressIndicator()),
                              child: ElevatedButton(
                                  onPressed: () {
                                    updateProfile();
                                    /*Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> null), (route) => false);*/
                                  },
                                  child: const Icon(
                                      Icons.arrow_circle_right_outlined)),
                            )),
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
   /* if(_formKey.currentState!.validate()){
      return;
    } */
    _profileInProgress=true;
    if(mounted){
      setState(() {});
    }
    String? photoInBase64;
    Map<String, dynamic> profileData = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneNumberTEController.text.trim(),

    };
   if(_passWordTEController.text.isNotEmpty){
     profileData['password']= _passWordTEController.text;
   }

    if(photo!=null){
      List<int> photoBytes= await photo!.readAsBytes();
      photoInBase64= base64Encode(photoBytes);
      profileData['photo']= photoInBase64; // photo ta server e encode kore send kore dessi
    }

    NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.updateProfile, body: profileData);



    if(response.isSuccess){
     await AuthController().updateProfileInfo(UserModel(
        email: _emailTEController.text.trim(),
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        mobile: _phoneNumberTEController.text.trim(),
        photo: photoInBase64 ?? AuthController.user.value?.photo??''  // ekhane local cache e rakha hocce cuz use picture from modal
      ));
    }

    _profileInProgress=false;
    if(mounted){
      setState(() {});
    }
  }
}
