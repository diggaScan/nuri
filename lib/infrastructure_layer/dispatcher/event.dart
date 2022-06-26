
/// Event 刷新
class RefreshEvent {
  final String whichPart;
  Map<String, dynamic>? parameters;
  final int delaySeconds;

  RefreshEvent(this.whichPart, {this.delaySeconds = 0, this.parameters});
}