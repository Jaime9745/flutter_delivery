import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/api/environment.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UserProvider {
    final String _url = Environmet.API_DELIVERY;
    final String _api = '/api/users';

    BuildContext context;

    Future init(BuildContext context){
      this.context = context;
    }

    Future<Stream> createWithImage(User user, File image) async {
      try{
        Uri url = Uri.http(_url, '$_api/create');
        final request = http.MultipartRequest('POST', url);
        if (image != null) {
          request.files.add(http.MultipartFile(
              'image',
              http.ByteStream(image.openRead().cast()),
              await image.length(),
              filename: basename(image.path)
          ));
      }
        request.fields['user'] = json.encode(user);
        final response = await request.send();
        return response.stream.transform(utf8.decoder);
      }
      catch(e){
        if (kDebugMode) {
          print('Error: $e');
        }
        return null;
      }
    }

    Future<ResponseApi> create(User user) async{
      try{
        Uri url = Uri.http(_url, '$_api/create');
        String bodyParams = json.encode(user);
        Map<String, String> headers = {
          'Content-type': 'application/json'
        };
        final res = await http.post(url, headers: headers, body: bodyParams);
        final data = json.decode(res.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        return responseApi;
      }
      catch(e){
        if (kDebugMode) {
          print('Error: $e');
        }
        return null;
      }
    }

    Future<ResponseApi> login(String email, String password) async{
      try{
        Uri url = Uri.http(_url, '$_api/login');
        String bodyParams = json.encode({
          'email': email,
          'password': password
        });
        Map<String, String> headers = {
          'Content-type': 'application/json'
        };
        final res = await http.post(url, headers: headers, body: bodyParams);
        final data = json.decode(res.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        return responseApi;
      }
      catch(e){
        if (kDebugMode) {
          print('Error: $e');
        }
        return null;
      }
    }
}
