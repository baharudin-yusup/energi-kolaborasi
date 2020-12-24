import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum FeatureSize {
  small,
  medium,
  big,
}

class FeatureButton extends StatelessWidget {
  final String title;
  final double size;

  final Function onTap;

  final bool clickable;

  FeatureButton({
    @required String title,
    @required double size,
    Function onTap,
    bool clickable,
  })  : this.title = title,
        this.size = size,
        this.onTap = onTap,
        this.clickable = clickable ?? true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          color: Color(0xffFF8C00),
        ),
        width: size,
        height: size * 0.13,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

Widget featureButton({
  @required IconData icon,
  @required String title,
  @required String route,
  @required double baseWidth,
  @required double baseHeight,
  @required BuildContext context,
  var arguments,
}) {
  return InkWell(
    onTap: () {
      if (arguments == null) {
        Navigator.pushNamed(context, route);
      }

      if (arguments != null) {
        Navigator.pushNamed(context, route, arguments: arguments);
      }
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            color: Theme.of(context).primaryColor,
          ),
          width: baseWidth * 0.2,
          height: baseWidth * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: baseHeight * 0.055,
                color: Colors.black54,
              ),

              SizedBox(
                height: baseHeight * 0.01,
              ),
              // Title
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: Colors.white,
                ),
                width: baseWidth * 0.16,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 2.0, vertical: 2.0),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                        fontSize: baseWidth * 0.03),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

enum Object {
  zero,
}

Widget featureBanner({
  @required ImageProvider background,
  @required String title,
  @required IconData icon,
  @required String route,
  FeatureSize size = FeatureSize.small,
  @required double baseWidth,
  @required double baseHeight,
  @required BuildContext context,
  var arguments = Object.zero,
}) {
  double height = size == FeatureSize.small
      ? baseHeight * 0.13
      : (size == FeatureSize.medium ? baseHeight * 0.15 : baseHeight * 0.25);

  return InkWell(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Colors.black,
        image: DecorationImage(
          image: background,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8), BlendMode.dstATop),
        ),
      ),
      width: baseWidth * 0.9,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: Colors.black54,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Text(
                    title,
                    style: size == FeatureSize.small
                        ? Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white70)
                        : Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white70),
                    maxLines: 5,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: baseWidth * 0.25,
            height: height,
            child: Icon(
              icon,
              size: baseWidth * 0.1,
              color: Colors.white,
            ),
          )
        ],
      ),
    ),
    onTap: () {
      arguments == Object.zero
          ? Navigator.pushNamed(context, route)
          : Navigator.pushNamed(context, route, arguments: arguments);
    },
  );
}
