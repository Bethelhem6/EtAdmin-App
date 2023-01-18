import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/global_methods.dart';
import 'package:flutter_application_1/screens/orderrr.dart';
import 'package:flutter_sms/flutter_sms.dart';

import 'customer_detail.dart';

class ConfirmShipment extends StatefulWidget {
  final String orderId;
  const ConfirmShipment({Key? key, required this.orderId}) : super(key: key);

  @override
  State<ConfirmShipment> createState() => _ConfirmShipmentState();
}

class _ConfirmShipmentState extends State<ConfirmShipment> {
  FocusNode numberOfDaysTakeToDeliverFoucusNode = FocusNode();
  late String numberOfDaysTakeToDeliver;
  String message = '';
  GlobalMethods _globalMethods = GlobalMethods();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() async {
    numberOfDaysTakeToDeliverFoucusNode.dispose();

    super.dispose();
  }

  deleteOrder(orderId) async {
    await FirebaseFirestore.instance
        .collection('processing orders')
        .doc(orderId)
        .delete();
  }

  addToReported(
      String orderIds,
      String name,
      String phoneNumber,
      String email,
      String city,
      String subCity,
      String street,
      double total,
      double subtotal,
      double deliveryFee,
      var products,
      String orderedDate) async {
    var date = DateTime.now().toString();
    var parsedDate = DateTime.parse(date);
    var formattedDate =
        '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
    print("about to add");
    try {
      await FirebaseFirestore.instance
          .collection('completed orders')
          .doc(widget.orderId)
          .set({
        "customer information": {
          // 'userId': _uid,
          'name': name,
          'email': email,
          'phoneNumber': phoneNumber,
        },
        "delivery information": {
          'city': city,
          'subCity': subCity,
          'street': street,
        },
        "ordered products": products,
        "TotalPricewithDelivery": total,
        "deliveryFee": deliveryFee,
        "subtotal": subtotal,
        // "orderData": formattedDate,
        "orderId": orderIds,
        'name': name,
        'orderedDate': orderedDate,
        'reportedDate': formattedDate,
        'status': "Completed",
      });
      deleteOrder(widget.orderId);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Orders(),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void sendMessage(_phoneNumber) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      List<String> phoneNumber = [_phoneNumber.toString()];
      sendSMS(message: message, recipients: phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> courseDocStream =
        FirebaseFirestore.instance
            .collection('processing orders')
            .doc(widget.orderId)
            .snapshots();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Confirmation message for Customer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: courseDocStream,
                // future: orderProvider.getData(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var document = snapshot.data!;
                    var sections = document['ordered products'];
                    var deliveryinfo = document['delivery information'];
                    var customerInfo = document['customer information'];

                    var name = customerInfo['name'];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            initialValue:
                                "Dear $name thank you for ordering our products on Bj Etherbal App. Your orders will be delivered after 3 days.\n\n \n Thank you! \nEtherbal magnifies beauty!",
                            key: const ValueKey('message'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Message is required';
                              }
                              return null;
                            },
                            maxLines: 10,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              labelText: ' Message',
                              hintText: 'Message',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (value) {
                              message = value!;
                            },
                          ),
                        ),
                        MaterialButton(
                          color: Colors.deepPurple[800],
                          onPressed: () async {
                            addToReported(
                                document['orderId'],
                                customerInfo['name'],
                                customerInfo['phoneNumber'].toString(),
                                customerInfo['email'],
                                deliveryinfo['city'],
                                deliveryinfo['subCity'],
                                deliveryinfo['street'],
                                document['subtotal'],
                                document['TotalPricewithDelivery'],
                                document['TotalPricewithDelivery'],
                                sections,
                                document['orderData'].toString());
                            var recipients = customerInfo['phoneNumber'];

                            sendMessage(recipients);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Send',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
