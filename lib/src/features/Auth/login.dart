import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/features/Auth/forget_password.dart';
import 'package:login_signin_screens/src/features/Auth/signin.dart';
import 'package:login_signin_screens/src/features/splash_screen/splash_screen.dart';
import 'package:login_signin_screens/src/shared/widgets/appButtan.dart';
import 'package:login_signin_screens/src/shared/widgets/textField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF8040),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                margin: EdgeInsets.only(top: 210),
                width: double.infinity,
                height: 800,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 40),
                      child: Text(
                        "LogIn",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TxtField('Emale', 'Login@example.com', false),
                    TxtField('Password', '*********', true),

                    AppButtan(btnText: 'Login'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgetPassword(),
                              ),
                            );
                          },
                          child: Text(
                            'Forget Password ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFFFF8040),
                              decorationThickness: 3,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    divider(),
                    otherLoginContainers(),
                    noAccount(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row noAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't Have Any Account? ", style: TextStyle(fontSize: 17)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SigninScreen()),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
            ),
          ),
        ),
      ],
    );
  }

  Padding otherLoginContainers() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Color(0xFFFFEBDB),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SplashScreen()),
                  );
                },
                child: Image.asset('assets/google.png'),
              ),
            ),
          ),
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Color(0xFFFFEBDB),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset('assets/twitter.png'),
            ),
          ),
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Color(0xFFFFEBDB),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset('assets/facebook.png'),
            ),
          ),
        ],
      ),
    );
  }

  Row divider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Divider(color: Colors.grey, thickness: 2)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'OR',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),

        Expanded(child: Divider(color: Colors.grey, thickness: 2)),
      ],
    );
  }
}
