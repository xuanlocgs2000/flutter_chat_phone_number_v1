import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ffb/data/model/user_model.dart';
import 'package:flutter_chat_ffb/presentation/bloc/get_device_number/get_device_numbers_cubit.dart';
import 'package:flutter_chat_ffb/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:flutter_chat_ffb/presentation/bloc/user/user_cubit.dart';
import 'injection_container.dart' as di;
import 'package:flutter_chat_ffb/presentation/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_chat_ffb/data/model/user_model.dart';
import 'package:flutter_chat_ffb/presentation/bloc/auth/auth_cubit.dart';
// import 'package:flutter_chat_ffb/presentation/bloc/communication/communication_cubit.dart';
// import 'package:flutter_chat_ffb/presentation/bloc/get_device_number/get_device_numbers_cubit.dart';
// import 'package:flutter_chat_ffb/presentation/bloc/my_chat/my_chat_cubit.dart';
import 'package:flutter_chat_ffb/presentation/screens/home_screen.dart';
import 'package:flutter_chat_ffb/presentation/screens/welcome_screen.dart';
// import 'package:flutter_chat_ffb/presentation/widgets/theme/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<PhoneAuthCubit>(
          create: (_) => di.sl<PhoneAuthCubit>(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>()..getAllUsers(),
        ),
        BlocProvider<GetDeviceNumbersCubit>(
          create: (_) => di.sl<GetDeviceNumbersCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return BlocBuilder<UserCubit, UserState>(
                    builder: (context, userState) {
                      if (userState is UserLoaded) {
                        final currentUserInfo = userState.users.firstWhere(
                            (user) => user.uid == authState.uid,
                            orElse: () => UserModel());
                        return HomeScreen(
                          userInfo: currentUserInfo,
                        );
                      }
                      return Container();
                    },
                  );
                }
                if (authState is UnAuthenticated) {
                  return WelcomeScreen();
                }
                return Container();
              },
            );
          }
        },
        // home: SplashScreen(),
      ),
    );
  }
}
