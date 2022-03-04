import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageFullScreenWrapperWidget extends StatelessWidget {
  final String child;
  final String name;
  final bool dark;

  ImageFullScreenWrapperWidget({
    required this.child,
    required this.name,
    this.dark = true,
  });

  @override
  Widget build(BuildContext context) {
    return FullScreenPage(
      name: name,
      child: Image.network(
        child,
        fit: BoxFit.contain,
      ),
      dark: dark,
    );
  }
}

class FullScreenPage extends StatefulWidget {
  FullScreenPage({
    required this.name,
    required this.child,
    required this.dark,
  });

  final String name;
  final Image child;
  final bool dark;

  @override
  _FullScreenPageState createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
  @override
  void initState() {
    var brightness = widget.dark ? Brightness.light : Brightness.dark;
    var color = widget.dark ? Colors.black12 : Colors.white70;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: color,
      statusBarColor: color,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
      systemNavigationBarDividerColor: color,
      systemNavigationBarIconBrightness: brightness,
    ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // Restore your settings here...
        ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
      ),
      backgroundColor: widget.dark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 333),
                curve: Curves.fastOutSlowIn,
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 4,
                  child: widget.child,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
