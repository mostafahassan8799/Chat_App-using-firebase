import 'package:chat/pages/blocs/bloc/auth_bloc.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/cubits/register_cubit/register_cubit.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FansChat());
}

class FansChat extends StatelessWidget {
  const FansChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => RegisterCubit()),
      ],
      child: MaterialApp(
        routes: {
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
          LoginPage.id: (context) => LoginPage()
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
