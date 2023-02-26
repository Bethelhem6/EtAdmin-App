import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/customer_detail.dart';

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Customer"),
          centerTitle: true,
          elevation: 0,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("customers").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var doc = snapshot.data!.docs;
                return ListView(
                    children: doc.map((doc) {
                  return ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerDetail(
                                  uid: doc['id'],
                                ))),
                    leading: const Icon(
                      Icons.person,
                      size: 30,
                    ),
                    // tileColor: deepPurple[50],
                    title: Text(
                      doc['name'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "0${doc['phoneNumber']}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[500],
                      ),
                    ),
                    trailing: Text(
                      doc['joinedDate'],
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.orange,
                      ),
                    ),
                  );
                }).toList());
              } else if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            }));
  }
}
