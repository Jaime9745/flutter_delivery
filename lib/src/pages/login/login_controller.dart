import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/provider/user_provider.dart';

class LoginController{
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UserProvider usersProvider = new UserProvider();

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

    ResponseApi responseApi = awai
    print('Email: $email');
    print('Password: $password');
  }
}