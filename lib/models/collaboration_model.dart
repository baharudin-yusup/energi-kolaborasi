import 'package:flutter/cupertino.dart';

abstract class CollaborationModel {
  final String uploader;
  final String title;

  final description;
  final String searchFor;

  CollaborationModel(
      {@required this.uploader,
      @required this.description,
      @required this.searchFor,
      @required this.title,});
}

class CollaborationPartnerModel extends CollaborationModel {
  final List<String> skillNeeded;
  final String projectId;
  final String category;

  CollaborationPartnerModel({
    @required String uploader,
    @required String projectId,
    @required String category,
    @required List<String> skills,
    @required String description,
    @required String title,
  })  : this.projectId = projectId,
        this.skillNeeded = skills,
        this.category = category,
        super(
          description: description,
          uploader: uploader,
          searchFor: 'partner',
        title: title,
        );
}

class CollaborationTeamModel extends CollaborationModel {
  final String category;
  final List<String> skillOffered;

  CollaborationTeamModel({
    @required String uploader,
    @required String category,
    @required List<String> skills,
    @required String description,
    @required String title,
  })  : this.category = category,
        this.skillOffered = skills,
        super(
        searchFor: 'team',
        uploader: uploader,
        description: description,
        title: title,
      );
}
