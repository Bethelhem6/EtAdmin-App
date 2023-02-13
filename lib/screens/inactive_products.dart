import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../global_methods.dart';
import 'add_packages.dart';

class InactiveProducts extends StatefulWidget {
  const InactiveProducts({Key? key}) : super(key: key);

  @override
  State<InactiveProducts> createState() => _ProductState();
}

class _ProductState extends State<InactiveProducts> {
     GlobalMethods _globalMethods = GlobalMethods();

  get width => null;

  Future<void> delete(BuildContext context, String id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text(
                "All information about this package will be deleted and cannot be undone! Do you want to continue?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await FirebaseFirestore.instance
                      .collection("inactiveProducts")
                      .doc(id)
                      .delete();
                },
                child: const Text("Yes"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    bool _isLoading = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inactive Products"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.white,
     
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          // <2> Pass `Stream<QuerySnapshot>` to stream
          stream: FirebaseFirestore.instance
              .collection('inactiveProducts')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 25),
                          child: Column(children: [
                            Card(
                              elevation: 10,
                              shadowColor: Colors.grey.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 250,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(snapshot
                                                .data!.docs[index]['image']),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                delete(
                                                    context,
                                                    snapshot.data!.docs[index]
                                                        ['id']);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  Icon(
                                                    Icons
                                                        .remove_moderator_outlined,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    " Delete",
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    print("edit");
                                                    activateProduct(
                                                      image: snapshot.data!
                                                          .docs[index]['image'],
                                                      id: snapshot.data!
                                                          .docs[index]['id'],
                                                      title: snapshot.data!
                                                          .docs[index]['title'],
                                                      description: snapshot
                                                              .data!.docs[index]
                                                          ['description'],
                                                      price: snapshot.data!
                                                          .docs[index]['price'],
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: const [
                                                      Icon(
                                                        Icons.edit,
                                                        color: Colors.orange,
                                                      ),
                                                      Text(
                                                        " Activate",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.orange,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    height: 350,
                                    width: 180,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Title: ${snapshot.data!.docs[index]['title']}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.purple,
                                            ),
                                          ),
                                          Text(
                                            "Price : ${snapshot.data!.docs[index]['price']}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black45,
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.black,
                                          ),
                                          const Text(
                                            "Description",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                ['description'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }

  void activateProduct(
      {required image,
      required id,
      required title,
      required description,
      required price}) async{


        try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(id)
          .set({
        'title': title,
        'description': description,
        'price': price,
        'image': image,
        'id': id,
        'createdAt': Timestamp.now()
      });
      await FirebaseFirestore.instance
          .collection("inactiveProducts")
          .doc(id)
          .delete();
      
          _globalMethods.showDialogues(context, "Product activated successfully.");
    } catch (e) {
      print(e);
    }
      }
}
