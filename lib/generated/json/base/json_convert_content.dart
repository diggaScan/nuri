// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:nuri/domain_layer/bp_module_login/data/get_verifycode_response_entity.dart';
import 'package:nuri/generated/json/get_verifycode_response_entity_helper.dart';
import 'package:nuri/domain_layer/bp_module_login/data/login_response_entity.dart';
import 'package:nuri/generated/json/login_response_entity_helper.dart';
import 'package:nuri/domain_layer/bp_module_login/data/logout_response_entity.dart';
import 'package:nuri/generated/json/logout_response_entity_helper.dart';
import 'package:nuri/domain_layer/bp_module_login/data/name_used_response_entity.dart';
import 'package:nuri/generated/json/name_used_response_entity_helper.dart';
import 'package:nuri/domain_layer/bp_module_login/data/register_response_entity.dart';
import 'package:nuri/generated/json/register_response_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
		switch (type) {
			case GetVerifyCodeResponseEntity:
				return getVerifyCodeResponseEntityFromJson(data as GetVerifyCodeResponseEntity, json) as T;
			case LoginResponseEntity:
				return loginResponseEntityFromJson(data as LoginResponseEntity, json) as T;
			case LogoutResponseEntity:
				return logoutResponseEntityFromJson(data as LogoutResponseEntity, json) as T;
			case NameUsedResponseEntity:
				return nameUsedResponseEntityFromJson(data as NameUsedResponseEntity, json) as T;
			case RegisterResponseEntity:
				return registerResponseEntityFromJson(data as RegisterResponseEntity, json) as T;    }
		return data as T;
	}

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case GetVerifyCodeResponseEntity:
				return getVerifyCodeResponseEntityToJson(data as GetVerifyCodeResponseEntity);
			case LoginResponseEntity:
				return loginResponseEntityToJson(data as LoginResponseEntity);
			case LogoutResponseEntity:
				return logoutResponseEntityToJson(data as LogoutResponseEntity);
			case NameUsedResponseEntity:
				return nameUsedResponseEntityToJson(data as NameUsedResponseEntity);
			case RegisterResponseEntity:
				return registerResponseEntityToJson(data as RegisterResponseEntity);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (GetVerifyCodeResponseEntity).toString()){
			return GetVerifyCodeResponseEntity().fromJson(json);
		}
		if(type == (LoginResponseEntity).toString()){
			return LoginResponseEntity().fromJson(json);
		}
		if(type == (LogoutResponseEntity).toString()){
			return LogoutResponseEntity().fromJson(json);
		}
		if(type == (NameUsedResponseEntity).toString()){
			return NameUsedResponseEntity().fromJson(json);
		}
		if(type == (RegisterResponseEntity).toString()){
			return RegisterResponseEntity().fromJson(json);
		}

		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<GetVerifyCodeResponseEntity>[] is M){
			return data.map<GetVerifyCodeResponseEntity>((e) => GetVerifyCodeResponseEntity().fromJson(e)).toList() as M;
		}
		if(<LoginResponseEntity>[] is M){
			return data.map<LoginResponseEntity>((e) => LoginResponseEntity().fromJson(e)).toList() as M;
		}
		if(<LogoutResponseEntity>[] is M){
			return data.map<LogoutResponseEntity>((e) => LogoutResponseEntity().fromJson(e)).toList() as M;
		}
		if(<NameUsedResponseEntity>[] is M){
			return data.map<NameUsedResponseEntity>((e) => NameUsedResponseEntity().fromJson(e)).toList() as M;
		}
		if(<RegisterResponseEntity>[] is M){
			return data.map<RegisterResponseEntity>((e) => RegisterResponseEntity().fromJson(e)).toList() as M;
		}

		throw Exception("not found");
	}

  static M fromJsonAsT<M>(json) {
		if (json is List) {
			return _getListChildType<M>(json);
		} else {
			return _fromJsonSingle<M>(json) as M;
		}
	}
}