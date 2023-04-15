import 'package:chat/components/constants.dart';
import 'package:chat/components/login_custom_button.dart';
import 'package:chat/pages/blocs/bloc/auth_bloc.dart';
import 'package:chat/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/custom_text_field.dart';
import '../helper/showSnackBar.dart';
import 'chat_page.dart';

class LoginPage extends StatelessWidget {
  static String id = 'LoginPage';
  bool isLoading = false;
  String? email;
  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginIsLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if (state is LoginFailure) {
          isLoading = false;
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    kLogoName,
                    height: 124,
                    width: 124,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        kAppName,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.red[900],
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    obscureText: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                            LoginEvent(email: email!, password: password!));
                      } else {}
                    },
                    text: 'SIGN IN',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don\'t have an account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text(
                          "  Register",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
