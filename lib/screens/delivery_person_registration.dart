// ignore_for_file: use_build_context_synchronously, unused_element, prefer_final_fields, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global_methods.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/admin.dart';

class DeliveryPerson extends StatefulWidget {
  static const routeName = '/deliveryperson';

  const DeliveryPerson({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DeliveryPerson();
  }
}

class _DeliveryPerson extends State<DeliveryPerson> {
  var checkBoxValue = true;
  void _chanageVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _fullName = '';
  late int _phoneNumber;
  File? _image;
  String _url = '';

  FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;

  Future _getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }

  bool _isVisible = false;

  void _submitData() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var parsedDate = DateTime.parse(date);
    var formattedDate =
        '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
    if (isValid) {
      _formKey.currentState!.save();
    }
    try {
      if (_image == null) {
        return _globalMethods.showDialogues(context, 'Please provide an image');
      } else {
        setState(() {
          _isLoading = true;
        });
        final ref = FirebaseStorage.instance
            .ref()
            .child('adminImage')
            .child('$_fullName.jpg');
        await ref.putFile(_image!);
        _url = await ref.getDownloadURL();

        await _auth.createUserWithEmailAndPassword(
            email: _email.toLowerCase().trim(), password: _password.trim());

        final User? user = _auth.currentUser;
        final uid = user!.uid;
        FirebaseFirestore.instance.collection('users').doc(uid).set({
          'id': uid,
          'name': _fullName,
          'email': _email,
          'phoneNumber': _phoneNumber,
          'imageUrl': _url,
          'joinedDate': formattedDate,
          'role':'admins'
          // 'createdAt': TimeStamp.now()
        });

        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const Admin()),
          ),
        );
      }
    } catch (e) {
      _globalMethods.showDialogues(context, e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _numberFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _numberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios)),
          title: const Text(
            "Delivery Person Registration",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 120.0, vertical: 10),
                      child: InkWell(
                        onTap: _getImage,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.purple.shade500,
                          backgroundImage:
                              _image == null ? null : FileImage(_image!),
                          child: Icon(
                            _image == null ? Icons.camera_alt : null,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        onSaved: (value) {
                          _fullName = value!;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_numberFocusNode),
                        key: const ValueKey('id'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter id';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Id',
                          // filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _fullName = value!;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_numberFocusNode),
                        key: const ValueKey('name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
                          // filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _phoneNumber = int.parse(value!);
                        },
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_emailFocusNode),
                        // keyboardType: TextInputType.emailAddress,
                        key: const ValueKey('number'),
                        validator: (value) {
                          if (value!.length < 10) {
                            return 'Phone number must be 11 units';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          // filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.phone),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      email(),
                      const SizedBox(
                        height: 15,
                      ),
                      password(),
                      const SizedBox(
                        height: 15,
                      ),
                      // confirm(),

                      Signup(context),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget email() {
    return TextFormField(
      onSaved: (value) {
        _email = value!;
      },
      onEditingComplete: () =>
          FocusScope.of(context).requestFocus(_passwordFocusNode),
      keyboardType: TextInputType.emailAddress,
      key: const ValueKey('email'),
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Email",
        // hintText: "bettymisg6@gmail.com",
        hintStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.grey[500]),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.email),
      ),
    );
  }

  Widget password() {
    return TextFormField(
      
      focusNode: _passwordFocusNode,
      onSaved: (value) {
        _password = value!;
      },
      onEditingComplete: _submitData,
      obscureText: !_isVisible,
      key: const ValueKey('password'),
      validator: (value) {
        if (value!.isEmpty || value.length < 6) {
          return 'Password must be atleast 6 units';
        }
        return null;
      },
      
      decoration: InputDecoration(
        labelStyle: const TextStyle(
        
            fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),
        labelText: "Password",
        // hintText: "6-digits",
        hintStyle: TextStyle(
            fontSize: 18,
            
            fontWeight: FontWeight.normal,
            color: Colors.grey[500]),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          icon: Icon(_isVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }

  // Widget confirm() {
  //   return TextFormField(
  //     obscureText: true,
  //     decoration: InputDecoration(
  //       labelStyle: const TextStyle(
  //           fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),
  //       labelText: "Confirm Password",
  //       hintText: "Re-enter password",
  //       hintStyle: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.normal,
  //           color: Colors.grey[500]),
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //     ),
  //   );
  // }

  Widget Signup(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(300)),
            child: MaterialButton(
              onPressed: _submitData,
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ProductMainPage()));

              child: const Center(
                child: Text("Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center),
              ),
            ));
  }

  
}
