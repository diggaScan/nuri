import 'package:nuri/common/local_storage/local_storage.dart';
import 'package:uuid/uuid.dart';
import 'common/local_storage/preference_key.dart';

class EnvConfig {
  static getClientId() {
    var clientId = LocalStorage().get(key: PreferenceKey.CLIENT_ID);
    if (clientId == null) {
       clientId = Uuid().v4().substring(0, 32);
      LocalStorage().save(key: PreferenceKey.CLIENT_ID, value: clientId);
    }
    return clientId;
  }
}
