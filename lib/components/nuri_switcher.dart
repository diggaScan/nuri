import 'package:flutter/cupertino.dart';
import 'package:nuri/ui_theme/ui_color.dart';

class NuriSwitcher extends StatefulWidget {
  final bool initialStatus;
  const NuriSwitcher({Key? key,this.initialStatus=false}) : super(key: key);

  @override
  State<NuriSwitcher> createState() => _NuriSwitcherState();
}

class _NuriSwitcherState extends State<NuriSwitcher> {
  bool onSwitch = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onSwitch=widget.initialStatus;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          onSwitch = !onSwitch;
        });
      },
      child: Container(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: onSwitch
              ? Container(
                  width: 30,
                  height: 18,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: UiColor.brandingGreen),
                  padding: EdgeInsets.all(4.5),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: UiColor.bottomSheetBkg),
                  ),
                )
              : Container(
                  width: 30,
                  height: 18,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(4.5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: UiColor.grey2),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: UiColor.bottomSheetBkg),
                  ),
                ),
        ),
      ),
    );
  }
}
