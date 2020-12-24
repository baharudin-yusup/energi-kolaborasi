import 'package:flutter/material.dart';

class AbstractButton extends StatelessWidget {
  final double size;
  final String title;
  final Function onTap;

  AbstractButton(
      {@required this.size,
        @required  this.title,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {

    double absoluteHeight = size * 0.15;

    return RaisedButton(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      padding: EdgeInsets.all(0.0),
      onPressed: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          color: Theme.of(context).primaryColor,
        ),
        width: size,
        height: absoluteHeight,
        child: Text(title, style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),),
      ),
    );
  }
}
