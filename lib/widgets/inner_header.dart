import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'feature_button.dart';

Widget innerHeader({
  @required ImageProvider background,
  @required String title,
  @required String subtitle,
  FeatureSize size = FeatureSize.small,
  @required double baseWidth,
  @required double baseHeight,
}) {
  double height = size == FeatureSize.small
      ? baseHeight * 0.15
      : (size == FeatureSize.medium ? baseHeight * 0.2 : baseHeight * 0.35);

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
      color: Colors.black54,
      image: DecorationImage(
        image: background,
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
      ),
    ),
    width: baseWidth * 0.9,
    height: height,
    child: Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: height * 0.2, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.3,
            width: height * 0.02,
            child: Container(color: Colors.white,),
          ),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white, fontSize: height * 0.06),
          ),

        ],
      ),
    ),
  );
}

Widget coloredText(String text, BuildContext context, {bool small = false, bool big = false}) {

  double size = 16.0;
  if (small) size = 14.0;
  if (big) size = 20.0;

  return Text(text, style: Theme.of(context).textTheme.bodyText1.copyWith(
    color: Colors.white,
    fontSize: size,
    fontWeight: small ? FontWeight.normal : FontWeight.w600,
  ),);
}