import '../api_impl.dart';
import 'data/get_verifycode_response_entity.dart';
import 'data/login_response_entity.dart';
import 'data/logout_response_entity.dart';
import 'data/name_used_response_entity.dart';
import 'data/register_response_entity.dart';

class BpModuleLogin {
  static BpModuleLogin? _instance;

  BpModuleLogin._();

  factory BpModuleLogin() {
    _instance ??= BpModuleLogin._();
    return _instance!;
  }

  /**
   * 检查昵称是否可用
   * sNickName: 域名
   */
  Future<NameUsedResponseEntity> isDomainUsed(
      {required String nickName}) async {
    Map<String, dynamic>? res = await ApiImpl.getHttp()
        .post(_ApiPath.isDomainUsed, {"sNickname": nickName.trim()});

    NameUsedResponseEntity entity =
        NameUsedResponseEntity().fromJson(res ?? {});
    return entity;
  }

  /**
   * 获取验证码
   */

  Future<GetVerifyCodeResponseEntity> getVerifyCode(
      {required String account,
      String countryCode = "86",
      int type = 3}) async {
    Map<String, dynamic>? res = await ApiImpl.getHttp().get(
        _ApiPath.getVerifyCode,
        {"sAccount": account, "sCountryCode": countryCode, "eLoginType": type});

    GetVerifyCodeResponseEntity entity =
        GetVerifyCodeResponseEntity().fromJson(res ?? {});
    return entity;
  }

  /**
   * 注册账号
   */

  Future<RegisterResponseEntity> registerAccount({
    required String account,
    required String verifyCode,
    required String nickName,
    int type = 3,
  }) async {
    Map<String, dynamic>? res = await ApiImpl.getHttp().post(
        _ApiPath.register, {
      "sAccount": account,
      "sVerify": verifyCode,
      "sNickname": nickName,
      "eType": type
    });

    RegisterResponseEntity entity =
        RegisterResponseEntity().fromJson(res ?? {});
    return entity;
  }

  /**
   * 登录
   */

  Future<LoginResponseEntity> login(
      {required String account,
      required String verifyCode,
      int type = 3}) async {
    Map<String, dynamic>? res = await ApiImpl.getHttp().post(_ApiPath.login,
        {"sAccount": account, "sVerify": verifyCode, "eType": type});

    LoginResponseEntity entity = LoginResponseEntity().fromJson(res ?? {});
    return entity;
  }

  /**
   * 退出登录
   */

  Future<LogoutResponseEntity> logout(
      {required String account,
      required String verifyCode,
      int type = 3}) async {
    Map<String, dynamic>? res =
        await ApiImpl.getHttp().post(_ApiPath.logout, {});

    LogoutResponseEntity entity = LogoutResponseEntity().fromJson(res ?? {});
    return entity;
  }
}

class _ApiPath {
  static String isDomainUsed = "account/name/usable";
  static String getVerifyCode = "account/get/verify/code";
  static String register = "account/register";
  static String login = "account/login";
  static String logout = "/account/logout";
}
