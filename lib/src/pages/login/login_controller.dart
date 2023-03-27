import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/provider/user_provider.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';

import '../../models/user.dart';
import '../../utils/shared_pref.dart';

class LoginController{
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UserProvider usersProvider = new UserProvider();
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context) async{
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    if(user?.sessionToken != null){
      Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);

    }
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
      Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
    }else{
      MySnackbar.show(context, responseApi.message);
    }
    
    print('Respuesta object: ${responseApi}');
    print('Respuesta: ${responseApi.toJson()}');
    print('Email: $email');
    print('Password: $password');
  }
}