import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winter_school/congrats.dart';

class Questions extends StatefulWidget {
  Questions({required this.uid});
  String uid;
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  TextEditingController txt = TextEditingController();
  DateTime time = DateTime.now();
  int questionid = 1;
  double factor = 0.0001;
  int score = 5000;
  bool istext = true;
  bool isphoto = true;
  bool islink = true;
  String text = "";
  String onwronglink = "";
  String hint1 = "";
  String hint2 = "";
  String photo = "";
  String link = "";
  String answer = "";
  bool isLoading = true;
  double totalscore = 0;

  Future<void> getquestioninfo() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    String uid = FirebaseAuth.instance.currentUser!.uid;
    print(uid);
    DocumentSnapshot doc = await users.doc(uid).get();
    setState(() {
      questionid = (doc["currentquestion"]);
      print(questionid);
      totalscore = double.parse(doc["totalscore"].toString());
      print(totalscore);
      // print(DateTime.now().difference(time));
      // time = DateTime.parse(doc["logintime"]);
    });
    CollectionReference users1 =
        FirebaseFirestore.instance.collection('/Question');
    //DocumentSnapshot doc1 = await users1.doc("1").get();
    print(questionid);
    var doc1 = await users1.doc(questionid.toString()).get();

    setState(() {
      factor = doc1["factor"] ?? 0.01;
      score = doc1["score"] ?? 5000;
      istext = doc1["istext"] ?? "";
      isphoto = doc1["isphoto"] ?? false;
      islink = doc1["islink"] ?? false;
      text = doc1["text"] ?? "";
      photo = doc1["image"] ?? "";
      link = doc1["link"] ?? "";
      answer = doc1["answer"] ?? "";
      onwronglink = doc1["onwronglink"] ?? "";
      hint1 = doc1["hint1"] ?? "";
      hint2 = doc1["hint2"] ?? "";
      //    time = DateTime.parse(doc1["starttime"]);
    });
    await questionofuser();
    isLoading = false;
  }

  Future<void> questionofuser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
    print(questionid);
    CollectionReference users1 =
        FirebaseFirestore.instance.collection('Users/$uid/Answers');
    DocumentSnapshot doc1 = await users1.doc(questionid.toString()).get();
    setState(() {
      time = DateTime.parse(doc1["starttime"]);
      print(time);
    });
  }

  Future<void> updateinfoofuser() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await users.doc(uid).set({
      "currentquestion": questionid + 1,
      "totalscore": totalscore +
          score -
          DateTime.now().difference(time).inMinutes * factor * 100
    }, SetOptions(merge: true));
  }

  Future<void> updateanswerofuser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users1 =
        FirebaseFirestore.instance.collection('Users/$uid/Answers');
    await users1.doc(questionid.toString()).set({
      "endtime": DateTime.now().toString(),
      "score": score - DateTime.now().difference(time).inMinutes * factor * 100
    }, SetOptions(merge: true));
    await users1
        .doc((questionid + 1).toString())
        .set({"starttime": DateTime.now().toString()}, SetOptions(merge: true));
    isLoading = false;
    // setState(() {
    //   time = DateTime.parse(doc1["starttime"]);
    //   print("object");
    //   print(time);
    //   isLoading = false;
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    getquestioninfo();
    // print(FirebaseAuth .instance.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/owasp.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator()),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/owasp.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TweenAnimationBuilder<Duration>(
                          duration: Duration(days: 3),
                          tween: Tween(
                              begin: DateTime.now().difference(time),
                              end: Duration(days: 3)),
                          onEnd: () {
                            print('Timer ended');
                          },
                          builder: (BuildContext context, Duration value,
                              Widget? child) {
                            final minutes = value.inMinutes;
                            final seconds = value.inSeconds % 60;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Score: ${(score - factor * 100 * minutes).round()}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text('$minutes:$seconds',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30))),
                              ],
                            );
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {
                                print(
                                    DateTime.now().difference(time).inMinutes);
                                showAlertDialog(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  "Hint 1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )),
                          InkWell(
                              onTap: () {
                                showAlertDialog1(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  "Hint 2",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Question No. $questionid",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      isphoto
                          ? Image(
                              image: NetworkImage(photo),
                              width: 250,
                              height: 250,
                            )
                          : Container(),
                      SizedBox(
                        height: 30,
                      ),
                      istext
                          ? Text(
                              text,
                              style: TextStyle(color: Colors.white),
                            )
                          : Container(),
                      SizedBox(
                        height: 30,
                      ),
                      islink
                          ? Container(
                              margin: EdgeInsets.all(10),
                              width: 200,
                              height: 35.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: Color.fromRGBO(0, 160, 227, 1))),
                                onPressed: () {
                                  launch(link);
                                },
                                padding: EdgeInsets.all(10.0),
                                color: Colors.black,
                                textColor: Colors.white,
                                child: Text("Link to the Question",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        width: 400,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: txt,
                            autofocus: false,
                            onSubmitted: (value) async {
                              if (value.toLowerCase() == answer) {
                                if (questionid < 9) {
                                  await updateanswerofuser();
                                  await updateinfoofuser();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          Questions(uid: widget.uid),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          Congrats(),
                                    ),
                                  );
                                }
                              } else {
                                launch(onwronglink);
                              }
                            },
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Your Answer',
                              filled: true,
                              fillColor: Colors.grey,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 6.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      )
                      // SizedBox(
                      //   width: 400,
                      //   child: TextField(
                      //     onFieldSubmitted: (value) {
                      //       if (value.toLowerCase() == answer) {}
                      //     },
                      //   ),
                      //   autofocus: false,
                      //           style: TextStyle(fontSize: 15.0, color: Colors.black),
                      //           decoration: InputDecoration(
                      //             border: InputBorder.none,
                      //             hintText: 'Username',
                      //             filled: true,
                      //             fillColor: Colors.grey,
                      //             contentPadding: const EdgeInsets.only(
                      //                 left: 14.0, bottom: 6.0, top: 8.0),
                      //             focusedBorder: OutlineInputBorder(
                      //               borderSide: BorderSide(color: Colors.red),
                      //               borderRadius: BorderRadius.circular(10.0),
                      //             ),
                      //             enabledBorder: UnderlineInputBorder(
                      //               borderSide: BorderSide(color: Colors.grey),
                      //               borderRadius: BorderRadius.circular(10.0),
                      //             ),
                      //           ),
                      // )
                      ,
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 50.0,
                        width: 150,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black)),
                          onPressed: () async {
                            if (txt.text.toLowerCase() == answer) {
                              if (questionid < 9) {
                                await updateanswerofuser();
                                await updateinfoofuser();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        Questions(uid: widget.uid),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        Congrats(),
                                  ),
                                );
                              }
                            } else {
                              launch(onwronglink);
                            }
                          },
                          padding: EdgeInsets.all(10.0),
                          color: Colors.black,
                          textColor: Colors.white,
                          child: Text("     Submit    ",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Hint 1", style: TextStyle(color: Colors.white)),
      content: Text(DateTime.now().difference(time).inMinutes > 30
          ? hint1
          : "Please Wait for ${30 - DateTime.now().difference(time).inMinutes} minutes"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog1(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK", style: TextStyle(color: Colors.white)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Hint 2", style: TextStyle(color: Colors.white)),
      content: Text(DateTime.now().difference(time).inMinutes > 90
          ? hint2
          : "Please Wait for ${90 - DateTime.now().difference(time).inMinutes} minutes"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
