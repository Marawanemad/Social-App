// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Screens/Home.dart/SocialHome.dart';
import 'package:socialapp/Screens/Register/Cubit/RegisterStates.dart';
import 'package:socialapp/Screens/Register/Cubit/Registercubit.dart';
import 'package:socialapp/Widgets/FormField.dart';
import 'package:socialapp/Widgets/Navigation.dart';
import 'package:socialapp/Widgets/ShowToast.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class Register extends StatelessWidget {
  Register({super.key});
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emilControler = TextEditingController();
    var nameControler = TextEditingController();
    var phoneControler = TextEditingController();
    var passwordControler = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
        listener: (BuildContext context, SocialRegisterState state) {
          if (state is SocialRegisterErrorState) {
            ShowToast(
                colorstate: toastState.ERROR,
                msg: state.error,
                toasttimelength: toastLengthTime.LONG,
                position: 'center');
          } else if (state is SocialCreateSuccessState) {
            navigateAndFinish(context: context, pageScreen: SocialHome());
          }
        },
        builder: (BuildContext context, SocialRegisterState state) {
          var cubit = SocialRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[50],
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.cyan, size: 30),
            ),
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
                              controller: nameControler,
                              labelText: 'Name',
                              prefixicon: const Icon(Icons.person),
                              keyboardtype: TextInputType.name,
                              text_input_action: TextInputAction.next,
                              validiationMesseage:
                                  'Please Enter Your Name Address'),
                          formField(
                            controller: emilControler,
                            labelText: 'Email',
                            prefixicon: const Icon(Icons.email),
                            keyboardtype: TextInputType.emailAddress,
                            text_input_action: TextInputAction.next,
                            validiationMesseage:
                                'Please Enter Your Email Address',
                          ),
                          formField(
                              controller: passwordControler,
                              labelText: 'Password',
                              prefixicon: const Icon(Icons.lock),
                              suffixicon: cubit.suffixIcon,
                              obscureText: cubit.isPasswordobscure,
                              suffixpressed: cubit.ChangeSuffixIcon,
                              keyboardtype: TextInputType.visiblePassword,
                              text_input_action: TextInputAction.next,
                              validiationMesseage:
                                  'Please Enter Your Password Address'),
                          formField(
                              controller: phoneControler,
                              labelText: 'Phone',
                              prefixicon: const Icon(Icons.phone),
                              keyboardtype: TextInputType.number,
                              text_input_action: TextInputAction.done,
                              validiationMesseage:
                                  'Please Enter Your Phone Address'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ConditionalBuilder(
                  // ignore: unnecessary_type_check
                  condition: state is! SocialRegisterLoadingState,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userRegister(
                                email: emilControler.text,
                                password: passwordControler.text,
                                name: nameControler.text,
                                phone: phoneControler.text);
                          }
                        },
                        textColor: Colors.white,
                        color: Colors.cyan,
                        minWidth: 500,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text('Sign Up')),
                  ),
                  fallback: (context) => const Center(
                      child: CircularProgressIndicator(color: Colors.cyan)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
