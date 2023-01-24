// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/global_methods.dart';
import 'package:flutter_application_1/screens/confirm_shipment.dart';
import 'package:flutter_application_1/screens/confirmed_details.dart';
import 'package:flutter_application_1/screens/delivery_person_registration.dart';

class AssignDeliveryPerson extends StatefulWidget {
  String docId;
  AssignDeliveryPerson({
    Key? key,
    required this.docId,
  }) : super(key: key);

  @override
  State<AssignDeliveryPerson> createState() => _AssignDeliveryPersonState();
}

class _AssignDeliveryPersonState extends State<AssignDeliveryPerson> {
  GlobalMethods _globalMethods = GlobalMethods();
  String _email = '';

  String _city = '';
  String _subCity = '';
  String _street = '';
  String _fullName = '';
  late int _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Assign Delivery Person",
        ),
      ),
      bottomSheet: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DeliveryPerson(),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.center,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.purple,
            ),
            child: const Text(
              'Register New Delivery Person',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "List of Delivery persons",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              ListofDeliveryPerson(
                  globalMethods: _globalMethods,
                  collection: "delivery person",
                  docId: widget.docId),
              const SizedBox(
                height: 180,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListofDeliveryPerson extends StatelessWidget {
  String collection;
  String docId;
  ListofDeliveryPerson({
    Key? key,
    required GlobalMethods globalMethods,
    required this.collection,
    required this.docId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection(collection).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            final List<DocumentSnapshot<Map<String, dynamic>>> documents =
                snapshot.data!.docs;

            return SizedBox(
                height: 600,
                child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () async {
                            // var doc = await FirebaseFirestore.instance
                            //     .collection("processing orders")
                            //     .doc(docId)
                            //     .get();

                            // try {
                            //   await FirebaseFirestore.instance
                            //       .collection('completed orders')
                            //       .doc(docId)
                            //       .set({
                            //     "customer information": {
                            //       'userId': doc["customer information"]
                            //           ["userId"],
                            //       'name': doc["customer information"]["name"],
                            //       'email': doc["customer information"]["email"],
                            //       'phoneNumber': doc["customer information"]
                            //           ["phoneNomber"],
                            //     },
                            //     "delivery information": {
                            //       'city': doc["delivery information"]["city"],
                            //       'subCity': doc["delivery information"]
                            //           ["subCity"],
                            //       'street': doc["delivery information"]
                            //           ["street"],
                            //     },
                            //     "ordered products": doc["ordered products"],
                            //     "TotalPricewithDelivery":
                            //         doc["TotalPricewithDelivery"],
                            //     "deliveryFee": doc["deliveryFee"],
                            //     "subtotal": doc["subtotal"],
                            //     "orderData": doc["orderData"],
                            //     "orderId": doc["orderId"],
                            //     'name': doc["name"],
                            //     'status': "completed"
                            //   });
                              // await FirebaseFirestore.instance
                              //     .collection("processing orders")
                              //     .doc(docId)
                              //     .delete();
                              print("successfully Assigned");
                             
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ConfirmShipment(orderId: docId)));
                            // } catch (e) {
                            //   print(e);
                            // }
                          },
                          child: ListTile(
                            title: Text(
                              documents[index]["name"],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              documents[index]["email"],
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(documents[index]["imageUrl"]),
                              backgroundColor: Colors.grey,
                            ),
                          ));
                    }));
          }
          return const Text("no data found");
        });
  }
}
