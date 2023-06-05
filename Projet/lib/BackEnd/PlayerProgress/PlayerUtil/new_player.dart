




import 'package:sorttrash/BackEnd/PlayerProgress/player.dart';

import '../../DataBaseService/local_data_base_service.dart';

class NewPlayerUtil {
  static PlayerProgress returnNewPlayer(){
    return PlayerProgress(0, DataBaseService.newGameDataPlayer, DateTime.now(), 0, 'childsName', 'childGlobalUID', 'avatarProfileName', DateTime.now());
  }
}