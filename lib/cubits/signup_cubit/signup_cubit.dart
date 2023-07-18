import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> signUp({required String email, required String pass}) async {
    emit(SignupLoading());

    try {
      UserCredential uc = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignupFailed(exception: e));
    } catch (e) {
      emit(SignupFailed(
          errormessage: "Something went wrong please try again"));
    }
  }
}
