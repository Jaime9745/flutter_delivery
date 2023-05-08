
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/provider/user_provider.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/user.dart';

class RegisterController {
  BuildContext context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UserProvider usersProvider = UserProvider();

  XFile xFile;
  File imageFile;
  Function refresh;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
  }

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastname = lastnameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || name.isEmpty || lastname.isEmpty || phone.isEmpty ||
        password.isEmpty || confirmPassword.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    if (confirmPassword != password) {
      MySnackbar.show(context, 'Las contraseñas no coinciden');
      return;
    }

    if (password.length < 6) {
      MySnackbar.show(
          context, 'La contraseña debe tener al menos 6 carcateres');
      return;
    }

    if (imageFile == null){
      MySnackbar.show(context, 'Debes seleccionar una imagen');
      return;
    }

    User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password
    );

    Stream stream = await usersProvider.createWithImage(user, imageFile);
    stream.listen((res) {
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      if (kDebugMode) {
        print('RESPUESTA: ${responseApi.toJson()}');
      }
      MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, 'login');
        });
      }
    });





  }

  Future selectImage(ImageSource imageSource) async {
    xFile = await ImagePicker().pickImage(source: imageSource);
    if (xFile != null){
      imageFile = File(xFile.path);
    }
    Navigator.pop(context);
    refresh();
  }
     void showAlertDialog() {
       Widget galleryButton = ElevatedButton(
           onPressed: () {
             selectImage(ImageSource.gallery);
           },
           child: const Text('Galeria')
       );


       Widget cameraButton = ElevatedButton(
           onPressed: () {
              selectImage(ImageSource.camera);
           },
           child: const Text('Camara')
       );

       AlertDialog alertDialog = AlertDialog(
         title: const Text('Selecciona tu imagen'),
         actions: [
           galleryButton,
           cameraButton
         ],
       );

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return alertDialog;
            }
        );
     }


  void back(){
    Navigator.pop(context);
  }
}
