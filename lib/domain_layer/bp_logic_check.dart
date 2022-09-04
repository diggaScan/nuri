class BpLogicCheck {
  
  static isDomainValid(
    String domain, {
    Function? whenDomainEmpty,
    Function? whenDomainValid,
    Function? whenDomainUnvalid,
  }) {
    if (domain.isEmpty) {
      if (whenDomainEmpty != null) {
        whenDomainEmpty();
        return;
      }
    }

    RegExp pattern = RegExp(r'^[a-zA-Z0-9_]+$');
    bool allQualifiedChar = pattern.hasMatch(domain);
    if (!allQualifiedChar) {
      if (whenDomainUnvalid != null) {
        whenDomainUnvalid();
      }
    } else {
      if (whenDomainValid != null) {
        whenDomainValid();
      }
    }
  }
}
