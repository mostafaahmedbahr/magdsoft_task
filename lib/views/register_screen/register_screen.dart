import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/colors..dart';
import '../../components/core/toast/toast.dart';
import '../../components/core/toast/toast_states.dart';
import '../../components/core/utils.dart';
import '../../services/end_points.dart';
import '../login/login.dart';
import '../user/user_details.dart';
import 'bloc/cubit_register.dart';
import 'bloc/states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailCon = TextEditingController();
  var passCon = TextEditingController();
  var nameCon = TextEditingController();
  var phoneCon = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel?.status == true) {
              // مهم
              TOKEN = state.loginModel!.data!.token!;
              print(state.loginModel?.data?.token);
              ToastConfig.showToast(
                msg: "${state.loginModel!.message}",
                toastStates: ToastStates.Success,
              );
              AppNav.customNavigator(
                context: context,
                screen: UserDetails(),
                finish: true,
              );
            }
            if (state.loginModel!.status == false) {
              ToastConfig.showToast(
                msg: "${state.loginModel!.message}",
                toastStates: ToastStates.Error,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: mainColor,
              body: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset("assests/images/logo.png"),
                        Container(
                          height: height * 0.70,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 80, horizontal: 20),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nameCon,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter your name";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey[300],
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: "Full Name",
                                    prefixIcon: const Icon(Icons.email),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
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
                                    hintText: " Email",
                                    prefixIcon: const Icon(Icons.email),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: phoneCon,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter your phone";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey[300],
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: "Phone",
                                    prefixIcon: const Icon(Icons.phone),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  obscureText: cubit.isVisible,
                                  controller: passCon,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "password is too short";
                                    }
                                  },
                                  onFieldSubmitted: (value) {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userRegister(
                                        email: emailCon.text,
                                        password: passCon.text,
                                        phone: phoneCon.text,
                                        name: nameCon.text,
                                      );
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: width * 0.3,
                                      height: height * 0.08,
                                      child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: mainColor,
                                            ),
                                            onPressed: () {
                                              AppNav.customNavigator(
                                                context: context,
                                                screen: Login(),
                                                finish: true,
                                              );
                                            },
                                            child: const Text("Login"),
                                          ),
                                      ),

                                    SizedBox(
                                      width: width * 0.3,
                                      height: height * 0.08,
                                      child: ConditionalBuilder(
                                          condition: state is! RegisterLoadingState,
                                        fallback: (context) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        builder:(context){
                                          return  ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: mainColor,
                                            ),
                                            onPressed: () {
                                              cubit.userRegister(
                                                  email: emailCon.text,
                                                  password: passCon.text,
                                                  name: nameCon.text,
                                                  phone: phoneCon.text,
                                              );
                                            },
                                            child: const Text("Register"),
                                          );
                                        }
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
