import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: null,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
          LoginLogo(),
          LoginForm(),
          SizedBox(height: 16.0),
          LoginTextBtn(),
          SizedBox(height: 66.0),
          LoginThirdLoginBtn(),
          SizedBox(height: 80.0),
          Center(
              child: Text(
            '掘金 · juejin.im',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ))
        ],
      ),
    );
  }
}

class LoginThirdLoginBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List _btns = [
      {
        'image': 'assets/login/weibo_login.png',
        'text': '微博',
        'onPress': () {
          print('微博');
        }
      },
      {
        'image': 'assets/login/wechat_login.png',
        'text': '微信',
        'onPress': () {
          print('微信');
        }
      },
      {
        'image': 'assets/login/github_login.png',
        'text': 'Github',
        'onPress': () {
          print('Github');
        }
      }
    ];

    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  padding: EdgeInsets.only(top: 9.0),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                      width: .1,
                    )),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    '其他账号登录',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 14.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _btns.map((item) {
              return FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: item['onPress'],
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      item['image'],
                      width: 50.0,
                      height: 50.0,
                    ),
                    Text(
                      item['text'],
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, .6),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class LoginTextBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Text(
            '忘记密码？',
            style: TextStyle(
              fontSize: 14.0,
              color: Color.fromRGBO(255, 255, 255, 0.5),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            '注册账号',
            style: TextStyle(
              fontSize: 14.0,
              color: Color.fromRGBO(255, 255, 255, 1.0),
            ),
          ),
        )
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
//  final _formKey = new GlobalKey<FormState>();

  String _username;
  String _pwd;

  void _submitForm() {
//    var _form = _formKey.currentState;
    print(_username);
    print(_pwd);

    Navigator.of(context).pop({
      "name": "今天又懒的加班",
      "job": "渔夫",
      "actor":
          "https://user-gold-cdn.xitu.io/2019/3/2/1693f1ecd565a033?imageView2/1/w/100/h/100/q/85/format/webp/interlace/1"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (val) => _username = val,
          onSubmitted: (val) => _username = val,
          style: TextStyle(fontSize: 16.0),
          decoration: InputDecoration(
            hintText: '手机号/邮箱',
            hintStyle: TextStyle(
              color: Color(0xFFD2D2D2),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.4),
              borderRadius: BorderRadius.vertical(top: Radius.circular(2.0)),
            ),
            filled: true,
            fillColor: Colors.white,
//            focusedBorder: UnderlineInputBorder(
//              borderSide: BorderSide(width: 0.6),
//            ),
            contentPadding: EdgeInsets.all(16.0),
          ),
        ),
        TextField(
          onChanged: (val) => _pwd = val,
          onSubmitted: (val) => _pwd = val,
          obscureText: true,
          style: TextStyle(fontSize: 16.0),
          decoration: InputDecoration(
            hintText: '密码',
            hintStyle: TextStyle(
              color: Color(0xFFD2D2D2),
            ),
            border: UnderlineInputBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(2.0)),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(16.0),
          ),
        ),
        SizedBox(
          height: 14.0,
        ),
        SizedBox(
          width: double.infinity,
          height: 46.0,
          child: FlatButton(
            onPressed: _submitForm,
            color: Color(0xFF2C68D1),
            child: Text(
              '登录',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 3.0, bottom: 20.0),
        child: Image.asset(
          'assets/login/ic_login_logo.png',
          width: 50.0,
          height: 50.0,
        ),
      ),
    );
  }
}
