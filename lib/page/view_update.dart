import 'package:database_app/db/my_database.dart';
import 'package:database_app/model/model.dart';
import 'package:flutter/material.dart';

class ViewUpdate extends StatefulWidget {
  final int? id;
  const ViewUpdate({
    super.key,
    required this.id,
  });

  @override
  State<ViewUpdate> createState() => _ViewUpdateState();
}

class _ViewUpdateState extends State<ViewUpdate> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController occupation = TextEditingController();
  final TextEditingController age = TextEditingController();
  bool rebuildOn = false;
  MainModel? result;
  bool showButton = false;

  void autoRefresh() async {
    setState(() {
      rebuildOn = true;
    });
    MainDatabase.instance.getById(widget.id).then((v) => result = v);
    setState(() {
      rebuildOn = false;
    });
  }

  void updateMyData() async {
    final editData = result!.copy(
      name: name.text,
      occupation: occupation.text,
      age: int.parse(age.text),
    );

    await MainDatabase.instance.updateData(editData);
  }

  //showbuttonController
  void conditionofShowButton() {
    if (name.text.isNotEmpty &&
        occupation.text.isNotEmpty &&
        age.text.isNotEmpty) {
      setState(
        () {
          showButton = true;
        },
      );
    } else {
      setState(
        () {
          showButton = false;
        },
      );
    }
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
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: MainDatabase.instance.getById(widget.id),
            builder: (context, snapshot) {
              if (!(snapshot.hasData)) {
                return const CircularProgressIndicator();
              }
              return result == null
                  ? const Center(
                      child: Text(
                        "Can't load",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Name:${snapshot.data!.name}\n\nOccupation:${snapshot.data!.occupation}\n\nAge:${snapshot.data!.age}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 100.0,
                            ),
                            const Text(
                              "Wanna Edit?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            //name
                            SizedBox(
                              height: 60.0,
                              width: 300.0,
                              child: TextFormField(
                                onChanged: (value) {
                                  conditionofShowButton();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty!";
                                  }
                                  return null;
                                },
                                controller: name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white12,
                                  labelText: "New Name",
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20.0,
                            ),
                            //occupation
                            SizedBox(
                              height: 60.0,
                              width: 300.0,
                              child: TextFormField(
                                onChanged: (value) {
                                  conditionofShowButton();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty!";
                                  }
                                  return null;
                                },
                                controller: occupation,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white12,
                                  labelText: "New Occupation",
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            //age
                            SizedBox(
                              height: 60.0,
                              width: 300.0,
                              child: TextFormField(
                                onChanged: (value) {
                                  conditionofShowButton();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty!";
                                  }
                                  return null;
                                },
                                controller: age,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white12,
                                  labelText: "New Age",
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            showButton
                                ? ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        updateMyData();
                                      });
                                      autoRefresh();
                                    },
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),

                            const SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
