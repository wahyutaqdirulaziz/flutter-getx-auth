import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardPostPage extends StatefulWidget {
  String? caption;
  String? url_picture;
  String? url_image;
  String? name;
  DateTime? date;
  CardPostPage(
      {Key? key,
      this.caption,
      this.url_picture,
      this.url_image,
      this.name,
      this.date})
      : super(key: key);

  @override
  State<CardPostPage> createState() => _CardPostPageState();
}

class _CardPostPageState extends State<CardPostPage> {
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat.yMMMMd('en_US');
    return Card(
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            child: Image.network(
              widget.url_image!,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(20), // Image radius
                  child: Image.network(widget.url_picture!, fit: BoxFit.cover),
                ),
              ),
              title: Text(
                widget.caption!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.name!,
                    style: TextStyle(color: Colors.black26),
                  ),
                  Text(formatter.format(widget.date!).toString(),
                      style: TextStyle(color: Colors.black26)),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
