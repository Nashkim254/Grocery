import 'package:flutter/material.dart';
import 'package:grocery_app/model/login.dart';
import 'package:grocery_app/util/logs.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ButtonLoginAnimation extends StatefulWidget {
  final String? label;
  final String? phone;
  final String? password;
  final Color? background;
  final Color? borderColor;
  final Color? fontColor;
  final Function? onTap;
  final Widget? child;

  const ButtonLoginAnimation(
      {Key? key,
      this.label,
      required this.phone,
     required this.password,
      this.background,
      this.borderColor,
      this.fontColor,
      this.onTap,
      this.child})
      : super(key: key);

  @override
  _ButtonLoginAnimationState createState() => _ButtonLoginAnimationState();
}

class _ButtonLoginAnimationState extends State<ButtonLoginAnimation> with TickerProviderStateMixin {
  late AnimationController _positionController;
  late Animation<double> _positionAnimation;

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  bool _isIconHide = false;

  @override
  void initState() {
    super.initState();

    _positionController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    _positionAnimation = Tween<double>(begin: 10.0, end: 255.0).animate(_positionController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isIconHide = true;
          });
          _scaleController.forward();
        }
      });

    _scaleController = AnimationController(vsync: this, duration: Duration(milliseconds: 900));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 32).animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
              context, PageTransition(type: PageTransitionType.fade, child: widget.child!));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(builder: (context, provider, child) {
      return InkWell(
        onTap: provider.isDataLoading == true
            ? () {}
            : () {
                printSuccess(widget.phone);
                printSuccess(widget.password);
                // controller.login(widget.phone!, widget.password!, context);
                // _positionController.forward();
              },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.background,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
    });
  }
}
