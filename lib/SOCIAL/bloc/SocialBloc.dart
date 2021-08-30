import 'dart:async';

import 'package:personal/SOCIAL//database/Database.dart';
import 'package:personal/SOCIAL/model/SocialModel.dart';

class SocialBloc {

  SocialBloc() {
    getSocial();
  }
  final _socialController = StreamController<List<Social>>.broadcast();
  get social => _socialController.stream;
  dispose() {
    _socialController.close();
  }

  getSocial() async {
    _socialController.sink.add(await DBProvider.db.getAllSocial());
  }

  add(Social social) {
    DBProvider.db.newSocial(social);
    getSocial();
  }
  update(Social social) {
    DBProvider.db.updateSocial(social);
    getSocial();
  }

  delete(int id) {
    DBProvider.db.deleteSocial(id);
    getSocial();
  }

  deleteAll() {
    DBProvider.db.deleteAll();
    getSocial();
  }

}

