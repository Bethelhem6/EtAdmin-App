import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screens/customer_detail.dart';

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Customer"),
      ),
      body: Container(
          padding: EdgeInsets.all(5),
          child:Container(
            
            // decoration: BoxDecoration(
            //   color: Colors.purple,
            //   borderRadius:BorderRadius.circular(30),
              
            //   ) ,
            height: 100,
            padding: EdgeInsets.all(5),
            color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute( builder: (context) => const CustomerDetail()));
                },
                child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Icon(Icons.person,size: 40,),
                  SizedBox(width: 30,),
                  Container(
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Text("Yordanos Daniel",
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                      SizedBox(height: 5,),
                      Text("yordanos2019@gmail.com",
                      style: TextStyle(
                        
                        color: Colors.grey,
                      ),),
                    ]),
                  ),
                  SizedBox(width: 50,),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      
                      children: [
                        Text("13/4/2022",
                        style: TextStyle(
                          color: Colors.red,
                        ),),
                    ]),
                  )
                   
                ],
                  ),
              ),
                
          )),
    );
  }
}