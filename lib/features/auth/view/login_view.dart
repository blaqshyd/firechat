// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:gesture/constants/app_exports.dart';
import 'package:gesture/features/auth/view/signup_view.dart';
import 'package:gesture/features/auth/controller/auth_service.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  // final VoidCallback onTap;
  const LoginView({
    Key? key,
    // required this.onTap,
  }) : super(key: key);

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInUser(
        email: _emailCtrl.text,
        password: _pwdCtrl.text,
        context: context,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: AppConstants.padding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppConstants.appBar(),
              AppConstants.h32,
              CustomTextf(
                controller: _emailCtrl,
                hintText: 'Email Address',
                textInputAction: TextInputAction.next,
              ),
              AppConstants.h16,
              CustomTextf(
                controller: _pwdCtrl,
                hintText: 'Password',
                textInputAction: TextInputAction.done,
                obscureText: true,
              ),
              AppConstants.h32,
              ButtonUtil.filled(text: 'Login', cta: signIn),
              AppConstants.h32,
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: 'New member?'),
                    TextSpan(
                        text: '  Signup',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              AppRouter.pushReplacement(const SignupView()))
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}