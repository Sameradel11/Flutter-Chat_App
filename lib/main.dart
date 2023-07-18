import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar/Pages/chat_page.dart';
import 'package:scholar/Pages/sing_in_page.dart';
import 'package:scholar/Pages/sing_up_page.dart';
import 'package:scholar/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar/cubits/signin_cubit/signin_cubit.dart';
import 'package:scholar/cubits/signup_cubit/signup_cubit.dart';
import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupCubit()),
        BlocProvider(create: (context) => SigninCubit()),
        BlocProvider(create: (context) => ChatCubit())
      ],
      child: MaterialApp(routes: {
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        ChatPage.id: (context) => ChatPage()
      }, debugShowCheckedModeBanner: false, home: SignInPage()),
    );
  }
}
