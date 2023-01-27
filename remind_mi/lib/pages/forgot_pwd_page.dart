import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text("Réinitialiser votre mot de passe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Mot de passe oublié ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Une fois votre demande envoyée, vous recevrez un lien pour réinitialiser votre mot de passe.",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    resetPwd();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Soumettre',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                      ),
                      Icon(Icons.email, size: 24),
                    ],
                  ),
                ),
              ],
            )),
      ));

  Future resetPwd() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()));
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());

        final successSnackBar = SnackBar(
          content:
              Text('Un email a été envoyé à ${emailController.text.trim()}'),
          backgroundColor: const Color.fromARGB(255, 83, 201, 87),
          duration: const Duration(seconds: 6),
        );

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        context.go('/');
      } on FirebaseAuthException catch (e) {
        final errSnackBar = SnackBar(
          content: Text('Erreur : ${e.message}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 6),
        );

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(errSnackBar);
        // Utils.showSnackBar(e.message);
        Navigator.pop(context);
      }
    }
  }
}
