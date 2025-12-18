import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/features/Auth/forget_password.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF8040),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 30),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
              margin: EdgeInsets.only(top: 30),
              width: double.infinity,
              height: 850,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textField('First Name', 'Muhammad', false),
                  textField('Last Name', 'Ali', false),
                  textField('Email', 'Login@abc.com', false),
                  textField('Password', '*********', true),
                  textField('Confirm Password', '*********', true),
                  button('Sign Up'),
                  divider(),
                  otherLoginContainers(),
                  noAccount(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row noAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Have An Account ", style: TextStyle(fontSize: 17)),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            "Login",
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgetPassword()),
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Color(0xFFFFEBDB),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: Image.asset('assets/google.png'),
              ),
            ),
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Color(0xFFFFEBDB),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Image.asset('assets/twitter.png'),
            ),
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Color(0xFFFFEBDB),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(17),
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

  Container button(String btnText) {
    return Container(
      margin: EdgeInsets.only(top: 25, bottom: 25),
      height: 50,
      width: 450,
      decoration: BoxDecoration(
        color: Color(0xFFFF8040),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container textField(String lableText, String hintText, bool isTexthide) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              lableText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          TextField(
            obscureText: isTexthide,

            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.shade500),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
