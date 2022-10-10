import 'package:dio/dio.dart';
import 'package:nuri/infrastructure_layer/http/abstract_dhttp.dart';
import 'package:nuri/infrastructure_layer/http/config.dart';

class SimpleDHttp extends AbstractDHttp {
  static Dio? _httpClient;
  String? _clientId;
  String? _vesion;

  static SimpleDHttp? _instance;

  SimpleDHttp._();

  factory SimpleDHttp() {
    if (_instance == null) {
      _instance = SimpleDHttp._();
    }
    return _instance!;
  }

  getHttp() {
    return _instance;
  }

  init(
      {required String domain,
      required int sendTimeout,
      required int connectTimeout,
      required int receiveTimeout,
      required String clientId,
      required String version}) {
    this._clientId = clientId;
    this._vesion = version;
    _httpClient = Dio(BaseOptions(
      baseUrl: domain,
      connectTimeout: 5000,
      sendTimeout: 5000,
      receiveTimeout: 6000,
    ));
  }

  Future<Map<String,dynamic>?> post(String path, payload,
      {Map<String, dynamic>? queryParams}) async {
    Map<String, dynamic> formated_payload = _formatRequestJson(payload);
    Map<String, dynamic> params =
        _formatRequestJson(compositeCommonQuery(queryParams));
    Response? res = await _httpClient?.post(path,
        data: formated_payload,
        queryParameters: params,
        options:
            Options(method: 'POST', headers: {'Accept': 'application/json'}));
    var aRes=_formatResponseJson(res?.data??{});
    return aRes;
  }

  Future<Map<String,dynamic>?> get(String path, Map<String, dynamic> queryParams) async {
    Map<String, dynamic> params =
        _formatRequestJson(compositeCommonQuery(queryParams));
    Response? res = await _httpClient?.get(path,
        queryParameters: params,
        options:
            Options(method: "GET", headers: {'Accept': 'application/json'}));
    var aRes=_formatResponseJson(res?.data??{});
    return aRes;
  }

  //请求是转化请求的字段
  Map<String, dynamic> _formatRequestJson(params) {
    var newParams;
    if (params is List) {
      newParams = [];
    }

    if (params is Map) {
      newParams = <String, dynamic>{};
      for (String key in params.keys) {
        newParams[_formatRequestKey(key)] = params[key];
      }
    }
    return newParams ?? {};
  }

  _formatRequestKey(key) {
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
    String newKey = '';
    int keyLength = keyContent.length;
    for (int i = 0; i < keyLength; i++) {
      if (keyContent[i].compareTo('A') > 0 &&
          keyContent[i].compareTo('Z') < 0) {
        if (i == 0) {
          newKey += keyContent[i].toLowerCase();
        } else {
          newKey += '_' + keyContent[i].toLowerCase();
        }
      } else {
        newKey += keyContent[i];
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

    return prefix + newKey;
  }

  Map<String, dynamic> compositeCommonQuery(Map? params) {
    Map<String, dynamic> commonParams = {};
    commonParams["_sClientId"] = this._clientId;
    commonParams["_iReqTime"] = DateTime.now().millisecondsSinceEpoch / 1000;
    commonParams["_sVersion"] = this._vesion;
    commonParams["_sDebug"] = "i_love_tang_ping";
    for (String key in params?.keys ?? []) {
      commonParams["$key"] = params![key];
    }

    return commonParams;
  }

  //解析返回的字段
  Map<String, dynamic> _formatResponseJson(aRes) {
    var newParams;
    if (aRes is List) {
      newParams = [];
    }

    if (aRes is Map) {
      newParams = <String, dynamic>{};
      for (String key in aRes.keys) {
        if (aRes[key] is Map) {
          newParams[_formatResponseKey(key)] = _formatResponseJson(aRes[key]);
        } else {
          newParams[_formatResponseKey(key)] = aRes[key];
        }
      }
    }
    return newParams ?? {};
  }

  _formatResponseKey(String sKey) {
    if (sKey is num) {
      return sKey.toString();
    }
    if (sKey.substring(1,2) == sKey.substring(1,2).toUpperCase() || sKey.substring(2,3) == sKey.substring(2,3).toUpperCase()) {
      // 是驼峰结构
      return sKey;
    }
    var sType = sKey.substring(sKey.length-1, sKey.length);
    var sNewKey = '';
    var sPrefix = '';
    if (sKey.substring(0, 1) == '_') {
      sPrefix = '_';
      sKey.substring(1, sKey.length - 3).split('_').forEach((sPart) {
        sNewKey += sPart.substring(0, 1).toUpperCase() + sPart.substring(1);
      });
    } else {
      sKey.substring(0, sKey.length - 2).split('_').forEach((sPart) {
      sNewKey += sPart.substring(0, 1).toUpperCase() + sPart.substring(1);
      });
    }
    switch (sType) {
      case Config.VAR_TYPE_INT:
        sNewKey = 'i' + sNewKey;
        break;
      case Config.VAR_TYPE_STRING:
        sNewKey = 's' + sNewKey;
        break;
      case Config.VAR_TYPE_ARRAY:
        sNewKey = 'a' + sNewKey;
        break;
      case Config.VAR_TYPE_BOOL:
        sNewKey = 'b' + sNewKey;
        break;
      case Config.VAR_TYPE_ENUM:
        sNewKey = 'e' + sNewKey;
        break;
      case Config.VAR_TYPE_MIXED:
        sNewKey = 'm' + sNewKey;
        break;
      default:
        sNewKey = 'u' + sNewKey;
        break;
    }
    return sPrefix + sNewKey;
  }
}
