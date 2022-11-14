import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:winter_school/questions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: "WinterSchool",
      // Replace with actual values
      options: const FirebaseOptions(
          apiKey: "AIzaSyBwGDmiEuXfcF4X_1xN0oBbJfm50STTQ5U",
          authDomain: "winterschool-4e953.firebaseapp.com",
          projectId: "winterschool-4e953",
          storageBucket: "winterschool-4e953.appspot.com",
          messagingSenderId: "584612848947",
          appId: "1:584612848947:web:d9e202cfeca7fca80b8a46",
          measurementId: "G-XYC4L2JNKE"),
    ).whenComplete(() {
      print("completedAppInitialize");
    });
  } else {
    Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THE UNSUNG HEIR',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'THE UNSUNG HEIR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isLoading = false;
  // late GoogleA _googleSignIn;
  // late FirebaseAuthWeb _firebaseAuth;
  String htmldata =
      '<img src="https://image.similarpng.com/very-thumbnail/2020/12/Illustration-of-Google-icon-on-transparent-background-PNG.png" alt="Lamp" width="32" height="32">';
  Future<UserCredential> signInWithGoogle() async {
    print("hello");
    // Trigger the authentication flow

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    print(googleUser);
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    print(googleAuth);
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print("***********************");
    print(googleAuth?.accessToken);
    // print(googleAuth?.idToken);
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/owaspfront.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content here */,
      ),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () async {
            setState(() {
              isLoading = true;
            });

            try {
              print("I am here");
              // await GoogleSignIn().signOut();
              await signInWithGoogle().then((value) async {
                print("hello");
                if (value.additionalUserInfo!.isNewUser) {
                  String docid = value.user!.uid;
                  CollectionReference users =
                      FirebaseFirestore.instance.collection('/Users');
                  await users.doc(docid).set({
                    "name": value.user!.displayName,
                    "email": value.user!.email,
                    "totalscore": 0,
                    "currentquestion": 1,
                    "logintime": DateTime.now().toString()
                  }, SetOptions(merge: true)).then((_) async {
                    CollectionReference users1 = FirebaseFirestore.instance
                        .collection('/Users/${value.user!.uid}/Answers/');
                    print(users1.get());
                    await users1.doc("1").set(
                        {"starttime": DateTime.now().toString()},
                        SetOptions(merge: true));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            Questions(uid: value.user!.uid),
                      ),
                    );
                  });
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          Questions(uid: value.user!.uid),
                    ),
                  );
                }

                print("navigating");
              });

              print("logged in");
            } catch (e) {
              if (e is FirebaseAuthException) {
                print(e.message);
              }
            }
            setState(() {
              isLoading = false;
            });
          },
          tooltip: 'Login',
          child: //HtmlElementView(
              //     viewType:
              //         '<img src="https://www.w3schools.com/images/lamp.jpg" alt="Lamp" width="32" height="32">')
              Image(
            width: 30,
            height: 30,
            image: AssetImage("assets/glogo.png"),
          )
          // Html(
          //   data: htmldata,
          //   customImageRenders: {
          //   networkSourceMatcher(domains: ["flutter.dev"]):
          //       (context, attributes, element) {
          //     return FlutterLogo(size: 36);
          //   },
          //   networkSourceMatcher(domains: ["mydomain.com"]): networkImageRender(
          //     headers: {"Custom-Header": "some-value"},
          //     altWidget: (alt) => Text(alt ?? ""),
          //     loadingWidget: () => Text("Loading..."),
          //   ),
          //   // On relative paths starting with /wiki, prefix with a base url
          //   (attr, _) =>
          //           attr["src"] != null && attr["src"]!.startsWith("/wiki"):
          //       networkImageRender(
          //           mapUrl: (url) => "https://upload.wikimedia.org" + url!),
          //   // Custom placeholder image for broken links
          //   networkSourceMatcher():
          //       networkImageRender(altWidget: (_) => FlutterLogo()),
          // },
          // onLinkTap: (url, _, __, ___) {
          //   print("Opening $url...");
          // },
          // onImageTap: (src, _, __, ___) {
          //   print(src);
          // },
          // onImageError: (exception, stackTrace) {
          //   print(exception);
          // },
          // onCssParseError: (css, messages) {
          //   print("css that errored: $css");
          //   print("error messages:");
          //   messages.forEach((element) {
          //     print(element);
          //   });
          //   },
          // ),

          //    const Image(
          //       image: NetworkImage(
          //           "https://image.similarpng.com/very-thumbnail/2020/12/Illustration-of-Google-icon-on-transparent-background-PNG.png")),
          // ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}
