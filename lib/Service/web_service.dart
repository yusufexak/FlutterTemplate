import 'dart:convert';
import 'dart:core';
import 'package:denemehttp/Model/basemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<T> getData<T, C>({
    @required String url,
    @required BaseModel model,
    Map<String, String> headers,
  }) async {
    try {
      final response = await http.get(url, headers: headers);
      final responseBody = json.decode(response.body);
      if (responseBody is List) {
        return responseBody.map((e) => model.fromJson(e)).toList().cast<C>()
            as T;
      } else if (responseBody is Map) {
        return model.fromJson(responseBody) as T;
      }
      return model as T;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
