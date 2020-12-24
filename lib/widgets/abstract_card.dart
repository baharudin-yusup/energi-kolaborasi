import 'package:flutter/material.dart';

class AbstractCard extends StatelessWidget {
  final double size;
  final Widget trailing;
  final Widget leading;

  AbstractCard(
      {this.size,
      this.trailing = const Icon(
        Icons.add_circle,
        size: 20.0,
      ),
      this.leading});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        color: Colors.white,
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
      height: size / 2.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: (size * 0.8 * 0.3),
            height: (size * 0.8)  / 2.5,
            child: trailing,
          ),
          Container(
            alignment: Alignment.center,
            width: (size * 0.8 * 0.7),
            height: (size * 0.8)  / 2.5,
            child: leading,
          ),
        ],
      ),
    );
  }
}
