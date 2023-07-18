// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signin_cubit.dart';

@immutable
abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninSuccess extends SigninState {}

class SigninFailed extends SigninState {
  String? errormessage;
  FirebaseAuthException? exception;
  SigninFailed({
    this.errormessage,
    this.exception,
  });
}
