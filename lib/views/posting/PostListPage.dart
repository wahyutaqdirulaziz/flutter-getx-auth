import 'package:dummy1/controllers/NewsControllers.dart';
import 'package:dummy1/views/posting/CardPostPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final NewsController newsController = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    
    newsController.getnews();
    return Obx(() {
      if (newsController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: Colors.blue),
        );
      } else {
        return ListView.builder(
            itemCount: newsController.news.length,
            itemBuilder: (BuildContext context, int index) {
              return CardPostPage(
                caption: newsController.news[index].caption,
                url_image: newsController.news[index].displayPicture,
                url_picture: newsController.news[index].displayContent,
                name: newsController.news[index].displayName,
                date: newsController.news[index].createdAt,
              );
            });
      }
    });
  }
}
