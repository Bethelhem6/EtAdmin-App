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
                    isScrollable: true,
                    labelColor: Colors.deepPurple,
                    labelStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
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
                  height: 650,
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
                                      MediaQuery.of(context).size.height * 0.4,
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
                            body: kindOfOrders(
                                "processing orders", Colors.purpleAccent)),
                    kindOfOrders("completed orders", Colors.purple),
                    kindOfOrders("delivered orders", Colors.deepPurple),
                    kindOfOrders("canceled orders", Colors.red.shade800)
                  ]),
                ),
              ),
            ],
          )),
    ));
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> kindOfOrders(
      String collection, Color color) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection(collection).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<DocumentSnapshot<Map<String, dynamic>>> documents =
              snapshot.data!.docs;

          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: documents
                  .map((doc) => Card(
                        shadowColor: Colors.deepPurple,
                        elevation: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 235, 230, 245),
                                Color.fromARGB(31, 242, 228, 247)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 0),
                                      child: Container(
                                        padding: const EdgeInsets.all(13),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            doc['status'],
                                            style: TextStyle(
                                              color: color,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "OrderId: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: doc['orderId'],
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.grey.shade700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Ordere Placed On: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: doc['orderData'],
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.grey.shade700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Address: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: doc["delivery information"]['city'],
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.grey.shade700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Payment Status: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: doc['status'],
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Total: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "Birr ${doc['TotalPricewithDelivery']}"
                                              .toString(),
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDetailScreen(
                                                        collection: collection,
                                                        orderIds:
                                                            doc["orderId"])));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 0),
                                        child: Container(
                                          padding: const EdgeInsets.all(13),
                                          decoration: BoxDecoration(
                                            color: color,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Details',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const Center(
            child: Center(
              child: Text("No Data Found"),
            ),
          );
        }
      },
    );
  }
}
