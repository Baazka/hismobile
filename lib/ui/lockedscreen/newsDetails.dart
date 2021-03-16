import 'package:flutter/material.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/data/models/news.dart';

import 'package:flutter_html/flutter_html.dart';

Future<NewsDesc> fetchData(int newsid) async {
  NewsDesc news;
  var value = await RestApi().getNewsDetails(newsid);
  if (isValidResponse(value)) {
    var _data = parseResponse(value);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      news = NewsDesc.fromJson(_data['ResponseData']['News']);
    }
  }
  return news;
}

class NewsDetails extends StatefulWidget {
  final int newsid;
  final String title;
  NewsDetails(this.newsid, this.title);
  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  Future<NewsDesc> news;
  @override
  initState() {
    super.initState();
    news = fetchData(widget.newsid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title}'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FutureBuilder<NewsDesc>(
                    future: news,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Html(
                                data: snapshot.data.fullContent,
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
