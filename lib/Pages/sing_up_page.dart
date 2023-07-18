import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar/Pages/chat_page.dart';
import 'package:scholar/Pages/sing_in_page.dart';
import 'package:scholar/cubits/signin_cubit/signin_cubit.dart';
import 'package:scholar/cubits/signup_cubit/signup_cubit.dart';

import '../Widgets/custom_button.dart';
import '../Widgets/custom_text_field.dart';
import '../helper/const.dart';

class SignUpPage extends StatelessWidget {
  static const id = "Signup";
  String? email;

  String? pass;

  GlobalKey<FormState> formkey = GlobalKey();

  bool show = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupFailed) {
          show = false;
          showSnackBar(context, exception: state.exception);
        } else if (state is SignupSuccess) {
          show = false;
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          showSnackBar(context, text: "Account created successfully");
        } else if (state is SignupLoading) {
          show = true;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: show,
        child: Scaffold(
          backgroundColor: KprimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  const SizedBox(height: 100),
                  Image.asset(
                    KphotoPath,
                    height: 100,
                  ),
                  const Center(
                    child: Text(
                      "Scholar Chat",
                      style: TextStyle(
                          fontFamily: "Pacifico",
                          fontSize: 25,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 79),
                  Row(
                    children: const [
                      Text(
                        "Sign Up ",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomFormTextField(
                      label: "Email",
                      fontcolor: Colors.white,
                      onchange: (data) {
                        email = data;
                      }),
                  const SizedBox(height: 15),
                  CustomFormTextField(
                    obscuretext: true,
                    action: TextInputAction.send,
                    label: "password",
                    fontcolor: Colors.white,
                    onchange: (data) {
                      pass = data;
                    },
                    onsubmit: (data) async {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<SignupCubit>(context)
                            .signUp(email: email!, pass: pass!);
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                    text: "Sign Up",
                    ontap: () async {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<SignupCubit>(context)
                            .signUp(email: email!, pass: pass!);
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'have an account?',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          " Log in",
                          style:
                              TextStyle(color: Color(0xffC7EDE6), fontSize: 19),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context,
      {FirebaseAuthException? exception, String? text}) {
    if (exception != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            exception.code,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text!)),
      );
    }
  }
}
