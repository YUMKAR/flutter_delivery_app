import 'package:delivery_app/common/const/color.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/common/service/auth_api.dart';
import 'package:delivery_app/restaurant/view/restaurant_screen.dart';
import 'package:delivery_app/user/view/login_screen.dart';
import 'package:flutter/material.dart';


class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with TickerProviderStateMixin{
  final AuthService auth = AuthService();
  late TabController controller;

  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TabController(length: 4, vsync: this);
    controller.addListener((){
      setState(() {
        currentIndex = controller.index;
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
    controller.removeListener((){
      setState(() {
        currentIndex = controller.index;
      });
    });

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Input_Border_color,
        elevation: 2,
        selectedItemColor: Primary_Color,
        unselectedItemColor: Body_Text_Color,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index){
          controller.animateTo(index);
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood_outlined),label: '음식'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined),label: '주문'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline),label: '프로필'),
        ],
      ),
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          RestaurantScreen(),
          Center(child: Text('음식'),),
          Center(child: Text('주문'),),
          Center(child: TextButton(onPressed: (){auth.deleteToken();Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>LoginScreen()), (route)=>false);}, child: Text('토큰제거')),),
        ],
      ),
    );
  }
}
