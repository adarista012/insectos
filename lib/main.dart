import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:insectos/global/theme.dart';

import 'package:insectos/pages/sign_in.dart';
import 'package:insectos/services/authentication.dart';
import 'package:insectos/services/categories.dart';
import 'package:insectos/services/components.dart';
import 'package:insectos/services/sub_categories.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home.dart';
import 'pages/loading.dart';

import 'pages/sign_up.dart';
import 'pages/something_went_wrong.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences.getInstance().then((prefs) {
    var isDarkTheme = prefs.getBool("darkTheme") ?? false;
    return runApp(
      ChangeNotifierProvider<ThemeProvider>(
        child: MyApp(),
        create: (BuildContext context) {
          return ThemeProvider(isDarkTheme);
        },
      ),
    );
  });

  // runApp(MyApp());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [MyApp] is rebuilt, that
/// would re-initialize FlutterFire and make our Myapplication re-enter loading state,
/// which is undesired.
class MyApp extends StatefulWidget {
  // static final ValueNotifier<ThemeMode> themeNotifier =
  //     ValueNotifier(ThemeMode.light);

  // Create the initialization Future outside of `build`:
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: value.getTheme(),
          home: FutureBuilder(
            // Initialize FlutterFire:
            future: _initialization,
            builder: (context, snapshot) {
              // Check for errors
              if (snapshot.hasError) {
                return SomethingWentWrongPage();
              }

              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider<AuthenticationService>.value(
                        value: AuthenticationService()),
                    ChangeNotifierProvider<CategoriesServices>.value(
                        value: CategoriesServices()),
                    ChangeNotifierProvider<SubCategoriesServices>.value(
                        value: SubCategoriesServices()),
                    ChangeNotifierProvider<ServicesComponents>.value(
                        value: ServicesComponents()),
                  ],
                  child: StreamBuilder<User?>(
                      stream: AuthenticationService().authChanges,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          //print(snapshot.data);
                          if (snapshot.data == null) {
                            return Toggle();
                          } else {
                            return HomePage();
                          }
                        } else {
                          return LoadingPage();
                        }
                      }),
                );
              }

              // Otherwise, show something whilst waiting for initialization to complete
              return LoadingPage();
            },
          ),
        );
      },
    );
  }
}

class Toggle extends StatefulWidget {
  @override
  _ToggleState createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  bool isRegister = false;

  void toggleScreen() {
    setState(() {
      isRegister = !isRegister;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isRegister) {
      return SignUpPage(toggleScreen: toggleScreen);
      //return LoginPage(toggleScreen: toggleScreen);
    } else {
      return SignInPage(toggleScreen: toggleScreen);
      //SignUpPage(toggleScreen: toggleScreen);
    }
  }
}
