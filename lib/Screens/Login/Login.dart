// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Screens/Login/Cubit/LoginStates.dart';
import 'package:socialapp/Screens/Login/Cubit/Logincubit.dart';
import 'package:socialapp/Screens/Register/Register.dart';
import 'package:socialapp/Widgets/FormField.dart';
import 'package:socialapp/Widgets/Navigation.dart';
import 'package:socialapp/Widgets/ShowToast.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emilControler = TextEditingController();
    var passwordControler = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (BuildContext context, SocialLoginState state) {
          print(state.toString());
          if (state is SocialLoginErrorState) {
            ShowToast(
              colorstate: toastState.ERROR,
              msg: state.error,
              toasttimelength: toastLengthTime.LONG,
              position: 'center',
            );
          }
        },
        builder: (BuildContext context, SocialLoginState state) {
          var cubit = SocialLoginCubit.get(context);
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          formField(
                            controller: emilControler,
                            labelText: "Email",
                            prefixicon: const Icon(Icons.email),
                            keyboardtype: TextInputType.emailAddress,
                            text_input_action: TextInputAction.next,
                            validiationMesseage:
                                'Please Enter Your Email Address',
                          ),
                          formField(
                              controller: passwordControler,
                              labelText: "Password",
                              prefixicon: const Icon(Icons.lock),
                              suffixicon: cubit.suffixIcon,
                              obscureText: cubit.isPasswordobscure,
                              suffixpressed: cubit.ChangeSuffixIcon,
                              keyboardtype: TextInputType.visiblePassword,
                              text_input_action: TextInputAction.done,
                              validiationMesseage:
                                  'Please Enter Your Password Address'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ConditionalBuilder(
                  // ignore: unnecessary_type_check
                  condition: state is! SocialLoginLoadingState,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userLogin(
                              email: emilControler.text,
                              password: passwordControler.text,
                            );
                          }
                        },
                        textColor: Colors.white,
                        color: Colors.cyan,
                        minWidth: 500,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text("Log In")),
                  ),
                  fallback: (context) => const Center(
                      child: CircularProgressIndicator(color: Colors.cyan)),
                ),
                const SizedBox(height: 30),
                InkWell(
                  child: const Text(
                    'Forgot your password?',
                    style: TextStyle(fontSize: 25),
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    InkWell(
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 15, color: Colors.cyan),
                      ),
                      onTap: () {
                        navigate(context: context, pageScreen: Register());
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
