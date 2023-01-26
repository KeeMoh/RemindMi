// ignore_for_file: prefer_interpolation_to_compose_strings

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:remind_mi/models/reminder.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:remind_mi/models/reminders.dart';
import 'package:remind_mi/pages/todo_list_page.dart';

class FormPage extends StatefulWidget {
  final Reminder? reminder;
  const FormPage({super.key, this.reminder});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormBuilderState>();
  bool isAllDay = false;
  // bool reminding = false;
  // final isAllDay = ValueNotifier<bool>(false);
  // final user = FirebaseAuth.instance.currentUser!;
  List<MaterialColor> availableColors = [
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.pink,
    Colors.orange,
    Colors.purple,
    Colors.grey,
    Colors.yellow
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nouvel évènement'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(32),
            child: ListView(
              children: [
                FormBuilder(
                    key: formKey,
                    onChanged: () {
                      formKey.currentState!.save();
                      debugPrint(formKey.currentState!.value.toString());
                    },
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(children: [
                      FormBuilderTextField(
                        initialValue: widget.reminder?.title,
                        name: 'title',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(248, 228, 148, 1)),
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
                            fontSize: 16,
                            color: Color.fromRGBO(248, 228, 148, 1)),
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
                              activeColor:
                                  const Color.fromRGBO(248, 228, 148, 1),
                              controlAffinity: ListTileControlAffinity.leading,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
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
                                      color: e,
                                      borderRadius: BorderRadius.circular(10)),
                                )))
                            .toList(),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          isSavePossible(
                                  formKey.currentState?.value, widget.reminder)
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      fullscreenDialog: false,
                                      builder: (context) => const ToDoList()))
                              : {print("missing data...")};
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
                          delete(widget.reminder);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(20),
                          backgroundColor:
                              const Color.fromARGB(255, 163, 28, 28),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Supprimer',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                            Icon(Icons.delete, size: 24, color: Colors.white),
                          ],
                        ),
                      ),
                    ])),
              ],
            )));
  }

  DateTime beginDate() {
    return DateTime.now();
  }

  DateTime endDate() {
    return DateTime.now().add(Duration(hours: 2));
  }
}

void addReminder(formData) {
  DateTime startDate = DateTime.now();
  Reminders.reminders.add(Reminder(
      userID: "", //FirebaseAuth.instance.currentUser!.uid,
      title: formData["title"],
      startDate: formData["begin_date"],
      endDate: formData["end_date"],
      description: formData["description"],
      background: formData["background_color"] ?? Colors.amber,
      isAllDay: formData["all_day_long"]));
  // setState(() {});
}

bool isSavePossible(formular, reminder) {
  if (formular["title"] != null && formular["title"] != "") {
    if (reminder != null) {
      delete(reminder);
    }
    addReminder(formular);
    print("save data");
    return true;
  }

  return false;
}

void delete(reminder) {
  Reminders.reminders.remove(reminder);
  print("delete");
}
// enum recurrence {
//   Jamais,
// }
