// ignore_for_file: unnecessary_const, prefer_final_fields, unused_field, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin.dart';
import 'package:flutter_application_1/screens/orders_detail.dart';
import 'package:flutter_application_1/screens/package_list.dart';
import 'package:flutter_application_1/screens/product_list.dart';

import '../auth/change_password_page.dart';
import '../auth/login_admin.dart';
import '../global_methods.dart';
import 'customer.dart';
import 'inactive_products.dart';
import 'orderrr.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  GlobalMethods _globalMethods = GlobalMethods();
  String _email = "";
  String _url = "";
  String _uid = "";
  String _name = '';
  bool isLoaded = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  void _getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;

    final DocumentSnapshot userDocs =
        await FirebaseFirestore.instance.collection("users").doc(_uid).get();
    setState(() {
      _url = userDocs.get("imageUrl");
      _email = userDocs.get("email");
      _name = userDocs.get("name");
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    // dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.deepPurple),
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/head.jpg",
          height: 100,
          width: 170,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Orders(),
      drawer: Drawer(
        width: 250,
        backgroundColor: Colors.deepPurple.shade100,
        child: ListView(
          children: [
            SizedBox(
              height: 200,
              child: DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        _url,
                      ),
                      radius: 50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        Text(
                          _email,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 88, 85, 85),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PackageList()));
              },
              child: ListTile(
                title: const Text("Package List",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                leading: Icon(
                  Icons.list_alt_outlined,
                  color: Colors.deepPurple[800],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductList()));
              },
              child: ListTile(
                title: const Text("Product List",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                leading: Icon(
                  Icons.list_sharp,
                  color: Colors.teal[800],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InactiveProducts()));
              },
              child: ListTile(
                title: const Text("Inactive products",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                leading: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red[800],
                ),
              ),
            ),
            const Divider(
              height: 3,
              color: Colors.purple,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Customer()));
              },
              child: ListTile(
                title: const Text("Customer",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                leading: Icon(
                  Icons.person,
                  color: Colors.deepPurple[800],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePassword()));
              },
              title: const Text("Change Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              leading: Icon(
                Icons.key,
                color: Colors.orange[800],
              ),
            ),
            GestureDetector(
              onTap: () async {},
              child: ListTile(
                onTap: (() async {
                  await _auth.signOut();
                  Navigator.pop(context);
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                }),
                title: const Text("Log out",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                leading: Icon(
                  Icons.logout,
                  color: Colors.red[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
