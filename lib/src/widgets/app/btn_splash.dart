// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class ButtonSplash extends StatefulWidget {

  const ButtonSplash(
      {super.key,
      @required this.child,
      this.splashColor,
      @required this.onTap,
      this.center,
      this.borderRadius,
      this.centerBottom,
      this.topRight,
      this.margin,
      this.hoverColor,
      this.selectedWidget,});
  final Widget? child;
  final Color? splashColor;
  final Color? hoverColor;
  final void Function()? onTap;
  final Widget? center;
  final Widget? centerBottom;
  final Widget? topRight;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final bool Function()? selectedWidget;
  @override
  _ButtonSplashState createState() => _ButtonSplashState();
}

class _ButtonSplashState extends State<ButtonSplash>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;
  bool enable = false;
  bool onhover = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      upperBound: 0.02,
    );
    _controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        setState(() {
          enable = true;
        });
      },
      onPointerUp: (PointerUpEvent event) {
        setState(() {
          enable = false;
        });
      },
      child: Transform.scale(
        scale: _scale!,
        child: Container(
          margin: widget.margin ??
              const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
          child: InkWell(
            onTap: widget.onTap ?? () => print('tap'),
            onHover: (hover) {
              onhover = hover;
              setState(() {});
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                widget.child!,
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 0),
                      color: enable
                          ? (widget.splashColor ??
                              Colors.black.withOpacity(0.2))
                          : Colors.transparent,
                    ),
                  ),
                ),
                if (widget.selectedWidget != null)
                  if (widget.selectedWidget!())
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 5,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                        ),
                      ),
                    ),),
                if (onhover)
                  Positioned.fill(
                    child: Align(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius ?? 0),
                          color: onhover
                              ? (widget.hoverColor ??
                                  Colors.black.withOpacity(0.1))
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                if (widget.center != null)
                  Positioned.fill(
                      child: Align(
                    child: enable
                        ? Icon(Icons.play_circle_outline,
                            size: 36, color: widget.splashColor ?? Colors.white,)
                        : Container(),
                  ),),
                if (widget.centerBottom != null)
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: enable ? widget.centerBottom : Container(),),),
                if (widget.topRight != null)
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.topRight,
                          child: enable ? widget.topRight : Container(),),),
                // Container(
                //   margin: widget.margin,
                //   child: Material(
                //     color: enable
                //         ? (widget.splashColor ?? Colors.black.withOpacity(0.4))
                //         : Colors.transparent,
                //     borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                //     child: GestureDetector(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: <Widget>[
                //           Material(
                //               color: Colors.transparent,
                //               child: Container(
                //                 width: widget.width ??
                //                     MediaQuery.of(context).size.width * 0.9,
                //                 height: widget.height,
                //                 child: enable
                //                     ? widget.whenSplashWidget
                //                     // Align(
                //                     //     alignment: Alignment.topRight,
                //                     //     child: Padding(
                //                     //       padding: const EdgeInsets.all(8.0),
                //                     //       child: CircleAvatar(
                //                     //         child: Icon(EvaIcons.playCircleOutline),
                //                     //       ),
                //                     //     ),
                //                     //   )
                //                     : Text(''),
                //               ))
                //         ],
                //       ),

                //       onTap: widget.onTap,
                //       // borderRadius: BorderRadius.circular(15.0),
                //     ),
                //   ),
                // ),
                // enable
                //     ? Positioned(
                //         top: 30, left: 10, child: widget.topLeft ?? Text(''))
                //     : Text(''),
                // enable
                //     ? Positioned(
                //         top: 30, right: 10, child: widget.topRight ?? Text(''))
                //     : Text(''),
                // enable
                //     ? Positioned(
                //         bottom: 30,
                //         right: 10,
                //         child: widget.bottomRight ?? Text(''))
                //     : Text(''),
                // enable
                //     ? Positioned(
                //         bottom: 30, left: 10, child: widget.bottomLeft ?? Text(''))
                //     : Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
