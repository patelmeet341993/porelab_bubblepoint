import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/views/commons/common_dropdown.dart';
import '../../config/app_colors.dart';
import '../../config/common_text.dart';
class CommonTextWithDropDown extends StatefulWidget {
  List<String> items;
  String dropdownvalue;
  String title;
  void Function(String?)? onChanged;
  CommonTextWithDropDown({required this.dropdownvalue,required this.items,required this.title,required this.onChanged});
  @override
  State<CommonTextWithDropDown> createState() => _CommonTextWithDropDownState();
}

class _CommonTextWithDropDownState extends State<CommonTextWithDropDown> {


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: CommonText(text: widget.title,fontSize: 25,)),
        Expanded(
          flex: 3,
          child: CommonDropDown(dropdownvalue:widget.dropdownvalue , items:widget.items,onChanged:widget.onChanged , )
        )
      ]
    );
  }

}