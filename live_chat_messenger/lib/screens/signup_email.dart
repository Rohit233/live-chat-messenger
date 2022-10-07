import 'package:flutter/material.dart';
import 'package:live_chat_messenger/helperfunctions/basic_helper.dart';
import 'package:live_chat_messenger/screens/signin_email.dart';
import 'package:live_chat_messenger/services/auth.dart';

class SignUpFields {
  late String username;
  late String name;
  late String email;
  late String password;
}

class SignUpEmail extends StatefulWidget {
  const SignUpEmail({Key? key}) : super(key: key);

  @override
  State<SignUpEmail> createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final SignUpFields _signUpFields = SignUpFields();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (BasicHelper.isNullOrEmpty(value)) {
                              return 'Enter name';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            _signUpFields.name = val!.trim();
                          },
                          decoration: InputDecoration(labelText: 'Name'),
                        ),
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
                            _signUpFields.email = val!.trim();
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
                            _signUpFields.password = val!.trim();
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                      ],
                    )),
              ),
              ElevatedButton(
                  onPressed: isLoading ? null : () async{
                    setState(() {
                       isLoading = true;
                    });
                    await AuthMethods()
                        .signUpWithEmail(context, _formKey, _signUpFields);
                    setState(() {
                        isLoading = false;
                    });    
                  },
                  child: Text('Sign up')),
              TextButton(
                  onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SignInEmail();
                     }));
                  },
                  child: Text(
                    'Already have an account',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
