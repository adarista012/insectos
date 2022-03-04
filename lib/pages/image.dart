import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final String imageUrl;
  const ImagePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade300.withAlpha(120),
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
              fit: BoxFit.contain, image: NetworkImage(imageUrl)),
        ),
      ),
    );
  }
}
