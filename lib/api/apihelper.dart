import 'dart:convert';
import 'package:http/http.dart';
import 'package:xml2json/xml2json.dart';

bool isValidResponse(Response response) => response.statusCode == 200;
dynamic parseResponse(Response response) {
  final myTransformer = Xml2Json();
  myTransformer.parse(response.body);
  return jsonDecode(myTransformer.toParker() ?? '');
}
