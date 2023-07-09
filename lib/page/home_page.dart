import 'package:database_app/db/my_database.dart';
import 'package:database_app/model/model.dart';
import 'package:database_app/page/send_data.dart';
import 'package:database_app/page/view_update.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MainModel>? allResponse;
  final MainDatabase ins = MainDatabase.instance;
  bool rebuildOn = false;

  void autoRefresh() {
    setState(
      () {
        rebuildOn = true;
      },
    );
    ins.getAllData().then((v) => allResponse = v);
    setState(
      () {
        rebuildOn = false;
      },
    );
  }

  @override
  void initState() {
    autoRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const SendData();
              },
            ),
          );
          autoRefresh();
        },
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: const Icon(
          Icons.add_box_rounded,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: ins.getAllData(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<MainModel>> snapshot) {
                if (!(snapshot.hasData)) {
                  return const LinearProgressIndicator();
                }
                return rebuildOn
                    ? const LinearProgressIndicator()
                    : allResponse == null || allResponse!.isEmpty
                        ? const Center(
                            child: Text(
                              "No Data!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: allResponse!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return ViewUpdate(
                                          id: allResponse![index].id,
                                        );
                                      },
                                    ),
                                  );
                                  autoRefresh();
                                },
                                child: Dismissible(
                                  key: Key(allResponse![index].id.toString()),
                                  onDismissed: (direction) async {
                                    await MainDatabase.instance.deleteData(
                                      allResponse![index].id,
                                    );
                                    setState(
                                      () {
                                        allResponse!.removeAt(index);
                                      },
                                    );
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 60.0,
                                    ),
                                  ),
                                  child: Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      title: Text(
                                        allResponse![index].name.toString(),
                                        style: const TextStyle(
                                          color: Colors.purple,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        allResponse![index].id.toString(),
                                        style: const TextStyle(
                                          color: Colors.purple,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                height: 10.0,
                                thickness: 5.0,
                                color: Colors.white10,
                              );
                            },
                          );
              },
            ),
          ),
        ),
      ),
    );
  }
}
