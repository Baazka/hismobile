import 'package:flutter/material.dart';
import '../../constants.dart';

class Avatar extends StatefulWidget {
  final String filepath;
  Avatar({this.filepath});
  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  dynamic url;
  @override
  Widget build(BuildContext context) {
    url ??= widget.filepath;

    return (url ?? '').isNotEmpty
        ? Image.network(_getAvatarURL(url))
        : Image.asset(
            'assets/images/emp.png',
          );
  }

  _getAvatarURL(String filepath) {
    String responseURL;
    if ((filepath ?? '').isNotEmpty) {
      var filename = filepath.split('.');
      responseURL = apiURL + 'System/thumbnail/' + filename[0];
    }
    return responseURL;
  }
}
