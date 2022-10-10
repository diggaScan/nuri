import 'package:nuri/domain_layer/request_data/account_info_entity.dart';
import 'package:nuri/domain_layer/request_data/avatar_entity.dart';
import 'package:nuri/domain_layer/request_data/login_entity.dart';
import 'package:nuri/infrastructure_layer/http/simple_dhttp.dart';

class ApiImpl{

  static SimpleDHttp getHttp(){
    return SimpleDHttp().getHttp();
  }

  static  ApiImpl? _instance;
  SimpleDHttp? _simpleDHttp;
  ApiImpl._();
  factory ApiImpl(){
      _instance??=ApiImpl._();
    return _instance!;
  }

  init(
      {required String domain,
      required int sendTimeout,
      required int connectTimeout,
      required int receiveTimeout,
      required String clientId,
      required String version}) {
     _simpleDHttp=SimpleDHttp();
    _simpleDHttp?.init(domain: domain, sendTimeout: sendTimeout, connectTimeout: connectTimeout, receiveTimeout: receiveTimeout, clientId: clientId, version: version);
  }
  /**
   * 抢占昵称
   * sNickName: 域名
   */
   registerName({required String nickName}){
    _simpleDHttp?.post("/account/apply/nickname", {"sNickName":nickName});
  }


///账号注册
///
   accountRegister({required String accountName,required String verify,required String repeat,required String nickName,required String key,required int type}){
    _simpleDHttp?.post("/account/register", {},queryParams: {"sAccount":accountName,"sVerify":verify,"sRepeat":repeat,"sNickName":nickName,"sKey":key,"eType":1});
  }

///上传新头像
  uploadAvatar({required AvatarEntity entity}){
    _simpleDHttp?.post("/account/avatar/upload",{""});
  }

///账号信息修改
 editAccountInfo({required AccountInfoEntity entity}){
  _simpleDHttp?.post("/account/info/update", {});
 }

///获取验证码
///type:1-账号，2-邮箱，3-手机号
getVerifyCode({required String account,required String countryCode,required int type}){
  _simpleDHttp?.get("/account/get/verify/code", {"sAccount":account,"sCountryCode":countryCode,"eLoginType":type});
}

///登录
 login({required LoginEntity entity}){
  _simpleDHttp?.post("/account/login", {});
 }

 ///退出登录
 logout(){
  _simpleDHttp?.post("/account/logout", {});
 }

 ///获取文件上传链接
 getUploadUrl({required String biz,required String ext}){
  _simpleDHttp?.get("/file/upload/url", {"sBiz":biz,"sExt":ext});
 }

 ///获取客户端配置
 getClientConfig(){
  _simpleDHttp?.get("/client/config",{});
 }

///域名是否已经被占用
  hasDomainAvailable(){
     _simpleDHttp?.get("",{});
  }







}