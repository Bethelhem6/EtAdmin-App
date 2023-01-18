import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/global_methods.dart';
import 'package:flutter_application_1/screens/orders_detail.dart';
import 'package:flutter_application_1/screens/reported_orders.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
   void initState() {
    super.initState();
  }
  bool _isOrder = false;

  GlobalMethods globalMethods = GlobalMethods();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
       title: Text("Orders",),
      ),
      body: DefaultTabController(
        length: 3,
       child: Container(
       
        height: double.infinity,
        width: double.infinity,
        child:Column(
          children: [
            Container(
              
              height: 50,
              width: double.infinity,
              child: TabBar(
              
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
                tabs: [
                Tab(text: "Proccessing",),
                
                Tab(text: "Completed",),
                Tab(text: "Delivered",),
              ]),
            ),
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
               height: 670,
                width: double.maxFinite,
                child: TabBarView (
                      
                  children: [
                       _isOrder
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
            
            body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                // <2> Pass `Stream<QuerySnapshot>` to stream
                stream: FirebaseFirestore.instance
                    .collection('processing orders')
                    .orderBy('orderData', descending: true)
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
                                              OrderDetailScreen(
                                                orderIds: doc['orderId'],
                                              ))),
                                  leading: Icon(Icons.person),
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
                                      color: Colors.red,
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
                  
          ),
                
                  Text("Completed Orders"),
                  Text("Delivered Orders"),
                ]),
              ),
            ),
          ] ,)
         ),
          ) );
          
  }
}