class AccountInfoEntity{
  AccountInfo? aAccount;
  ContactInfo? aContact;
}

class AccountInfo{
  String? sSummary;
  String? sNickName;
}

class ContactInfo{
  String? sWeChat;
  String? sEmail;
  String? sMobile;
  int? bIsPublic;
}