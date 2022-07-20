import 'package:dummy1/models/PostingResponeModel.dart';
import 'package:dummy1/service/NewsService.dart';
import 'package:dummy1/views/home/HomePage.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class NewsController extends GetxController {
  var isLoading = true.obs;
  var ispostLoading = false.obs;
  var error = "".obs();

  List news = <Content>[].obs();

  void getnews() async {
    try {
      isLoading(true);
      var res = await News.getposting();
      news.assignAll(res.content!.toList());
    } finally {
      isLoading(false);
    }
  }

  Future<String> postingcon({
    String? caption,
    String? display_picture,
    String? display_content,
  }) async {
    error = "";
    try {
      ispostLoading(true);
      var postingResp = await News.posting(
          caption: caption,
          display_picture: display_picture,
          display_content: display_content);
      if (postingResp.result == 1) {
        //success
        Get.offAll(() => HomePage());
      } else {
        error = "500 server error";
      }
    } finally {
      ispostLoading(false);
    }
    return error;
  }
}
