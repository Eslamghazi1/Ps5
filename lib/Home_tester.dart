import 'package:flutter/material.dart';
import 'additions.dart';
import 'sql.dart';
import 'package:intl/intl.dart';

class Home_offer extends StatefulWidget {
  const Home_offer({super.key});

  @override
  State<Home_offer> createState() => _Home_offerState();
}


class _Home_offerState extends State<Home_offer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // togethers_costs();
  }
  String Home = "OFFERS";
  Map<String, dynamic> data = {};
  bool stated=false;
  Widget build(BuildContext context) {
    // bool stated=false;
    data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ??
        // ignore: dead_null_aware_expression
        data;
    int cost = 0;
    if (data["data"].isNotEmpty) {
      for (int i = 0; i < data["data"].length; i++) {
        try {
          String temp = data["data"][i].cost;
          int new_cost = int.parse(temp);
          cost = cost + new_cost;
        } catch (error) {}
      }
    }
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.grey[400],
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      radius: 48,
                      child: Image(image: AssetImage("images/PS5.png")),
                    ),
                    Text(
                      "PS5:$Home",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                )),
            ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "load_orders", (route) => false);
              },
              title: Text("ORDERS", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[400],
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {},
              title: Text("OFFER", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[200],
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () { Navigator.pushNamedAndRemoveUntil(context, "loading", (route) => false,);
              },
              title: Text("PLAYS LIST", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[400],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 3,
              color: Colors.deepPurple[400],
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "load_costs", (route) => false,arguments: {
                  "name":"costs",
                  "navigator":"view_costs"
                });
              },
              title: Text("PREVIEW COSTS", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[400],
            ),
            SizedBox(
              height: 10,
            ),
            // PAYMENT BUTTON
            ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "load_costs", (route) => false,arguments: {
                  "name":"payments",
                  "navigator":"payments"
                });
              },
              title: Text("PAYMENTS", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[400],
            ),
            SizedBox(
              height: 10,
            ),
            // MONTHLY COSTS BUTTON
            ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "load_costs", (route) => false,arguments: {
                  "name":"monthly",
                  "navigator":"monthly"
                });
              },
              title: Text("MONTHLY COSTS", style: TextStyle(fontSize: 15)),
              tileColor:Colors.deepPurple[400],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(Home),
        backgroundColor: Colors.deepPurple,
        actions: [
          data["data"].isNotEmpty
              ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () async {

                int temperary= await gettheorders_costs();
                sql mysql = sql();
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    backgroundColor: Colors.white54,
                    title: Text("DID YOU REALLY WANT TO END THIS?",
                      // textAlign: TextAlign.center,
                    ),
                    actions: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          onPressed: () async {
                            await mysql.deletedb("DELETE FROM offers WHERE 'id' > 0");
                            await mysql.insert("costs", {
                              "day": convert_preview(data["data"][0].frm),
                              "tasks":  temperary,
                              "play": cost,
                            });
                            await mysql.deletedb("DELETE FROM orders WHERE 'key' > 0");
                            Navigator.pushNamedAndRemoveUntil(
                                context, "loading", (route) => false);
                          },
                          child: const Text("YES",style: TextStyle(color: Colors.white),)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Text("No",style: TextStyle(color: Colors.white)))],
                  );
                });

              },
              child: const Text("END THAT DAY!!!",style: TextStyle(color: Colors.white),))
              : const Icon(
            Icons.deblur_rounded,
          ),
        ],
      ),
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
              Text("the total cost is:$cost",
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center),
              const Divider(),
              Container(

                height: MediaQuery.of(context).size.height - 150,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 5),
                      color: checkcolor(data["data"][index].too) ==
                          false &&
                          data["data"][index].too != "Still Running"
                          ? Colors.green[200]
                          : Colors.red[200],
                      child: Column(
                        children: [
                          ListTile(
                            onLongPress: (){
                              Navigator.pushNamed(context, "update_offer",arguments: {
                                "id":data["data"][index].id,
                                "state":data["data"][index].special,
                                "too":data["data"][index].too,
                                "frm":data["data"][index].frm,
                                "kind":data["data"][index].kind,
                                "place":data["data"][index].place,
                                "Hours":setdifference_in_Hours(data["data"][index].frm, data["data"][index].too),
                                "Minutes":setdifference_in_Minutes(data["data"][index].frm, data["data"][index].too),
                              });
                            },
                            title: Row(children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Text(data["data"][index].kind,
                                      style: const TextStyle(fontSize: 17))),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    data["data"][index].cost,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 21),
                                  ))
                            ]),
                            leading: Text(
                              data["data"][index].place,
                              style: const TextStyle(fontSize: 22),
                            ),
                            trailing: SizedBox(
                              width: 70,
                              child: Column(
                                children: [
                                  Text(
                                    finishedtime(data["data"][index].too),
                                    style: const TextStyle(fontSize: 17),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                        Extractdata(
                                            data["data"][index].frm),
                                        style: const TextStyle(
                                            fontSize: 16))),
                                Expanded(
                                    flex: 2,
                                    child: checkcolor(data["data"][index].too) ==
                                        true ||
                                        data["data"][index].too==
                                            "Still Running"
                                        ? Text(
                                      gettonow(data["data"][index].frm),
                                      style: const TextStyle(
                                          fontSize: 16),
                                      textAlign: TextAlign.center,
                                    )
                                        : Text(
                                      setdifference(
                                          data["data"][index].frm,
                                          data["data"][index].too),
                                      style: const TextStyle(
                                          fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ))
                              ],
                            ),

                          ),
                          Row(
                            children: <Widget>[
                              //   the stop button
                              Expanded(
                                  child: Container(
                                    child:checkcolor(data["data"][index].too) ==
                                        false &&
                                        data["data"][index].too !=
                                            "Still Running"
                                        ? Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        // color: Colors.blue,
                                        child: Text(
                                          "STOPPED",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ))
                                        :
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                        ),
                                        onPressed: () async {
                                          sql mysql = sql();
                                          String instance =
                                          cost_calculator(data["data"]
                                          [index])
                                              .toString();
                                          await mysql.update(
                                              "offers",
                                              {
                                                "too": DateTime.now()
                                                    .toString(),
                                                "cost": instance,
                                              },
                                              "id=${data["data"][index].id}");
                                          print("done");
                                          setState(() {
                                            data["data"][index].too= DateTime.now().toString();
                                            data["data"][index].cost=instance;
                                            // checkcolor(DateTime.now().toString());
                                          });
                                        },
                                        child: Text("STOP")),
                                  )),
                              // the refresh buttom
                              Expanded(
                                  child:checkcolor(data["data"][index].too) ==
                                      false &&
                                      data["data"][index].too !=
                                          "Still Running"
                                      ? Container(
                                      padding: EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                          left: 3,
                                          right: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      // color: Colors.green,
                                      child: Text(
                                        "Finished",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ))
                                      :
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          checkcolor(data["data"][index].too);
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
                                        showDialog(context: context, builder: (context){
                                          return AlertDialog(
                                            backgroundColor: Colors.white54,
                                            title: Text("DID YOU REALLY WANT TO DELETE THIS?",
                                              // textAlign: TextAlign.center,
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.deepPurple,
                                                  ),
                                                  onPressed: () async {
                                                    sql mysql = sql();
                                                    await mysql.deletedb(
                                                        "DELETE FROM offers WHERE id = ${data["data"][index].id}");
                                                    Navigator.pushNamedAndRemoveUntil(
                                                        context,
                                                        "loading_offer",
                                                            (route) => false);
                                                  },
                                                  child: const Text("YES",style: TextStyle(color: Colors.white),)),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.deepPurple,
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("No",style: TextStyle(color: Colors.white)))],
                                          );
                                        });

                                      },
                                      child: Text("DELETE"))),
                            ],
                          ),
                          Container(
                            color:data["data"][index].special==false?Colors.red[200]:
                            Colors.green[200] ,
                            child: CheckboxListTile(value:  data["data"][index].special,
                                title: Text("ORDERS"),
                                onChanged: (value)async{
                                  sql mysql = sql();
                                  String State="";
                                  await mysql.update(
                                      "offers",
                                      {"state": value.toString(),},
                                      "id=${data["data"][index].id}");
                                  print(value);
                                  setState(() {
                                    // stated=value!;
                                    data["data"][index].special=value;
                                  });
                                  print(data["data"][index].special);

                               }


                                ),
                          ),
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
            Navigator.pushNamed(context, "insert_offer");
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

int tricky(int instance){
  try{
    int temp=instance;
    return temp;
  }catch(error){
    return 0;
  }
}

// get the cost of the stopping timer

int cost_calculator(offers data) {
  try {
    bool mass=false;
    int cost_demo = 0;
    // DateFormat dateFormatsecond = DateFormat('h:mma MM/dd/yyyy');
    DateTime dateTimesecond = DateTime.parse(data.frm);
    dynamic duration = DateTime.now().difference(dateTimesecond);
    int wholeHours = duration.inHours;
    wholeHours = wholeHours.abs();
    int remainingMinutes = duration.inMinutes % 60;
    if (data.kind == "Multi") {
      data.place=="Ps6"?mass=false:mass =true;
      cost_demo = data.place == "Ps6"
          ? ((wholeHours + (remainingMinutes / 60)) * 25).toInt()
          : ((wholeHours + (remainingMinutes / 60)) * 20).toInt();
      if(data.place=="Ps6")
        cost_demo=cost_demo%5<3.2
            ?cost_demo-(cost_demo%5):cost_demo+(5-(cost_demo%5));
      else
        cost_demo=cost_demo%5<3.2
            ?cost_demo-(cost_demo%5):cost_demo+(5-(cost_demo%5));

      cost_demo = cost_demo.toInt();
    } else {
      cost_demo = (data.place == "Ps6")
          ? ((wholeHours + (remainingMinutes / 60)) * 20).toInt()
          : ((wholeHours + (remainingMinutes / 60)) * 15).toInt();
      if(data.place =="Ps6")
        cost_demo=cost_demo%5<3.2
            ?cost_demo-(cost_demo%5):cost_demo+(5-(cost_demo%5));
      else
        cost_demo=cost_demo%5<2.2
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
String convert_preview(String time) {
  try {
    // DateFormat dateFormatsecond = DateFormat('h:mma MM/dd/yyyy');
    DateTime dateTimesecond = DateTime.parse(time);
    String instance = DateFormat.yMMMMEEEEd().format(dateTimesecond);
    return instance;
  } catch (error) {
    return "No Data For That Day";
  }
}

// the get the time from to now()
String gettonow(String time) {
  try {
    // DateFormat dateFormatsecond = DateFormat('h:mma MM/dd/yyyy');
    DateTime dateTimesecond = DateTime.parse(time);
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

// convert the time form string_from to Datetime
String Extractdata(String time) {
  try {
    // DateFormat dateFormatsecond = DateFormat('h:mma MM/dd/yyyy');
    DateTime dateTimesecond = DateTime.parse(time);
    String instance = DateFormat.jmv().format(dateTimesecond);
    return instance;
  } catch (error) {
    return "error of returning";
  }
}

// to convert the time of string_to to Datetime
String finishedtime(String time) {
  try {
    DateTime timer = DateTime.parse(time);
    return DateFormat.jmv().format(timer);
  } catch (error) {
    return "Still Running";
  }
}

//  from to color checkcolor
bool checkcolor(String second) {
  try {
    DateTime dateTimesecond = DateTime.parse(second);
    if (dateTimesecond.compareTo(DateTime.now()) == 1 ||
        dateTimesecond.compareTo(DateTime.now()) == 0) {
      return true;
    } else {
      return false;
    }
  } catch (error) {}
  return false;
}

//  set the difference between to times
String setdifference(String first, String second) {
  try {
    // DateFormat dateFormatters = DateFormat('h:mma MM/dd/yyyy');
    DateTime dateTimefirst = DateTime.parse(first);
    DateTime dateTimesecond = DateTime.parse(second);
    dynamic duration = dateTimesecond.difference(dateTimefirst);
    int wholeHours = duration.inHours;
    wholeHours = wholeHours.abs();
    int remainingMinutes = duration.inMinutes % 60;
    // Display the time difference in a formatted string
    String timeDifferenceString = "$wholeHours Hr and $remainingMinutes M";
    return timeDifferenceString;
  } catch (error) {
    return "Inter Finished Time";
  }
}

// get the difference hours
int setdifference_in_Hours(String first, String second) {
  try {
    // DateFormat dateFormatters = DateFormat('h:mma MM/dd/yyyy');
    DateTime dateTimefirst = DateTime.parse(first);
    DateTime dateTimesecond = DateTime.parse(second);
    dynamic duration = dateTimesecond.difference(dateTimefirst);
    int wholeHours = duration.inHours;
    wholeHours = wholeHours.abs();
    int remainingMinutes = duration.inMinutes % 60;
    // Display the time difference in a formatted string
    return wholeHours;
  } catch (error) {
    return 0;
  }
}
// get the difference minute
int setdifference_in_Minutes(String first, String second) {
  try {
    // DateFormat dateFormatters = DateFormat('h:mma MM/dd/yyyy');
    DateTime dateTimefirst = DateTime.parse(first);
    DateTime dateTimesecond = DateTime.parse(second);
    dynamic duration = dateTimesecond.difference(dateTimefirst);
    int remainingMinutes = duration.inMinutes % 60;
    // Display the time difference in a formatted string
    return remainingMinutes;
  } catch (error) {
    return 0;
  }
}