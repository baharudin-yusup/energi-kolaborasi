import 'package:flutter/material.dart';

class SolidButton extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final String title;

  final IconData leadingIcon;
  final IconData trailingIcon;

  final Function onTap;

  SolidButton({
    @required double size,
    Color backgroundColor,
    @required String title,
    Function onTap,
    IconData leadingIcon,
    IconData trailingIcon,
  })  : this.size = size,
        this.backgroundColor = backgroundColor ?? Color(0xffd3a93b),
        this.title = title,
        this.onTap = onTap,
        this.leadingIcon = leadingIcon ?? Icons.circle,
        this.trailingIcon = trailingIcon ?? Icons.arrow_forward_ios_rounded;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: backgroundColor,
      ),
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: Colors.white,
          size: size * 0.1,
        ),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.white),
        ),
        trailing: Icon(
          trailingIcon,
          color: Colors.white,
        ),
        onTap: onTap,
      ),
    );
  }
}
