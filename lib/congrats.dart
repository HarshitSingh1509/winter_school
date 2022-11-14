import 'package:flutter/material.dart';

class Congrats extends StatefulWidget {
  const Congrats({Key? key}) : super(key: key);

  @override
  _CongratsState createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/GORO.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Card(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Story',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 15,
                          bottom: 30,
                        ),
                        width: 100,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            """As Goro made his way to the Rekka Leader after breaking the spell, at the moment when he encountered the Chousuke, rage and vengeance took all over his eyes as he loathed at the very existence of the Chousuke. Goro then charged at the Gang leader and stroked him with all of his might, but of no use as he showed explicit defence skills and then Chousuke and Goro had a fierce fight ending in a demolishing defeat of Goro and the Chousuke was just about to kill Goro but at the very moment a masked man came out of nowhere and rescued Goro out of the battle.
                              Though defeated, this time Goro did not faint and caught a glimpse of the face behind the mask and with utter shock dozed off.""",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ), /* add child content here */
      ),
    );
  }
}
