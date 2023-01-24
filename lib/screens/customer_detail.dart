// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_interpolation_to_compose_strings, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerDetail extends StatefulWidget {
  String uid;
  CustomerDetail({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Detail"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("customers")
                .doc(widget.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var doc = snapshot.data!;

                return Column(children: [
                  SizedBox(
                      width: double.infinity,
                      child: Column(children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(doc["imageUrl"]),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.deepPurple,
                          ),
                          title: const Text(
                            "Customer Information",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Full Name: " + doc['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "Email: " + doc['email'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "Phone Number: ${doc['phoneNumber']}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.location_on,
                            size: 30,
                            color: Colors.deepPurple,
                          ),
                          title: const Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "City: " + doc["delivery information"]['city'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "Subcity: " +
                                    doc["delivery information"]['subCity'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "street: " +
                                    doc["delivery information"]['street'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        )
                      ]))
                ]);
              }
              return const Text("No data");
            }),
      ),
    );
  }
}
