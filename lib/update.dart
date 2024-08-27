import 'package:flutter/material.dart';
import 'sql.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:audioplayers/audioplayers.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

String controller_form = "";
String controller_to = "";
int cost_demo = 0;
int minutes = 0;
int Hours = 0;
int second_hours = 0;
int second_minutes = 0;
bool STATE = false;

class _UpdateState extends State<Update> {
  bool STATE = false;
  bool check = false;
  Map<String, dynamic> data = {};
  Widget build(BuildContext context) {
    // STATE=false;
    data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ??
        // ignore: dead_null_aware_expression
        data;
    final validate = GlobalKey<FormState>();
    TextEditingController _fromController = TextEditingController();
    TextEditingController kind = TextEditingController();
    TextEditingController place = TextEditingController();
    kind.text = data["kind"];
    place.text = data["place"];
    controller_to = data["too"];
    controller_form = data["frm"];
    cost_demo = 0;
    second_hours = 0;
    second_minutes = 0;
    Hours = data["Hours"];
    minutes = data["Minutes"];

    DateTime dateTime = DateTime.parse(controller_form);

    _fromController.text = DateFormat.jmv().format(dateTime);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey,
          child: ListView(
            children: [
              Form(
                key: validate,
                child: Column(
                  children: <Widget>[
                    //  the place entry
                    TextFormField(
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter The Place";
                        }
                        return null;
                      },
                      controller: place,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white70,
                                title: Text(
                                  "ENTER THE AREA OR THE ROOM",
                                  textAlign: TextAlign.center,
                                ),
                                content: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            title: const Text(
                                              "Ps1",
                                              textAlign: TextAlign.center,
                                            ),
                                            onTap: () {
                                              place.text = "Ps1";
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            title: const Text(
                                              "Ps2",
                                              textAlign: TextAlign.center,
                                            ),
                                            onTap: () {
                                              place.text = "Ps2";
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            title: const Text(
                                              "Ps3",
                                              textAlign: TextAlign.center,
                                            ),
                                            onTap: () {
                                              place.text = "Ps3";
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            title: const Text(
                                              "Ps4",
                                              textAlign: TextAlign.center,
                                            ),
                                            onTap: () {
                                              place.text = "Ps4";
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            title: const Text(
                                              "Ps5",
                                              textAlign: TextAlign.center,
                                            ),
                                            onTap: () {
                                              place.text = "Ps5";
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            title: const Text(
                                              "Ps6",
                                              textAlign: TextAlign.center,
                                            ),
                                            onTap: () {
                                              place.text = "Ps6";
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      enabled: true,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(),
                          hintText: "place",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.deepPurple,
                          ))),
                    ),
                    // the kind entry
                    TextFormField(
                      readOnly: true,
                      controller: kind,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter The Kind";
                        }
                        return null;
                      },
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white70,
                                title: const Text("Choose the kind you want."),
                                content: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ListTile(
                                        title: const Text("Single"),
                                        onTap: () {
                                          kind.text = "Single";
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text("Multi"),
                                        onTap: () {
                                          kind.text = "Multi";
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(),
                          hintText: "kind",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.deepPurple,
                          ))),
                    ),
                    // the time to start
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            readOnly: true,
                            controller: _fromController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter The Time to Start";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIconColor: Colors.deepPurple,
                                prefixIcon: Icon(Icons.access_alarm),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.deepPurple,
                                )),
                                hintText: 'From',
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.deepPurple,
                                ))),
                          ),
                        ),
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                ),
                                onPressed: () {
                                  check = true;
                                  controller_form = DateTime.now().toString();
                                  _fromController.text =
                                      DateFormat.jmv().format(DateTime.now());
                                },
                                child: Text("Start",
                                    style: TextStyle(
                                      color: Colors.white,
                                    )))),
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white70,
                                          title: Text(
                                            "SELECT THE TIME TO SUBTRACT",
                                            textAlign: TextAlign.center,
                                          ),
                                          content: SizedBox(
                                              height: 180, child: _Integer()),
                                          actions: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.deepPurple,
                                                ),
                                                onPressed: () async {
                                                  check = true;
                                                  DateTime dateTime =
                                                      DateTime.parse(
                                                          controller_form);
                                                  dateTime = dateTime.subtract(
                                                      Duration(
                                                          hours: second_hours,
                                                          minutes:
                                                              second_minutes));
                                                  controller_form =
                                                      dateTime.toString();
                                                  _fromController.text =
                                                      DateFormat.jmv()
                                                          .format(dateTime);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Finish",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    )))
                                          ],
                                        );
                                      });
                                },
                                child: Text("Edit",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ))))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "ENTER THE EXPECTED TIME TO FINISH AFTER (UPDATED):",
                      style: TextStyle(fontSize: 19),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _IntegerExample(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () async {
          if (validate.currentState!.validate()) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Great")));
            String costst = "Not Yet";
            try {
              double costdouble = 0.0;
              // ignore: unused_local_variable
              bool mass = false;

              DateTime dateTime = DateTime.parse(controller_form);
              sql mysql = sql();
              if (Hours == 0 && minutes == 0) {
              } else {
                DateTime dateTimesecond =
                    dateTime.add(Duration(hours: Hours, minutes: minutes));
                controller_to = dateTimesecond.toString();
                if (kind.text == "Multi") {
                  place.text == "Ps6" ? mass = false : mass = true;
                  costdouble = place.text == "Ps6"
                      ? ((Hours + (minutes / 60)) * 30)
                      : ((Hours + (minutes / 60)) * 25);
                  if (place.text == "Ps6")
                    costdouble = costdouble % 5 < 3.2
                        ? costdouble - (costdouble % 5)
                        : costdouble + (5 - (costdouble % 5));
                  else
                    costdouble = costdouble % 5 < 3.2
                        ? costdouble - (costdouble % 5)
                        : costdouble + (5 - (costdouble % 5));
                  cost_demo = costdouble.toInt();
                } else {
                  place.text == "Ps6" ? mass = false : mass = true;
                  costdouble = (place.text == "Ps6")
                      ? ((Hours + (minutes / 60)) * 25)
                      : ((Hours + (minutes / 60)) * 20);
                  if (place.text == "Ps6")
                    costdouble = costdouble % 5 < 3.2
                        ? costdouble - (costdouble % 5)
                        : costdouble + (5 - (costdouble % 5));
                  else
                    costdouble = costdouble % 5 < 3.2
                        ? costdouble - (costdouble % 5)
                        : costdouble + (5 - (costdouble % 5));
                  cost_demo = costdouble.toInt();
                }
                costst = cost_demo.toString();
              }
              controller_to =
                  controller_to.isEmpty ? "Still Running" : controller_to;
              await mysql.update(
                  "tables",
                  {
                    "kind": kind.text,
                    "place": place.text,
                    "frm": controller_form,
                    "too": controller_to,
                    "cost": costst,
                    "state": STATE.toString(),
                  },
                  "id=${data["id"]}");
              Navigator.pushNamedAndRemoveUntil(
                  context, "loading", (route) => false);
            } catch (erorr) {}
          }
        },
        child: const Icon(Icons.fact_check_outlined),
      ),
    );
  }
}

class _IntegerExample extends StatefulWidget {
  @override
  __IntegerExampleState createState() => __IntegerExampleState();
}

class __IntegerExampleState extends State<_IntegerExample> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // the Hours Row
        Row(
          children: [
            // HOURS DIALOG SELECTION
            Expanded(
                child: Text(
              " Hours:",
              style: TextStyle(fontSize: 20),
            )),
            Expanded(
              flex: 4,
              child: Center(
                child: NumberPicker(
                  value: Hours,
                  minValue: 0,
                  maxValue: 24,
                  step: 1,
                  itemHeight: 40,
                  itemWidth: 40,
                  itemCount: 5,
                  selectedTextStyle:
                      TextStyle(color: Colors.deepPurple, fontSize: 24),
                  infiniteLoop: true,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.black26),
                  ),
                  axis: Axis.horizontal,
                  onChanged: (value) => setState(() {
                    Hours = value;
                  }),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        // The Minutes Row
        Row(
          children: [
            // MINUTES DIALOG SELECTION
            Expanded(
                child: Text(
              " Minutes:",
              style: TextStyle(fontSize: 20),
            )),
            Expanded(
              flex: 4,
              child: Center(
                child: NumberPicker(
                  value: minutes,
                  minValue: 0,
                  maxValue: 59,
                  itemHeight: 40,
                  itemWidth: 40,
                  step: 5,
                  itemCount: 5,
                  selectedTextStyle:
                      TextStyle(color: Colors.deepPurple, fontSize: 24),
                  infiniteLoop: true,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.black26),
                  ),
                  axis: Axis.horizontal,
                  onChanged: (value) => setState(() => minutes = value),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Integer extends StatefulWidget {
  @override
  __IntegerState createState() => __IntegerState();
}

class __IntegerState extends State<_Integer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // the Hours Row
        Row(
          children: [
            // HOURS DIALOG SELECTION
            Expanded(
                flex: 2,
                child: Text(
                  "Hours:",
                  // style: TextStyle(fontSize: 18),
                )),
            Expanded(
              flex: 4,
              child: Center(
                child: NumberPicker(
                  value: second_hours,
                  minValue: 0,
                  maxValue: 24,
                  itemHeight: 40,
                  itemWidth: 30,
                  itemCount: 5,
                  selectedTextStyle:
                      TextStyle(color: Colors.deepPurple, fontSize: 22),
                  infiniteLoop: true,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.black26),
                  ),
                  axis: Axis.horizontal,
                  onChanged: (value) => setState(() {
                    second_hours = value;
                  }),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        // The Minutes Row
        Row(
          children: [
            // MINUTES DIALOG SELECTION
            Expanded(
                flex: 2,
                child: Text(
                  "Minutes:",
                  // style: TextStyle(fontSize: 18),
                )),
            Expanded(
              flex: 4,
              child: Center(
                child: NumberPicker(
                  value: second_minutes,
                  minValue: 0,
                  maxValue: 59,
                  itemHeight: 40,
                  itemWidth: 30,
                  step: 2,
                  itemCount: 5,
                  selectedTextStyle:
                      TextStyle(color: Colors.deepPurple, fontSize: 22),
                  infiniteLoop: true,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black26),
                  ),
                  axis: Axis.horizontal,
                  onChanged: (value) => setState(() => second_minutes = value),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


DateTime convert_time(String time) {
  DateTime dateTimesecond = DateTime.parse(time);
  return dateTimesecond;
}

String Extractdata(String time) {
  try {
    DateTime dateTimesecond = DateTime.parse(time);
    String instance = DateFormat.jmv().format(dateTimesecond);
    return instance;
  } catch (error) {
    return "error of returning";
  }
}
