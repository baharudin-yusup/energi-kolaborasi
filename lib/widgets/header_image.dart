import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeaderImage extends StatelessWidget {
  final String title;
  final String subtitle;
  final double size;
  final Color backgroundColor;
  final ImageProvider image;
  final bool addBorder;

  HeaderImage({
    @required String title,
    String subtitle,
    @required double size,
    Color backgroundColor,
    @required ImageProvider image,
    bool addBorder,
  })  : this.title = title,
        this.subtitle = subtitle,
        this.size = size,
        this.backgroundColor = backgroundColor ?? Colors.white,
        this.image = image,
        this.addBorder = addBorder ?? false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            width: size * 0.05 * 16,
            height: size * 0.05 * 9,
            decoration: BoxDecoration(
                image: DecorationImage(image: image, fit: BoxFit.fitWidth)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07,
                vertical: MediaQuery.of(context).size.width * 0.005),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
          subtitle != null ? Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07,
                vertical: MediaQuery.of(context).size.width * 0.005),
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ) :
          SizedBox(
            height: size * 0.01,
          ),
          SizedBox(
            height: size * 0.03,
          ),
        ],
      ),
    );
  }
}
