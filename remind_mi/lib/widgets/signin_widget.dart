import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:remind_mi/app.dart';
import 'package:remind_mi/pages/forgot_pwd_page.dart';

class SignInWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const SignInWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errMsg = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Image.asset(
              'assets/logo/remindmi_logo_nobg.png',
              height: 120,
              width: 120,
            ),
            const Text('Connexion sur RemindMi',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 40),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  (email != null && !EmailValidator.validate(email)
                      ? 'Utilisez un email valide'
                      : null),
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: passwordController,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  labelStyle: TextStyle(color: Colors.white)),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => (value != null && value.length < 6
                  ? 'Votre mot de passe doit avoir au moins 6 caractères'
                  : null),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              child: Text("mot de passe oublié?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary)),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ForgotPasswordPage())),
            ),
            const SizedBox(height: 20),
            Text(errMsg!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signIn,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Connexion',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                  Icon(Icons.arrow_forward_sharp, size: 24),
                ],
              ),
            ),
            const SizedBox(height: 24),
            RichText(
                text: TextSpan(
                    text: 'Première connexion?  ',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: 'Créer un compte',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary))
                ]))
          ],
        ),
      ));

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      setState(() {
        passwordController.text = "";
      });
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()));

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          passwordController.text = '';
          errMsg = e.message;
        });
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
}
