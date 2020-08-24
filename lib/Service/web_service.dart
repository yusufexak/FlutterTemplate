import 'dart:convert';
import 'dart:core';
import 'package:denemehttp/Model/basemodel.dart';
import 'package:denemehttp/Service/IResponseModel.dart';
import 'package:denemehttp/Service/responseList.dart';
import 'package:denemehttp/Service/responseMap.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<IResponseModel<T>> getData<T extends BaseModel>({
    @required String url,
    @required BaseModel model,
    Map<String, String> headers,
  }) async {
    IResponseModel<T> responseModel;
    try {
      final response = await http.get(url, headers: headers);
      final responseBody = json.decode(response.body);
      if (responseBody is List) {
        responseModel = ResponseList(
            responseBody.map((e) => model.fromJson(e)).toList().cast<T>());
      } else if (responseBody is Map) {
        responseModel = ResponseMap(model.fromJson(responseBody) as T);
      }
      return responseModel;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
