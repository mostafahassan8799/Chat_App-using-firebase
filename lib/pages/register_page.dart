import 'package:chat/components/constants.dart';
import 'package:chat/components/login_custom_button.dart';
import 'package:chat/pages/cubits/register_cubit/register_cubit.dart';
import 'package:chat/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/showSnackBar.dart';

class RegisterPage extends StatelessWidget {
  static String id = 'RegisterPage';
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterIsLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          Navigator.pop(context);
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) => Scaffold(
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
                        'Register',
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
                      isLoading = true;
                      BlocProvider.of<RegisterCubit>(context)
                          .registerUser(email: email!, password: password!);
                    }
                  },
                  text: 'REGISTER',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "  Sign In",
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
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
