import 'package:dummy1/controllers/NewsControllers.dart';
import 'package:dummy1/helpers/theme.dart';
import 'package:dummy1/views/home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final NewsController controller = Get.put(NewsController());
  final TextEditingController caption = TextEditingController();
  final TextEditingController display_picture = TextEditingController();
  final TextEditingController display_content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.ispostLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: Colors.blue),
        );
      } else {
        return ListView(
          children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: display_picture,
                        decoration: InputDecoration(
                          hintText: 'Url Image Display',
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
                        controller: display_content,
                        decoration: InputDecoration(
                          hintText: 'Url Content Display',
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
                        controller: caption,
                        minLines: 6,
                        maxLines: null,
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
                  ],
                ),
              ),
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
                        String error = await controller.postingcon(
                            caption: caption.text,
                            display_content: display_content.text,
                            display_picture: display_picture.text);
                        if (controller.error != "") {
                          Get.defaultDialog(
                              title: "Upload gagal", middleText: "");
                        } else {
                          Get.to(() => HomePage());
                        }
                      }
                    },
                    borderRadius: BorderRadius.circular(14.0),
                    child: Center(
                      child: Text(
                        "Posting",
                        style: heading5.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
