import 'package:energi_kolaborasi/models/user_model.dart';
import 'package:flutter/material.dart';

enum AbstractAvatarType {
  profile,
  changeAvatar,
}

class AbstractAvatar extends StatelessWidget {

  final double size;
  final ImageProvider image;

  final AbstractAvatarType type;

  String getInitials(String userName) => userName.isNotEmpty
      ? userName.trim().split(' ').map((l) => l[0]).take(3).join().toUpperCase()
      : '';

  AbstractAvatar({
    bool hasPhoto,
    @required double size,
    String url,
    AbstractAvatarType type,
  })  :
        this.size = size,
        this.image = url != null ? NetworkImage(url) : null,
  this.type = type ?? AbstractAvatarType.profile;

  @override
  Widget build(BuildContext context) {

    switch (type) {
      case AbstractAvatarType.changeAvatar:
        if (image != null) {
          return CircleAvatar(
            radius: size * 0.4,
            backgroundImage: image,
            backgroundColor: Colors.white60.withOpacity(0.7),
          );
        }
        return CircleAvatar(
          radius: size * 0.25,
          backgroundColor: Colors.white60.withOpacity(0.7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera,
                size: size * 0.1,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: size * 0.04,
              ),
              // Skills Title
              Text(
                'Foto Profil (Ukuran 800x800)',
                style:
                Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
        break;
      default:
        if (image != null) {
          return CircleAvatar(
            radius: size * 0.4,
            backgroundImage: image,
            backgroundColor: Colors.white60.withOpacity(0.7),
          );
        }
        return CircleAvatar(
          radius: size * 0.25,
          backgroundColor: Colors.white60.withOpacity(0.7),
          child: getInitials(UserModel.instance?.name ?? '') != '' ? Text(getInitials(UserModel.instance?.name ?? ''), style: Theme.of(context).textTheme.headline3,) : Icon(Icons.person, size: size * 0.25, color: Colors.grey,),
        );
        break;
    }
  }
}
