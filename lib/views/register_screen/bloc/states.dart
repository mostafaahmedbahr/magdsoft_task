
import '../../../model/model.dart';

abstract class RegisterStates{}

class  RegisterInitialState extends RegisterStates{}

class  RegisterLoadingState extends RegisterStates{}

class  RegisterErrorState extends RegisterStates{
  final String error;
   RegisterErrorState(this.error);
}

class  RegisterSuccessState extends RegisterStates{
  LoginModel? loginModel;
   RegisterSuccessState(this.loginModel);
}

class ChangeSuffixIconRegisterState extends RegisterStates{}