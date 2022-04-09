import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../model/user.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_point.dart';
import '../../shared/network/local/cache_helper.dart';

class LoginProvider with ChangeNotifier {

  User? _user;
  User? get user=>_user;

  Future<String> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + LOGIN),
        body: jsonEncode(
          {"email": '$email', "password": '$password'},
        ),
       headers: {'Content-Type': 'application/json','accept': '*/*'},
      );
      log("response ${response.statusCode} ${response.body}");
        if(response.statusCode==200){
          token=jsonDecode(response.body)["token"];
          username=jsonDecode(response.body)["name"];
          mail=jsonDecode(response.body)["email"];
          CacheHelper.saveData(key: 'token', value: token);
          CacheHelper.saveData(key: 'name', value: username);
          CacheHelper.saveData(key: 'email', value: mail);
          return "success";
        }
        return jsonDecode(response.body)["message"];

    } catch (e) {
      if (kDebugMode) {
        print("Error: " + e.toString());
      }
      rethrow;
    }
  }

  Future<String> logout()async{
    try{
      final response = await http.post(
        Uri.parse(baseUrl + LOGOUT),
        headers: {'Content-Type': 'application/json','accept': '*/*','Authorization':"Bearer "+token!},
      );
      log("response ${response.statusCode} ${response.body}");

      if(response.statusCode == 200){
        token=null;
        CacheHelper.removeData(key: 'token');
        CacheHelper.removeData(key: 'name');
        CacheHelper.removeData(key: 'email');
        return "success";
      }else{
        return 'failed';
      }
    }catch(e) {
      if (kDebugMode) {
        print("Error: " + e.toString());
      }
      rethrow;
    }
  }

  Future<void> userInfo()async{
    try{
      final response = await http.get(
        Uri.parse(baseUrl + USER),
        headers: {'Content-Type': 'application/json','accept': '*/*','Authorization':"Bearer "+token!},
      );
      log("response ${response.statusCode} ${response.body}");

      if(response.statusCode == 200){
        _user =User.fromJson(jsonDecode(response.body));
        notifyListeners();
      }
    }catch(e) {
      if (kDebugMode) {
        print("Error: " + e.toString());
      }
      rethrow;
    }
  }
}


