import 'package:flutter/material.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_login/ui/app/app_drawer.dart';
import 'package:flutter_login/scan.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Байршил')),
        drawer: AppDrawer(),
        body: Column(
          children: [
            ScanPage(),
            SizedBox(
              height: 10.0,
            ),
            Column(
              children: [
                Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.location_on_outlined,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatDateTime.format(DateTime.now())),
                          SizedBox(),
                          Text('I-501')
                        ],
                      )),
                ),
                Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.location_on_outlined,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatDateTime.format(DateTime.now())),
                          SizedBox(),
                          Text('I-501')
                        ],
                      )),
                ),
              ],
            ),
          ],
        ));
  }
}
