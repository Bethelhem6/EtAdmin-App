import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import'package:flutter/src/material/bottom_navigation_bar.dart';
import 'package:flutter_application_1/global_methods.dart';
import 'package:flutter_application_1/screens/add_packages.dart';
import 'package:flutter_application_1/screens/add_product.dart';
import 'package:flutter_application_1/screens/delivery_person_registration.dart';

class AssignDeliveryPerson extends StatefulWidget {
  const AssignDeliveryPerson({super.key});

  @override
  State<AssignDeliveryPerson> createState() => _AssignDeliveryPersonState();
}

class _AssignDeliveryPersonState extends State<AssignDeliveryPerson> {
  GlobalMethods _globalMethods = GlobalMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assign Delivery Person",
        
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
            
            alignment: Alignment.center,
            height: 45,
            color: Colors.purple,
            child: const Text(
              'Register New Delivery Person',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
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
                Text("List of Delivery persons",
                style:TextStyle(
                  fontSize: 18,
                  
                ),
                textAlign: TextAlign.center,
                
                ),
                SizedBox(height: 10,),
                
              InkWell(
                onTap: (() {
                 Navigator.pop(context);
        _globalMethods.showDialogues(context, "Successfully Assigned");
                }),
                  child: Container(
                    height: 100,
                              width: 400,
                     decoration: BoxDecoration(
                  color: Color.fromARGB(255, 236, 196, 226),
                  borderRadius: BorderRadius.circular(20)),
                              
                    child: Row(
                      
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5,vertical: 0)),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(width: 30,),
                        Text("Yordanos Daniel",
                        style: TextStyle(
                          fontSize: 20,
                        ),),
                        SizedBox(width: 25,),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: () {
                     Navigator.pop(context);
        _globalMethods.showDialogues(context, "Successfully Assigned");
                  },
                  child: Container(
                     decoration: BoxDecoration(
                  color: Color.fromARGB(255, 236, 196, 226),
                  borderRadius: BorderRadius.circular(20)),
                              height: 100,
                              width: 400,
                    child: Row(
                      
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5,vertical: 0)),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(width: 30,),
                        Text("Yordanos Daniel",
                        style: TextStyle(
                          fontSize: 20,
                        ),),
                        SizedBox(width: 25,),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: () {
                     Navigator.pop(context);
        _globalMethods.showDialogues(context, "Successfully Assigned");
                  },
                  child: Container(
                     decoration: BoxDecoration(
                  color: Color.fromARGB(255, 236, 196, 226),
                  borderRadius: BorderRadius.circular(20)),
                              height: 100,
                              width: 400,
                    child: Row(
                      
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5,vertical: 0)),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(width: 30,),
                        Text("Yordanos Daniel",
                        style: TextStyle(
                          fontSize: 20,
                        ),),
                        SizedBox(width: 25,),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: () {
                     Navigator.pop(context);
        _globalMethods.showDialogues(context, "Successfully Assigned");
                  },
                  child: Container(
                     decoration: BoxDecoration(
                  color: Color.fromARGB(255, 236, 196, 226),
                  borderRadius: BorderRadius.circular(20)),
                              height: 100,
                              width: 400,
                    child: Row(
                      
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5,vertical: 0)),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(width: 30,),
                        Text("Yordanos Daniel",
                        style: TextStyle(
                          fontSize: 20,
                        ),),
                        SizedBox(width: 25,),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
               
                
                SizedBox(height: 180,),
                     
                  ],
                  
                ),
        ),

      ),
     
    );
              
       
           
           
      
    
  }
}