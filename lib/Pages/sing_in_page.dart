import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar/Pages/chat_page.dart';
import 'package:scholar/Pages/sing_up_page.dart';
import 'package:scholar/Widgets/custom_text_field.dart';
import 'package:scholar/Widgets/custom_button.dart';
import 'package:scholar/helper/const.dart';
import 'package:scholar/helper/show_snack_bar.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  static const String id = "SignIn";

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                      "Sign in ",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomFormTextField(
                  action: TextInputAction.next,
                  label: "Email",
                  fontcolor: Colors.white,
                  onchange: (data) {
                    email = data;
                  },
                ),
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
                        await signIn(email!, pass!);
                        show = false;
                        setState(() {});
                        showSnackBar(context, text: "Signed in");
                        // await Future.delayed(Duration(seconds: 2));
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        show = false;
                        setState(() {});
                        showSnackBar(context, exception: e);
                      } catch (e) {
                        show = false;
                        setState(() {});
                        showSnackBar(context, text: "Error");
                      }
                    }
                  },
                ),
                const SizedBox(height: 25),
                CustomButton(
                  ontap: () async {
                    if (formkey.currentState!.validate()) {
                      try {
                        show = true;
                        setState(() {});
                        await signIn(email!, pass!);
                        show = false;
                        setState(() {});
                        showSnackBar(context, text: "Signed in");

                        // await Future.delayed(Duration(seconds: 2));
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        show = false;
                        setState(() {});
                        showSnackBar(context, exception: e);
                      } catch (e) {
                        show = false;
                        setState(() {});
                        showSnackBar(context, text: "Error");
                      }
                    }
                  },
                  text: "Sign in",
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpPage.id);
                      },
                      child: const Text(
                        " Register",
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
}

Future<void> signIn(String email, String pass) async {
  UserCredential uc = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: pass);
}
