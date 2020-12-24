import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FileCard extends StatelessWidget {
  final double size;
  final String title;

  final Function onTap;

  final String url;

  FileCard(
      {@required this.size,
      @required this.title,
      @required this.onTap,
      this.url});

  @override
  Widget build(BuildContext context) {
    double height = size / 5;

    return InkResponse(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: Colors.white12,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 0.5,
              spreadRadius: 2.0,
              offset: Offset(0.0, 0.0), // shadow direction: bottom right
            )
          ],
        ),
        width: size,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              width: height,
              height: height,
              child: Icon(
                title != null ? Icons.done_all_rounded : Icons.note_rounded,
                color: Theme.of(context).accentColor,
                size: size * 0.07,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              alignment: Alignment.center,
              width: size - height * 1.6,
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title ?? 'Upload disini dengan format PDF max. 20 MB',
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: url != null ? () async {
        await launch(url);
      }: onTap,
    );
  }
}
