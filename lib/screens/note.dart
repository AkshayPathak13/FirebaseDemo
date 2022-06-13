import 'package:elred_test/arguments.dart';
import 'package:elred_test/models/note_model.dart';
import 'package:elred_test/service/app_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../enums.dart';

class Note extends StatefulWidget {
  static const String route = '/Note';
  final NoteArguments createNoteArguments;
  const Note({Key? key, required this.createNoteArguments}) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final backgroundColor = const Color.fromRGBO(70, 83, 158, 1);
  final iconColor = const Color.fromRGBO(46, 186, 239, 1);
  final UnderlineInputBorder underlineInputBorder = const UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.white));
  late final TextEditingController taskNameController;
  late final TextEditingController descriptonController;
  late final TextEditingController dateController;
  final DateFormat dateFormat = DateFormat.yMd();
  DateTime selectedDate = DateTime.now();
  late String noteType;
  @override
  void initState() {
    noteType = widget.createNoteArguments.noteModel.type;
    taskNameController = TextEditingController(
        text: widget.createNoteArguments.noteModel.taskName);
    descriptonController = TextEditingController(
        text: widget.createNoteArguments.noteModel.description);

    dateController = TextEditingController(
        text: dateFormat.format(DateTime.fromMillisecondsSinceEpoch(
            int.tryParse(widget.createNoteArguments.noteModel.time) ??
                selectedDate.millisecondsSinceEpoch)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                color: iconColor,
                icon: const Icon(Icons.arrow_back),
                onPressed: goBack,
              ),
              Text(
                'Add new thing',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
              Icon(Icons.toggle_on_rounded, color: iconColor)
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade500)),
                child: Icon(
                  Icons.ac_unit,
                  color: iconColor,
                  size: 48,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
              child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                createDropDown(),
                createTextField(taskNameController, 'Task Name'),
                createTextField(descriptonController, 'Description'),
                datePicker(context, dateController, 'Select Date'),
                const SizedBox(height: 10),
                actions()
              ],
            ),
          ))
        ]),
      ),
    ));
  }

  Widget actions() {
    switch (widget.createNoteArguments.noteMode) {
      case NoteMode.add:
        return ElevatedButton(
            onPressed: () {
              var doc = widget.createNoteArguments.collectionReference.doc();
              final noteModel = NoteModel(
                  taskName: taskNameController.text.toString(),
                  type: noteType,
                  id: doc.id,
                  description: descriptonController.text.toString(),
                  time: DateTime.now().millisecondsSinceEpoch.toString());
              doc.set(noteModel.toJson()).then((value) {
                if (mounted) {
                  AppService.pop();
                }
              });
            },
            child: const Text('ADD YOUR THING'));
      case NoteMode.update:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  var doc = widget.createNoteArguments.collectionReference
                      .doc(widget.createNoteArguments.noteModel.id);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('DELETING')));
                  doc.delete().then((value) => goBack());
                },
                child: const Text('DELETE')),
            const SizedBox(width: 50),
            ElevatedButton(
                onPressed: () {
                  var doc = widget.createNoteArguments.collectionReference
                      .doc(widget.createNoteArguments.noteModel.id);
                  final noteModel = NoteModel(
                      taskName: taskNameController.text.toString(),
                      type: noteType,
                      id: doc.id,
                      description: descriptonController.text.toString(),
                      time: DateTime.now().millisecondsSinceEpoch.toString());
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('UPDATING')));
                  doc.set(noteModel.toJson()).then((value) => goBack());
                },
                child: const Text('UPDATE'))
          ],
        );
    }
  }

  void goBack() {
    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      AppService.pop();
    }
  }

  DropdownButton<String> createDropDown() {
    return DropdownButton<String>(
        underline: Container(
          color: Colors.white,
          height: 1,
        ),
        isExpanded: true,
        value: noteType,
        icon: const Icon(Icons.keyboard_arrow_down),
        iconEnabledColor: Colors.white,
        dropdownColor: iconColor,
        style: const TextStyle(color: Colors.white),
        items: ['Business', 'Personal']
            .map((e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.white),
                )))
            .toList(),
        onChanged: (item) {
          setState(() {
            noteType = item!;
          });
        });
  }

  TextField createTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: hintText,
          suffixIconConstraints:
              const BoxConstraints.tightForFinite(width: 18, height: 18),
          suffixIcon: InkWell(
            onTap: () {
              controller.clear();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3), shape: BoxShape.circle),
              child: const Icon(
                Icons.clear,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
          focusedBorder: underlineInputBorder,
          enabledBorder: underlineInputBorder,
          border: underlineInputBorder),
    );
  }

  Future? _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      controller.value =
          TextEditingValue(text: dateFormat.format(picked).toString());
    }
  }

  GestureDetector datePicker(
      BuildContext context, TextEditingController controller, String hintText) {
    return GestureDetector(
      onTap: () => _selectDate(context, controller),
      child: AbsorbPointer(
        child: TextField(
            controller: controller,
            keyboardType: TextInputType.datetime,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: hintText,
                focusedBorder: underlineInputBorder,
                enabledBorder: underlineInputBorder,
                border: underlineInputBorder)),
      ),
    );
  }

  @override
  void dispose() {
    taskNameController.dispose();
    descriptonController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
