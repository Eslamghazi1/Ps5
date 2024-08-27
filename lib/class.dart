import 'sql.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class tester extends StatefulWidget {
  const tester({super.key});

  @override
  State<tester> createState() => _testerState();
}

class _testerState extends State<tester> {
  @override

    void initState() {
      // TODO: implement initState
      super.initState();
      gettheorders_costs();
    }
    String Home = "PLAY LIST";
    Map<String, dynamic> data = {};
    @override
    Widget build(BuildContext context) {
      data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ??
          // ignore: dead_null_aware_expression
          data;
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: SafeArea(
          child: (data["data"].isEmpty)
              ? const Center(
            child: Text(
              "NO TABLE FOR THAT DAY YET!!!!",
              style: TextStyle(fontSize: 20),
            ),
          )
              : ListView(
            children: [
              const Divider(),
              Container(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.green[300],
                      child: Column(
                        children: [
                          InkWell(
                            child: Row(children: [
                              Expanded(child: Column(children: [
                                Text(
                                  data["data"][index]["place"],
                                  style: const TextStyle(fontSize: 22),
                                ),
                                Text(
                                    Extractdata(
                                        data["data"][index]["frm"]),
                                    style: const TextStyle(
                                        fontSize: 17))
                              ],)),
                              Expanded(child: Column(children: [
                              Text(data["data"][index]["kind"],
                                  style: const TextStyle(fontSize: 17)),
                              ],)),
                              Expanded(child: Column(children: [
                                Text(
                                  data["data"][index]["cost"],
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  gettonow(data["data"][index]
                                  ["frm"]),
                                  style: const TextStyle(
                                      fontSize: 17),
                                  textAlign: TextAlign.center,
                                )
                              ],)),

                              Expanded(child: Column(children: [
                                Text(
                                finishedtime(data["data"][index]["too"]),
                                style: const TextStyle(fontSize: 17),
                                textAlign: TextAlign.center,
                              )
                                ,],)),
                            ],
                            ),

                          ),




                          Row(
                            children: <Widget>[
                              //   the stop button
                              Expanded(
                                  child: Container(
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          sql mysql = sql();
                                          String instance =
                                          cost_calculator(data["data"]
                                          [index])
                                              .toString();
                                          await mysql.update(
                                              "tables",
                                              {
                                                "too": DateTime.now()
                                                    .toString(),
                                                "cost": instance,
                                              },
                                              "id=${data["data"][index]["id"]}");
                                          setState(() {
                                            // data["data"][index]["too"]=DateFormat.jmv().format(DateTime.now());
                                            // data["data"][index]["cost"]=cost_calculator(data).toString();
                                            // checkcolor(data["data"][index]["too"]);
                                          });
                                        },
                                        child: Text("STOP")),
                                  )),
                              // the refresh buttom
                              Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                        });
                                      },
                                      child: Text("REFRESH"))),
                              // the delete buttom
                              Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () async {
                                        sql mysql = sql();
                                        // Make sure the data object is mutable
                                        Map<String, dynamic> mutableData = data;
                                        mutableData["data"].removeAt(index);

                                        // Update the database
                                        try {
                                          await mysql.deletedb("DELETE FROM tables WHERE id = ${mutableData["id"]}");
                                        } catch (error) {
                                          // Handle error and display message to user
                                        }

                                        // Remove the element from the data list
                                        setState(() {

                                           data=mutableData;
                                        });

                                        // Navigate back to the previous screen
                                        Navigator.pop(context);
                                      },
                                      child: Text("DELETE"))),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: ((data["data"]).length) as int,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "insert_tester");
          }),
    );
  }
}
gettheorders_costs()async{
  int? tempcost=0;
  try{
    List<Map> instance;
    sql mysql=sql();
    instance= await mysql.readdb("SELECT payment FROM orders");
    for(int i=0;i<instance.length;i++){
      tempcost=(tempcost!+instance[i]["payment"]) as int?;
    }
    return tempcost;
  }catch(error){
    return 0;
  }
}

// get the cost of the stopping timer
int cost_calculator(Map data) {
  try {
    int cost_demo = 0;
    DateFormat dateFormatsecond = DateFormat('h:mma MM/dd/yyyy');
    DateTime dateTimesecond = dateFormatsecond.parse(data["frm"]);
    dynamic duration = DateTime.now().difference(dateTimesecond);
    int wholeHours = duration.inHours;
    wholeHours = wholeHours.abs();
    int remainingMinutes = duration.inMinutes % 60;
    if (data["kind"] == "Multi") {
      cost_demo = data["place"] == "Ps5"
          ? ((wholeHours + (remainingMinutes / 60)) * 30).toInt()
          : ((wholeHours + (remainingMinutes / 60)) * 25).toInt();
      if(data["place"]=="Ps5")
        cost_demo=cost_demo%5<4.9
            ?cost_demo-(cost_demo%5):cost_demo+(5-(cost_demo%5));
      else
        cost_demo=cost_demo%5<4.1
            ?cost_demo-(cost_demo%5):cost_demo+(5-(cost_demo%5));

      cost_demo = cost_demo.toInt();
    } else {
      cost_demo = (data["place"] == "Ps5")
          ? ((wholeHours + (remainingMinutes / 60)) * 25).toInt()
          : ((wholeHours + (remainingMinutes / 60)) * 20).toInt();
      if(data["palce"]=="Ps5")
        cost_demo=cost_demo%5<4.15
            ?cost_demo-(cost_demo%5):cost_demo+(5-(cost_demo%5));
      else
        cost_demo=cost_demo%5<3.2
            ?cost_demo-(cost_demo%5):cost_demo+(5-(cost_demo%5));
      cost_demo = cost_demo.toInt();
    }
    return cost_demo;
  } catch (error) {
    return 0;
  }
}

// get the first form and make the day time
// use it when you finish the day inserted

// the get the time form to now()
String gettonow(String time) {
  try {
    DateFormat dateFormatsecond = DateFormat('h:mma MM/dd/yyyy');
    DateTime dateTimesecond = dateFormatsecond.parse(time);
    dynamic duration = DateTime.now().difference(dateTimesecond);
    int wholeHours = duration.inHours;
    wholeHours = wholeHours.abs();
    int remainingMinutes = duration.inMinutes % 60;
    // Display the time difference in a formatted string
    String timeDifferenceString = "$wholeHours Hr and $remainingMinutes M";
    return timeDifferenceString;
  } catch (error) {
    return "Inter Second Time";
  }
}
String Extractdata(String time) {
  try {
    DateFormat dateFormatsecond = DateFormat('h:mma MM/dd/yyyy');
    DateTime dateTimesecond = dateFormatsecond.parse(time);
    String instance = DateFormat.jmv().format(dateTimesecond);
    return instance;
  } catch (error) {
    return "error of returning";
  }
}
String finishedtime(String time) {
  try {
    DateTime timer = DateTime.parse(time);
    return DateFormat.jmv().format(timer);
  } catch (error) {
    return "Still Running";
  }
}

