import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/provider/user_provider.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';
import 'package:flutter_delivery/src/utils/shared_pref.dart';

import '../../models/user.dart';

class LoginController{
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UserProvider usersProvider = new UserProvider();
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context) async{
    this.context = context;
    await usersProvider.init(context);
  }

  void goToRegisterPage(){
    Navigator.pushNamed(context, 'register');
  }

  void login()async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    ResponseApi responseApi = await usersProvider.login(email, password);

    if(responseApi.success){
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());
    }
    else{
      MySnackbar.show(context, responseApi.message);
    }
    print('Respuesta object: ${responseApi}');
    print('Respuesta: ${responseApi.toJson()}');
    MySnackbar.show(context, responseApi.message);
    print('Email: $email');
    print('Password: $password');
  }
}