import 'package:flutter/material.dart';

import '../../../../core/utils/form_fields_validators.dart';
import 'commons_form_widgets.dart';

class SignUpForm extends StatefulWidget {
  final void Function() onLoginRequest;
  SignUpForm({@required this.onLoginRequest});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), _showFacebookSignInSuggestion);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: height * .07),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white),
            padding: const EdgeInsets.all(4),
            child: const Text(
              "Inscription ",
              textScaleFactor: 1.7,
            ),
          ),
          SizedBox(height: 30),
          _form(),
          SizedBox(
            height: 15,
          ),
          FormValidatorButton(
            onClick: () {
              if (_formKey.currentState.validate()) print("Subscribed!!!!");
            },
          ),
          _formLoginLink(),
        ],
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          CustomTextField(
            prefixIcon: Icon(Icons.person),
            maxLength: 30,
            title: "Nom",
            validator: namesValidator,
          ),
          CustomTextField(
            prefixIcon: Icon(Icons.person_outline),
            maxLength: 30,
            title: "Prénom",
            validator: namesValidator,
          ),
          CustomTextField(
            maxLength: 9,
            prefixIcon: Icon(Icons.phone),
            helperText: "Le numéro de téléphone est facultatif",
            title: "Téléphone",
            fieldType: TextInputType.numberWithOptions(),
            validator: phoneNumberValidator,
          ),
          emailField,
          SizedBox(
            height: 16,
          ),
          PasswordField(),
        ],
      ),
    );
  }

  Future<void> _showFacebookSignInSuggestion() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Recommendation"),
          content: Text(
              "Cher utilisateur, si vous avez un compte Facebook il n'est pas nécessaire de créer un compte Taluxi, vous pouvez vous connecter à Taluxi à l'aide de votre compte Facebook. C'est plus facile et plus rapide,\nMerci de votre compréhension."),
          actions: [
            Center(
              child: RaisedButton(
                onPressed: () {
                  //TODO Facebook login
                },
                child: Text("Me connecter à l'aide de Facebook"),
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text("Remplire le formulaire"),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _formLoginLink() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      padding: EdgeInsets.symmetric(vertical: 7),
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: widget.onLoginRequest,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 27,
            ),
            Text(
              'Déjà inscrit ?  ',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Text(
              'Cliquez ici pour vous connecter',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
