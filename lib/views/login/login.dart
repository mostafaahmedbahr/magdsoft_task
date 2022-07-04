import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_task/views/login/bloc/cubit_login.dart';
import 'package:magdsoft_task/views/register_screen/register_screen.dart';
import 'package:magdsoft_task/views/user/user_details.dart';

import '../../components/colors..dart';
import '../../components/core/toast/toast.dart';
import '../../components/core/toast/toast_states.dart';
import '../../components/core/utils.dart';
import '../../services/end_points.dart';
import 'bloc/states_login.dart';
class Login extends StatelessWidget {
    Login({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var emailCon= TextEditingController();
    var passwordCon= TextEditingController();

    return  BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState)
          {
            if(state.loginModel.status==true)
            {
              TOKEN = state.loginModel.data!.token!;
              ToastConfig.showToast(
                msg: "${state.loginModel.message}",
                toastStates: ToastStates.Success,
              );
              AppNav.customNavigator(
                context: context,
                screen: UserDetails(),
                finish: true,
              );
            }
            if(state.loginModel.status==false)
            {
              ToastConfig.showToast(
                msg: "${state.loginModel.message}",
                toastStates: ToastStates.Error,
              );
            }
          }
        },
        builder: (context,state)
        {
          var cubit = LoginCubit.get(context);
          return  Scaffold(
            backgroundColor:mainColor,
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset("assests/images/logo.png"),
                      Container(
                        height: height*0.70,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 80,
                              horizontal: 20
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              TextFormField(
                                controller: emailCon,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter your email";
                                  }
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: "Email",
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              TextFormField(
                                obscureText: cubit.isVisible,
                                controller: passwordCon,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "password is too short";
                                  }
                                },
                                onFieldSubmitted: (value)
                                {
                                  if(formKey.currentState!.validate())
                                  {
                                    cubit.userLogin(
                                        email: emailCon.text,
                                        password: passwordCon.text);
                                  }

                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: "Password",
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: cubit.isVisible
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                    onPressed: () {
                                      cubit.changeSuffixIcon();
                                    },
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: width*0.3,
                                    height: height*0.08,
                                    child: ConditionalBuilder(
                                      condition: state is! LoginLoadingState,
                                      fallback: (context)=>const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      builder: (BuildContext context){
                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: mainColor,
                                          ),
                                          onPressed: (){
                                            cubit.userLogin(
                                                email: emailCon.text,
                                                password: passwordCon.text,
                                            );
                                          },
                                          child: const Text("Login"),
                                        );
                                      },

                                    ),
                                  ),
                                  SizedBox(
                                    width: width*0.3,
                                    height: height*0.08,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: mainColor,
                                      ),
                                      onPressed: (){
                                        Navigator.push(context,
                                        MaterialPageRoute(builder: (context){
                                          return   RegisterScreen();
                                        }));
                                      },
                                      child:const Text("Register"),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
