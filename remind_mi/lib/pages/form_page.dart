// ignore_for_file: prefer_interpolation_to_compose_strings

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:remind_mi/models/reminder.dart';
import 'package:remind_mi/pages/todo_list_page.dart';
import 'package:remind_mi/utils/charter.dart';
import 'package:remind_mi/utils/hex_color.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class FormPage extends StatefulWidget {
  final Reminder? reminder;
  const FormPage({super.key, this.reminder});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormBuilderState>();
  final user = FirebaseAuth.instance.currentUser!;
  // Reminder? reminder;
  bool isAllDay = false;
  List<String> availableColors = [
    "FF4CAF50",
    "FFF44336",
    "FF2196F3",
    "FFE91E63",
    "FFFF9800",
    "FF9C27B0",
    "FF9E9E9E",
    "FFFFEB3B"
  ];
  // final String _backgroundColor = "FFFFEB3B";

  // void init() async {
  //   print("init form 1 : " + widget.reminder.toString());
  //   if (widget.reminder != null) {
  //     print("init form 2 : " + widget.reminder.toString());
  //     final reminder = await readReminder(widget.reminder!);
  //     setState(() {
  //       this.reminder = reminder;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // init();
  }

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor = Colors.red;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nouvel évènement'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(32),
            child: FormBuilder(
                key: formKey,
                onChanged: () {
                  formKey.currentState!.save();
                  debugPrint(formKey.currentState!.value.toString());
                },
                autovalidateMode: AutovalidateMode.disabled,
                child: ListView(children: [
                  FormBuilderTextField(
                    initialValue: widget.reminder?.title,
                    name: 'title',
                    style: const TextStyle(
                        fontSize: 16, color: Color.fromRGBO(248, 228, 148, 1)),
                    decoration: const InputDecoration(
                      labelText: 'Titre *',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  FormBuilderTextField(
                    initialValue: widget.reminder?.description,
                    name: 'description',
                    style: const TextStyle(
                        fontSize: 16, color: Color.fromRGBO(248, 228, 148, 1)),
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          "Jour entier :",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(248, 228, 148, 1)),
                        ),
                      ),
                      Expanded(
                        child: FormBuilderSwitch(
                          title: const Text(""),
                          initialValue: isAllDay,
                          name: 'all_day_long',
                          activeColor: const Color.fromRGBO(248, 228, 148, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          onChanged: (value) {
                            setState(() {
                              isAllDay = value ?? false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  FormBuilderDateTimePicker(
                    initialValue: widget.reminder?.startDate ?? beginDate(),
                    name: 'begin_date',
                    style: isAllDay
                        ? const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(248, 228, 148, 0.2))
                        : const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(248, 228, 148, 1)),
                    enabled: !isAllDay,
                    decoration: InputDecoration(
                      labelText: 'Date de début',
                      labelStyle: isAllDay
                          ? const TextStyle(
                              color: Color.fromRGBO(248, 228, 148, 0.2))
                          : const TextStyle(color: Colors.white),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  FormBuilderDateTimePicker(
                    initialValue: widget.reminder?.endDate ?? endDate(),
                    name: 'end_date',
                    style: isAllDay
                        ? const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(248, 228, 148, 0.2))
                        : const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(248, 228, 148, 1)),
                    enabled: !isAllDay,
                    decoration: InputDecoration(
                      labelText: 'Date de fin',
                      labelStyle: isAllDay
                          ? const TextStyle(
                              color: Color.fromRGBO(248, 228, 148, 0.2))
                          : const TextStyle(color: Colors.white),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        const Text(
                          "Couleur de fond :",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(248, 228, 148, 1)),
                        ),
                        SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FormBuilderField<String?>(
                            name: 'background_color',
                            builder: (FormFieldState field) {
                              return Container(
                                height: 35,
                                width: 65,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      backgroundColor: _backgroundColor),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Choisissez une couleur"),
                                            content: BlockPicker(
                                                pickerColor:
                                                    _backgroundColor, //default color
                                                onColorChanged: (Color color) {
                                                  _backgroundColor = color;
                                                  field.didChange(
                                                      getStringFromColor(
                                                          color));
                                                  Navigator.pop(context);
                                                }),
                                          );
                                        });
                                  },
                                  child: const SizedBox(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Récurrence :",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(248, 228, 148, 1)),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: FormBuilderDropdown(
                          menuMaxHeight: 300,
                          initialValue: "aucun",
                          iconSize: 40,
                          dropdownColor: Charter.primarycolor,
                          // decoration: const InputDecoration(
                          //     labelText: 'Couleur de fond',
                          //     labelStyle:
                          //         TextStyle(color: Colors.white, fontSize: 16)),
                          // alignment: AlignmentDirectional.bottomEnd,
                          name: "recurrence",
                          items: [
                            DropdownMenuItem(
                              value: "aucun",
                              child: Text(
                                "aucun",
                                style: TextStyle(
                                    color: Charter.secondarycolor[500]),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "FREQ=DAILY;INTERVAL=1",
                              child: Text(
                                "quotidien",
                                style: TextStyle(
                                    color: Charter.secondarycolor[500]),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "FREQ=WEEKLY;INTERVAL=1",
                              child: Text(
                                "hebdomadaire",
                                style: TextStyle(
                                    color: Charter.secondarycolor[500]),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "FREQ=MONTHLY;INTERVAL=1",
                              child: Text(
                                "mensuel",
                                style: TextStyle(
                                    color: Charter.secondarycolor[500]),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "FREQ=YEARLY;INTERVAL=1",
                              child: Text(
                                "annuel",
                                style: TextStyle(
                                    color: Charter.secondarycolor[500]),
                              ),
                            ),
                          ],
                          // validator: FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(),
                          // ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      await saveReminder(
                          formKey.currentState?.value, widget.reminder);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ToDoList(),
                      ));
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
                            'Enregistrer',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Icon(Icons.save, size: 24),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      widget.reminder?.delete();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(20),
                      backgroundColor: const Color.fromARGB(255, 163, 28, 28),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Supprimer',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Icon(Icons.delete, size: 24, color: Colors.white),
                      ],
                    ),
                  ),
                ]))));
  }

  DateTime beginDate() {
    return DateTime.now();
  }

  DateTime endDate() {
    return DateTime.now().add(const Duration(hours: 2));
  }
}

String getStringFromColor(dynamic color) {
  print(color);
  if (color.runtimeType == MaterialColor) {
    return color
        .toString()
        .substring(color.toString().length - 10, color.toString().length - 2)
        .toUpperCase();
  }
  if (color.runtimeType == Color) {
    return color
        .toString()
        .substring(color.toString().length - 9, color.toString().length - 1)
        .toUpperCase();
  }
  return "FFFCFCFC";
}

Future saveReminder(formular, reminder) async {
  if (formular["title"] != null && formular["title"] != "") {
    String? id = reminder?.ref?.id;
    if (id != null) {
      final docReminder = FirebaseFirestore.instance
          .collection('reminder_collection')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('reminders')
          .doc(id);

      final reminder = Reminder(
          title: formular["title"],
          startDate: formular["begin_date"],
          endDate: formular["end_date"],
          description: formular["description"],
          reminder: formular["reminder"],
          recurrence: formular["recurrence"],
          background: formular["background_color"] ?? "FF4CAF50",
          isAllDay: formular["all_day_long"]);

      final json = reminder.toJson();

      docReminder.update(json);
// }
    } else {
      try {
        final listReminders = FirebaseFirestore.instance
            .collection('reminder_collection')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('reminders');

        final reminder = Reminder(
            title: formular["title"],
            startDate: formular["begin_date"],
            endDate: formular["end_date"],
            description: formular["description"],
            reminder: formular["reminder"],
            recurrence: formular["recurrence"],
            background: formular["background_color"] ?? "FF4CAF50",
            isAllDay: formular["all_day_long"]);

        final json = reminder.toJson();
        await listReminders.add(json);
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
  }
}

Future<Reminder?> readReminder(DocumentReference ref) async {
  final docReminder = FirebaseFirestore.instance
      .collection('reminder_collection')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('reminders')
      .doc(ref.id);

  final snapshot = await docReminder.get();

  if (snapshot.exists) {
    return Reminder.fromJson(snapshot.data()!, ref: snapshot.reference);
  } else {
    return null;
  }
}
