import 'package:live_chat_messenger/services/auth.dart';
import 'package:live_chat_messenger/assets/glassbox.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/App Icon.png'),
                      fit: BoxFit.fill),
                  shape: BoxShape.circle),
            ),
            Container(
                child: GlassBox(
                    height: 300.0,
                    width: 300.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password',
                            ),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  AuthMethods().signInWithGoogle(context);
                                },
                                child: Container(
                                    child: Image.asset('assets/google-logo.png',
                                        scale: 16)),
                              ),
                              Icon(Icons.apple, size: 70),
                            ])
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
