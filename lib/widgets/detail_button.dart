import 'package:flutter/material.dart';

class DetailButton extends StatelessWidget {
  final double size;
  final ImageProvider backgroundImage;
  final String title;
  final List<String> subtitle;

  final Function onTap;

  DetailButton({
    @required double size,
    ImageProvider backgroundImage,
    @required String title,
    Function onTap,
    List<String> subtitle,
  })  : this.size = size,
        this.backgroundImage =
            backgroundImage ?? AssetImage('assets/images/collaboration.jpg'),
        this.title = title,
        this.onTap = onTap,
        this.subtitle = subtitle ?? [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: size,
        height: size / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          color: Theme.of(context).primaryColor,
          image: DecorationImage(image: backgroundImage, fit: BoxFit.fitWidth),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1.1,
              spreadRadius: 0.9,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center,
              width: size,
              height: size / 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                color: Colors.black54,
              ),
              child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
