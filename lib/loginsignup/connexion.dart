import 'package:flutter/material.dart';
import 'package:e_wanacc/loginsignup/authentication.dart';
import 'package:e_wanacc/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Connexion extends StatefulWidget{
  Connexion({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _Connexion createState() => new _Connexion();
}

enum FormMode { LOGIN, SIGNUP}

class _Connexion extends State<Connexion>{

  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  initLogin() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
      if (account != null) {
        Navigator.of(context).pushNamed('/dashboard');
      } else {
        // user NOT logged
      }
    });
    _googleSignIn.signInSilently();
  }

  doLogin() async {
    
    await _googleSignIn.signIn();
  }

  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  FormMode _formMode = FormMode.LOGIN;

  bool _isIos;
  bool _isLoading;

  bool _validateAndSave(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void _validationAndSubmit() async {
    setState(() {
     _errorMessage = "";
     _isLoading = true; 
    });
    if(_validateAndSave()){
      String userId = "";
      try{
        if(_formMode == FormMode.LOGIN){
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        }else{
          userId = await widget.auth.signUp(_email, _password);
          //widget.auth.sendEmailVerification();
          //_showVerificationEmailDialog();
          print('Signed up user: $userId');
        }
        if(userId.length > 0 && userId != null && _formMode == FormMode.LOGIN){
          widget.onSignedIn();
        }
      }catch (e){
        print('Error: $e');
        setState(() {
         _isLoading = false;
         if(_isIos){
           _errorMessage = e.details;
         } else{
           _errorMessage = e.message;
         }
        });
      }
    }
  }

  @override
  void initState(){
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void _changeFormToSignUp(){
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
     _formMode = FormMode.SIGNUP; 
    });
  }

  void _changeFormToLogin(){
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
     _formMode = FormMode.LOGIN; 
    });
  }

  Widget _showCircularProgress(){
    if(_isLoading){
      return Center(child: CircularProgressIndicator(),);
    }return Container(height: 0.0, width: 0.0,);
  }

  Widget _showLogo(){
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/logo.jpg'),
        ),
      ),
    );
  }

  Widget _showEmailInput(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(30.0),
          border: Border.all()
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
        child:TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
           decoration: new InputDecoration(
             hintText: 'Email',
             icon: new Icon(
               Icons.mail,
               color: Colors.grey
             )
           ),
           validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
           onSaved: (value) => _email = value,
        ),
      ),
    );
  }

  Widget _showPasswordInput(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(30.0),
          border: Border.all()
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
        child:TextFormField(
          maxLines: 1,
          obscureText: true,
          keyboardType: TextInputType.text,
          autofocus: false,
           decoration: new InputDecoration(
             hintText: 'Password',
             icon: new Icon(
               Icons.lock,
               color: Colors.grey
             )
           ),
           validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
           onSaved: (value) => _password = value,
        ),
      ),
    );
  }

  Widget _showNameInput(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(30.0),
          border: Border.all()
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
        child:TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.text,
          autofocus: false,
           decoration: new InputDecoration(
             hintText: 'Prenom et nom',
             icon: new Icon(
               Icons.people,
               color: Colors.grey
             )
           ),
          /* validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
           onSaved: (value) => _email = value,*/
        ),
      ),
    );
  }

  Widget _showPrimaryButton(){
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Container(
        width: 150.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.green[500],
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: new Material(
          child: MaterialButton(
            child: _formMode == FormMode.LOGIN 
                ? new Text('Se connecter', style: new TextStyle(fontSize: 20.0, color: Colors.black),)
                : new Text('S\'inscrire', style: new TextStyle(fontSize: 20.0, color: Colors.black)),
            onPressed: () => _validationAndSubmit(),
            highlightColor: Colors.green.withOpacity(0.5),
            splashColor: Colors.green.withOpacity(0.5),
          ),
          color: Colors.transparent,
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    );
  }

  Widget _showSecondaryButton(){
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Container(
        width: 150.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.lightGreen[500],
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: new Material(
          child: MaterialButton(
            child: _formMode == FormMode.SIGNUP
                ? new Text('Se connecter', style: new TextStyle(fontSize: 20.0, color: Colors.black),)
                : new Text('S\'inscrire', style: new TextStyle(fontSize: 20.0, color: Colors.black)),
            onPressed: _formMode == FormMode.LOGIN ? _changeFormToSignUp: _changeFormToLogin,
            highlightColor: Colors.lightGreen.withOpacity(0.5),
            splashColor: Colors.lightGreen.withOpacity(0.5),
          ),
          color: Colors.transparent,
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    );
  }

  Widget _showSeparator(){
    return new Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
              Text("Se connecter avec"),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
            ]);
  }

  Widget _showAlternativeLogin(){
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Container(
        width: 120.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: new Material(
          child: MaterialButton(
            child: Row(
              children: <Widget>[
                Image.asset('assets/search.png'),
                Text('Google', style: TextStyle(fontFamily: 'Cambria', color: Colors.black))
              ],
          ),
            onPressed: () => {},//doLogin(),
            highlightColor: Colors.white.withOpacity(0.5),
            splashColor: Colors.white.withOpacity(0.5),
          ),
          color: Colors.transparent,
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    ),
      ],
    );
  }

  Widget _showErrorMessage(){
    if(_errorMessage.length > 0 && _errorMessage != null){
      return new Text(
        _errorMessage,
        style: TextStyle(
          fontSize: 13.0,
          color: Colors.red,
          height: 1.0,
          fontWeight: FontWeight.w300
        ),
      );
    }else{
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showBody(){
    return new Container(
      padding: EdgeInsets.all(16.0),
      child:new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            _showLogo(),
            _formMode == FormMode.SIGNUP? _showNameInput(): SizedBox(height: 0.0,),
            _showEmailInput(),
            _showPasswordInput(),
            _showPrimaryButton(),
            _showSecondaryButton(),
            _showErrorMessage(),
            _formMode == FormMode.LOGIN? _showSeparator(): SizedBox(height: 0.0,),
            _formMode == FormMode.LOGIN? _showAlternativeLogin(): SizedBox(height: 0.0,),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Connexion"),
      ),
      body: Stack(
        children: <Widget>[
          _showBody(),
          _showCircularProgress(),
        ],
      ),
    );
  }
}