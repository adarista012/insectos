import 'package:flutter/material.dart';
import 'package:insectos/global/styles.dart';
import 'package:insectos/services/authentication.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInPage extends StatefulWidget {
  final Function toggleScreen;
  SignInPage({required this.toggleScreen});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool oT = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final authProvider = Provider.of<AuthenticationService>(context);

    return Scaffold(
      body: Container(
        height: h,
        width: w,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 40.0),
                    Text(
                      'Ingrese con su cuenta',
                      style: boldBrown,
                    ),
                    SizedBox(height: h / 16.0),
                    TextFormField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      validator: (input) =>
                          input!.contains('@') && input.isNotEmpty
                              ? null
                              : 'Ingrese un correo electrónico válido',
                      decoration: InputDecoration(
                        labelText: 'Correo Electrónico',
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        contentPadding: EdgeInsets.all(12),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      obscureText: oT,
                      validator: (input) =>
                          input!.isNotEmpty && input.length > 6
                              ? null
                              : 'Ingrese una contraseña con más caracteres',
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              oT = !oT;
                            });
                          },
                          color: Theme.of(context).focusColor,
                          icon: Icon(
                            !oT ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        contentPadding: EdgeInsets.all(12),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    isLoading
                        ? MaterialButton(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            onPressed: () {},
                            height: 40.0,
                            shape: StadiumBorder(),
                            color: Theme.of(context).colorScheme.secondary,
                          )
                        : MaterialButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                await authProvider.signIn(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim());
                              }

                              if (authProvider.errorMessage == true) {
                                isLoading = false;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: Duration(seconds: 10),
                                  content: Text(
                                    authProvider.message,
                                  ),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    onPressed: () {
                                      authProvider.setErrorMessage(false);
                                    },
                                  ),
                                ));
                              }
                              isLoading = false;
                              authProvider.setErrorMessage(false);
                              authProvider.authChanges;
                            },
                            minWidth: w,
                            height: 40.0,
                            shape: StadiumBorder(),
                            color: Theme.of(context).colorScheme.secondary,
                            child: Text('Ingresar', style: mediumWhite),
                          ),
                    SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No tienes cuenta? '),
                        TextButton(
                            onPressed: () => widget.toggleScreen(),
                            child: Text('Registrate'))
                      ],
                    ),
                    SizedBox(height: 24.0),
                    TextButton(
                        onPressed: () async {
                          if (_emailController.text != '') {
                            await authProvider.resetPassword(
                                email: _emailController.text);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //duration: Duration(seconds: 10),

                              content: Text(
                                  'Se envió un email a ${_emailController.text}'),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //duration: Duration(seconds: 10),
                              backgroundColor: Colors.red,
                              content: Text('Ingrese un email válido.'),
                            ));
                          }
                        },
                        child: Text('Olvidaste tu contraseña?')),
                  ],
                )),
            Container(
                margin: EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () async =>
                      {await launch("https://wa.me/+59170573566")},
                  child: Text(
                    'Desarrollador +591 70573566',
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
