import 'package:flutter/material.dart';

class DataView extends StatelessWidget {
  final IconData leadingIcon;
  final IconData trailingIcon;
  final String title;
  final String value;

  final double realWidth;
  final double maxWidth;

  final Function onTap;

  DataView(
      {@required this.leadingIcon,
        @required this.trailingIcon,
        @required this.title,
        @required this.value,
        @required this.realWidth,
        @required this.maxWidth,
        @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: maxWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: realWidth * 0.005,
            ),

            // Leading Icon
            leadingIcon != null
                ? Icon(
              leadingIcon,
              color: Theme.of(context).primaryColor,
              size: realWidth * 0.08,
            )
                : SizedBox(
              width: realWidth * 0.08,
            ),
            SizedBox(
              width: realWidth * 0.04,
            ),

            // Field
            Container(
              width: realWidth * 0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Data Field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Data Field
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: realWidth * 0.01,
                          ),
                          Text(
                            value,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: realWidth * 0.025,
                      ),

                      //Trailing Icon
                      trailingIcon != null ? Icon(
                        trailingIcon,
                        color: Colors.black26,
                        size: realWidth * 0.055,
                      ) : SizedBox(
                        width: realWidth * 0.01,
                      ),
                    ],
                  ),

                  // Border
                  Padding(
                    padding: EdgeInsets.only(
                        top: realWidth * 0.015, bottom: realWidth * 0.025),
                    child: Container(
                      height: 1,
                      width: realWidth * 0.75,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: realWidth * 0.005,
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
