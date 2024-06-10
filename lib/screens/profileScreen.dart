// ignore_for_file: file_names, depend_on_referenced_packages, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, use_build_context_synchronously, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, unused_element, deprecated_member_use

import 'dart:convert';
// import 'dart:html';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mapfeature_project/helper/cach_helper.dart';
import 'package:mapfeature_project/screens/resetpassScreen.dart';
import 'dart:io' as io;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mapfeature_project/screens/soothe_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mapfeature_project/helper/cach_helper.dart';
import '../helper/show_snack_bar.dart';

class EditProfilePage extends StatefulWidget {
  final String? email;
  final String? username;
  final String userId;
  final String token;
  final String? name;
  late String? profileImageUrl;


  EditProfilePage({
    this.email,
    this.username,
    required this.userId,
    required this.token,
    this.name,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  io.File? _selectedImage;
  String? _uploadedImageUrl;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String? selectedGender;
  bool showPassword = false;
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    fullNameController.text = CachHelper.getFirstName() ?? " ";
    phoneNumberController.text = CachHelper.getPhone() ?? " ";
    dobController.text = CachHelper.getBirthDate() ?? " ";
    // _selectedImage = CachHelper.getPhoto() as io.File?;
    // _fetchProfileData();
    selectedGender = null;
  }

  // Future<void> _fetchProfileData() async {
  //   // Prepare the headers
  //   // print(CachHelper.getToken());
  //   Map<String, String> headers = {
  //     "Authorization": "Bearer ${widget.token}",
  //     "Accept": "application/json",
  //   };

  //   String apiUrl =
  //       'https://mental-health-ef371ab8b1fd.herokuapp.com/api/users/${widget.userId}';

  //   // Make the HTTP GET request to fetch the profile data
  //   http.Response response = await http.get(
  //     Uri.parse(apiUrl),
  //     headers: headers,
  //   );

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseData = json.decode(response.body);

  //     setState(() {
  //       fullNameController.text = responseData['name'] ?? '';
  //       // fullNameController.text = CachHelper.getFirstName();
  //       phoneNumberController.text = responseData['phone'] ?? '';
  //       selectedGender = responseData['gender'].toLowerCase(); //Abdo5 there was a mismatch between what was returned from the API and the dropdownlistMenuItems
  //       dobController.text = responseData['DOB'] ?? '';
  //       _selectedImage = io.File(responseData['image']);
         
  //       // Update other fields if needed
  //     });
  //     print("this is the  $_selectedImage");
  //     print(_selectedImage!.path); 
  //   } else {
  //     print("Error: ${response.body}");
  //   }
  // }


//  Future<void> _saveProfile({
//     required String name,
//     required String gender,
//     required String phone,
//     required String dob,
//   }) async {
//     // Prepare the request body
//     Map<String, dynamic> requestBody = {
//       'id' : widget.userId,    //Abdo 1 , the id was not sent
//       'name': name,
//       'phone': phone,
//       'gender': gender,
//       'DOB': dob,
//       '_method': 'PUT'
//     };
//     // Prepare the headers
//     Map<String, String> headers = {
//       'Authorization': 'Bearer ${widget.token}',
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//     };

//     // Make the HTTP PUT request to update the profile
//     http.Response response = await http.put(
//       Uri.parse(
//           'https://mental-health-ef371ab8b1fd.herokuapp.com/api/user/update_profile'),
//       headers: headers,
//       body: json.encode(requestBody),
//     );

//     // Parse the response
//     if (response.statusCode == 200) {
//       print('Profile updated successfully');
//       // Optionally, fetch the profile data again
//       // await _fetchProfileData();
//     } else {
//       print('Error: ${response.body}');
//     }
//   }










  Future<void> _postData({
  required String name,
  required String? gender,
  required String phone,
  required String dob,
  // required io.File? image,
}) async {
  // Print the path of the image
  // print('Image Path: ${image!.path}');

  
  
  // dio.MultipartFile imageFile = await dio.MultipartFile.fromFile(
    // image.path,
    // filename: image.path.split('/').last,
  // );
  
  print("this one");
  // print(imageFile.toString());

  Map<String, String> headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${CachHelper.getToken()}',
  };

  String url = 'https://mental-health-ef371ab8b1fd.herokuapp.com/api/user/update_profile';

  dio.FormData formData = dio.FormData.fromMap({
    // 'image': imageFile, // Use 'file' as the key for the image
    'id': CachHelper.getUserId(),
    'name': name,
    'phone': phone,
    'gender': gender,
    'DOB': dob.replaceAll('-', '/'),
    '_method': 'PUT',
  });

  // if (image != null) {
  //   formData.files.add(MapEntry(
  //     'image',
  //     await dio.MultipartFile.fromFile(
  //       image.path,
  //       filename: image.path.split('/').last,
  //     ),
  //   ));
  //   print("image is not null");
  // }
  // else{
  //   print("image is null");
  // }
  // print(formData);
  formData.fields.forEach((element) {
    print('Field: ${element.key}, Value: ${element.value}');
  });
  dio.Dio dioClient = dio.Dio();

  try {
    dio.Response response = await dioClient.post(
      url,
      data: formData,
      options: dio.Options(headers: headers),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;
      showSnackBar(context, responseData['message']);
      print('sddsad');
      CachHelper.setFirstName(userInfo: name);
      CachHelper.setPhone(userInfo: phone);
      CachHelper.setBirthDate(userInfo: dob);
      // setState(() {
        // _uploadedImageUrl = responseData["image"];
        // _selectedImage = null;
        // isEditMode = false;
        // _fetchProfileData();
      // });
    } else {
      print(response.statusMessage);
      Map<String, dynamic> responseData = response.data;
      print('object');
      print(responseData['message']);

      // setState(() {
        // isEditMode = true;
      // });
      showSnackBar(context, responseData['message']);
    }
  } catch (e) {
    print('Error: $e');
    showSnackBar(context, 'An error occurred');
  }
}

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('       Personal Info'),
        actions: [
          if (isEditMode) // Show save button only in edit mode
          ElevatedButton(
              onPressed: () async {
                // print(fullNameController.text);      //Abdo2 These prints the data when pressing save
                // print(phoneNumberController.text);
                // print(selectedGender);
                // print(dobController.text);

                // Map gender string to an integer
                // String? gender;
                // if (selectedGender == "Male") {
                //   gender = 'male';
                // } else if (selectedGender == "Female") { //Abdo3 Made changes here 3
                //   gender = 'female';
                // }

                if (selectedGender != null) {
                  await _postData(
                    name: fullNameController.text,
                    gender: selectedGender!.toLowerCase(),
                    phone: phoneNumberController.text,
                    dob: dobController.text,
                    // image: _selectedImage,
                  );

                  setState(() { //Abdo7 this should be added to the if condition indicating only saves if the request was sent succesfully . look at Abdo6
                    isEditMode = false;
                  });
                } else {
                  showSnackBar(context, "Please select a gender.");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB7C3C5),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "SAVE",
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 2.2,
                  color: Colors.white,
                ),
              ),
            ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              // _saveProfile({});
              if (isEditMode==false){  ///Abdo4 the edit icon works as a switch on/off for save to appear 
              setState(() {
                isEditMode = !isEditMode; // Toggle edit mode
              });
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isEditMode) {
                        _pickImage(); // Open gallery only in edit mode
                      }
                    },
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10),
                          )
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (isEditMode) {
                            _pickImage(); // Open gallery only in edit mode
                          }
                        },
                        child: CircleAvatar(
                              backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : (_uploadedImageUrl != null
                              ? NetworkImage(CachHelper.getPhoto()!) as ImageProvider
                              : const AssetImage("images/photo_2024-01-17_04-23-53-removebg-preview.png")),
                              radius: 50,
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Visibility(
                      visible: isEditMode,
                      child: GestureDetector(
                        onTap: () {
                          _pickImage(); // Open gallery when edit icon is tapped
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: const Color(0xFFB7C3C5),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            const Text(
              'Full Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            buildTextField('.', fullNameController),
            const Text(
              'Phone Number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            buildTextField('..', phoneNumberController),
            const Text(
              'Gender',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            buildGenderDropdown(),
            const Text(
              'Date of Birth',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            buildTextField('...', dobController,
                onTap: () => _selectDate(context)),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ResetPasswordScreen(email: widget.email ?? ""),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Reset your password',
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xFF355A5C)),
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.grey[700],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: 
                  _logout
                ,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      Text('  Log Out',
                          style: TextStyle(fontSize: 16, color: Colors.red)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

    Future<void> _logout() async {
      print("logging");
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    String? token = prefs.getString('token');
    final response = await http.post(
      Uri.parse(
          'https://mental-health-ef371ab8b1fd.herokuapp.com/api/logout'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200){
      final dynamic responseData = jsonDecode(response.body);
      
      Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => sotheeScreen()));
        showSnackBar(context, responseData["message"]);
        CachHelper.clearAll();
      }
  }








  Widget buildTextField(String labelText, TextEditingController controller,
      {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: labelText == "."
          ? TextFormField(
              controller: controller,
              readOnly: !isEditMode, // Set readOnly based on edit mode
              onTap: onTap,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.grey[500],
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold, // تجعل النص داخل الحقل bold
              ),
            )
          : labelText == ".."
              ? IntlPhoneField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, // تجعل النص داخل الحقل bold
                  ),
                  controller: controller,
                  enabled: isEditMode,
                  initialCountryCode: 'EG', // تعيين رمز البلد لمصر
                  onChanged: (phone) {
                    // يمكنك إضافة العمليات التي تريدها هنا على أساس التغييرات في الحقل
                  },
                )
              : TextFormField(
                  controller: controller,
                  readOnly: !isEditMode, // Set readOnly based on edit mode
                  onTap: onTap,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    suffixIcon: labelText == "..."
                        ? Icon(
                            Icons.calendar_today,
                            color: Colors.grey[500],
                          )
                        : null,
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, // تجعل النص داخل الحقل bold
                  ),
                ),
    );
  }

  Widget buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: DropdownButtonFormField<String>(
        onChanged: isEditMode
            ? (value) {
                setState(() {
                  selectedGender = value!;

                });
              }
            : null,
        value: selectedGender,
// Disable onChanged outside edit mode
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          labelText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        items: <String>["male", 'female'].map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _saveProfile({
    required String name,
    required String gender,
    required String phone,
    required String dob,
  }) async {
    // Prepare the request body
    Map<String, dynamic> requestBody = {
      'id' : widget.userId,    //Abdo 1 , the id was not sent
      'name': name,
      'phone': phone,
      'gender': gender,
      'DOB': dob,
      '_method': 'PUT'
    };

    // Prepare the headers
    Map<String, String> headers = {
      'Authorization': 'Bearer ${widget.token}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    // Make the HTTP PUT request to update the profile
    http.Response response = await http.put(
      Uri.parse(
          'https://mental-health-ef371ab8b1fd.herokuapp.com/api/user/update_profile'),
      headers: headers,
      body: json.encode(requestBody),
    );

    // Parse the response
    if (response.statusCode == 200) {
      print('Profile updated successfully');
      // Optionally, fetch the profile data again
      // await _fetchProfileData();
    } else {
      print('Error: ${response.body}');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        dobController.text = DateFormat('yyyy/MM/dd').format(pickedDate);
      });
    }
  }

  final picker = ImagePicker();

  //Image Picker function to get image from gallery

  Future _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
    setState(() {
       _selectedImage = io.File(pickedFile.path);
    });
    
  }
  else{
    print("image not picked");
  }
  }
}
