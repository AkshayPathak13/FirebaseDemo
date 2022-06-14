import 'package:elred_test/arguments.dart';
import 'package:elred_test/models/note_model.dart';
import 'package:elred_test/enums.dart';
import 'package:elred_test/screens/note.dart';
import 'package:elred_test/service/app_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'header.dart';

class Home extends StatefulWidget {
  static const String route = '/Home';
  final HomeArguments arguments;
  const Home({Key? key, required this.arguments}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DateFormat dateFormat = DateFormat("hh aa");
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          const Expanded(
            flex: 2,
            child: Header(),
          ),
          Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Text('INBOX'), noteList()],
                ),
              ))
        ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              AppService.navigateTo(Note.route,
                  arguments: NoteArguments(
                      navigation: NAVIGATION.push,
                      noteMode: NoteMode.add,
                      noteModel: NoteModel.empty()));
            },
            child: const Icon(Icons.add)),
      ),
    );
  }

  Expanded noteList() {
    return Expanded(
      child: StreamBuilder<List<NoteModel>>(
          stream: AppService.dataService!.getNotes(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                if (!snapshot.hasData) {
                  return const Center(child: Text('NO NOTES'));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const Divider(color: Colors.black),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    AppService.navigateTo(Note.route,
                                        arguments: NoteArguments(
                                            navigation: NAVIGATION.push,
                                            noteMode: NoteMode.update,
                                            noteModel: snapshot.data![index]));
                                  },
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  leading: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.grey, width: 2)),
                                      child: const Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Icon(Icons.menu))),
                                  title: Text(
                                    snapshot.data![index].taskName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index].description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          dateFormat.format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  int.parse(snapshot
                                                      .data![index].time))),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                ),
                              ],
                            );
                          }),
                    ),
                    Row(
                      children: [
                        Text(
                          'COMPLETED',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          child: Text(
                            snapshot.data?.length.toString() ?? '0',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                );
            }
          }),
    );
  }
}
