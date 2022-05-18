// import 'package:flutter/material.dart';
// import 'package:machinavision/tool_kit.dart' as T;

// class ToolTip extends StatefulWidget {
//   final String message;
//   final T.SvgImage? image;
//   final Color? bgColor;
//   final Color? borderColor;
//   final Color? messageColor;

//   const ToolTip({
//     required this.message,
//     this.image,
//     this.bgColor,
//     this.borderColor,
//     this.messageColor,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _ToolTipState createState() => _ToolTipState();
// }

// class _ToolTipState extends State<ToolTip> {
//   final _tooltipKey = GlobalKey();

//   T.SvgImage get _image => widget.image ?? T.Images.question;
//   Color get _bgColor => widget.bgColor ?? T.Colors.secondary;
//   Color get _borderColor => widget.borderColor ?? T.Colors.secondary;
//   Color get _messageColor => widget.borderColor ?? T.Colors.white;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => T.Utilities.showToolTip(_tooltipKey),
//       child: Tooltip(
//         key: _tooltipKey,
//         message: widget.message,
//         preferBelow: false,
//         decoration: BoxDecoration(
//           color: _bgColor,
//           border: Border.all(width: 0, color: _borderColor),
//           borderRadius: BorderRadius.circular(5),
//           boxShadow: [
//             BoxShadow(
//               color: T.Colors.shadow,
//               blurRadius: 11,
//               spreadRadius: 3,
//               offset: const Offset(0, 0),
//             )
//           ],
//         ),
//         textStyle: TextStyle(
//           color: _messageColor,
//           fontSize: 10,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
//           child: _image,
//         ),
//       ),
//     );
//   }
// }
