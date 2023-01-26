import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:remind_mi/pages/home_page.dart';
import 'package:remind_mi/pages/main_page.dart';
import 'package:remind_mi/utils/charter.dart';
import 'package:remind_mi/widgets/custom_menu.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmePasswordController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  String? errMsg = '';
  String? successMsg = '';

  @override
  void dispose() {
    passwordController.dispose();
    confirmePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Charter.secondarycolor,
        foregroundColor: Charter.primarycolor,
        elevation: 0,
        title: const Center(child: Text("Paramètres du compte")),
        actions: const [CustomMenu()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Image.asset(
                    'assets/logo/remindmi_logo_nobg.png',
                    height: 120,
                    width: 120,
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: [
                      const Text(
                        'Vous être connecté en tant que : ',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.email!,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 2.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2.0, color: const Color(0xFFFFFFFF))),
                    child: Column(children: [
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          "Changer de mot de passe",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Charter.secondarycolor),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            labelText: 'Mot de passe',
                            labelStyle: TextStyle(color: Colors.white)),
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => (value != null && value.length < 6
                            ? 'Votre mot de passe doit avoir au moins 6 caractères'
                            : null),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: confirmePasswordController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            labelText: 'Confirmation du mot de passe',
                            labelStyle: TextStyle(color: Colors.white)),
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => (value != null &&
                                value.trim() != passwordController.text.trim()
                            ? 'Vos mots de passes doivent être identiques'
                            : null),
                      ),
                      const SizedBox(height: 20),
                      Text(errMsg!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                      Text(successMsg!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      const SizedBox(height: 10),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: resetPwd,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Enregistrer',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Icon(Icons.save, size: 24),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  RichText(
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = signOut,
                          text: 'Déconnexion',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).colorScheme.secondary)))
                ],
              ),
            )),
      ));

  Future resetPwd() async {
    final isValid = formKey.currentState!.validate();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    if (!isValid) {
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()));

      User? currentUser = firebaseAuth.currentUser;
      currentUser?.updatePassword(passwordController.text).then((res) {
        passwordController.text = "";
        confirmePasswordController.text = "";
        setState(() {
          errMsg = "";
          successMsg = "mot de passe modifié avec succès !";
        });
      }).catchError((err) {
        passwordController.text = "";
        confirmePasswordController.text = "";
        setState(() {
          errMsg = err.message;
          successMsg = "";
        });
      });
      // Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }

  Future signOut() async {
    try {
      FirebaseAuth.instance.signOut();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
