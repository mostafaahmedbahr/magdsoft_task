import 'package:magdsoft_task/model/model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginSuccessState extends LoginStates {
   LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class ChangeSuffixIconState extends LoginStates {}
