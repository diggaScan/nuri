import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:nuri/infrastructure_layer/http/abstract_dhttp.dart';
import 'package:nuri/infrastructure_layer/http/config.dart';

class SimpleDHttp extends AbstractDHttp {

  Dio? _httpClient;
  String? _clientId;
  String? _vesion;

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

  Future<Response?> post(String path, payload,
      {Map<String, dynamic>? queryParams}) async {
    Map<String, dynamic> formated_payload = _format(payload);
    Map<String, dynamic> params = _format(compositeCommonQuery(queryParams));
    Response? res = await _httpClient?.request(path,
        data: formated_payload,
        queryParameters: params,
        options:
            Options(method: 'POST', headers: {'Accept': 'application/json'}));
    return res;
  }

  Future<Response?> get(String path, Map<String, dynamic> queryParams) async {
    Map<String, dynamic> params = _format(compositeCommonQuery(queryParams));
    Response? res = await _httpClient?.request(path,
        queryParameters: params,
        options:
            Options(method: "GET", headers: {'Accept': 'application/json'}));
    return res;
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

  _format(params) {
    var newParams;
    if (params is List) {
      newParams = [];
    }

    if (params is Map) {
      newParams = {};
      for (String key in params.keys) {
        newParams[_formatKey(key)] = params[key];
      }
    }

    return newParams ?? {};
  }

  Map<String, dynamic> compositeCommonQuery(Map? params) {
    Map<String, dynamic> commonParams = {};
    commonParams["_sClientId"] = this._clientId;
    commonParams["_iReqTime"] = DateTime.now().millisecondsSinceEpoch;
    commonParams["_sVersion"] = this._vesion;
    for (String key in params?.keys ?? []) {
      commonParams["$key"] = params![key];
    }

    return commonParams;
  }
}
