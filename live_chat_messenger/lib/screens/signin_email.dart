import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:live_chat_messenger/helperfunctions/basic_helper.dart';
import 'package:live_chat_messenger/screens/signin.dart';
import 'package:live_chat_messenger/screens/signup_email.dart';
import 'package:live_chat_messenger/services/auth.dart';

class SignInFields {
  late String email;
  late String password;
}

class SignInEmail extends StatefulWidget {
  const SignInEmail({Key? key}) : super(key: key);

  @override
  State<SignInEmail> createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final SignInFields _signInFields = SignInFields();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded)),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (BasicHelper.isNullOrEmpty(value)) {
                              return 'Enter email';
                            }
                            if (BasicHelper.isEmailValid(value!)) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            _signInFields.email = val!.trim();
                          },
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (BasicHelper.isNullOrEmpty(value)) {
                              return 'Enter password';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            _signInFields.password = val!.trim();
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                      ],
                    )),
              ),
              ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          await AuthMethods().signInWithEmail(
                              context, _formKey, _signInFields);
                          setState(() {
                            isLoading = false;
                          });
                        },
                  child: Text('Sign in')),
              TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpEmail()),
                              (route) => false);
                        },
                  child: Text(
                    "Don't have an account??",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
