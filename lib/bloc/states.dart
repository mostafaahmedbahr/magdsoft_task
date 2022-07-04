import '../model/model.dart';

abstract class AppStates{}

class InitialState extends AppStates{}

class LoadingUserDataState extends AppStates{}

class SuccessUserDataState extends AppStates{
  LoginModel? loginModel;
  SuccessUserDataState(this.loginModel);
}

class ErrorUserDataState extends AppStates{}
