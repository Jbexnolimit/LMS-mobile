import 'package:flutter/material.dart';
import 'package:lms/dashboard.dart';
import 'package:page_transition/page_transition.dart';
import '../profile.dart';

class CustomBottomAppBar extends StatefulWidget {

  final email;
  final fullname;
  final userId;
  final usertype;


   CustomBottomAppBar({Key? key,required this.fullname,required this.email,required this.userId, required this.usertype }) : super(key: key);

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  Color _currentColor = const Color(0xFF111111);
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: ImageIcon(
                    const AssetImage(
                        'assets/images/bottom_navigation_bar/layout.png'),
                    size: 24,
                    color: _currentColor),

                              onPressed: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DashBoard(
                                  fullname: widget.fullname,
                                  email: widget.email, userId: widget.userId,
                                    usertype: widget.usertype,),),);

                                  }

              ),
              IconButton(
                icon: ImageIcon(
                    const AssetImage(
                        'assets/images/bottom_navigation_bar/people.png'),
                    size: 24,
                    color: _currentColor),
                onPressed: () {

                  setState(() {
                    _currentColor = const Color(0xFF5F59E1);
                  });
                },
              ),
              IconButton(
                icon: ImageIcon(
                    const AssetImage(
                        'assets/images/bottom_navigation_bar/user.png'),
                    size: 24,
                    color: _currentColor),
                onPressed: () {
                  Navigator.push(context,
                      PageTransition(type: PageTransitionType.bottomToTop,
                          child: ProfilePage(fullname: widget.fullname,email: widget.email )));
                  setState(() {
                    _currentColor = const Color(0xFF5F59E1);
                  });
                },
              ),
              IconButton(
                icon: ImageIcon(
                    const AssetImage(
                        'assets/images/bottom_navigation_bar/fi_settings.png'),
                    size: 24,
                    color: _currentColor),
                onPressed: () {
                  setState(() {
                    _currentColor = const Color(0xFF5F59E1);
                  });
                },
              ),
            ],
          )),
    );
  }
}
