import 'package:flutter/material.dart';
import 'package:netflix/core/strings.dart';

class SearchResultCard extends StatelessWidget {
  final String image;
  const SearchResultCard({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image.endsWith('.jpg')
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage('$imageAppendUrl$image'),
                fit: BoxFit.cover,
              ),
            ),
          )
        : const Center(
            child: Text(
              'Image \nnot found',
              textAlign: TextAlign.center,
            ),
          );
  }
}
