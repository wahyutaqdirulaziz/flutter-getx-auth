import 'package:dummy1/helpers/theme.dart';
import 'package:dummy1/views/auth/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? username = "";
  String? password = "";
  @override
  void initState() {
    // TODO: implement initState
    getSet();
    super.initState();
  }

  void getSet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      password = prefs.getString("password");
    });
  }

  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(30), // Image radius
                child: Image.network(
                    'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                    fit: BoxFit.cover),
              ),
            ),
            title: Text(
              username!,
              maxLines: 2,
            ),
            subtitle: Text('Member Woilo'),
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
            minLines: 6,
            maxLines: null,
            controller: TextEditingController(
                text:
                    "Hasil password dienkripsi dengan SHA-256 -> ${password}"),
            decoration: InputDecoration(
              hintText: 'Caption',
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Material(
          borderRadius: BorderRadius.circular(14.0),
          elevation: 0,
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear();
                  Get.to(LoginPage());
                },
                borderRadius: BorderRadius.circular(14.0),
                child: Center(
                  child: Text(
                    "Logout",
                    style: heading6.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
