// ignore_for_file: prefer_interpolation_to_compose_strings

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:remind_mi/models/reminder.dart';
import 'package:remind_mi/utils/charter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:remind_mi/utils/hex_color.dart';

class FormPage extends StatefulWidget {
  final Reminder? reminder;
  final DateTime? beginDate;
  final DateTime? endDate;
  const FormPage({super.key, this.reminder, this.beginDate, this.endDate});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormBuilderState>();
  final user = FirebaseAuth.instance.currentUser!;
  bool isEdit = false;
  bool isAllDay = false;

  late DateTime valueBeginDate;
  late DateTime valueEndDate;

  @override
  void initState() {
    super.initState();

    valueBeginDate = validateBeginDate(widget.beginDate);
    valueEndDate = validateEndDate(widget.endDate, valueBeginDate);
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = (widget.reminder?.background != null)
        ? HexColor(widget.reminder!.background)
        : const Color(0xFFF44336);
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
                  if (!isEdit) {
                    setState(() {
                      isEdit = true;
                    });
                  }
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
                    initialValue: valueBeginDate,
                    name: 'begin_date',
                    locale: const Locale("fr", "FR"),
                    onChanged: (value) {
                      setState(() {
                        valueBeginDate = value!;
                        valueEndDate = validateEndDate(valueEndDate, value);
                      });
                    },
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
                    initialValue: valueEndDate,
                    name: 'end_date',
                    locale: const Locale("fr", "FR"),
                    onChanged: (value) {
                      setState(() {
                        valueEndDate = validateEndDate(value, valueBeginDate);
                      });
                    },
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
                        const SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FormBuilderField<String?>(
                            name: 'background_color',
                            builder: (FormFieldState field) {
                              return SizedBox(
                                height: 35,
                                width: 65,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      backgroundColor: backgroundColor),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Choisissez une couleur"),
                                            content: BlockPicker(
                                                pickerColor:
                                                    backgroundColor, //default color
                                                onColorChanged: (Color color) {
                                                  backgroundColor = color;
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
                      const SizedBox(width: 20),
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
                  isEdit
                      ? ElevatedButton(
                          onPressed: () async {
                            await saveReminder(
                                formKey.currentState?.value, widget.reminder);
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
                        )
                      : const SizedBox(height: 10),
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            isEdit ? 'Supprimer' : 'Annuler',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Icon(isEdit ? Icons.delete : Icons.arrow_back,
                            size: 24, color: Colors.white),
                      ],
                    ),
                  ),
                ]))));
  }

  Future saveReminder(formular, reminder) async {
    if (isEdit) {
      if (formular["title"] != null && formular["title"] != "") {
        if (formular["end_date"]!.isAfter(formular["begin_date"])) {
          String? id = reminder?.ref?.id;
          const successSnackBar = SnackBar(
            content: Text('Evenement sauvegardé'),
            backgroundColor: Color.fromARGB(255, 83, 201, 87),
            duration: Duration(seconds: 6),
          );

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
                background: formular["background_color"] ?? "FFF44336",
                isAllDay: formular["all_day_long"]);

            final json = reminder.toJson();

            docReminder.update(json);

            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
            // ignore: use_build_context_synchronously
            context.go('/');
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

              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
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
            }
          }
        } else {
          const errSnackBar = SnackBar(
            content: Text(
                "Sélectionnez une date de début antérieur à la date de fin"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 6),
          );

          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(errSnackBar);
        }
      } else {
        const errSnackBar = SnackBar(
          content: Text('Sélectionnez un titre'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 6),
        );

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(errSnackBar);
      }
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

DateTime validateBeginDate(DateTime? beginDate) {
  if (beginDate != null) {
    return beginDate;
  } else {
    return DateTime.now();
  }
}

DateTime validateEndDate(DateTime? endDate, DateTime valueBeginDate) {
  if (endDate != null) {
    if (endDate.isAfter(valueBeginDate)) {
      return endDate;
    } else {
      return valueBeginDate.add(const Duration(hours: 1));
    }
  } else {
    return valueBeginDate.add(const Duration(hours: 1));
  }
}



/* TODO : Séparer heure et date

FormBuilderDateTimePicker(
                    initialValue: valueBeginDate,
                    name: 'begin_date',
                    locale: const Locale("fr", "FR"),
                    inputType: InputType.date,
                    // onChanged: (value) {
                    //   setState(() {
                    //     valueBeginDate = value!;
                    //     valueEndDate = validateEndDate(valueEndDate, value);
                    //   });
                    // },
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
                    initialValue: valueBeginDate,
                    name: 'begin_time',
                    locale: const Locale("fr", "FR"),
                    inputType: InputType.time,
                    // onChanged: (value) {
                    //   setState(() {
                    //     valueBeginDate = value!;
                    //     valueEndDate = validateEndDate(valueEndDate, value);
                    //   });
                    // },
                    style: isAllDay
                        ? const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(248, 228, 148, 0.2))
                        : const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(248, 228, 148, 1)),
                    enabled: !isAllDay,
                    decoration: InputDecoration(
                      labelText: 'Heure de début',
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
                    initialValue: valueEndDate,
                    name: 'end_date',
                    locale: const Locale("fr", "FR"),
                    inputType: InputType.date,
                    onChanged: (value) {
                      setState(() {
                        valueEndDate = validateEndDate(value, valueBeginDate);
                      });
                    },
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
                  FormBuilderDateTimePicker(
                    initialValue: valueEndDate,
                    name: 'end_time',
                    locale: const Locale("fr", "FR"),
                    inputType: InputType.time,
                    onChanged: (value) {
                      setState(() {
                        valueEndDate = validateEndDate(value, valueBeginDate);
                      });
                    },
                    style: isAllDay
                        ? const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(248, 228, 148, 0.2))
                        : const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(248, 228, 148, 1)),
                    enabled: !isAllDay,
                    decoration: InputDecoration(
                      labelText: 'Heure de fin',
                      labelStyle: isAllDay
                          ? const TextStyle(
                              color: Color.fromRGBO(248, 228, 148, 0.2))
                          : const TextStyle(color: Colors.white),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),


*/