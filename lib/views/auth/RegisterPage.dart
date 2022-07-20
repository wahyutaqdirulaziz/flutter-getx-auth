import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dummy1/controllers/AuthControllers.dart';
import 'package:dummy1/helpers/theme.dart';
import 'package:dummy1/views/auth/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthController controller = Get.put(AuthController());
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
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
          if (controller.registerProcess.value) {
            return Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          } else {
            return ListView(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Register your\naccount',
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
                                    hintStyle:
                                        heading6.copyWith(color: textGrey),
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
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                    hintText: 'first Name',
                                    hintStyle:
                                        heading6.copyWith(color: textGrey),
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
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                    hintText: 'last Name',
                                    hintStyle:
                                        heading6.copyWith(color: textGrey),
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
                                    hintStyle:
                                        heading6.copyWith(color: textGrey),
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
                                  // var bytes =
                                  //     utf8.encode(_passwordController.toString());
                                  // var digest1 = sha256.convert(bytes);
                                  // print(digest1);
                                  // createAlbum(_emailController.text, digest1.toString());
                                  if (_key.currentState!.validate()) {
                                    _key.currentState!.save();
                                    String error = await controller.register(
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        username: _usernameController.text,
                                        password: _passwordController.text);
                                    if (controller.error != "") {
                                      Get.defaultDialog(
                                          title: "Aduh !!!",
                                          middleText: "Registerasi Gagal");
                                    } else {
                                      Get.to(() => LoginPage());
                                    }
                                  }
                                },
                                borderRadius: BorderRadius.circular(14.0),
                                child: Center(
                                  child: Text(
                                    "Sign up",
                                    style:
                                        heading5.copyWith(color: Colors.white),
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
                                Get.to(LoginPage());
                              },
                              child: Text(
                                'Sign in',
                                style: regular16pt.copyWith(color: primaryBlue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }));
  }
}
