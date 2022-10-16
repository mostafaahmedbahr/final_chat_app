import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_chat_app_using_firebase_with_more_things/bloc/cubit.dart';

import '../../../core/toast/toast.dart';
import '../../../core/toast/toast_states.dart';
import '../../../core/utile/nav.dart';
 import '../../../h.dart';
import '../../../widgets/custom_button.dart';
import '../../home.dart';
import '../login/login_screen.dart';
import 'cubit_register/cubit_register.dart';
import 'cubit_register/register_states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailCon = TextEditingController();
  var passCon = TextEditingController();
  var nameCon = TextEditingController();
  var phoneCon = TextEditingController();
  var focusEmail = FocusNode();
  var focusPassword = FocusNode();
  var focusName = FocusNode();
  var focusPhone = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatRegisterCubit(),
      child: BlocConsumer<ChatRegisterCubit, ChatRegisterStates>(
        listener: (context, state) {
          if(state is ChatRegisterSuccessState)
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
          if(state is ChatRegisterErrorState)
          {
            ToastConfig.showToast(
                msg: state.error,
              toastStates:ToastStates.Error,
            );
          }
          if(state is ChatRegisterGoogleSuccessState)
          {
            AppNav.customNavigator(
              context: context,
              screen: const HomeScreen(),
              finish: true,
            );
          }
        },
        builder: (context, state) {
          var cubit = ChatRegisterCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.deepOrange,
                  ),
                  onPressed: () {
                    AppNav.customNavigator(
                      context: context,
                      screen: LoginScreen(),
                      finish: false,
                    );
                  },
                ),
              ),
              body: SizedBox(
                width: double.infinity,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key:  formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Register in our Chat App",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.deepOrange,
                                fontFamily: "Blaka",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              focusNode:  focusName,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus( focusEmail);
                              },
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              keyboardType: TextInputType.name,
                              controller:  nameCon,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "please enter your name";
                                }
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                )),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                                hintText: "Name",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              focusNode: focusEmail,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus( focusPassword);
                              },
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller:  emailCon,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "please enter your email";
                                }
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                )),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              focusNode:  focusPassword,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus( focusPhone);
                              },
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              obscureText: cubit.isVisible,
                              controller: passCon,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "password is not valid";
                                }
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                )),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                suffixIcon: IconButton(
                                  color: Colors.black,
                                  icon: cubit.isVisible
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  onPressed: () {
                                    cubit.changeSuffixIcon();
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              focusNode: focusPhone,
                              onEditingComplete: () {},
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              keyboardType: TextInputType.phone,
                              controller:phoneCon,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "this number is using before";
                                }
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                )),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                                hintText: "Phone Number",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            CustomElevatedButton(
                              borderRadius: 16,
                              color: Colors.white,
                              onPress: () {
                                cubit.signInWithGoogle(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/images/g.png",
                                    height: 40,
                                  ),
                                  const Text(
                                    "Sign in with Google",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Opacity(
                                      opacity: 0,
                                      child: Image.asset(
                                        "assets/images/g.png",
                                        height: 40,
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! ChatRegisterLoadingState,
                              builder: (context) => SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepOrange,
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate())
                                    {
                                      cubit.register(
                                          name: nameCon.text,
                                          email: emailCon.text,
                                          phone: phoneCon.text,
                                          password: phoneCon.text,
                                      );

                                    }

                                  },
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 30, fontFamily: "Blaka"),
                                  ),
                                ),
                              ),
                              fallback: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),
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
