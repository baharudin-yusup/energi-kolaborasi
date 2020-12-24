import 'package:flutter/material.dart';

class ChoiceTile extends StatelessWidget {
  final String activeTitle;
  final String passiveTitle;

  final IconData activeLeading;
  final IconData passiveLeading;

  final IconData activeTrailing;
  final IconData passiveTrailing;

  final Color activeColor;
  final Color passiveColor;

  final bool isActive;

  final Function onTap;

  final double size;

  ChoiceTile({
    @required String activeTitle,
    String passiveTitle,
    IconData activeLeading,
    IconData passiveLeading,
    IconData activeTrailing,
    IconData passiveTrailing,
    Color activeColor,
    Color passiveColor,
    @required bool isActive,
    Function onTap,
    @required size,
  })  : this.activeTitle = activeTitle,
        this.passiveTitle = passiveTitle ?? activeTitle,
        this.activeLeading = activeLeading ?? Icons.circle,
        this.passiveLeading = passiveLeading ?? (activeLeading ?? Icons.circle),
        this.activeTrailing = activeTrailing ?? Icons.done_all_rounded,
        this.passiveTrailing = passiveTrailing ?? null,
        this.activeColor = activeColor ?? Color(0xffd3a93b),
        this.passiveColor = passiveColor ?? Color(0xffD3D3D3),
        this.isActive = isActive,
        this.onTap = onTap ?? null,
  this.size = size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: isActive ? activeColor : passiveColor,
      ),
      child: ListTile(
        leading: Wrap(
          spacing: MediaQuery.of(context).size.width * 0.05,
          children: [
            Icon(
              isActive ? activeLeading : passiveLeading,
              color: Colors.white,
              size: MediaQuery.of(context).size.width * 0.07,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.01,
              height: MediaQuery.of(context).size.width * 0.07,
              color: Colors.white,
            )
          ],
        ),
        title: Text(
          isActive ? activeTitle : passiveTitle,
          style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
        ),
        trailing: Icon(
          isActive ? activeTrailing : passiveTrailing,
          color: Colors.white,
          size: MediaQuery.of(context).size.width * 0.07,
        ),
        onTap: onTap,
      ),
    );
  }
}
