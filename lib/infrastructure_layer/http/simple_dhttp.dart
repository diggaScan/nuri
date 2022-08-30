import 'package:dio/dio.dart';
import 'package:nuri/infrastructure_layer/http/abstract_dhttp.dart';



class SimpleDHttp extends AbstractDHttp {
  static SimpleDHttp? _instance;

  Dio? _httpClient;

  factory SimpleDHttp() {
    _instance ??= SimpleDHttp._();
    return _instance!;
  }

  SimpleDHttp._();

  init(
      {required String domain,
      required int sendTimeout,
      required int connectTimeout,
      required int receiveTimeout}) {
    _httpClient = Dio(BaseOptions(
      baseUrl: domain,
      connectTimeout: 5000,
      sendTimeout: 5000,
      receiveTimeout: 6000,
    ));
  }

  post(
    String path,
    payload,
    Map<String, dynamic> queryParams,
  ) {
    _httpClient?.request(path,
        data: payload,
        queryParameters: queryParams,
        options: Options(method: 'POST'));
  }

  get(String path, Map<String, dynamic> queryParams) {
    _httpClient?.request(path,
        queryParameters: queryParams, options: Options(method: "GET"));
  }

  _formatKey(key) {
    if (key is num) {
      return key.toString();
    }

    String value = key;
    var kType = value.substring(0, 1);
    String prefix = '';
    String keyContent = '';
    if (kType == '_') {
      keyContent = value.substring(2);
      prefix = "_";
      kType = value.substring(1, 2);
    } else {
      keyContent = value.substring(1);
    }
    String newKey='';
    int keyLength=keyContent.length;
    for(int i =0;i<keyLength;i++){
      if(keyContent[i].compareTo('A')>0&&keyContent[i].compareTo('Z')<0){
          if(i==0){
             newKey+=keyContent[i].toLowerCase();
          }else{
            newKey+='_'+keyContent[i].toLowerCase();
          }
      }else{
        newKey+=keyContent[i];
      }
    }
    
   switch (kType) {
			case 'i':
				newKey += '_' + Config.VAR_TYPE_INT;
				break;
			case 's':
				newKey += '_' + Config.VAR_TYPE_STRING;
				break;
			case 'a':
				newKey += '_' + Config.VAR_TYPE_ARRAY;
				break;
			case 'b':
				newKey += '_' + Config.VAR_TYPE_BOOL;
				break;
			case 'e':
				newKey += '_' + Config.VAR_TYPE_ENUM;
				break;
			case 'm':
				newKey += '_' + Config.VAR_TYPE_MIXED;
				break;
			default:
				newKey += '_' + Config.VAR_TYPE_UNKNOWN;
				break;
		}






  }
}
