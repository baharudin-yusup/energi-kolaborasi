import 'package:energi_kolaborasi/utils/function.dart';
import 'package:energi_kolaborasi/utils/router.dart';
import 'package:energi_kolaborasi/widgets/detail_button.dart';
import 'package:energi_kolaborasi/widgets/header_image.dart';
import 'package:energi_kolaborasi/widgets/solid_button.dart';
import 'package:flutter/material.dart';

class ProjectProgressScreen extends StatefulWidget {

  final String title = 'Kemajuan Proyekmu';

  @override
  _ProjectProgressScreenState createState() => _ProjectProgressScreenState();
}

class _ProjectProgressScreenState extends State<ProjectProgressScreen> {
  double _realWidth;
  double _realHeight;
  double _mediaWidth;
  double _mediaHeight;
  bool _perfectRatio = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if ((_mediaHeight ?? 0) != MediaQuery.of(context).size.height ||
        (_mediaWidth ?? 0) != MediaQuery.of(context).size.width) {
      Map<String, dynamic> media = calculateSize(
        context,
        mediaHeight: _mediaHeight,
        mediaWidth: _mediaWidth,
        realHeight: _realHeight,
        realWidth: _realWidth,
        perfectRatio: _perfectRatio,
      );

      setState(() {
        _mediaHeight = media['media_height'];
        _mediaHeight = media['media_width'];
        _realHeight = media['real_height'];
        _realWidth = media['real_width'];
        _perfectRatio = media['perfect_ratio'];
      });
    }

    return WillPopScope(
      onWillPop: () async => true,
      child: Container(
        color: _perfectRatio == true ? Colors.white : Colors.black12,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: _realHeight,
              maxWidth: _realWidth,
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: Container(
                alignment: Alignment.topCenter,
                width: _realWidth,
                height: _realHeight,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: _realWidth * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: _realWidth * 0.06,
                        ),

                        HeaderImage(
                          title: 'Cek Kemajuan Proyekmu',
                          size: _realWidth,
                          image: AssetImage('assets/images/collaboration.jpg'),
                          subtitle: 'Pilih kategori yang ingin kamu cek',
                        ),
                        SizedBox(
                          height: _realWidth * 0.12,
                        ),

                        Text('Kemajuan Pengajuan Proyek', style: Theme.of(context).textTheme.headline6,),
                        SizedBox(
                          height: _realWidth * 0.03,
                        ),
                        SolidButton(
                            size: _realWidth,
                            title: 'Kemajuan Proyek Riset',
                          onTap: () => Navigator.pushNamed(context, RouteHandler.PROGRESS_RESEARCH),
                        ),
                        SizedBox(
                          height: _realWidth * 0.03,
                        ),

                        SolidButton(
                          size: _realWidth,
                          title: 'Kemajuan Konsultasi',
                          onTap: () => Navigator.pushNamed(context, RouteHandler.PROGRESS_CONSULTATION),
                        ),
                        SizedBox(
                          height: _realWidth * 0.03,
                        ),

                        SolidButton(
                          size: _realWidth,
                          title: 'Kemajuan Proyek Pendanaan',
                          onTap: () => Navigator.pushNamed(context, RouteHandler.PROGRESS_FUNDING),
                        ),
                        SizedBox(
                          height: _realWidth * 0.03,
                        ),

                        SolidButton(
                          size: _realWidth,
                          title: 'Kemajuan Proyek Startup',
                          onTap: () => Navigator.pushNamed(context, RouteHandler.PROGRESS_STARTUP),
                        ),
                        SizedBox(
                          height: _realWidth * 0.06,
                        ),

                        Text('Kemajuan Pengajuan Kolaborasi', style: Theme.of(context).textTheme.headline6,),
                        SizedBox(
                          height: _realWidth * 0.03,
                        ),

                        DetailButton(
                          size: _realWidth,
                          title: 'Pengajuan Kolaborasi Partner Riset',
                          onTap: () => Navigator.pushNamed(context, RouteHandler.PROGRESS_RESEARCH_FIND_PARTNER),
                        ),
                        SizedBox(
                          height: _realWidth * 0.03,
                        ),

                        DetailButton(
                          size: _realWidth,
                          title: 'Pengajuan Kolaborasi Tim Riset',
                          onTap: () => Navigator.pushNamed(context, RouteHandler.PROGRESS_RESEARCH_FIND_TEAM),
                        ),
                        SizedBox(
                          height: _realWidth * 0.03,
                        ),


                        DetailButton(
                          size: _realWidth,
                          title: 'Pengajuan Kolaborasi Tim Startup',
                          onTap: () => Navigator.pushNamed(context, RouteHandler.PROGRESS_STARTUP_FIND_TEAM),
                        ),
                        SizedBox(
                          height: _realWidth * 0.03,
                        ),

                        DetailButton(
                          size: _realWidth,
                          title: 'Pengajuan Kolaborasi Partner Startup',
                          onTap: () => Navigator.pushNamed(context, RouteHandler.PROGRESS_STARTUP_FIND_PARTNER),
                        ),
                        SizedBox(
                          height: _realWidth * 0.03,
                        ),

                        SizedBox(
                          height: _realWidth * 0.07,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
