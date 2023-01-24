//// ignore_for_file: deprecated_member_use, duplicate_ignore, prefer_final_fields, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/assign_delivery_person.dart';
import 'package:flutter_application_1/screens/customer.dart';
import 'package:flutter_application_1/screens/orderrr.dart';
import 'package:flutter_application_1/screens/package_list.dart';
import 'package:flutter_application_1/screens/product_list.dart';
import 'package:flutter_application_1/screens/reported_orders.dart';

import '../auth/change_password_page.dart';
import '../auth/login_admin.dart';
import 'add_packages.dart';
import 'add_product.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  MaterialColor active = Colors.deepPurple;
  MaterialColor notActive = Colors.grey;

  FirebaseAuth _auth = FirebaseAuth.instance;
  String _url = "";
  String _uid = "";
  String _email = "";
  String _name = "";

  void _getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;

    final DocumentSnapshot userDocs =
        await FirebaseFirestore.instance.collection("users").doc(_uid).get();
    setState(() {
      _email = userDocs.get('email');
      _name = userDocs.get('name');
      _url = userDocs.get("imageUrl");
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin"),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {
              _auth.signOut();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
              print("signed out");
            },
            child: Container(
              margin: const EdgeInsets.only(right: 25),
              child: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Text("Dashboard"),
      // _loadScreen(),
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
                        Text(
                          _name,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          _email,
                          style: const TextStyle(
                              fontSize: 15,
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
            // const Divider(
            //   height: 3,
            //   color: Colors.purple,
            // ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Admin()));
              },
              child: ListTile(
                title: const Text("Dashboard"),
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.deepPurple[800],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Orders()));
              },
              child: ListTile(
                title: const Text("Orders"),
                leading: Icon(
                  Icons.shopping_cart_checkout_outlined,
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
                        builder: (context) => const PackageList()));
              },
              child: ListTile(
                title: const Text("Package List"),
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
                title: const Text("Product List"),
                leading: Icon(
                  Icons.list_sharp,
                  color: Colors.deepPurple[800],
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const AssignDeliveryPerson()));
            //   },
            //   child: ListTile(
            //     title: const Text("Delivery Persons"),
            //     leading: Icon(
            //       Icons.person_add_alt_outlined,
            //       color: Colors.deepPurple[800],
            //     ),
            //   ),
            // ),
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
                title: const Text("Customer"),
                leading: Icon(
                  Icons.person,
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
                        builder: (context) => const ChangePassword()));
              },
              child: ListTile(
                title: const Text("Change Password"),
                leading: Icon(
                  Icons.key,
                  color: Colors.deepPurple[800],
                ),
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
                title: const Text("Log out"),
                leading: Icon(
                  Icons.logout,
                  color: Colors.deepPurple[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadScreen() {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Orders()));
                },
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_cart_checkout_outlined,
                      size: 100,
                      color: Colors.orange,
                    ),
                    Text(
                      "New Orders",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
          Card(
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReportedOrders()));
                },
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.replay_10_outlined,
                      size: 100,
                      color: Colors.orange,
                    ),
                    Text(
                      "Replied Orders",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
          Card(
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductList()));
                },
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.change_history,
                      size: 100,
                      color: Colors.orange,
                    ),
                    Text(
                      "Product List",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
          Card(
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PackageList()));
                },
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.list_alt_outlined,
                      size: 100,
                      color: Colors.orange,
                    ),
                    Text(
                      "Package List",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
          Card(
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UploadProducts()));
                },
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      size: 100,
                      color: Colors.orange,
                    ),
                    Text(
                      "Add Single Product",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
          Card(
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UploadPackages()));
                },
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_basket_outlined,
                      size: 100,
                      color: Colors.orange,
                    ),
                    Text(
                      "Add Package",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
          Card(
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const UploadPackages()));
                },
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.delivery_dining_outlined,
                      size: 100,
                      color: Colors.orange,
                    ),
                    Text(
                      "Delivered Orders",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
          Card(
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const UploadPackages()));
                },
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.reviews,
                      size: 100,
                      color: Colors.orange,
                    ),
                    Text(
                      "Reviews",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
          // const Divider(),
          // ListTile(
          //   leading: Stack(
          //     children: const [
          //       Positioned(
          //         child: Icon(
          //           Icons.shopping_cart_checkout_outlined,
          //           color: Colors.red,
          //         ),
          //       ),
          //       // Positioned(
          //       //   top: 0,
          //       //   right: 0,
          //       //   child: Text(
          //       //     "2",
          //       //     style: TextStyle(
          //       //         color: Colors.red,
          //       //         fontWeight: FontWeight.bold,
          //       //         fontSize: 18),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          //   title: const Text("New Orders"),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => const OrderScreen()));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.replay,
          //     color: Colors.purple,
          //   ),
          //   title: const Text("Replied Orders"),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => const ReportedOrders()));
          //   },
          // ),
          // const Divider(
          //   height: 2,
          //   color: Colors.deepPurpleAccent,
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.shopping_basket_outlined,
          //     color: Colors.orange,
          //   ),
          //   title: const Text("Add new product packages"),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => const UploadPackages()));
          //   },
          // ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(
          //     Icons.add,
          //     color: Colors.teal,
          //   ),
          //   title: const Text("Add new single product"),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => const UploadProducts()));
          //   },
          // ),
          // const Divider(
          //   height: 2,
          //   color: Colors.deepPurpleAccent,
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.change_history,
          //     color: Colors.brown,
          //   ),
          //   title: const Text("Products list"),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => const ProductList()));
          //   },
          // ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(
          //     Icons.list,
          //     color: Colors.pinkAccent,
          //   ),
          //   title: const Text("Package list"),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => const PackageList()));
          //   },
          // ),
          // const Divider(),
        ],
      ),
    );
  }
}
