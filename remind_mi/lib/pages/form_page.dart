// ignore_for_file: prefer_interpolation_to_compose_strings

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:remind_mi/models/reminder.dart';
import 'package:remind_mi/pages/todo_list_page.dart';
import 'package:remind_mi/utils/hex_color.dart';

class FormPage extends StatefulWidget {
  final DocumentReference? docReference;
  const FormPage({super.key, this.docReference});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormBuilderState>();
  final user = FirebaseAuth.instance.currentUser!;
  Reminder? reminder;
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
  // bool reminding = false;
  // final user = FirebaseAuth.instance.currentUser!;

  void init() async {
    print("init form 1 : " + widget.docReference.toString());
    if (widget.docReference != null) {
      print("init form 2 : " + widget.docReference.toString());
      final reminder = await readReminder(widget.docReference!);
      setState(() {
        this.reminder = reminder;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
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
                    initialValue: reminder?.title,
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
                    initialValue: reminder?.description,
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
                    initialValue: reminder?.startDate ?? beginDate(),
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
                    initialValue: reminder?.endDate ?? endDate(),
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
                  FormBuilderDropdown(
                    iconSize: 40,
                    decoration: const InputDecoration(
                        labelText: 'Couleur de fond',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 16)),
                    alignment: AlignmentDirectional.bottomEnd,
                    name: "background_color",
                    items: availableColors
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: HexColor(e),
                                  borderRadius: BorderRadius.circular(10)),
                            )))
                        .toList(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await saveReminder(widget.docReference?.id,
                          formKey.currentState?.value, reminder);
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
                      delete(context, widget.docReference?.id);
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

Future saveReminder(docId, formular, reminder) async {
  if (formular["title"] != null && formular["title"] != "") {
    if (docId != null) {
      final docReminder = FirebaseFirestore.instance
          .collection('reminder_collection')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('reminders')
          .doc(docId);

      final reminder = Reminder(
          title: formular["title"],
          startDate: formular["begin_date"],
          endDate: formular["end_date"],
          description: formular["description"],
          reminder: formular["reminder"],
          recurrence: formular["recurrence"],
          background: formular["background"] ?? "FF4CAF50",
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
            background: formular["background"] ?? "FF4CAF50",
            isAllDay: formular["all_day_long"]);

        final json = reminder.toJson();
        await listReminders.add(json);
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
  }
}

void delete(context, docId) {
  if (docId != null) {
    print("delete " + docId);
  } else {
    Navigator.of(context).pop();
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
