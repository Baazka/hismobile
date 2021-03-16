import 'package:flutter/material.dart';
import 'package:flutter_login/ui/app/app_drawer.dart';
import 'package:flutter_login/ui/student/payment/studentData.dart';
import 'package:flutter_login/ui/student/payment/studentLesson.dart';
import 'package:flutter_login/ui/student/payment/studentTransaction.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Төлбөр')),
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
              child: ListTile(
            //leading: Icon(Icons.home_outlined),
            title: Text(
              'Төлбөрийн мэдээлэл',
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentData()),
              ),
            },
          )),
          Card(
              child: ListTile(
            //leading: Icon(Icons.home_outlined),
            title: Text(
              'Хичээл сонголт',
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentLesson()),
              ),
            },
          )),
          Card(
              child: ListTile(
            //leading: Icon(Icons.home_outlined),
            title: Text(
              'Гүйлгээний мэдээлэл',
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentTransaction()),
              ),
            },
          ))
        ],
      ),
    );
  }
}
