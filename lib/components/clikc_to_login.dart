import 'package:flutter/cupertino.dart';
import 'package:nuri/ui_theme/ui_color.dart';
import 'package:nuri/ui_theme/ui_text_style.dart';

class ClickToLogin extends StatelessWidget {
  final Function? onTap;
  final String content;
  const ClickToLogin({Key? key,this.onTap,this.content='点击登录'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(onTap!=null){
          onTap!();
        }
      },
      child: Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "已有账号？",
          style: UiTextStyles.n12(color: UiColor.grey3),
        ),
        Text(
          content,
          style: UiTextStyles.n12(color: UiColor.brandingGreen),
        ),
      ]),
    ),
    )
    
    ;
  }
}
