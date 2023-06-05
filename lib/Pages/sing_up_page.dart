import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar/Pages/chat_page.dart';
import 'package:scholar/Pages/sing_in_page.dart';

import '../Widgets/custom_button.dart';
import '../Widgets/custom_text_field.dart';
import '../helper/const.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});
  static const String id = "SignUp";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? email;

  String? pass;

  GlobalKey<FormState> formkey = GlobalKey();

  bool show = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                      try {
                        show = true;
                        setState(() {});
                        await signUp();
                        showSnackBar(context,
                            text: "Account created successfully");
                        await signIn(email!, pass!);
                        showSnackBar(context, text: "Logged in");
                        Navigator.pushNamed(context, ChatPage.id);
                        show = false;
                        setState(() {});
                      } on FirebaseAuthException catch (e) {
                        show = false;
                        setState(() {});

                        showSnackBar(context,
                            exception: e, text: "there is an error");
                      } catch (e) {
                        show = false;
                        setState(() {});

                        showSnackBar(context, text: "there is an error");
                      }
                    }
                  },
                ),
                const SizedBox(height: 25),
                CustomButton(
                  text: "Sign Up",
                  ontap: () async {
                    if (formkey.currentState!.validate()) {
                      try {
                        show = true;
                        setState(() {});
                        await signUp();
                        showSnackBar(context,
                            text: "Account created successfully");
                        await signIn(email!, pass!);
                        showSnackBar(context, text: "Logged in");
                        show = false;
                        setState(() {});
                        Navigator.pushNamed(context, SignInPage.id);
                      } on FirebaseAuthException catch (e) {
                        show = false;
                        setState(() {});

                        showSnackBar(context,
                            exception: e, text: "there is an error");
                      } catch (e) {
                        show = false;
                        setState(() {});

                        showSnackBar(context, text: "there is an error");
                      }
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

  Future<void> signUp() async {
    UserCredential uc = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: pass!);
  }
}
