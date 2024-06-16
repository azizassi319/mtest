import 'package:flutter/material.dart';
import 'package:maidstest/Provider/UserProvider.dart';
import 'package:maidstest/const/Tcolor.dart';
import 'package:maidstest/screen/Signin.dart';
import 'package:maidstest/screen/TaskScreen.dart';
import 'package:maidstest/screen/splashScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider()..checkLoginStatus(),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              textTheme: ThemeData.light().textTheme.copyWith(
                    titleLarge: TextStyle(
                      color: Tcolor.white,
                      fontSize: 20,
                      fontFamily: 'HB',
                    ),
                    titleMedium: TextStyle(
                      color: Tcolor.white,
                      fontSize: 15,
                      fontFamily: 'HB',
                    ),
                    displayMedium: TextStyle(
                      color: Tcolor.white,
                      fontSize: 20,
                      fontFamily: 'H',
                    ),
                    displaySmall: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'HB',
                    ),
                  ),
            ),
            home: userProvider.isSplashLoading
                ? SplashScreen()
                : (userProvider.isLoggedIn ? TodosPage() : Signin()),
            routes: {
              SplashScreen.screenRoute: (context) => SplashScreen(),
              Signin.screenRoute: (context) => Signin(),
              TodosPage.screenRoute: (context) => TodosPage(),
            },
          );
        },
      ),
    );
  }
}
