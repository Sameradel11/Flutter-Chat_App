// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailed extends SignupState {
  String? errormessage;
  FirebaseAuthException? exception;
  SignupFailed({
    this.errormessage,
    this.exception,
  });
}

class SignupLoading extends SignupState {}
