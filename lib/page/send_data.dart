import 'package:database_app/db/my_database.dart';
import 'package:database_app/model/model.dart';
import 'package:flutter/material.dart';

class SendData extends StatefulWidget {
  const SendData({super.key});

  @override
  State<SendData> createState() => _SendDataState();
}

class _SendDataState extends State<SendData> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController occupation = TextEditingController();
  final TextEditingController age = TextEditingController();

  Future<MainModel>? result;

  Future sendMyData() async {
    final data = MainModel(
      name: name.text,
      age: int.parse(age.text),
      occupation: occupation.text,
    );
    result = MainDatabase.instance.postData(data);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //name
                  SizedBox(
                    height: 60.0,
                    width: 300.0,
                    child: TextFormField(
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
                        labelText: "Name",
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
                        labelText: "Occupation",
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
                        labelText: "Age",
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
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          sendMyData();
                        });
                      }
                    },
                    child: const Text(
                      "Send",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 300.0,
                    width: 300.0,
                    child: Center(
                      child: FutureBuilder(
                        future: result,
                        builder: (BuildContext context,
                            AsyncSnapshot<MainModel> snapshot) {
                          if (!(snapshot.hasData)) {
                            return const SizedBox();
                          }
                          return result == null
                              ? const Text(
                                  "Faild",
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                )
                              : const Text(
                                  "Successful",
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
