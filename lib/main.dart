import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsme/presentation/bloc/auth/auth_cubit.dart';
import 'package:whatsme/presentation/bloc/auth_phone/phone_auth_cubit.dart';
import 'package:whatsme/presentation/screens/home_screen.dart';
import 'package:whatsme/presentation/screens/splash_screen.dart';
import 'package:whatsme/presentation/screens/welcome_screen.dart';
import 'package:whatsme/presentation/widgets/theme/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsme/injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>di.sl<AuthCubit>()..appStarted()),
        BlocProvider(create: (_)=>di.sl<PhoneAuthCubit>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "WhatsMe",
        theme: ThemeData(
          primaryColor: primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          "/":(context)=>BlocBuilder<AuthCubit,AuthState>(builder:(context,authState){
            if(authState is Authenticated){
              return HomeScreen(uid: authState.uid,);
            }if(authState is UnAuthencticated){
              return WelcomeScreen();
            }
            return Container();
          }),
        },
      ),
    );
  }
}

