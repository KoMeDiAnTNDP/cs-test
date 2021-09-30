import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cs_test/utilities/constants.dart';

class CSRaisedButton extends StatelessWidget {
  final Color buttonColor;
  final String label;
  final Color labelColor;
  final double labelFontSize;
  final String suffix;
  final String suffixIcon;
  final Color suffixIconColor;
  final double rightPadding;
  final Function onPressed;
  final Key key;

  CSRaisedButton({
    @required this.label,
    this.buttonColor = Colors.white,
    this.labelColor = Colors.black,
    this.suffix,
    this.suffixIcon,
    this.suffixIconColor,
    this.rightPadding = 22,
    this.labelFontSize = 14,
    this.onPressed,
    this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(Constants.HEADER_CARD_BORDER_RADIUS),
      ),
      child: Container(
        height: Constants.HEADER_ICON_BACKGROUND_LENGTH,
        child: Center(
          child: (suffix == null && suffixIcon == null)
              ? Text(
                  label,
                  style: TextStyle(color: labelColor, fontSize: this.labelFontSize),
                )
              : Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          label,
                          style: TextStyle(color: labelColor , fontSize: this.labelFontSize),
                        ),
                      ),
                    ),
                    suffix != null
                        ? Text(
                            suffix,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: labelColor,
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 6),
                      child: suffixIcon != null
                          ? SvgPicture.asset(
                              suffixIcon,
                              color: suffixIconColor ?? labelColor,
                              fit: BoxFit.scaleDown,
                            )
                          : Container(
                              padding: EdgeInsets.only(right: rightPadding),
                            ),
                    ),
                  ],
                ),
        ),
      ),
      onPressed: onPressed,
      key: key,
    );
  }
}