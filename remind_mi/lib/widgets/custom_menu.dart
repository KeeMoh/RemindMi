import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remind_mi/utils/charter.dart';

class CustomMenu extends StatelessWidget {
  const CustomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        // shape: ShapeBorder(OutlinedBorder(side: )),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        color: Charter.white,
        offset: const Offset(20, 50),
        itemBuilder: (context) => [
              PopupMenuItem(
                  child: GestureDetector(
                      onTap: () => context.go('/'),
                      child: Row(
                        children: const [
                          Icon(Icons.star, color: Charter.red),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Évènements")
                        ],
                      ))),
              PopupMenuItem(
                  child: GestureDetector(
                      onTap: () => context.go('/calendar'),
                      child: Row(
                        children: const [
                          Icon(Icons.view_agenda, color: Charter.red),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Agenda")
                        ],
                      ))),
              PopupMenuItem(
                  child: GestureDetector(
                      onTap: () => context.go('/parameters'),
                      child: Row(
                        children: const [
                          Icon(Icons.settings, color: Charter.red),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Compte")
                        ],
                      ))),
            ]);
  }
}
