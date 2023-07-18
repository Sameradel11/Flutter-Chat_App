import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:scholar/helper/show_snack_bar.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SigninInitial());
  Future<void> signIn({required String email, required String pass}) async {
    try {
      emit(SigninLoading());
      UserCredential uc = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      emit(SigninSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SigninFailed(exception: e));
    } catch (e) {
      emit(SigninFailed(
          errormessage: "Something went wrong please try again later"));
    }
  }
}
