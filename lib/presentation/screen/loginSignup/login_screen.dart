import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quiz_iq/data/datasource/login_datasources.dart';

import '../../widgets/login/edit_text.dart';
import '../../widgets/login/facebook_google.dart';
import '../../widgets/login/login_header.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //! Header
                    LoginHeader(screenSize: screenSize),
                    SizedBox(height: screenSize.height * 0.05),
                    Text(
                      'or Login with Email',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.0,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    //! This is Login Container Row
                    Row(
                      children: [
                        //! Facebook login
                        FacebookGoogleConTainer(
                            imagePath: 'assets/icons/facebook.svg',
                            onClick: () {
                              LoginDataSourcesImp().getFacebookLogin();
                              
                            }),
                        SizedBox(width: 20.0),
                        //!  Google Login
                        FacebookGoogleConTainer(
                          imagePath: 'assets/icons/google.svg',
                          onClick: () {
                            // signInGoogle().then((value) {
                            //   if (value != null) {
                            //     print('Data Pass');
                            //     Navigator.of(context).push(
                            //       MaterialPageRoute(
                            //         builder: (context) => HomeScreen(),
                            //       ),
                            //     );
                            //   }
                            // });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.12),

                    //! Form Page
                    Form(
                      child: Column(
                        children: [
                          EditText(
                            labelText: 'Email',
                            onSaved: (value) {},
                            onValidator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Email';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          EditText(
                            labelText: 'Password',
                            onSaved: (value) {},
                            onValidator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Password';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: screenSize.height * 0.05),
                          Container(
                            width: double.infinity,
                            height: screenSize.height * 0.07,
                            child: RaisedButton(
                              color: Colors.black,
                              onPressed: () {},
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.03),
                          RichText(
                            text: TextSpan(
                              text: 'Don\'t have an account?',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Sign up',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16.0,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //!To call sign up page
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
