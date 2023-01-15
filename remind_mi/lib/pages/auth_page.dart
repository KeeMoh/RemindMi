import 'package:flutter/cupertino.dart';
import 'package:remind_mi/widgets/signin_widget.dart';
import 'package:remind_mi/widgets/signup_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) =>
      isLogin ? SignInWidget(onClickedSignUp: toggle) : SignUpWidget(onClickedSignIn: toggle);

  void toggle() {setState(() {
    isLogin = !isLogin;
  });}
}
