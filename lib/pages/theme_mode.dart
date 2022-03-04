import 'package:flutter/material.dart';
import 'package:insectos/global/theme.dart';
import 'package:provider/provider.dart';

class ThemeModeI extends StatefulWidget {
  const ThemeModeI({Key? key}) : super(key: key);

  @override
  _ThemeModeIState createState() => _ThemeModeIState();
}

class _ThemeModeIState extends State<ThemeModeI> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 160, 198, 168),
        title: Text(
          'Apariencia',
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              Provider.of<ThemeProvider>(context, listen: false).isD
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: Theme.of(context).primaryColorLight,
            ),
            Row(
              children: [
                Text('Modo oscuro'),
                Expanded(child: Container()),
                Checkbox(
                    value:
                        Provider.of<ThemeProvider>(context, listen: false).isD
                            ? false
                            : true,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    onChanged: (bool? value) {
                      setState(() {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .swapTheme();
                        //MyApp.themeNotifier.value = ThemeMode.dark;
                      });
                    }),
              ],
            ),
            Row(
              children: [
                Text('Modo claro'),
                Expanded(child: Container()),
                Checkbox(
                    value:
                        Provider.of<ThemeProvider>(context, listen: false).isD
                            ? true
                            : false,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    onChanged: (bool? value) {
                      setState(() {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .swapTheme();
                        //MyApp.themeNotifier.value = ThemeMode.light;
                      });
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
