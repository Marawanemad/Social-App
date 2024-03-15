import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/Cubit.dart';
import 'package:socialapp/Screens/Login/Login.dart';
import 'package:socialapp/Screens/Home.dart/SocialHome.dart';
import 'package:socialapp/firebase_options.dart';

void main() async {
  // to wait any future function
  WidgetsFlutterBinding.ensureInitialized();
  // to initialize firebase in the app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // stream make listener to check if we logIn or LogOut
        home: StreamBuilder(
          // make object from firebase and check what change happened
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // to check if state in watting or no
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(color: Colors.cyan);
            }
            // to check if find data that mean app login with email
            if (snapshot.hasData) {
              return SocialHome();
            }
            // else we donot have any data and must login or signUp
            return LogIn();
          },
        ),
      ),
    );
  }
}
