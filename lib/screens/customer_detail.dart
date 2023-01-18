import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomerDetail extends StatefulWidget {
  const CustomerDetail({super.key});

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Detail"),
      ),
      // body: SingleChildScrollView(
      //   child:Container(
      //      padding: EdgeInsets.all(5),
      //     child: InkWell(
      //       child: Container(
      //         decoration: BoxDecoration(
      //           borderRadius:BorderRadius.circular(20),
      //           color: Color.fromARGB(255, 236, 196, 226),
      //            ),
      //        padding: EdgeInsets.all(10),
      //         height: 320,
      //         width: double.infinity,
      //         color: Color.fromARGB(255, 238, 205, 216),
      //         child:Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.start,
               
      //           children: [
      //             CircleAvatar(
                    
      //               radius: 50,
      //             ),
      //             SizedBox(height: 5,),
      //           Text("Customer Information",
      //           style: TextStyle(
      //             fontSize: 20,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.purple,
      //           ),),
      //            SizedBox(height: 5,),
      //           Text("User name:Yordanos Daniel",
      //           style: TextStyle(
      //             fontSize: 15,
      //             color: Colors.purple,
      //           ),),
      //            SizedBox(height: 5,),
      //           Text("email:yordanos2019@gmail.com",
      //           style: TextStyle(
      //             fontSize: 15,
      //             color: Colors.purple,
      //           ),),
      //            SizedBox(height: 5,),
      //           Text("phone number:0949674981",
      //           style: TextStyle(
      //             fontSize: 15,
      //             color: Colors.purple,
      //           ),),
      //            SizedBox(height: 5,),
      //           Text("Location",
      //           style: TextStyle(
      //             fontSize: 20,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.purple,
      //           ),),
      //            SizedBox(height: 5,),
      //           Text("City:Addis Ababa",
      //           style: TextStyle(
      //             fontSize: 15,
      //             color: Colors.purple,
      //           ),),
      //            SizedBox(height: 5,),
      //           Text("Subcity:Bolle",
      //           style: TextStyle(
      //             fontSize: 15,
      //             color: Colors.purple,
      //           ),),
      //            SizedBox(height: 5,),
      //           Text("Street:Alem Cinema",
      //           style: TextStyle(
      //             fontSize: 15,
      //             color: Colors.purple,
      //           ),),
      //         ],) ),
      //     ),
      //   ) ),
      body: SingleChildScrollView(
        child: Container(
              padding: const EdgeInsets.all(5),
               child: Column(
                
            
              mainAxisSize: MainAxisSize.max,
              children: [
               
              InkWell(
                onTap: (() {
                 
                }),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 320,
                              width: 400,
                     decoration: BoxDecoration(
                  color: Color.fromARGB(255, 236, 196, 226),
                  borderRadius: BorderRadius.circular(20)),
                              
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.all(5)),
                        CircleAvatar(
                  
                          radius: 40,
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(height: 10,),
                        Text("Customer Information",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),),
                 SizedBox(height: 5,),
                Text("User name:Yordanos Daniel",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.purple,
                ),),
                 SizedBox(height: 5,),
                Text("email:yordanos2019@gmail.com",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.purple,
                ),),
                 SizedBox(height: 5,),
                Text("phone number:0949674981",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.purple,
                ),),
                 SizedBox(height: 5,),
                Text("Location",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),),
                 SizedBox(height: 5,),
                Text("City:Addis Ababa",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.purple,
                ),),
                 SizedBox(height: 5,),
                Text("Subcity:Bolle",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.purple,
                ),),
                 SizedBox(height: 5,),
                Text("Street:Alem Cinema",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.purple,
                ),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                
                SizedBox(height: 180,),
                     
                  ],
                  
                ),
        ),

      ),
     
    );
  }
}