import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineCard extends StatelessWidget {

  final double size;

  final String headline;
  final String startTitle;
  final DateTime startDate;
  final String endTitle;
  final DateTime endDate;

  TimelineCard({
    @required double size,
    @required String headline,
    String startTitle,
    @required DateTime startDate,
    String endTitle,
    @required DateTime endDate,
  })  :
        this.size = size,
        this.headline = headline,
        this.startTitle = startTitle ?? 'Pengumpulan',
        this.startDate = startDate,
        this.endTitle = endTitle ?? 'Penutupan',
        this.endDate = endDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Wave 1
        Container(
          width: size,
          child: Text(headline, style: Theme.of(context).textTheme.headline6),
        ),

        SizedBox(
          height: size * 0.03,
        ),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            color: Theme.of(context).primaryColor,
          ),
          width: size,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 13.0, vertical: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      startTitle,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: size * 0.01,),
                    Text(
                      DateFormat('dd-MM-yyy').format(startDate),
                      style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 35.0,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 13.0, vertical: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      endTitle,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: size * 0.01,),
                    Text(
                      DateFormat('dd-MM-yyy').format(endDate),
                      style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
