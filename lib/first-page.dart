import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winter_school/questions.dart';

class firstpage extends StatefulWidget {
  firstpage(
    @required this.uid,
  );
  String uid;
  @override
  _firstpageState createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/owasp13.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: 70,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "THE UNSUNG HEIR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                          ),
                        ),
                        Text(
                          'Presented by',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          "OWASP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.search,
                  //     color: Colors.white,
                  //     size: 35,
                  //   ),
                  //   onPressed: () {},
                  // ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 50,
                  left: 50,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "STORY",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "LINE",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 15,
                          bottom: 30,
                        ),
                        width: 100,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xffc44536),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Text(
                            """His thoughts wandered across the blossomed meadows glittering in the moonlight and the pathways of his village. He had left his village two days ago as he was going to present his skills in music at a great event in the city. It was a great achievement for a boy from a small village known throughout the country for its men with excellent martial skills and acts of unmatched valor. He thought of the ways his friends and brothers will celebrate back in the village as they would welcome him after this great achievement. Even though his brief visit to the city was enthralling and exciting, he had been missing his brothers. His elder brother was a well-known master of martial arts. None in the village could match his commendable skills and bravery. But for him, Goro was the showering fountain of fatherly love and affection. Even though he always wanted to turn Goro into a fearsome like their father, he supported Goro as he explored his passion for music. On the other hand, his younger brother was a witty and naughty child. These thoughts glowed in his eyes in form of affection as he realized he had almost reached his back to his village. It had been a long journey.  As entered his village, he was not welcomed by any jubilation but by an unknown silence which was followed by a sight he could have never imagined even in his worst nightmare.  The sun shone brightly over the corpses with bruised faces, broken limbs, and disfigured features that lay on the meadows. The blood flushed the pathways to the wells and the huts with the mysterious symbol drawn over them. The sight had left him in a state of shock and numbness that could be broken only by a chilling fear that ran down his spine as the tears drained his eyes. He hustled towards his house with trembling feet. His house was no different and had the same mysterious symbol drawn over it. With shivering steps, he moved ahead when he tripped and fell. As he struggled to get up, he saw the stillness of death holding his little brother. He held his body and shouted with all his might. He kept weeping as his shirt got drained with his little brother's blood and mud. After weeping for an hour holding his brother, he searched all around for his elder brother  He could nowhere find his elder brother. Tired and grief-stricken, he entered his house. Inside he found, his brother's clothes and a letter lying beside them. Yes, his brother had left him a message, most probably his last message for him. He opened the letter and started to read. "They have.....  """),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50.0,
                            width: 150,
                            padding: EdgeInsets.only(right: 50),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(0, 160, 227, 1))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        Questions(uid: widget.uid),
                                  ),
                                );
                              },
                              padding: EdgeInsets.all(10.0),
                              color: Colors.black,
                              textColor: Colors.white,
                              child: Text("     START    ",
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
