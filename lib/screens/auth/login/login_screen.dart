
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_chat_app_using_firebase_with_more_things/screens/auth/register/register_screen.dart';

import '../../../bloc/cubit.dart';
import '../../../core/toast/toast.dart';
import '../../../core/toast/toast_states.dart';
import '../../../core/utile/nav.dart';
import '../../../widgets/custom_button.dart';
import '../../home.dart';
import 'cubit_login/cubit.dart';
import 'cubit_login/states.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ChatLoginCubit(),
      child: BlocConsumer<ChatLoginCubit,ChatLoginStates>(
        listener: (context, state) {
          if(state is ChatLoginSuccessState)
          {
            ToastConfig.showToast(
              msg: "welcome in our chat",
              toastStates:ToastStates.Success,
            );
            AppNav.customNavigator(
              context: context,
              screen: const HomeScreen(),
              finish: true,
            );
          }
          if(state is ChatLoginErrorState)
          {
            ToastConfig.showToast(
              msg: state.error,
              toastStates:ToastStates.Error,
            );
          }
        },
        builder: (context, state) {
          var cubit = ChatLoginCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("LOGIN",
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.deepOrange,
                            fontFamily: 'Blaka',
                            fontWeight: FontWeight.bold,
                          ),),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          controller:cubit. emailCon,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return "email is not correct";
                            }
                          },
                          decoration: const InputDecoration(
                            border:OutlineInputBorder(),
                            enabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                )
                            ),
                            focusedBorder:   OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            prefixIcon: Icon(Icons.email,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          onFieldSubmitted: (value)
                          {
                            if(formKey.currentState!.validate())
                            {

                            }

                          },
                          obscureText: cubit.isVisible,
                          controller: cubit.passCon,
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return "password is not correct";
                            }
                          },
                          decoration: InputDecoration(
                            border:const OutlineInputBorder(),
                            enabledBorder:const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                )
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )
                            ),
                            hintText: "Password",
                            hintStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            prefixIcon:const Icon(Icons.lock,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              color: Colors.black,
                              icon: cubit.isVisible ?const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                              onPressed: (){
                                cubit.changeSuffixIcon();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ChatLoginLoadingState,
                          builder: (context)=> SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.deepOrange,
                              ),
                              onPressed: (){
                                if(formKey.currentState!.validate())
                                {
                                  cubit.login();
                                }

                                ChatCubit.get(context).getAllUsers();
                              },
                              child: const Text("LoGin",
                                style: TextStyle(
                                  fontFamily: "Blaka",
                                  fontSize: 30,
                                ),),
                            ),
                          ),
                          fallback: (context)=>const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?",
                              style: TextStyle(
                                color: Colors.black,
                              ),),
                            TextButton(
                              onPressed: (){
                                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context)=>RegisterScreen(),),);
                              },
                              child:const Text("Register",
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  fontFamily: "Blaka",
                                ),),
                            ),
                          ],
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