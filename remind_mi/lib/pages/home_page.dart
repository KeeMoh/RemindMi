import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Nous sommes content de te revoir !'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Vous être connecté en tant que : ',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  user.email!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: signOut,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.arrow_back_sharp, size: 24),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Se déconnecter',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  Future signOut() async {
    try {
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
