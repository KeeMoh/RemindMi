// ignore_for_file: prefer_interpolation_to_compose_strings

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {
  final DateTime selectedDate;
  const FormPage({super.key, required this.selectedDate});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormBuilderState>();
  bool isAllDay = true;
  // bool reminding = false;
  // final isAllDay = ValueNotifier<bool>(false);
  // final user = FirebaseAuth.instance.currentUser!;

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
                        initialValue: 'unknown',
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
                        initialValue: "no description",
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
                        initialValue: beginDate(widget.selectedDate),
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
                        initialValue: endDate(widget.selectedDate),
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
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          print("save data");
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
                        onPressed: delete,
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

  DateTime beginDate(DateTime date) {
    return DateTime.parse(
        DateFormat("yyyy-MM-dd").format(date) + " 00:00:00.000");
  }

  DateTime endDate(DateTime date) {
    return DateTime.parse(
        DateFormat("yyyy-MM-dd").format(date) + " 23:59:59.999");
  }
}

void delete() {
  print("delete");
}
// enum recurrence {
//   Jamais,
// }
