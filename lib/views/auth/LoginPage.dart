import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dummy1/controllers/AuthControllers.dart';
import 'package:dummy1/helpers/theme.dart';
import 'package:dummy1/views/auth/RegisterPage.dart';
import 'package:dummy1/views/auth/widget/customcheckbox.dart';
import 'package:dummy1/views/home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController controller = Get.put(AuthController());
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Obx(() {
          if (controller.loginProcess.value) {
            return Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          } else {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Text(
                          'Login to your\naccount',
                          style: heading2.copyWith(color: textBlack),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/image/footer-logo.png',
                          width: 100,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                hintText: 'username',
                                hintStyle: heading6.copyWith(color: textGrey),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: !passwordVisible,
                              decoration: InputDecoration(
                                hintText: 'password',
                                hintStyle: heading6.copyWith(color: textGrey),
                                suffixIcon: IconButton(
                                  color: textGrey,
                                  splashRadius: 1,
                                  icon: Icon(passwordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                  onPressed: togglePassword,
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(14.0),
                      elevation: 0,
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              if (_key.currentState!.validate()) {
                                _key.currentState!.save();
                                String error = await controller.login(
                                    username: _usernameController.text,
                                    password: _passwordController.text);
                                if (controller.error != "") {
                                  Get.defaultDialog(
                                      title: "Aduh !!!!",
                                      middleText:
                                          "Username and Password is not valid");
                                } else {
                                  Get.offAll(() => HomePage());
                                }
                              }
                            },
                            borderRadius: BorderRadius.circular(14.0),
                            child: Center(
                              child: Text(
                                "Sign in",
                                style: heading5.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: regular16pt.copyWith(color: textGrey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(RegisterPage());
                          },
                          child: Text(
                            'Sign up',
                            style: regular16pt.copyWith(color: primaryBlue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }));
  }
}
