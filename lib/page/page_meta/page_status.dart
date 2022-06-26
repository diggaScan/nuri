
mixin PageStatus {
  String pageState=PageState.idle;

  void setPageState(String pageState) {
    this.pageState = pageState;
  }
}

class PageState {
  static const success = "success";
  static const loading = "loading";
  static const error = "error";
  static const idle = "idel";
  static const empty = "empty";
}