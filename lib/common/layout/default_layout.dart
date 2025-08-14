import 'package:delivery_app/common/service/auth_api.dart';
import 'package:flutter/material.dart';


class DefaultLayout extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? title;
  final Widget? bottomNavigationBar;


  const DefaultLayout({
    super.key,required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
  });

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  final AuthService auth = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.refreshToken();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      backgroundColor: widget.backgroundColor ?? Colors.white,
      body: widget.child,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }

  AppBar? renderAppBar(){
    if(widget.title==null){
      return null;
    }else{
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        ),
        foregroundColor: Colors.black,
        centerTitle: true,
      );
    }
  }
}
