import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AbstractTile extends StatelessWidget {
  final double size;
  final Color tileColor;
  final String title;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final Function onTap;

  final bool show;

  AbstractTile({
    @required double size,
    Color tileColor,
    @required String title,
    IconData leadingIcon,
    IconData trailingIcon,
    Function onTap,
    bool show,
  })  : this.tileColor = tileColor ?? Color(0xffd6c07f),
        this.title = title,
        this.leadingIcon = leadingIcon ?? Icons.circle,
        this.trailingIcon = trailingIcon ?? Icons.arrow_forward_ios_rounded,
        this.onTap = onTap,
        this.size = size,
  this.show = show ?? true;

  @override
  Widget build(BuildContext context) {

    if (!show) return SizedBox();

    return Container(
      alignment: Alignment.center,
      // height: size * 0.12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: tileColor,
      ),
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Colors.white,
              ),
          overflow: TextOverflow.ellipsis,
          softWrap: false,
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
