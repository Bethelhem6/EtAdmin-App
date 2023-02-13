import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/global_methods.dart';
import 'package:flutter_application_1/screens/orders_detail.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    super.initState();
  }

  // ignore: prefer_final_fields
  bool _isOrder = false;

  GlobalMethods globalMethods = GlobalMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Orders",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: DefaultTabController(
          length: 4,
          child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            text: "Proccessing",
                          ),
                          Tab(
                            text: "Completed",
                          ),
                          Tab(
                            text: "Delivered",
                          ),
                          Tab(
                            text: "Canceled",
                          ),
                        ]),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      height: 670,
                      width: double.maxFinite,
                      child: TabBarView(children: [
                        _isOrder
                            ? Scaffold(
                                body: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 30),
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/emptycart.png'),
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
                                body: kindOfOrders("processing orders"),
                              ),
                        kindOfOrders("completed orders"),
                        kindOfOrders("delivered orders"),
                        kindOfOrders("canceled orders")
                      ]),
                    ),
                  ),
                ],
              )),
        ));
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> kindOfOrders(
      String collection) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection(collection).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot<Map<String, dynamic>>> documents =
                snapshot.data!.docs;
            return ListView(
                children: documents
                    .map(
                      (doc) => Card(
                        child: ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetailScreen(
                                        collection: collection,
                                        orderIds: doc['orderId'],
                                      ))),
                          leading: const Icon(Icons.person),
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
                            doc['orderData'],
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList());
          } else if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        });
  }
}
