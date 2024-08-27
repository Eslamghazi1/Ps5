import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'sql.dart';
import 'package:numberpicker/numberpicker.dart';

class Insert_Orders extends StatefulWidget {
  @override
  _Insert_OrdersState createState() => new _Insert_OrdersState();
}

String controller_form = "";
String controller_to = "";

bool _isChecked = false;

class _Insert_OrdersState extends State<Insert_Orders> {
  int quantity = 1;
  final validate = GlobalKey<FormState>();
  TextEditingController time = TextEditingController();
  TextEditingController kind = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController hint = TextEditingController();

  String _selectedValue = "juice";
  List<String> listOfValue = ['Juice', 'Cola', 'Best', 'Chipsy','Indomie', 'Another','Tea','Coffee','Cofe Mix','Hot'];

  List<int> listOfint = [5,6, 7, 8, 10, 12, 13, 15,16,17,19,20];
  int intvalue = 0;

  Widget build(BuildContext context) {
    time.text = DateFormat.jmv().format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
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
                    DropdownButtonFormField(
                      hint: Text(
                        'choose one',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return " Can't Empty";
                        } else {
                          return null;
                        }
                      },
                      items: listOfValue.map((String val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(
                            val,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                        });
                      },
                    ),
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
                                  "ENTER THE AREA OR SELECT OTHERS",
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
                                    ListTile(
                                      title: const Text(
                                        "Others",
                                        textAlign: TextAlign.center,
                                      ),
                                      onTap: () {
                                        place.text = "Others";
                                        Navigator.pop(context);
                                      },
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
                    // the time to start
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            readOnly: true,
                            controller: time,
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
                      ],
                    ),
                    DropdownButtonFormField<int>(
                      hint: Text(
                        'Enter The Cost',
                      ),
                      validator: (value) {
                        String mody = value.toString();
                        if (value == null || mody.isEmpty) {
                          return "  Can't Empty";
                        } else {
                          return null;
                        }
                      },
                      items: listOfint.map((int val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(
                            val.toString(),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          intvalue = value!;
                        });
                      },
                    ),
                    Row(
                      children: [
                        // MINUTES DIALOG SELECTION
                        Expanded(
                            child: Text(
                          "quantity:",
                          style: TextStyle(fontSize: 18),
                        )),
                        Expanded(
                          flex: 4,
                          child: Center(
                            child: NumberPicker(
                              value: quantity,
                              minValue: 1,
                              maxValue: 10,
                              itemHeight: 40,
                              itemWidth: 40,
                              step: 1,
                              itemCount: 5,
                              selectedTextStyle: TextStyle(
                                  color: Colors.deepPurple, fontSize: 24),
                              infiniteLoop: true,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: Colors.black26),
                              ),
                              axis: Axis.horizontal,
                              onChanged: (value) =>
                                  setState(() => quantity = value),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // the state entry
              CheckboxListTile(
                value: _isChecked,
                onChanged: (newValue) {
                  setState(() {
                    _isChecked = newValue!;

                  });
                },
                title: Text('The State'),
                tristate: false, // Restrict to two states (true or false)
              ),
              SizedBox(
                height: 15,
              ),

              TextFormField(
                maxLength: 60,
                controller: hint,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(),
                    hintText: "Hint",
                    hintStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                        ))
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
            try{
              hint.text.isEmpty?hint.text="...":hint.text=hint.text;
              sql mysql = sql();
              if(_isChecked==true){
                await mysql.insert("orders", {
                  "position": place.text,
                  "name": _selectedValue,
                  "payment": intvalue * quantity,
                  "state": _isChecked.toString(),
                  "time": time.text,
                  "hint":hint.text,
                });

              }else{
                await mysql.insert("disorders", {
                  "position": place.text,
                  "name": _selectedValue,
                  "payment": intvalue * quantity,
                  "state": _isChecked.toString(),
                  "time": time.text,
                  "hint":hint.text,
                });
              }
              Navigator.pushNamedAndRemoveUntil(
                  context, "load_orders", (route) => false);
            } catch (erorr) {
            }
          }
        },
        child: const Icon(Icons.fact_check_outlined),
      ),
    );
  }
}
