import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_task/bloc/cubit.dart';
import 'package:magdsoft_task/bloc/states.dart';
import 'package:magdsoft_task/components/colors..dart';
  class UserDetails extends StatelessWidget {
  var name,email,phone;
    UserDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
        if(state is SuccessUserDataState)
        {
          email = state.loginModel!.data!.email!;
        }
      },
      builder: (context,state)
      {
        var cubit = AppCubit.get(context);
        name = cubit.loginModel!.data!.name!;
        email = cubit.loginModel!.data!.email!;
        phone = cubit.loginModel!.data!.phone!;
        return ConditionalBuilder(
          condition: cubit.loginModel !=null,
          fallback:(context)=> const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context)
          {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                title: const Text("UserData"),
              ),
              body: Center(
                child: Column(
                  children: [
                    Text("Name : $name",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 25,
                      ),),
                    const SizedBox(height: 20,),
                    Text("Email : $email",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text("Phone : $phone",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 25,
                      ),),
                    const SizedBox(height: 20,),



                  ],
                ),
              ),
            );
          },

        );
      },

    );
  }
}
