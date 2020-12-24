import 'package:flutter/cupertino.dart';

class Space {
  final double height1;
  final double height2;
  final double height3;
  final double height4;
  final double height5;

  Space({@required size}) :
  this.height5 = size * 0.02,
  this.height4 = size * 0.04,
  this.height3 = size * 0.08,
  this.height2 = size * 0.16,
  this.height1 = size * 0.32;
}