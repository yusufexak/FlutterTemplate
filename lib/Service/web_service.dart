import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:denemehttp/Service/Response/Error/errorMessage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/basemodel.dart';
import 'Response/IResponseModel.dart';
import 'Response/responseModel.dart';

class WebService {
  Future<IResponseModel<T>> getData<T extends BaseModel>({
    @required String url,
    @required BaseModel model,
    Map<String, String> headers,
  }) async {
    IResponseModel<T> responseModel = ResponseModel();
    try {
      final response = await http.get(url, headers: headers);
      final responseBody = json.decode(response.body);
      switch (response.statusCode) {
        case HttpStatus.ok:
          if (responseBody is List) {
            responseModel.list =
                responseBody.map((e) => model.fromJson(e)).toList().cast<T>();
          } else if (responseBody is Map) {
            responseModel.map = model.fromJson(responseBody);
          }
          responseModel.isSucces = true;
          break;
        default:
          throw Exception();
      }
      return responseModel;
    } catch (e) {
      responseModel.error = ErrorMessage(errorMessage: "ERROR");
      return responseModel;
    }
  }
}
