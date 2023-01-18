// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../global_methods.dart';
import 'confirmed_details.dart';

class ReportedOrders extends StatefulWidget {
  const ReportedOrders({
    Key? key,
  }) : super(key: key);

  @override
  State<ReportedOrders> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<ReportedOrders> {
  @override
  void initState() {
    super.initState();
  }

  bool _isOrder = false;

  GlobalMethods globalMethods = GlobalMethods();

  @override
  Widget build(BuildContext context) {
    // Stream<QuerySnapshot<Map<String, dynamic>>> courseDocStream =
    //     FirebaseFirestore.instance.collection('orders').snapshots();

    return _isOrder
        ? Scaffold(
            body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/emptycart.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Text(
                  'No orders yet!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ))
        : Scaffold(
            appBar: AppBar(
              title: Text('Replied orders '),
            ),
            body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                // <2> Pass `Stream<QuerySnapshot>` to stream
                stream: FirebaseFirestore.instance
                    .collection('completed orders')
                    .orderBy('reportedDate', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                    final List<DocumentSnapshot<Map<String, dynamic>>>
                        documents = snapshot.data!.docs;
                    return ListView(
                        children: documents
                            .map(
                              (doc) => Card(
                                child: ListTile(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConfirmedDetails(
                                                orderIds: doc['orderId'],
                                              ))),
                                  title: Text(
                                    doc['name'],
                                  ),
                                  subtitle: Text(
                                    "Birr ${doc['TotalPricewithDelivery']}",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  trailing: Text(
                                    "Replied: " + doc['reportedDate'],
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList());
                  } else if (snapshot.hasError) {
                    return const Text("It's Error!");
                  }
                  return Container();
                }),
          );
  }
}
