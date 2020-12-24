import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


Map<String, dynamic> calculateSize(BuildContext context, {
  @required bool perfectRatio,
  @required double mediaHeight,
  @required double mediaWidth,
  @required double realHeight,
  @required double realWidth,
}) {
  if (kIsWeb) {
    // TODO: Resolution 16:9

    mediaHeight = MediaQuery.of(context).size.height;
    mediaWidth = MediaQuery.of(context).size.width;

    double tempHeight = MediaQuery.of(context).size.height;
    double tempWidth = tempHeight * (9 / 16);
    bool ratioChange;

    print((MediaQuery.of(context).size.width - tempWidth).abs());
    if ((MediaQuery.of(context).size.width - tempWidth).abs() <=
        tempWidth * 0.1) {
      ratioChange = true;
    } else {
      ratioChange = false;
    }

    realHeight = tempHeight;
    realWidth = tempWidth;
    perfectRatio = ratioChange;

  } else {
    mediaHeight = MediaQuery.of(context).size.height;
    mediaWidth = MediaQuery.of(context).size.width;

    realWidth = mediaWidth;
    realHeight = mediaHeight;
  }

  return {

    'media_height': mediaHeight,
    'media_width': mediaWidth,

    'real_height': realHeight,
    'real_width': realWidth,

    'perfect_ratio': perfectRatio,
  };
}
