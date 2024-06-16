import 'package:flutter/material.dart';
import 'package:maidstest/Provider/UserProvider.dart';
import 'package:maidstest/const/Tcolor.dart';
import 'package:maidstest/widget/My_Button.dart';
import 'package:maidstest/widget/TextFlldBilder.dart';
import 'package:maidstest/widget/sizedboxbilder.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Signin extends StatefulWidget {
  static const screenRoute = '/signin';
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: userProvider.isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                child: Image.asset('assets/image/logo.png'),
              ),
              sizedboxbilder(50),
              TextFieldBilder(
                Title: 'Username',
                onchange: (value) {
                  userProvider.email = value;
                },
                obscureText: false,
              ),
              sizedboxbilder(20),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  TextFieldBilder(
                    Title: 'Password',
                    onchange: (value) {
                      userProvider.password = value;
                    },
                    obscureText: userProvider.hidepassword,
                  ),
                  InkWell(
                    onTap: () {
                      userProvider.hidepassword = !userProvider.hidepassword;
                      print(userProvider.hidepassword);
                      userProvider.notifyListeners();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      child: userProvider.hidepassword == true
                          ? Icon(Icons.remove_red_eye)
                          : Icon(Icons.hide_source),
                    ),
                  )
                ],
              ),
              sizedboxbilder(20),
              My_button(
                color: Tcolor.maincolor,
                title: 'Sign In',
                titleColor: Tcolor.white,
                onpressed: () async {
                  try {
                    if (userProvider.email.isEmpty ||
                        userProvider.password.isEmpty) {
                      Alert(
                        style: AlertStyle(
                          isOverlayTapDismiss: false,
                          alertBorder: Border.all(
                            color: Tcolor.maincolor,
                          ),
                        ),
                        context: context,
                        title: 'Sorry',
                        content: Text('Username and Password are required'),
                        buttons: [
                          DialogButton(
                            color: Tcolor.maincolor,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Ok',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ).show();
                    } else {
                      await userProvider.login(
                          context, userProvider.email, userProvider.password);
                    }
                  } catch (error) {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
