import 'package:flutter/material.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_login/data/models/news.dart';
import 'package:flutter_login/ui/app/app_drawer.dart';
import 'package:flutter_login/ui/lockedscreen/newsDetails.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<News> pros = [];
  int page = 0;
  bool isLoading = false;
  bool showMore = false;
  bool offState = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          showMore = true;
        });
        fetchData(page);
      }
    });
    fetchData(page);
  }

  void _onTapItem(BuildContext context, int newsid, String title) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => NewsDetails(newsid, title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Мэдээ мэдээлэл')),
      drawer: AppDrawer(),
      body: Stack(
        children: <Widget>[
          RefreshIndicator(
            child: ListView.builder(
              controller: scrollController,
              itemCount: pros.length + 1, //List length+Tips for bottom loading
              itemBuilder: choiceItemWidget,
            ),
            onRefresh: _onRefresh,
          ),
          Offstage(
            offstage: offState,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  Widget choiceItemWidget(BuildContext context, int position) {
    if (position < pros.length) {
      return Card(
        child: ListTile(
          title: Text(
            '$position ${pros[position].title}',
          ),
          subtitle: Text(
            '${formatDateTime.format(DateTime.parse(pros[position].publishedDate))}, ${pros[position].categoryName}',
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 16,
          ),
          onTap: () => _onTapItem(
              context, int.parse(pros[position].newsID), pros[position].title),
        ),
      );
    } else if (showMore) {
      return showMoreLoadingWidget();
    } else {
      return null;
    }
  }

  Widget showMoreLoadingWidget() {
    return Container(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Уншиж байна...',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Future<void> fetchData(page) async {
    if (isLoading) {
      return;
    }
    print(page);
    setState(() {
      isLoading = true;
      page++;
    });
    print(page);
    var value = await RestApi().getNewsList(page);
    if (isValidResponse(value)) {
      var _data = parseResponse(value);
      if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
        if (_data['ResponseData']['NewsList'] is List) {
          var list = _data['ResponseData']['NewsList'] as List;
          pros.addAll(list.map((data) => News.fromJson(data)).toList());
        } else {
          pros.add(new News.fromJson(_data['ResponseData']['NewsList']));
        }
        setState(() {
          isLoading = false;
          showMore = false;
          offState = true;
        });
      }
    }

    return pros;
  }

  Future<void> _onRefresh() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = false;
      page = 0;
    });
    pros = [];
    fetchData(page);
  }
}
